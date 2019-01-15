Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A3AC43613
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dvp222V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfAONo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:44:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAONoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YF3ANwy38FvJfD7VyrvFQJeVF+sWR2d8dg0AjmP6/mo=; b=dvp222V3Npp67xJDVlMnFRIz0
        7rWskSRf82ehuIPNH0gtu//ZhCYJjfJ6MHFGw4huvy27lTmYgpUKFPwN4F5bZF56pbKf9JZLxHDkY
        sSOxs6vUjvqZNIIofjW134IjXAi8L2Y5xmGLQ6MD5o/zueah5NYw6Imq5JB36HBtu1NxQ/lVcAIvC
        FSG6QiNTH6sP2x7tJJh9sczyIbo54nuT05A7tLdxXwHY575wZwncoP54hV8Iqne+BHLghpkvLt+WW
        6jKLq4ejjcTeFpCIA9ywdr5+8n48Wj6l7g5rufFUFNc3rIWNiEomDctwRFGHdhnqXPEeI3y0hnewp
        tpCwFvNRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP1R-0005rs-Lw; Tue, 15 Jan 2019 13:44:53 +0000
Date:   Tue, 15 Jan 2019 05:44:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/5] RISC-V: Move setup_bootmem() to mm/init.c
Message-ID: <20190115134453.GD13216@infradead.org>
References: <20190107161047.10516-1-anup@brainfault.org>
 <20190107161047.10516-4-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107161047.10516-4-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:40:45PM +0530, Anup Patel wrote:
> From: Anup Patel <anup.patel@wdc.com>
> 
> The setup_bootmem() mainly populates memblocks and does
> early memory reservations. The right location for this
> function is mm/init.c.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, please use up the available 72 chars per line in your changelogs
where possible.
