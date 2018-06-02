Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeFBGcq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeFBGcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:32:43 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Faiz Abbas <faiz_abbas@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180530141133.3711-6-faiz_abbas@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        paul@pwsan.com, t-kristo@ti.com, faiz_abbas@ti.com
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
Message-ID: <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module node for
 MCAN
Date: Fri, 01 Jun 2018 23:32:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526Wqfs004068

Quoting Faiz Abbas (2018-05-30 07:11:32)
> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
> index bfc82636999c..57b8dc0fe719 100644
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -11,6 +11,25 @@
>  / {
>         compatible = "ti,dra762", "ti,dra7";
>  
> +       ocp {
> +
> +               target-module@0x42c00000 {

Drop the 0x on unit address. Also, it should match the first register
property. And what is a "target-module"?

> +                       compatible = "ti,sysc-dra7-mcan";
> +                       ranges = <0x0 0x42c00000 0x2000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       reg = <0x42c01900 0x4>,
> +                             <0x42c01904 0x4>,
> 
