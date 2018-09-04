Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2866EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A29220645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GO9UDAHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A29220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIDXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jETR/wfXy9x/msfoWJqYG80XlhsDcZhqiUgmwlwtDhI=; b=GO9UDAHKjGGnSnFgQ+z6hC1X1
        cLvcdJiu3DOsvGCVgxsh00t4pxC0nCjrG+dFHI3BDZ7aOzR3onlPUCLqxONPs/YjRLBayo0wb7vwy
        Kh9VI1ur6KSUvpC+nl0hZZmQDeoFErWBQVxfhRtgi4IQWSDrzQaL3B3NiUPcqK3TyvbmaLM6z//Js
        YuT5OYehwIhfmmJmktS17kcZYpqKJRXNiwkb8xAo8txtq4LJgzjiLLOX0Ae9QP9yTft/nyOPso3Nn
        YZ4p2Ausdk3BUDV/bSdpBx2IFSwMDE2/ktNWobLwihI8+NkexbuUnxnXLUX7OtrDi1LsgoAHuHTLE
        M2gY47PtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxGV3-0001Q8-8P; Tue, 04 Sep 2018 18:56:29 +0000
Date:   Tue, 4 Sep 2018 11:56:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] RISC-V: Select useful GENERIC_IRQ kconfig options
Message-ID: <20180904185629.GC25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-4-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904124514.6290-4-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:15:12PM +0530, Anup Patel wrote:
> This patch selects following GENERIC_IRQ kconfig options:
> GENERIC_IRQ_MULTI_HANDLER

This is already selected by arch/riscv/Kconfig.

> GENERIC_IRQ_PROBE

This is something only used by ISA drivers.  Why would we want that
on RISC-V?

> GENERIC_IRQ_SHOW_LEVEL

We don't really have any special level triggerd irq handling in
RISC-V.  That being said this is trivial and I don't see why it
even is a Kconfig option.  Please have a discussion with Thomas
and Marc on why we have this option instead of a default.

> HANDLE_DOMAIN_IRQ

We aren't using handle_domain_irq anywhere in RISC-V, no need to
build this.
