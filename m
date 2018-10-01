Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BECC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B952083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLnPe+dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B952083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeJAQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:01:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37125 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbeJAQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:01:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so13040371wrr.4;
        Mon, 01 Oct 2018 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OhEgUOB92QopJxDtkpB/kyOIyuMWKtWWsN3PGIRlWBw=;
        b=kLnPe+dkYCEOCvcI7eAaPv/TjTybwXi9/8+YLm/CFZ4J8ecACyJLfgrkw1sGtAmgQJ
         OLqvFLXSsSpDxsyAGipT6gACLv4YleuKMnFWP9pA+7PibUfSTCDBwbJewzNXjFRTTGWw
         kIYwRopI/VRvQYwx+9meWsnaUkKxkpUUpTFMQHNq+7p54HceFFCWA7jz2wgJTgPRzk2A
         mpQUK4FL8EKE6N0T6yi3Hl+AMZqyIwN1uKEE8Mm91OYKmaB/qE19QOlAE15l1aCTBaS2
         +kXAanjp/l+q0m9PJAeIU6C4zCuVavNz57EBDpLCDlc50MDTa6xCyQUep4pI2/5IL8/Z
         xwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OhEgUOB92QopJxDtkpB/kyOIyuMWKtWWsN3PGIRlWBw=;
        b=SQgSTIMeyuobmHshO8Rd5NSlnchhZTZIEpvDthGHePhIlgHLG0ct7A3tDDR/cCkJoH
         bLgPxukMhZ+zkI7bT+iZXOOS3gAeP5ka94gnU0783rZav1xWKhUCnryA1EUlimuRqfBd
         zS1rSGHaFSufl50GbjpUQV4t3QFBST4IoNxcKW8Ch9ccWJl1IMRm48CvC651faT8krhP
         MlR3EQSn0zrhabo8TsA5KKa54mD9Xx6a8UJmaXkeBNDP0Nt4WrBZ2820oZg3LY0rQ0PN
         W7Rz/AamubOrbvDdymYSRIgy/5brXhYI7+7RcnFS74hdoT20/FDmiCRBjyw0orsVSVfm
         +dBw==
X-Gm-Message-State: ABuFfoicuAzH1AvuSPcKxx4BjXbjQfGLYeLQW5ci+sMzjZtyxgD9JT3+
        sM1rm8dLQCiKVL9JLtohd/M=
X-Google-Smtp-Source: ACcGV62G299+enXKRwlsf4p88HeqDdbJR0LYyf/+Y8gYw+MoknJFdSzaw+D4LNcD70JKOXXrECR6ew==
X-Received: by 2002:adf:ec11:: with SMTP id x17-v6mr6381768wrn.266.1538385901779;
        Mon, 01 Oct 2018 02:25:01 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id k25-v6sm10742636wre.18.2018.10.01.02.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 02:25:01 -0700 (PDT)
Message-ID: <a7854b26769c0baec6ad03cc1eee03b78f89b194.camel@gmail.com>
Subject: Re: [RFC 5/5] MIPS: Add Realtek RTL8186 SoC support
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Oct 2018 12:24:58 +0300
In-Reply-To: <351da67a-b1e6-7972-5c91-0f204690080f@arm.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
         <20180930141510.2690-6-yasha.che3@gmail.com>
         <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
         <ceced0d550bc30d4f3e66d2c7f569c39ca890ce4.camel@gmail.com>
         <351da67a-b1e6-7972-5c91-0f204690080f@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 10:15 +0100, Marc Zyngier wrote:
> On 01/10/18 09:48, Yasha Cherikovsky wrote:
> > Hi Marc,
> > 
> > On Mon, 2018-10-01 at 09:19 +0100, Marc Zyngier wrote:
> > > Hi Yasha,
> > > 
> > > On 30/09/18 15:15, Yasha Cherikovsky wrote:
> > > > The Realtek RTL8186 SoC is a MIPS based SoC
> > > > used in some home routers [1][2].
> > > > 
> > > > The hardware includes Lexra LX5280 CPU with a TLB,
> > > > two Ethernet controllers, a WLAN controller and more.
> > > > 
> > > > With this patch, it is possible to successfully boot
> > > > the kernel and load userspace on the Edimax BR-6204Wg
> > > > router.
> > > > Network drivers support will come in future patches.
> > > > 
> > > > This patch includes:
> > > > - New MIPS rtl8186 platform
> > > >       - Core platform setup code (mostly DT based)
> > > >       - New Kconfig option
> > > >       - defconfig file
> > > >       - MIPS zboot UART support
> > > > - RTL8186 interrupt controller driver
> > > > - RTL8186 timer driver
> > > > - Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
> > > >     router
> > > > 
> > > > [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> > > > [2] https://wikidevi.com/wiki/Realtek_RTL8186
> > > > 
> > > > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > > Cc: Paul Burton <paul.burton@mips.com>
> > > > Cc: James Hogan <jhogan@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-mips@linux-mips.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >    arch/mips/Kbuild.platforms                    |   1 +
> > > >    arch/mips/Kconfig                             |  17 ++
> > > >    arch/mips/boot/compressed/uart-16550.c        |   5 +
> > > >    arch/mips/boot/dts/Makefile                   |   1 +
> > > >    arch/mips/boot/dts/realtek/Makefile           |   4 +
> > > >    arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
> > > >    .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
> > > >    arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
> > > >    arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
> > > >    arch/mips/rtl8186/Makefile                    |   2 +
> > > >    arch/mips/rtl8186/Platform                    |   7 +
> > > >    arch/mips/rtl8186/irq.c                       |   8 +
> > > >    arch/mips/rtl8186/prom.c                      |  15 ++
> > > >    arch/mips/rtl8186/setup.c                     |  80 +++++++
> > > >    arch/mips/rtl8186/time.c                      |  10 +
> > > >    drivers/clocksource/Kconfig                   |   9 +
> > > >    drivers/clocksource/Makefile                  |   1 +
> > > >    drivers/clocksource/timer-rtl8186.c           | 220
> > > > ++++++++++++++++++
> > > >    drivers/irqchip/Kconfig                       |   5 +
> > > >    drivers/irqchip/Makefile                      |   1 +
> > > >    drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++
> > > 
> > > Could you please split this into at least three patches (arch code,
> > > clocksource, irqchip) to ease the review?
> > > 
> > > Thanks,
> > > 
> > > 	M.
> > 
> > Currently the RTL8186_IRQ and the RTL8186_TIMER Kconfig entries depend
> > on
> > MACH_RTL8186 (which is added in the MIPS portion of the same patch).
> > Also, MACH_RTL8186 in MIPS selects these two options.
> > 
> > What is the best way to split that?
> 
> It is absolutely fine to have something depending on a non-selectable 
> config option, which would allow you to split things up as finely as you 
> want. Just have the patch enabling the config option last.
> 
> Thanks,
> 
> 	M.

Good to know, thanks.
I'll send a v2 soon.

Yasha

