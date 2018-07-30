Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A2D20841
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaTkw9gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A2D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeG3To4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:44:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbeG3To4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R5jWr0kJNTH0P4xkwawvkWxp4H7LVV3lUV6KNhSF/fg=; b=UaTkw9gpe6gJRmW/1e77v/QxH
        6Z4aIuJQrITOHSqGnJ4iUW6dGKNlDhcGZgW3kevaeNrcCCIUBfv+mc+rRsmutWKj9sLkAxJEZEICP
        NUd9TC+p3VHwhjHv1pvqMQRjhFE7vxZri9rlBSePCFDHI5MYvCT8USC/lwYFAnDjoTioRdUoupaMY
        IPlBKlVCOpkpz7QLLyGafjYIWCz8MvyctNXBCylEdh5nB/E39UzzaM2nJc0sMwHt/T2m6USxwXuir
        Hah980BBsUqqyr21EoQIh87/8pU3jkLlXVLTPf6EvKePGg4/go6LQWOnTRVF4TKVQG9zJ4NRIUnSV
        x3FFKI2og==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkCb4-0005pK-Th; Mon, 30 Jul 2018 18:08:42 +0000
Date:   Mon, 30 Jul 2018 11:08:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730180842.GA5544@bombadil.infradead.org>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730143104.GB24051@amd>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:31:04PM +0200, Pavel Machek wrote:
> Well, I guess errors should have numbers, and catalog explaining what
> error means what. That way userspace can translate, and it is what we
> do with errno.
> 
> I believe numbers are best. If you hate numbers, you can still use
> strings, as long as you can enumerate them in docs (but it will be
> strange design).

Have you looked at how gettext() works?  It uses the english text as
a search string and replaces it with the localised string.  This is
a very common design!

