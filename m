Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5463208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="GH56QhWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5463208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK0KXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:23:50 -0500
Received: from vern.gendns.com ([98.142.107.122]:58056 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbeK0KXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OzpzA9BJf7/SLSzjqdKpFAfgkQshNkysSCIMi97enE4=; b=GH56QhWmoWaLoxD1oT/FXZjYQ5
        hULejPusBhY/yVYiSGWZbhASvr00Bkg2/6ulL4cjA1GiWDnTezqjrxClkxpQ0pIK2U/66333K1bFD
        1gwjrnRTSmycow/WnT4fcK/rIF83snb2q7TPfVWfPRHFOSKRUuR4RxZGdGM0z9pfWyHGFAWkPI4l3
        G93+wzZTAUiveDy5VacoPL/zwmpARYOkkbNivM9omQVoABY9K7C9Qs1BsH6cADTWLdC7iEuV10z1c
        jZxVCwGRlCU6TdcUL0vZ2qf7SM+8LLvY1h7axCEIPMFj8efVEdEc4O6wiN2cYBEgogAU8Innyfq3m
        S6VzS2oA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:46016 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gRQHU-0002nH-VA; Mon, 26 Nov 2018 18:27:09 -0500
Subject: Re: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document
 application node bindings
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-13-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <6a945433-00b2-e0e5-2dc8-2a4d2bf0db6f@lechnology.com>
Date:   Mon, 26 Nov 2018 17:27:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543218769-5507-13-git-send-email-rogerq@ti.com>
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

On 11/26/18 1:52 AM, Roger Quadros wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add documentation for the Texas Instruments PRU application nodes.
> These are used to configure specific user applications for PRU instances.

Could this be made into a generic remoteproc producer/consumer binding? Or
are there really things that are specific to the TI PRU that need to be
handled?

> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [s-anna@ti.com: some binding updates]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> index 3e5f32f..94c91ee 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
> @@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
>   Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
>   
>   
> +Application/User Nodes
> +=======================

Are these supposed to be stand-alone platform devices?

> +A PRU application/user node typically uses one or more PRU device nodes to
> +implement a PRU application/functionality. Each application/client node would
> +need a reference to at least a PRU node, and optionally pass some configuration
> +parameters.

I thought device tree is not supposed to be used for configuration.

> +
> +Required Properties:
> +--------------------
> +- prus                 : phandles to the PRU nodes used
> +
> +Optional Properties:
> +--------------------
> +- firmware-name        : firmwares for the PRU cores, the default firmware
> +                         for the core from the PRU node will be used if not
> +                         provided. The firmware names should correspond to
> +                         the PRU cores listed in the 'prus' property

Perhaps this should be a "compatible" property instead of "firmware-name"? The
driver that matches the compatible string can then set the firmware names.

> +- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
> +                         register for a PRU. This selects the internal muxing
> +                         scheme for the PRU instance. If not provided, the
> +                         default out-of-reset value (0) for the PRU core is
> +                         used. Values should correspond to the PRU cores listed
> +                         in the 'prus' property

Is this supposed to be a pinmux? So maybe we should be using pinmux bindings?

> +- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
> +                         with each entry consisting of 4 cell-values. First one
> +                         is an index towards the "prus" property to identify the
> +                         PRU core for the interrupt map, second is the PRU
> +                         System Event id, third is the PRU interrupt channel id
> +                         and fourth is the PRU host interrupt id. If provided,
> +                         this map will supercede any other configuration
> +                         provided through firmware

Could this mapping just be cells of the interrupt consumer nodes instead of an
extra property? As I mentioned in a reply to another patch, unless there is a
compelling reason to do otherwise, the channel to host mapping can be required
to be 1:1 as recommended in the TRMs, so that cell can be omitted. Also, since
the interrupt controller is independent of the PRU cores, the cell specifying the
index of the PRU core is not needed in this case. The #interrupt-cells already
includes a cell for the system event number, so this just leaves one cell, the
host channel, to be added to the #interrupt-cells.

So, instead of:

	ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;

we could have:

	interrupt-parent = <&pruss_intc>;
	interrupts = <16 7>, <19 3>;

There are also already alternate interrupt bindings that allow for the case
where there is more than one interrupt-parent.

> +
>   Example:
>   ========
>   1.	/* AM33xx PRU-ICSS */
> @@ -397,3 +429,14 @@ Example:
>   			...
>   		};
>   	};
> +
> +3:	/* PRU application node example */
> +	app_node: app_node {
> +		prus = <&pru1_0>, <&pru1_1>;
> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
> +		ti,pruss-gp-mux-sel = <2>, <1>;
> +		/* setup interrupts for prus:
> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
> +	}
> 

