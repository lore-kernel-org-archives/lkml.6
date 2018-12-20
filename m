Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFA20866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSKHF2Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbeLTMee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:34:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40529 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbeLTMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:34:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so1209807lfe.7;
        Thu, 20 Dec 2018 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vg+IqngfjhTQ/KUtyzdiBE7OmEUDfdJN1SFzJd+Eo5k=;
        b=JSKHF2RlIaeRkRQ4gMY2We04ewJmer/ID6K4mqx2KzZCHdw2+A1++Sw+PRqZbpjOp/
         diqwmuJ0qm2ht7I2i42ByZ6HLL1DxGnxWQtz/RNOryv+5Nh6Tafn5Tz7BHtWOCWmrRMs
         ukFej+I848P1p+zQhSZvS3p3Ehf6yQu/XpNsccE/AfNfKbyi3h6lGvSWywES2nw5QRKY
         s7K5ltRg0Td2HTAmHDiLkpGC9nKM9WnZUxp1k4qX/3O/dcYg2Pr9vrRsW/lXqJEc2s66
         GcsdCQfy3HJDGcy64OJLE5EN/QSTbIy5rezJUNGFUAMKYW64nCDZuaISouEtj3OTIqK1
         V+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vg+IqngfjhTQ/KUtyzdiBE7OmEUDfdJN1SFzJd+Eo5k=;
        b=J4nT4hPgaYsQyiSo/vj1tm6RPefXA785x1/IGX+5V/GUtiGmUqrIy5CKI91fNSDiaH
         6J5hxJx0MULf0BBuJYnLwvWo9M5PFwhRdVXthhUuL+R/926a/j6FcIYSfYCIXSMgeWj5
         S4nWJzES9k5xibIh4kdo2a/Zz6TbKfuYWY8EPizJHaQQ0WdxN23AGYUpVWk0emIu/AjZ
         lBXYixJTCvXrrao/yTEzqgnArrpsR+5Sq23hYib7sfhf+9dGmTQyxk4Y/5wrrQk9V93t
         lE2F5S1RbCOYpu0g1QGSQ91vE0IxKpRsxFFZXFACdrU07lVTgR+izPwF8MJQID3wF1+5
         t6Rw==
X-Gm-Message-State: AA+aEWawAXD5evEoAS95r38AA8/Xx4LzWAAUtwwTSyqNNTnbrTFFsdwB
        OWPvxLaXwbD8XeXfyKhcZ50=
X-Google-Smtp-Source: AFSGD/Wn7gCz8dru5vOgCoFVv7vSk8oKA8aVmQ6gkq1Ijpl4NsKrVGx3HnazjmNLfASOHP0rW8k4lw==
X-Received: by 2002:a19:df41:: with SMTP id q1mr15836687lfj.25.1545309269699;
        Thu, 20 Dec 2018 04:34:29 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id d2sm4435168lfg.16.2018.12.20.04.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:34:28 -0800 (PST)
Subject: Re: [PATCH v4 8/8] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
To:     Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     thierry.reding@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-8-dev@pschenker.ch>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9c380fe2-2db8-8bc6-15b6-d112f982b70a@gmail.com>
Date:   Thu, 20 Dec 2018 15:34:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212130649.15146-8-dev@pschenker.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philippe,

Please CC all the patches in the series to every recipient.

On 12.12.2018 16:06, Philippe Schenker wrote:
> Add the stmpe-adc DT node as found on Toradex T30 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v4:
>  - New separate commit to hold T30 devicetree changes
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
>  2 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 7f112f192fe9..850b0d13549a 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -976,11 +976,18 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
> +			/* forbid to use ADC channels 3-0 (touch) */>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -990,17 +997,16 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;

Does this change depend on some other patch in the series? Is this a backwards-compatible change? Please explain.

>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index 35af03ca9e90..1f9198bb24ff 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -845,11 +845,18 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
> +			/* forbid to use ADC channels 3-0 (touch) */
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -859,17 +866,16 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> 

