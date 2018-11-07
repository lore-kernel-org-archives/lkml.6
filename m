Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C8BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef5IIWnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbeKGNw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:52:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42871 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeKGNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:52:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so7275368plo.9;
        Tue, 06 Nov 2018 20:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4sgxXEOdOs3QCD+MDooRCjKxkaKA1vtlr59+tLG9PLU=;
        b=ef5IIWnpyVTxqkFiW5I1n74ro5hJiMfSi9qzMlLiAXq5krxFF4GAzkC6yhpZaMQvRk
         8kBBIlD67r8tBlYQ9Jz45TwSu2bIsjbjXQ6LEVojETMCeZ/gBRnZuelx+eFRnya+EYre
         t0q7eMgd0n5/0RKQ9nprenaY5lDCVyWOxDQfDcVq4ejln4+YtU7/Z55gHvKyp/n6EBST
         YFkSGBN+vowMmoA/dYXxI5R8/mwUPoiYbYrKpOc2qxta4/6DIdZsx1s1kOV0R3jgcdAo
         ZEGK9hcrrGmZtLFxMWwRP98Vj8WThcuTwmdSH5S8S/SDXEpXtwzOJRfb5uO5lWku0NCA
         cmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sgxXEOdOs3QCD+MDooRCjKxkaKA1vtlr59+tLG9PLU=;
        b=WXuBiC5+Fqmgzqf8NVKmMto02jXyt9npj6FDTg3rmvMns0a697Mz+4tv+5TGk/OJXR
         xnkdpy4PWjpzJnRTog+vgqnvM/y1eUDOvRA03gCuYjTBN2jCfXXCJdD2U5RpK67ZjSvS
         fDPeaZ/Pn3DB7VspCDzmOJRvWeD3nL+wKOZq6MCLoIQO8UbBXv7NPHNwoJPgQpX2kyvh
         HfGIlZLBk0ny6nFoU3W7tqGHLKx1oYlNFLH2UD9BsL1Dh9PNVrcHtg+NYhC3ycXj6CTR
         mKIfDi8GjF9k17gMIWFYalu/TAeQvKiYVxnfEgwZZvz5LWFa9uuQ/hyHoOPP6rdDs9Sw
         VWig==
X-Gm-Message-State: AGRZ1gLb046KsC2njoSfaLKDNFZ5Ut2SVj+XL6NshFWlw+bqhG0uS2XK
        zPQI/GeDbrZ2YrAA8u76t38=
X-Google-Smtp-Source: AJdET5f4tSZucOV+Ds6fYdXX36gyNghxPwyOjOdVXdV7oD3ivTI+E/EPdkoZc+hxpaoGzeyj1PPMhg==
X-Received: by 2002:a17:902:8346:: with SMTP id z6-v6mr367216pln.147.1541564661658;
        Tue, 06 Nov 2018 20:24:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18-v6sm42768319pgg.88.2018.11.06.20.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 20:24:20 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
 <20181107040010.27436-2-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <64720b73-dddf-783c-a3a4-3f32a748bf5d@roeck-us.net>
Date:   Tue, 6 Nov 2018 20:24:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107040010.27436-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 8:00 PM, Chris Packham wrote:
> With the addition of the invert-pwm property the adt7475 needs its own
> binding documentation rather being captured under trivial-devices.txt.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>   .../devicetree/bindings/hwmon/adt7475.txt     | 22 +++++++++++++++++++
>   .../devicetree/bindings/trivial-devices.txt   |  4 ----
>   2 files changed, 22 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> new file mode 100644
> index 000000000000..79255439e157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> @@ -0,0 +1,22 @@
> +*ADT7475 hwmon sensor.
> +
> +Required properties:
> +- compatible: One of
> +	"adi,adt7473"
> +	"adi,adt7475"
> +	"adi,adt7476"
> +	"adi,adt7490"
> +
> +- reg: I2C address
> +
> +optional properties:
> +
> +- invert-pwm: This configures the PWM to use logic low for 100% duty cycle.
> +
> +Example:
> +
> +hwmon@2e {
> +	compatible = ;
> +	reg = <0x2e>;
> +	invert-pwm;

If I understand correctly, the flag is set per pwm channel. A single global
property seems inappropriate.

Guenter

> +};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index 69c934aec13b..4f29100d6bbf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -14,10 +14,6 @@ ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert an
>   ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
>   adi,adt7461		+/-1C TDM Extended Temp Range I.C
>   adt7461			+/-1C TDM Extended Temp Range I.C
> -adi,adt7473		+/-1C TDM Extended Temp Range I.C
> -adi,adt7475		+/-1C TDM Extended Temp Range I.C
> -adi,adt7476		+/-1C TDM Extended Temp Range I.C
> -adi,adt7490		+/-1C TDM Extended Temp Range I.C
>   adi,adxl345		Three-Axis Digital Accelerometer
>   adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
>   ams,iaq-core		AMS iAQ-Core VOC Sensor
> 

