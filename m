Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1EB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1EB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keep-it-simple.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbeKPWCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:02:24 -0500
Received: from martinlund.org ([173.255.130.145]:34299 "EHLO
        slmp-550-86.slc.westdc.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727767AbeKPWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:02:24 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41806)
        by slmp-550-86.slc.westdc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <martin.lund@keep-it-simple.com>)
        id 1gNcdh-00DguJ-K2
        for linux-kernel@vger.kernel.org; Fri, 16 Nov 2018 04:50:21 -0700
Received: by mail-oi1-f169.google.com with SMTP id g188-v6so19405232oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:50:21 -0800 (PST)
X-Gm-Message-State: AA+aEWZJipkGeBPhD50/4dPhyGMOXUZyQIwgbINzpPkQCGtjemb/EIcD
        53czyQtw3jRjsMLjt1vFlVsg6bbLhVEPL2StpDc=
X-Google-Smtp-Source: AJdET5cfXOJ38Hmw/r0IWW8PDZUdZkU08pv0m9lauCDKkb9EUkcjXni7hv2u0Kk9e4at4a3AmRsHArBq+48DtSv931s=
X-Received: by 2002:aca:be45:: with SMTP id o66-v6mr748362oif.164.1542369021146;
 Fri, 16 Nov 2018 03:50:21 -0800 (PST)
MIME-Version: 1.0
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Martin Lund <martin.lund@keep-it-simple.com>
Date:   Fri, 16 Nov 2018 12:50:10 +0100
X-Gmail-Original-Message-ID: <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
Message-ID: <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
To:     naga.sureshkumar.relli@xilinx.com
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        michals@xilinx.com, naga sureshkumar <nagasuresh12@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - slmp-550-86.slc.westdc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - keep-it-simple.com
X-Get-Message-Sender-Via: slmp-550-86.slc.westdc.net: authenticated_id: martin.lund+keep-it-simple.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: slmp-550-86.slc.westdc.net: martin.lund@keep-it-simple.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

I've been working on running up the latest kernel (v4.20-rc2) on our
custom Xilinx hw board so that I can test the v12 version of your
Arasan nand driver.

I've managed to get the driver successfully up and running and ready
for testing with a Micron MT29F64G08AFAAAWP device. However, setting
it up I've found a few inaccuracies in the documentation of the device
tree bindings.

This is the device configuration that ended up working for me with
linux v4.20-rc2:

       nfc: nand@ff100000 {
            compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10";
            reg = <0x0 0xff100000 0x0 0x1000>;
            clock-names = "clk_sys", "clk_flash";
            clocks = <&clk200>, <&clk100>;
            interrupt-parent = <&gic>;
            interrupts = <0 14 4>;
            #address-cells = <1>;
            #size-cells = <0>;

            nand@0 {
                reg = <0>;
                nand-ecc-mode = "hw";
            };
        };

Compared with the example you will notice that "clock-name" should be
"clock-names". reg was missing a "0x0".

I think it is helpful to provide a real-world working example, so you
might also consider changing the example "clocks" configuration to
clk200/clk100 since there is no clk_misc among the clock sources of
any of the xilinx zynqmp board device tree configurations.

Br, Martin

On Fri, Nov 9, 2018 at 6:00 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:
>
> This patch adds the dts binding document for arasan nand flash controller
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v12:
>  - Removed interrupt-parent description as it is implied as suggested by
>    Rob Herring
>  - Added missing ';' as required
> Changes in v11:
>  - Updated compatible description as suggested by Boris
>  - Removed arasan-has-dma property
> Changes in v10:
>  - None
> Changes in v9:
>  - None
> Changes in v8:
>  - Updated compatible and clock-names as per Boris comments
> Changes in v7:
>  - Corrected the acronyms those should be in caps
> Changes in v6:
>  - Removed num-cs property
>  - Separated nandchip from nand controller
> Changes in v5:
>  - None
> Changes in v4:
>  - Added num-cs property
>  - Added clock support
> Changes in v3:
>  - None
> Changes in v2:
>  - None
> ---
>  .../devicetree/bindings/mtd/arasan_nand.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> new file mode 100644
> index 0000000..b522daf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> @@ -0,0 +1,32 @@
> +Arasan NAND Flash Controller with ONFI 3.1 support
> +
> +Required properties:
> +- compatible:          Should be "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> +- reg:                 Memory map for module access
> +- interrupts:          Should contain the interrupt for the device
> +- clock-name:          List of input clocks - "sys", "flash"
> +                       (See clock bindings for details)
> +- clocks:              Clock phandles (see clock bindings for details)
> +
> +Required properties for child node:
> +- nand-ecc-mode: see nand.txt
> +
> +For NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +       nfc: nand@ff100000 {
> +               compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10";
> +               reg = <0x0 0xff100000 0x1000>;
> +               clock-name = "sys", "flash";
> +               clocks = <&misc_clk &misc_clk>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 14 4>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               nand@0 {
> +                       reg = <0>;
> +                       nand-ecc-mode = "hw";
> +               };
> +       };
> --
> 2.7.4
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
