Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9A32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548801066;
	bh=8mchtL/kda+QX5rreOUh8RrpnFpvoBbcXfLnACnhg74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rDWqLpRVuCADZEKXFTHOaClREOc+MWDPzM4Q1we757QTfBqriAnGhQcpS9bDGXlYv
	 LhZGPz27/NJpCcjYlflr10eIWkJWUeqdba+nbSv1LwAt+0e9LHAq8Ld7mo/iK7koS6
	 oGUtB9BuXGypf4EXO5jHC1Mk3ns11RqDgRn5sMPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfA2WbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfA2WbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:31:03 -0500
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8E12147A;
        Tue, 29 Jan 2019 22:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548801062;
        bh=8mchtL/kda+QX5rreOUh8RrpnFpvoBbcXfLnACnhg74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eEa7536ucEFh2k5Ul7LJ0hYHP6HXe8zryDPiyEvKTt3Zc6NSK69j+CM/EDjgHRGKL
         wBzBh72QsQ4krwy6gq9miA7v0WREbn6759yL1EQfi5YdpZgc9fTiraJg4u+BmgXbmM
         KEELf6bYMjkawB1SY17aJ/hQmYVx+kCmByef6tTE=
Received: by mail-yw1-f53.google.com with SMTP id d190so8842577ywd.12;
        Tue, 29 Jan 2019 14:31:02 -0800 (PST)
X-Gm-Message-State: AJcUukfYh8tIqJYFrLLAee7USsaPy2zvYltvirp4/07XwXrUwAXJgSLc
        sZ03KujdxyDu672rJhlTiwRLzQ3/KTqMM/qKE3M=
X-Google-Smtp-Source: ALg8bN6GhWFWtesdzm070o/hq2HKx2K6aegmLp5gXPZTHtol0adO1wDQtAS/UqGFgIeAwte4G+Sm2flA7dn1oEJbG48=
X-Received: by 2002:a81:8c1:: with SMTP id 184mr27309701ywi.392.1548801061366;
 Tue, 29 Jan 2019 14:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de>
In-Reply-To: <20190129200858.19773-1-goldsimon@gmx.de>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 29 Jan 2019 16:30:25 -0600
X-Gmail-Original-Message-ID: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
Message-ID: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 2:09 PM Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:

Hi Simon,

Thanks for submitting.   A couple of things...

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index f365003f0..8f6c1a5d6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -788,9 +788,9 @@
>                         reg = <0xfffec000 0x100>;
>                 };
>
> -               sdr: sdr@ffc25000 {
> +               sdr: sdr@ffc20000 {
>                         compatible = "altr,sdr-ctl", "syscon";
> -                       reg = <0xffc25000 0x1000>;
> +                       reg = <0xffc20000 0x6000>;

The binding doc will also need this change (in a separate patch)
Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

> diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
> index f2d7f883e..bd7759357 100644
> --- a/arch/arm/mach-socfpga/self-refresh.S
> +++ b/arch/arm/mach-socfpga/self-refresh.S
> @@ -19,8 +19,8 @@
>  #define MAX_LOOP_COUNT         1000
>
>  /* Register offset */
> -#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
> -#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
> +#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
> +#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058

These offsets are used for ldr/sdr and are limited to 12 bits.  This
won't build if CONFIG_SOCFPGA_SUSPEND is enabled.

/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:
Assembler messages:
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:65:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:67:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:72:
Error: bad immediate value for offset (20568)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:101:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:103:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:108:
Error: bad immediate value for offset (20568)
/home/atull/repos/linux-socfpga/scripts/Makefile.build:367: recipe for
target 'arch/arm/mach-socfpga/self-refresh.o' failed

Thanks,
Alan
