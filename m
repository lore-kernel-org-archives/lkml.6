Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4396D218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AOzEpjcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLXJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:15:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45628 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeLXJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:15:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBO9FebE038535;
        Mon, 24 Dec 2018 03:15:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545642940;
        bh=/441wN8vu3oDMHP/Kav056s1tNR9HOB1yMrlVJX0HzA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AOzEpjcF2xGN+Alxht+6ZGV5Z6D4InL2t0oAedX4oTwrbRlCK8b8Ke8srJVRkatwV
         x7BkCcCBp7SeHFNPaK/EkZfc15MPaASCaCUa6xx7Q6loOCNatcr9BOG0sdulXlf/Y8
         YVrtsQ47Ous0Omh6rcxD+x7Lj/tbgfl20+PT2N9g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBO9FePH095783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Dec 2018 03:15:40 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 24
 Dec 2018 03:15:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 24 Dec 2018 03:15:40 -0600
Received: from [172.22.217.62] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBO9FWL6015898;
        Mon, 24 Dec 2018 03:15:34 -0600
Subject: Re: [PATCH 1/2] dt-bindings: regulator: extend tps65218 bindings
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <85cd3c92-8b13-495f-7ef5-dd1bebd46b64@ti.com>
Date:   Mon, 24 Dec 2018 14:45:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2018 1:35 PM, Christian Hohnstaedt wrote:
> Add input voltage configuration options
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>   Documentation/devicetree/bindings/regulator/tps65218.txt | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
> index 02f0e9b..a9ee377 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65218.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -16,12 +16,22 @@ Required properties:
>     regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
>     Each regulator is defined using the standard binding for regulators.
>   
> +Optional properties:
> +  If any of these properties is absent, the setting will not be touched.

I would reword this to:

"If any of these properties is absent then the corresponding setting 
will be untouched"

> +- strict-supply-voltage: <1|0> Set/Reset STRICT flag in CONFIG1

This is too less info on the strict bit:

You can perhaps add some more description from data sheet.

The Supply Voltage supervisor has two modes of operation, controlled by 
the STRICT bit. With the STRICT bit set to 0, all
enabled rails of the five regulators are monitored for undervoltage only 
with relaxed thresholds and
deglitch times. With the STRCT bit set to 1, all enabled rails of the 
five regulators are monitored for
undervoltage and overvoltage with tight limits and short deglitch times.

> +- under-voltage-limit: Select 2.75, 2.95, 3.25 or 3.35V as UVLO in CONFIG1

Again some more description on uvlo please.

> +- under-voltage-hysteresis: Select 200mV or 400mV UVLOHYS in CONFIG2

Even here for hysteresis.

> +
>   Example:
>   tps65218: tps65218@24 {
>   	reg = <0x24>;
>   	compatible = "ti,tps65218";
>   	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
>   	interrupt-controller;
> +	strict-supply-voltage = <1>;
> +	under-voltage-hysteresis = <400000>;
> +	under-voltage-limit = <3350000>;
> +
>   	#interrupt-cells = <2>;
>   
>   	dcdc1: regulator-dcdc1 {
> 
