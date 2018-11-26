Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B5EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED352086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="BWZwZ2Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED352086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeK0Dur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:50:47 -0500
Received: from vern.gendns.com ([98.142.107.122]:46184 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeK0Dur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UFjBS/labiZ32c6m6z/ujlYF1EXLTJ+qVF9qoQcH+Lk=; b=BWZwZ2UhLn/MHzV1w0rS1m9beH
        EKN1t7/ULJ5PhG/mc65LBjgJ+LqVq2ubocfX6bLQrJ13iY2GiwusKttQgSiA5DKk7P1dmG03bdZfq
        GgpPNylZFvrEK3tazDLCJjv1eHgmilrCHXJBpeeSgjgbD2VA0z15ErCaLQAM0gZG2vP3TqJSkSkBg
        b+TKID5j8Hox3NRtqX0flzJG67heLeB/taTPzDUnRsctyWu+2k/AfJlpQcSwGf01p5mpI6JbELDBZ
        5bv4wI+kt2p8I0FhcMhdW/uKLcSusGaf49UVrkCuzrAZfsV07Z/YXZvKLb6EbjM7kuineIZ81VGr8
        JNqSUM1w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41648 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gRJsB-0007xH-7W; Mon, 26 Nov 2018 11:36:35 -0500
Subject: Re: [PATCH 15/17] ARM: dts: AM33xx: Add the PRU-ICSS DT nodes
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-16-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <55dc1462-b154-8e57-c352-88f8ff28a708@lechnology.com>
Date:   Mon, 26 Nov 2018 10:37:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-16-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the DT nodes for the PRU-ICSS on AM33xx family of SoCs. The
> AM33xx SoCs contain a single PRU-ICSS instance and is represented
> by the pruss-soc-bus node and a child PRUSS node. PRU-ICSS is not
> supported on AM3352 SoC though in the AM33xx family, so the nodes
> are added in disabled state to the common am33xx dtsi file. They
> should be enabled in only those derivative board files that use
> a SoC containing PRU-ICSS.
> 
> The PRUSS subsystem node contains the entire address space and
> the various interrupts generated towards the main MPU. The various
> sub-modules of the PRU-ICSS are represented as individual child
> nodes (so platform devices themselves) of the PRUSS subsystem node.
> These include the two PRU cores and the interrupt controller. The
> Industrial Ethernet Peripheral (IEP), the Real Time Media Independent
> Interface controller (MII_RT), and the CFG sub-module are represented
> as syscon nodes. All the Data RAMs are represented within a child
> node of its own named 'memories' without any compatible.
> 
> The DT nodes use all standard properties. The regs property in
> the PRU nodes define the addresses for the Instruction RAM, the
> Debug and Control sub-modules for that PRU core. The firmware for
> each PRU core is defined through a 'firmware-name' property.
> 
> The default names for the firmware images for each PRU core are
> defined as follows (these can be adjusted either in derivative
> board dts files or through sysfs at runtime if required):
>       PRU-ICSS PRU0 Core: am335x-pru1_0-fw
>       PRU-ICSS PRU1 Core: am335x-pru1_1-fw
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index d3dd6a1..ce42cd9 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -924,6 +924,78 @@
>   			};
>   		};
>   
> +		pruss_soc_bus: pruss_soc_bus@4a326004 {
> +			compatible = "ti,am3356-pruss-soc-bus";
> +			reg = <0x4a326004 0x4>;
> +			ti,hwmods = "pruss";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			pruss: pruss@4a300000 {

<snip>

> +
>   		elm: elm@48080000 {
>   			compatible = "ti,am3352-elm";
>   			reg = <0x48080000 0x2000>;
> 

This doesn't apply cleanly to next-20181126. elm: elm@48080000 node
is not there. If it was, it seems like the pruss node should be after
instead of before to keep things sorted since 4a300000 > 48080000.
