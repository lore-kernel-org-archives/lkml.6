Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3474F20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBhnXfMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3474F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeJAPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:25:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeJAPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:25:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so12924787wrw.6;
        Mon, 01 Oct 2018 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5cO9sUI6UB3eBXu0i2JiQkKVFshWB5nWUr9I2zYUDa4=;
        b=CBhnXfMVwcdc4hXxgUAiuYZNQGAKPgQjUcchxwmQDhanbxL7ofa9DerRk2sVnANkV9
         27zg3TjrZPTRdkIcaXfOW1etGDCDyFOTjP7cYqzt85fH6+srBxoSCqn2M4Mi8AblVyyl
         1B/+Qw8NVDx/WyYfsFXQ6TEgJfZrGE82NpIOIcxP/4TYlvU6r3iN/TntbzYifInfHzKi
         lJYMF9czYn+LN/scqK1LxkKKot6vE4Db/iLK0zP3oZkPTl6soG6gEYG/HPFY6C/YimYe
         KO0c9HOhlyvzeSZ465JzhNSOMO1wu/3HirNqbt8TNb/c9wEkDjqNZdBcVbyVoeMqiNMn
         RmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5cO9sUI6UB3eBXu0i2JiQkKVFshWB5nWUr9I2zYUDa4=;
        b=VKrL3zYcukDiOiXHu7lqfUY/IEFXci1WnwEHbPifBLSvp47ccCJe6WQmHe8PMSEahi
         1fhmEhFAAJtG/PStXYy1K81JeNZ9zGYjUgk3ccTcV5jZbn8I7tfMWhY0emOEQMnroSSZ
         5lS56HQWl1BPl8vijen82vRaFBBZh8WvBim5j+RNtM/VHS8tdO6piH7j/3FaUgq0Vzms
         B3ShOB8G1oFnmjPzTnTAocYeHK/oCierekDTz3QnSgFK6k+prJlYT250Ls58tK+CdyBt
         HDNBTULJYS7Kuq9Hh8kUSjA1HJ0nxU3E9F2goadtAJcWpyNrb2W1MbAxKFc4xlJEDvbI
         WYPw==
X-Gm-Message-State: ABuFfog8BHnENHkbmWGR/Qn/INDJZt6OyZbY1dq1Q+anoPlAD3N30d+4
        4Ri8C69LmVrQh76+dSesPsk=
X-Google-Smtp-Source: ACcGV61auetduznmuD2woQLvOsiY8HjE3RDB09SJCmc4G2qb2FZr1HQjhB9IwOo79AiUv7jOK/BBnw==
X-Received: by 2002:a5d:6608:: with SMTP id n8-v6mr6540390wru.281.1538383738225;
        Mon, 01 Oct 2018 01:48:58 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id 198-v6sm12074350wmm.0.2018.10.01.01.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 01:48:57 -0700 (PDT)
Message-ID: <ceced0d550bc30d4f3e66d2c7f569c39ca890ce4.camel@gmail.com>
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
Date:   Mon, 01 Oct 2018 11:48:54 +0300
In-Reply-To: <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
         <20180930141510.2690-6-yasha.che3@gmail.com>
         <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, 2018-10-01 at 09:19 +0100, Marc Zyngier wrote:
> Hi Yasha,
> 
> On 30/09/18 15:15, Yasha Cherikovsky wrote:
> > The Realtek RTL8186 SoC is a MIPS based SoC
> > used in some home routers [1][2].
> > 
> > The hardware includes Lexra LX5280 CPU with a TLB,
> > two Ethernet controllers, a WLAN controller and more.
> > 
> > With this patch, it is possible to successfully boot
> > the kernel and load userspace on the Edimax BR-6204Wg
> > router.
> > Network drivers support will come in future patches.
> > 
> > This patch includes:
> > - New MIPS rtl8186 platform
> >      - Core platform setup code (mostly DT based)
> >      - New Kconfig option
> >      - defconfig file
> >      - MIPS zboot UART support
> > - RTL8186 interrupt controller driver
> > - RTL8186 timer driver
> > - Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
> >    router
> > 
> > [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> > [2] https://wikidevi.com/wiki/Realtek_RTL8186
> > 
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   arch/mips/Kbuild.platforms                    |   1 +
> >   arch/mips/Kconfig                             |  17 ++
> >   arch/mips/boot/compressed/uart-16550.c        |   5 +
> >   arch/mips/boot/dts/Makefile                   |   1 +
> >   arch/mips/boot/dts/realtek/Makefile           |   4 +
> >   arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
> >   .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
> >   arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
> >   arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
> >   arch/mips/rtl8186/Makefile                    |   2 +
> >   arch/mips/rtl8186/Platform                    |   7 +
> >   arch/mips/rtl8186/irq.c                       |   8 +
> >   arch/mips/rtl8186/prom.c                      |  15 ++
> >   arch/mips/rtl8186/setup.c                     |  80 +++++++
> >   arch/mips/rtl8186/time.c                      |  10 +
> >   drivers/clocksource/Kconfig                   |   9 +
> >   drivers/clocksource/Makefile                  |   1 +
> >   drivers/clocksource/timer-rtl8186.c           | 220
> > ++++++++++++++++++
> >   drivers/irqchip/Kconfig                       |   5 +
> >   drivers/irqchip/Makefile                      |   1 +
> >   drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++
> 
> Could you please split this into at least three patches (arch code, 
> clocksource, irqchip) to ease the review?
> 
> Thanks,
> 
> 	M.

Currently the RTL8186_IRQ and the RTL8186_TIMER Kconfig entries depend on
MACH_RTL8186 (which is added in the MIPS portion of the same patch).
Also, MACH_RTL8186 in MIPS selects these two options.

What is the best way to split that?

Thanks,
Yasha

