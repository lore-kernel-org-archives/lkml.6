Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC20C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45105217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWLL+vcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45105217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHDOTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:19:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34251 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHDOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:19:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so7232673wme.1;
        Sat, 04 Aug 2018 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IVRAW8VwXdrJ0tGLRugi2JMl3Cz2zYU4PINvvipaTD8=;
        b=SWLL+vclShGiPopwQx2+AkuRuXJ9YL2NC2GO9S++smiVrOWMi13fqwlYVlOzxNZsvA
         1dOr54eUEdQMq+SqTYfoBssyoMN0UrF70T09nTIpIzkIGaRcS3Y8850iv5QoQFxcA0Jp
         r+a8LIB/bATROhtTpDtJ+DdBeJylS9Qy6n3p+sdOPWpjeIGO39dV9wX2mH0/iLFmrknb
         es1ZpsJ1InvbhAmTcbfcSL6cJkCEZ/u2sDk43j+7zvrXajWDbl183RmcXvXvbQnoo+oi
         4+2LNV9PCiXx+v7GB2zfYk72s6giCC6+YGFp6kHzL06Rq6HhJygF/JO5C33DNRT3/g8V
         S6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVRAW8VwXdrJ0tGLRugi2JMl3Cz2zYU4PINvvipaTD8=;
        b=RZLydY/k1IqR1pmLL373953qR2/VjbTQSWbtkI0CLD1lu/O+oojVLxkCe129V6K5dg
         o2oeVEINZyxzti86XSO7/QBS/6eobSIyKN/Iuw/ZXjoEoIa7Ha8HwEeHFKhPyA3+xbrJ
         LYnRcknnZSgTUzE4/xJIjHzfmP06vvEyd+WD5rIGbAG20bheC1gy7MBkSZhsd5MHhycb
         AJNcl7kGdGrPq10vebKtpqifrvoh3V6ieiCDHtqIL+BDBLc0QB/8JoDhWh3k/opcbctt
         Zg8+1bRhTQ35k1M6ADHwctQeZpF4tr0xNGSlj5/uIhTsSnBQ5d6yGocZR93SWvMekIUl
         eQtA==
X-Gm-Message-State: AOUpUlFOM3PlpGs7HYtPUnyx8nRzLkS6SfIXlfYOYB+G4WrAwXdwlJkX
        hNrfLY2NhmpM+Ss7GTpO3j8RLhP9
X-Google-Smtp-Source: AAOMgpew0QLNlWAYD6iKCTDKRFX9d4KTobMRQy3Dbelrx+80ipJoNIO4u3H/DLsQiuavnmSfMgMfMA==
X-Received: by 2002:a1c:415:: with SMTP id 21-v6mr7637956wme.128.1533385130812;
        Sat, 04 Aug 2018 05:18:50 -0700 (PDT)
Received: from [192.168.1.18] (bky33.neoplus.adsl.tpnet.pl. [83.28.192.33])
        by smtp.gmail.com with ESMTPSA id x7-v6sm9444444wrr.95.2018.08.04.05.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 05:18:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] di: bindings: lm3697: Introduce the lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180803150231.7172-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <54ff1f05-7f0f-4a6f-a67c-d671056fa137@gmail.com>
Date:   Sat, 4 Aug 2018 14:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180803150231.7172-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

Typo in the patch title:

s/di: /dt-/

And maybe let's change the following text to:

"Add bindings for lm3697 LED driver"

Best regards,
Jacek Anaszewski

On 08/03/2018 05:02 PM, Dan Murphy wrote:
> Introduce the device tree bindings for the lm3697
> led driver for backlighting and display.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..7b8e490f1ea1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,64 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.
> +
> +This device is suitable for Display and Keypad Lighting
> +
> +Required properties:
> +	- compatible:
> +		"ti,lm3967"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
> +		0 - All HVLED outputs are controlled by bank A
> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
> +		7 - All HVLED outputs are controlled by bank B
> +
> +Optional properties:
> +	- enable-gpios : gpio pin to enable/disable the device.
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : 0 - LED is Controlled by bank A
> +		1 - LED is Controlled by bank B
> +
> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +led-controller@36 {
> +	compatible = "ti,lm3967";
> +	reg = <0x36>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +	control-bank-cfg = <0>;
> +
> +	led@0 {
> +		reg = <0>;
> +		label = "white:first_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		label = "white:second_backlight_cluster";
> +		linux,default-trigger = "frontlight";
> +	};
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
> 
