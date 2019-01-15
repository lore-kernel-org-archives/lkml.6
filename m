Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CF520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIeRinBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfAONnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfAONnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Czdbjv8mj+irDWUYzMDo9eeAPR9Jw7uPIpYVK4riaRE=; b=PIeRinBZct/6srcJIvEUsYxjZ
        Ci9YBtTfTnF8Vo5FTXgxcuGnEE7oBJPF6lvKwHJLtH0sN966KFrUXdWTNX30Ji1Zht8CwDkRQyiDz
        zSEs0QvZlXChi5y4O3Ls8TkHAkQiPJhYUHmDEI9zosapxgF8OQNKVZVhTVTcmlO5JVPHUiW6rAEl8
        4xKoFx1DuVOgErI+jj0XfCM0t1dVOjLMfk76OqHSvy9pLC1J+5EUlwI/OY0Mk0ayy89SnHU3gRdXX
        U7YWahXyezFCJGQ+RNDf5u5Iek+8mL5cXep+ESbTOe3FoImHmWQIWiN3b+hLrDi5Q8j+qOXv/Uy3L
        Y1MPmYD6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP0C-0005hL-5x; Tue, 15 Jan 2019 13:43:36 +0000
Date:   Tue, 15 Jan 2019 05:43:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] RISC-V: Move free_initrd_mem() to kernel/setup.c
Message-ID: <20190115134336.GB13216@infradead.org>
References: <20190107161047.10516-1-anup@brainfault.org>
 <20190107161047.10516-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107161047.10516-2-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:40:43PM +0530, Anup Patel wrote:
> From: Anup Patel <anup.patel@wdc.com>
> 
> We move free_initrd_mem() to kernel/setup.c so that all initrd
> related functions are in one place.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Talking about free_initrd_mem - don't we need to call free_reserved_area
to actually release the memory?
