Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2922C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE17218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545341486;
	bh=1FqKb1GpG+S9VoO7X/l5EZuqFJuSUyVphvXlILoc0yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dAo///9pmBhz82/TI4cs4kLXjtLexvN2QzDvhU3VMKik+oDu0DYo+7XasvbT0khew
	 m7aVV+obc5xxTXMiL+iPQDFWchWNVqHzvZdi3A4BEiPU+W0cg5sg1mFX1h+bdFvvSb
	 zvVWxbAD3KiN5iUUlDtFsckps8+MjCqOeRuf89JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbeLTVbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:31:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44074 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:31:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so3106769oig.11;
        Thu, 20 Dec 2018 13:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gf+h2AhWr0ZeBTfaM0rmwldFKBNFrJgqCEN8pBT818o=;
        b=S+ltHeI0IT0sEurmy0OhtB6iUczuNS2cFjY3pWz1+wheUmvT7lY8NhTbpdeg3ny9C7
         r61IGXQiFSYrfw/XRXF8nE1JPiagXYbEH1u9+6u0Dceyrf09YoRzN22lN17FZwx8NxIN
         J3drsOKuKPI0cM/Yi2w2la4ZeQ3l1C8jU+s4NQpfqcN/DACb8XecUhtzsZOtdXhosGGO
         MsVAlCize57lJ9IJFV/73pu4RPsKJVPqpl45mOSASPVB6qth+kSunUYa3WWFsSU8l2QU
         WqgB45T5XWI9CUExRgqYSuSNYqLSxyb6P/bP1HbIWIyMkG3pJLE9IvQIYgFeXxnt/s+n
         f5Zw==
X-Gm-Message-State: AA+aEWbTy0elW+Df9MTzBYnFPXHSJaR1bVxyePhGdv0Jfh0MNhQlmrfX
        etUSUbYN2brsNsUmKQEO/w==
X-Google-Smtp-Source: AFSGD/X+eQWYNul+hjHdxrIEy4EuRkOivVA+V0BovFnLtSLVvyZgdKknXjRvl2baVbKiD5kjxknw2Q==
X-Received: by 2002:aca:ad53:: with SMTP id w80mr262988oie.148.1545341483984;
        Thu, 20 Dec 2018 13:31:23 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id c78sm16608450oig.30.2018.12.20.13.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:31:23 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:31:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] riscv: dts: add initial board data for the SiFive
 HiFive Unleashed
Message-ID: <20181220212618.GA27359@bogus>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
 <20181215052154.24347-8-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-8-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:21:54PM -0800, Paul Walmsley wrote:
> Add initial board data for the SiFive HiFive Unleashed A00.
> 
> Currently the data populated in this DT file describes the board
> DRAM configuration and the external clock sources that supply the
> PRCI.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/riscv/boot/dts/Makefile                  |  2 +
>  arch/riscv/boot/dts/sifive/Makefile           |  4 ++
>  .../dts/sifive/hifive-unleashed-a00-fu540.dts | 39 +++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/Makefile
>  create mode 100644 arch/riscv/boot/dts/sifive/Makefile
>  create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> new file mode 100644
> index 000000000000..dcc3ada78455
> --- /dev/null
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +subdir-y += sifive
> diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
> new file mode 100644
> index 000000000000..e120ccf5649c
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00-fu540.dtb
> +
> +
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> new file mode 100644
> index 000000000000..0c6afabe69e3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0-or-later

This should be a single line with: (Apache-2.0 OR GPL-2.0+)

> +/* Copyright (c) 2018 SiFive, Inc */
> +/* See the file LICENSE for further information */
> +
> +/dts-v1/;
> +
> +#include "fu540-c000.dtsi"
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "SiFive HiFive Unleashed A00 (FU540-C000)"
> +	compatible = "sifive,hifive-unleashed-a00-fu540",
> +		"sifive,hifive-unleashed-fu540";

SoC compatible should be here too.

> +
> +	chosen {
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x1f 0x80000000>;
> +	};
> +
> +	soc {
> +		hfclk: hfclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <33333333>;
> +			clock-output-names = "hfclk";
> +		};
> +		rtcclk: rtcclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000000>;
> +			clock-output-names = "rtcclk";
> +		};

Are these the clock inputs to the SoC or dummy clocks until you write a 
proper clock driver? If the former, they should be at the top level. 

Rob
