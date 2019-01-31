Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B400420881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OlQ3jKPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbfAaPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:53:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732719AbfAaPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:53:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so3857272wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dRc25rJI4tiY9YddNYzEMJbcEVjclgz0jDWxqWuLBkY=;
        b=OlQ3jKPt0e+wq3C9F5WDwXSXYLFySYQaZ6OQwJE2w2EYhRHqF3aWfknP0xqKwzTDdw
         HqBkaNpoEIad9OWzPv4CTryj856Iqu1ypGeOcuohgbLZuBG3+CYhdR9kf8pWoUgPPkgK
         76xYVQirOZ0PvBOMfkUXuH8Rqb9NGa0KLCTsb3R8CySo5YXRtvh80LFbWPGBnNsjp7UO
         qqPZB8L0l/9ICqngEBeu0kUTw0bGQfnYszLF5o+D/SFEDlCYb9a3mH5tXq88hywxXb7B
         +FyUQlZHRjgUec+pfYOgaQmGXIncQiDWbV78G+yRUK4CgUTN9dgW043M31CfNuS7z4A4
         caNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dRc25rJI4tiY9YddNYzEMJbcEVjclgz0jDWxqWuLBkY=;
        b=RgLdoLoI3CjNZDVrwb9mKfbqIuRibUOwM2xfcyx+tQhjbrBzXYzEdKlBMTfoE4MFnS
         oqo1FTXwl7OqqKoEfo/yT0SiOw8HPqiVTIgq97uCXv35JlRL0wfu48vzHuvZpwuQ56yv
         W7TXbcgddaU4w6ycS/5atlFocfyST+rDa6qA+IL0PHxpoSJsPa8EZuX85FMfZHHDUnGw
         K7PAchqtiYuYp6D2l0xkpHb2AM+qk3br/I+ZGOjpU6/gI/FPhNxLKAtwt7XULIuvOCWP
         F6rDCyseCugglhNL43KEIHvnI+4aYYMDp2S+Ql5SY7eNZ5aH4QO3L5acKO+OcZ4wIN5v
         8Gvw==
X-Gm-Message-State: AHQUAuaAbgaFIIEt465k+hE9NvspVTvTitzXClsqtDTt1zZgH6O7LFWZ
        BgRQiNFBTTKRd6SxgsnGeY+6vd4lfYqUIg==
X-Google-Smtp-Source: AHgI3IaZvF35krU5Qg3S0VCHbPpFKFze/vzbgQEdKDnaYwl468v1xil3psuQgla66MfRs7gYEPnLBg==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr14559070wrp.92.1548950015241;
        Thu, 31 Jan 2019 07:53:35 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s66sm3857891wmf.34.2019.01.31.07.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:53:34 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: gpu: add bindings for the ARM Mali Bifrost
 GPU
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190131132939.2263-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0d80f33a-32ba-4d87-0f40-bd5a4b7d23c0@baylibre.com>
Date:   Thu, 31 Jan 2019 16:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131132939.2263-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 14:29, Neil Armstrong wrote:
> Add the bindings for the Bifrost family of ARM Mali GPUs.
> 
> The Bifrost GPU architecture is similar to the Midgard family,
> but with a different Shader Core & Execution Engine structures.
> 
> Bindings are based on the Midgard family bindings, but the inner
> architectural changes makes it a separate family needing separate
> bindings.
> 
> The Bifrost GPUs are present in a number of recent SoCs, like the
> Amlogic G12A Family, and many other vendors.
> The Amlogic vendor specific compatible is added to handle the
> specific IP integration differences and dependencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.txt         | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> new file mode 100644
> index 000000000000..a632f5136b08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> @@ -0,0 +1,94 @@
> +ARM Mali Bifrost GPU
> +====================
> +
> +Required properties:
> +
> +- compatible :
> +  * Must contain one of the following:
> +    + "arm,mali-g71"
> +    + "arm,mali-g51"
> +    + "arm,mali-g72"
> +    + "arm,mali-g76"

Wrong order and forgot the G31 and G52 cores.

Neil

> +  * which must be preceded by one of the following vendor specifics:
> +    + "amlogic,meson-g12a-mali"
> +
> +- reg : Physical base address of the device and length of the register area.
> +
> +- interrupts : Contains the three IRQ lines required by Mali Bifrost devices.
> +
> +- interrupt-names : Contains the names of IRQ resources in the order they were
> +  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
> +
> +
> +Optional properties:
> +
> +- clocks : Phandle to clock for the Mali Bifrost device.
> +
> +- mali-supply : Phandle to regulator for the Mali device. Refer to
> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +
> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> +  for details.
> +
> +- resets : Phandle of the GPU reset line.
> +
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accomodate those differences, you have the option
> +to specify one more vendor-specific compatible, among:
> +
> +- "amlogic,meson-g12a-mali"
> +  Required properties:
> +  - resets : Should contain phandles of :
> +    + GPU reset line
> +    + GPU APB glue reset line
> +
> +Example for a Mali-G71:
> +
> +gpu@ffa30000 {
> +	compatible = "amlogic,meson-g12a-mali", "arm,mali-g71";


It's a typo, it's a G31 on Amlogic G12A, anyway the example is still valid.

> +	reg = <0xffe40000 0x10000>;
> +	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "job", "mmu", "gpu";
> +	clocks = <&clk CLKID_MALI>;
> +	mali-supply = <&vdd_gpu>;
> +	operating-points-v2 = <&gpu_opp_table>;
> +	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
> +};
> +
> +gpu_opp_table: opp_table0 {
> +	compatible = "operating-points-v2";
> +
> +	opp@533000000 {
> +		opp-hz = /bits/ 64 <533000000>;
> +		opp-microvolt = <1250000>;
> +	};
> +	opp@450000000 {
> +		opp-hz = /bits/ 64 <450000000>;
> +		opp-microvolt = <1150000>;
> +	};
> +	opp@400000000 {
> +		opp-hz = /bits/ 64 <400000000>;
> +		opp-microvolt = <1125000>;
> +	};
> +	opp@350000000 {
> +		opp-hz = /bits/ 64 <350000000>;
> +		opp-microvolt = <1075000>;
> +	};
> +	opp@266000000 {
> +		opp-hz = /bits/ 64 <266000000>;
> +		opp-microvolt = <1025000>;
> +	};
> +	opp@160000000 {
> +		opp-hz = /bits/ 64 <160000000>;
> +		opp-microvolt = <925000>;
> +	};
> +	opp@100000000 {
> +		opp-hz = /bits/ 64 <100000000>;
> +		opp-microvolt = <912500>;
> +	};
> +};
> 

