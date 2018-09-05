Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AB92075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AB92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIEOuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:50:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIEOup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:50:45 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u2RLWBslu0gz; Wed,  5 Sep 2018 12:20:54 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0688C1EC02AE;
        Wed,  5 Sep 2018 12:20:53 +0200 (CEST)
Date:   Wed, 5 Sep 2018 12:20:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com, mchehab@kernel.org,
        leoyang.li@nxp.com, amit.kucheria@linaro.org, olof@lixom.net,
        sgoud@xilinx.com, anirudh@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 4/4] arm64: zynqmp: Add DDRC node
Message-ID: <20180905102053.GE2237@zn.tnic>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535722070-10394-5-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:57:50PM +0530, Manish Narani wrote:
> Add ddrc memory controller node in dts. The size mentioned in dts is
> 0x30000, because we need to access DDR_QOS INTR registers located at
> 0xFD090208 from this driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 29ce234..a81d3b16 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -355,6 +355,13 @@
>  			xlnx,bus-width = <64>;
>  		};
>  
> +		mc: memory-controller@fd070000 {
> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
> +			reg = <0x0 0xfd070000 0x0 0x30000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 112 4>;
> +		};
> +
>  		gem0: ethernet@ff0b0000 {
>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
> -- 

This still needs Rob's ACK.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
