Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC65C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081EB206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+PpD0bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081EB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeIJSXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:23:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbeIJSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VZr/UyMWRYLbTdkoJ79e3mgwsj3F7jrjxjYlqgd0Vtw=; b=Q+PpD0bSQwiVnId9hUdD3PRcv
        Zbb96Ffd4fe2ljAb6CbdJ6iswNX7W/jzhkFPXAjVRPYNxoDvfPDRRLdaDR6LhDwcoUZQDqD+32SZF
        wOSMSFrFHQLMvrMsINqyEGS7BRp9FgopmOwxuSM5B+nBLdtHhiOHpxfHWiB4LU3UQBV4adfvULAkY
        ETV8u0XKI2WlOaLZsXrhmXI2JTIuT5wKPStib1v3azK6hSC6X121aJgqL6oULH57pjU/864WuVKus
        CocCDgbIrfwIGMO82M8RtHe1O9L1h7wotKBjdtbKi28Cq6BwJt0MXuNPYuVq5eX9IDUCNNd6wBiof
        ccYiE+CmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMFo-0001qx-Ij; Mon, 10 Sep 2018 13:29:24 +0000
Date:   Mon, 10 Sep 2018 06:29:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180910132924.GA6987@infradead.org>
References: <20180906123651.28500-1-anup@brainfault.org>
 <20180906123651.28500-4-anup@brainfault.org>
 <20180906140628.GA10580@infradead.org>
 <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 12:46:35PM +0200, Thomas Gleixner wrote:
> On Thu, 6 Sep 2018, Christoph Hellwig wrote:
> 
> > Just as before:  NAK to entirely pointless abstractions.  Please stop
> > beating the dead horse.
> 
> I disagree. These interrupts very well fit into the percpu interupt
> mechanics and that allows them to be handled by all the generic mechanisms
> as any other interrupt.

Just a few weeks ago you said the contrary:

http://lists.infradead.org/pipermail/linux-riscv/2018-August/000943.html
