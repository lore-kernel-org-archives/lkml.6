Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F72C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF94D2154F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vo4enTSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF94D2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeHHEkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:40:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43319 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeHHEkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:40:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id a14-v6so317281pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=AzBh7Jad21nDkmjrRWl/tegNlyrjJzLzLgKojgLRWd4=;
        b=Vo4enTSxAw8YLYSIe/EyrRYkoXr56Ft3KGoWB9XcWDUYWddUVVXL76XEqf8NTomMHe
         yHSJmVlajg2qgEj6J12BOSlNL5BHVhGrpY8XgE0SE/ZZUOqPNLJnsAII5SA8LDp7sNd1
         sxbRWTrCOvOUs+kQtiYlsepwHG8EKnFkt7tfGYSbGWDKG1lU7NmNxaphPm6q0rJz9+an
         DNWHfrwsJMeRLbhT5z5gtt3qs1tzjlm5Z85Hy569/l7G6Ki7AT0GHuBtDeLendMPkELJ
         UanxSz8Kp/kXisHw56Ekl1pmp7CWeURH9wbuVD9/CFDST2CSRiCkvxz/uZ9gtcK5AL6W
         vUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=AzBh7Jad21nDkmjrRWl/tegNlyrjJzLzLgKojgLRWd4=;
        b=Rr2Wx4j6jLxkPaDBP6x3vql2YWJJrcC8x+eoBbbR2hBFxQe05FiacjqDzN9y58LJaD
         qQ2+V3owZGszBAkcYx4mz9B1uazT68i2RqiispA5IAb2nt4bWKjfBJ9VTZ5ZhIpUKvNN
         yQvvAORKTdus38iLs8+NSKm0ufLjnobgpXgpHPP+iT5csEYrvwMMBQDlyolOn+XTkQcr
         EaCBmk6tIl+GdjW6nmVHTD3uJTjiXcYltmNoqVte2kDLlV1Vy1nBwsE2V/sZ5mSMi4xM
         aooipjTj9SZ1s9v84A4ZdSm6rgS4Lf9aT+Ub0HfXBB5srejoary0aiSRiffIb3lqKXo7
         8Vdg==
X-Gm-Message-State: AOUpUlHzPKof8r0P6jLnAWdiLNbQbD1YFRzR3Xpno26To0WXQvQ1V2Lv
        ggWAHqlwkjNJmmjZQt2qcHxCTw==
X-Google-Smtp-Source: AA+uWPzA7+oCGu5mRYL8CmMNsgHZa5RpGCh+DeffQitW8s+igKtKUztcpAHyNBpcyVkfSjf5DQa55A==
X-Received: by 2002:a62:2bc8:: with SMTP id r191-v6mr846988pfr.164.1533695000734;
        Tue, 07 Aug 2018 19:23:20 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o27-v6sm5181227pfj.35.2018.08.07.19.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 19:23:19 -0700 (PDT)
Date:   Tue, 07 Aug 2018 19:23:19 -0700 (PDT)
X-Google-Original-Date: Tue, 07 Aug 2018 19:23:16 PDT (-0700)
Subject:     Re: simplified RISC-V interrupt and clocksource handling v3
In-Reply-To: <20180804082319.5711-1-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>, robh+dt@kernel.org
Message-ID: <mhng-d7c67842-dff7-4200-bc2e-c3eed1a0a7bf@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2018 01:23:11 PDT (-0700), Christoph Hellwig wrote:
> This series tries adds support for interrupt handling and timers
> for the RISC-V architecture.
>
> The basic per-hart interrupt handling implemented by the scause
> and sie CSRs is extremely simple and implemented directly in
> arch/riscv/kernel/irq.c.  In addition there is a irqchip driver
> for the PLIC external interrupt controller, which is called through
> the set_handle_irq API, and a clocksource driver that gets its
> timer interrupt directly from the low-level interrupt handling.
>
> Compared to previous iterations this version does not try to use an
> irqchip driver for the low-level interrupt handling.  This saves
> a couple indirect calls and an additional read of the scause CSR
> in the hot path, makes the code much simpler and last but not least
> avoid the dependency on a device tree for a mandatory architectural
> feature.
>
> A git tree is available here (contains a few more patches before
> the ones in this series)
>
>     git://git.infradead.org/users/hch/riscv.git riscv-irq-simple.3
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple.3
>
> Changes since v2:
>  - actually use SEIE instead of STIE in the plic driver
>  - rename the default compat string for the plic to sifive,u5-plic
>  - various spelling fixes
>  - drop a superflous derefence in the plic driver that is taken care of
>    by the following loop
>  - drop the patch to document the enable method - not relevant for the
>    rest of the series
>  - drop the patches for the per-hart timebase frequency - not relevant
>    for the rest of the series.
>  - use riscv_of_processor_hart in the timer driver
>
> Changes since v1:
>  - rename the plic driver to irq-sifive-plic
>  - switch to a default compatible of sifive,plic0 (still supporting the
>    riscv,plic0 name for compatibility)
>  - add a reference for the SiFive PLIC register layout
>  - fix plic_toggle addressing for large numbers of hwirqs
>  - remove the call to ack_bad_irq
>  - use a raw spinlock for plic_toggle_lock
>  - use the irq_desc cpumask in the plic enable/disable methods
>  - add back OF contexid parsing in the plic driver
>  - don't allow COMPILE_TEST builds of the clocksource driver, as it
>    depends on <asm/sbi.h>
>  - default the clocksource driver to y
>  - clean up naming in the clocksource driver
>  - remove the MINDELTA and MAXDELTA #defines
>  - various DT binding fixes

Thanks!  Modulo the one device tree issue I replied to in patch 3 this looks 
great!  We've already gotten the ACKs to take this through the RISC-V tree, so 
I'm going to put this along with the queued RISC-V patches on our for-next 
branch, including my proposed change for "sifive,plic-1.0" but leaving the 
device tree bindings with #{address,size}-cells=1.

We can always change this, but I'd like to get this out so people can start 
playing with it earlier rather than later.

Thanks to everyone for all the help!
