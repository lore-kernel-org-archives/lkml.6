Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD3ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C16214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVAq7lVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C16214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeJQQgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:36:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeJQQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+uyfAw5g7ZznxmENTmxX7gravnptuYGZH5719a97f2I=; b=tVAq7lVLrHBaMU8XzyqHDztU+
        k2bDcr7xJak6H1CyjdCx8KZOZPuHEZAvS1TKmmeSbMehK85nLkUB7YsOIBhq9MdNGXK2BELhqKWB3
        9rEH/i3KKRTWi9zxasJAUTVHjULEylI/5UZcFEgXlO6zZjUeTU16DcA/YTU8f0c3PTLbl2FyCeV+C
        gtmdKvKpPzD5zGjqC8t0wXmHKCBkZ1TW1K3dtHyz1JfvvL4d3muyAkLfK6U6/Q2XtepOgBdjPJP9m
        Ifca+4JYGvGHm5lqmmV1cSKDjL1XMArfdARmhSJw+NAJkNCXhCNUs2xs5N6MhtT0mEoTHULGYVbfg
        cj2dgJTKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gChON-0003MX-W0; Wed, 17 Oct 2018 08:41:23 +0000
Date:   Wed, 17 Oct 2018 01:41:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix error code in 'xfs_ioc_getbmap()'
Message-ID: <20181017084123.GK16896@infradead.org>
References: <20181017062138.1721-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017062138.1721-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:21:38AM +0200, Christophe JAILLET wrote:
> In this function, once 'buf' has been allocated, we unconditionally
> return 0.
> However, 'error' is set to some error codes in several error handling
> paths.
> Before commit 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
> this was not an issue because all error paths were returning directly,
> but now that some cleanup at the end may be needed, we must propagate the
> error code.
> 
> Fixes: 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
