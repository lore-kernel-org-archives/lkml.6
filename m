Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C28C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F921A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wJA6rjEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197F921A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbeHFR2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbeHFR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:28:37 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9F921A51;
        Mon,  6 Aug 2018 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568742;
        bh=PkZG50FcGw1TCROBAmEn1G3W3HCxbuWOi6YXHUxmWBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wJA6rjEQYbCR2lZYe+84IgGnbgDHDbV6b+t2D55Bb0RRxs9dnE7wtM4trZONXVvOy
         y2N7gw4FaWZllYNaybCkYrOMtiqLOITioNkUUmscXyEzKm+Jq+xaHjrsebrYlTQ1DF
         lzhs5fhRRPk0Jou/c1BFgPSNBUVYWtG88gYtIyIs=
Received: by mail-qt0-f174.google.com with SMTP id h4-v6so14190577qtj.7;
        Mon, 06 Aug 2018 08:19:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlHySD0EWxwB0n3NPzxoRLlt4AqEojpuXeSKBmrzg9je1mEJqRZA
        ZuIbO9bExZ/kaQ9i7Zi30aT06RzR7Zno94sUkg==
X-Google-Smtp-Source: AAOMgpculylW5ApuS8QKZ8DhANm5A3dq17wp0/dgsansz5h73MdMgfmS93BZF2kEKqhO5DSpoxtUgDQpq06MBo3LAzI=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr14448536qtp.22.1533568741064;
 Mon, 06 Aug 2018 08:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-4-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-4-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:18:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
Message-ID: <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] dt-bindings: clk: Add documentation of grx500
 clock controller
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>
> This patch adds binding documentation for grx500 clock controller.
>
> Signed-off-by: YiXin Zhu <yixin.zhu@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2:
> - Rewrite clock driver's dt-binding document according to Rob Herring's
>   comments.
> - Simplify device tree docoment, remove some clock description.
>
>  .../devicetree/bindings/clock/intel,grx500-clk.txt | 39 ++++++++++++++++++++++

Please match the compatible string: intel,grx500-cgu.txt

>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> new file mode 100644
> index 000000000000..e54e1dad9196
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> @@ -0,0 +1,39 @@
> +Device Tree Clock bindings for grx500 PLL controller.
> +
> +This binding uses the common clock binding:
> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +The grx500 clock controller supplies clock to various controllers within the
> +SoC.
> +
> +Required properties for clock node
> +- compatible: Should be "intel,grx500-cgu".
> +- reg: physical base address of the controller and length of memory range.
> +- #clock-cells: should be 1.
> +
> +Optional Propteries:
> +- intel,osc-frequency: frequency of the osc clock.
> +if missing, driver will use clock rate defined in the driver.

This should use a fixed-clock node instead.

> +
> +Example: Clock controller node:
> +
> +       cgu: cgu@16200000 {
> +                compatible = "intel,grx500-cgu", "syscon";
> +               reg = <0x16200000 0x200>;
> +               #clock-cells = <1>;
> +       };
> +
> +
> +Example: UART controller node that consumes the clock generated by clock
> +       controller.
> +
> +       asc0: serial@16600000 {
> +               compatible = "lantiq,asc";
> +               reg = <0x16600000 0x100000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
> +               clock-names = "freq", "asc";
> +       };
> --
> 2.11.0
>
