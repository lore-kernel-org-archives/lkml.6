Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F452082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XaC4VeyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F452082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeK1SGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:06:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeK1SGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OZgIK+vqlCt3S9rrJyWonYqb1NBJsFy3Yn7xCtMuMqo=; b=XaC4VeyOz0IrtRuJJEEol5Xhg
        aMpyBbDziQLcw6WyWN6UULh8COsfWCtHd927YA9E141jyIfD0t/Is1M3t7+VSObiPRT8Ko/9vLJaL
        5cqSWF0XIMI2QdP3hsEcXRvwr9Np/bQ3O92R0ahDa0leyy8UBfHH52c84MPggnFnrUS9ezez3BT7/
        pyOJRjyTr3/YTOXFNwGIEUz8tqlKba+c1AvAPEotBfL7aY+V5ocd0d592c21B/eRAwl5PeayXzqBD
        ZiwmKp7wWimVNJdKVS0RaOMPXoIU9oQi79JYOCEv4lxWYhdY+DyPTB8q04yEPInvQDww5UrnNj1sn
        7cJKjipvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRtuW-0000zr-Ks; Wed, 28 Nov 2018 07:05:24 +0000
Date:   Tue, 27 Nov 2018 23:05:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sis5513: fix potential use after free
Message-ID: <20181128070524.GB30936@infradead.org>
References: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:55:26AM +0800, Pan Bian wrote:
> The function sis_find_family drops lpc_bridge reference via pci_dev_put,
> however, after that, field lpc_bridge->revision is read. This may result
> in a use after free bug. The patch moves the put operation after the
> condition check.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
