Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5611C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93980217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnllyPgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93980217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHDOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:22:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33576 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHDOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:22:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so7207536wmh.0;
        Sat, 04 Aug 2018 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IVRAW8VwXdrJ0tGLRugi2JMl3Cz2zYU4PINvvipaTD8=;
        b=jnllyPgqxbDe1f2dmbQt9xeF22m06QITcXS6LYXJIZuzOoO/3siK7VPoQFI6ESWog3
         jtLfQzOBatX+8lip45gBhFQnBszzCOvl6/khQQeSCq5XGwYmaTQfu4uzIWjEXG1iCv7S
         z4B0Nf+LXjTJbQNRsjQWFUfrTquvm2PKuY2p9PnXn1HHrPRXCSRWxKOovDP+Bru6JfZN
         FL0lSgEhSzk7JJ/bMmqYPTBaK9jUG6vDosE1CCkNwOF521SxTaH4F976S5iImrO8fr/R
         QtINVwylFGtA5340Pv1spTlqpB9D7T8mpbEp5uq8EDZomwBVMCXpMQLWecbF2EbVSN9J
         +Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVRAW8VwXdrJ0tGLRugi2JMl3Cz2zYU4PINvvipaTD8=;
        b=A2ioW9hXyZFNfdXDR0+0oBVw1ATTwYa84PxQF7w2Pt2/DpYhNKiCQrDttHcSny8CVC
         7CvywdGar3HSMZtTnHmdhHoa8eVVPewQQDfY0MflB3xN3Uu9nB8VpamoLIeIZLz6QVTx
         lKYo+YJoFWNnkvcNb7PjXESDc2RbEaiy9BVcCvkBPI/Xt1O+tf6Sx54fIShw+NqNi2j8
         G5iFonyaDfqOVUEWhxsHMxIMQGtr0zZZZJwutjprYzH2+cFkI+wtUGHYG/W0N1MIzWd8
         yV3Iawd0L8WV7VpRrXK9DKOuE98DILmfxbSKyWWlbdq5qq9K4Mb4nxLcR/3IOOxR7bJM
         vu8g==
X-Gm-Message-State: AOUpUlE5Ov2MvmF3dMZC/KCj/xnsONJS9GPOcTdMkxLaSKQrRrV93hwC
        1pdtn1X6XopWJ01xlYQSOPsJfYjT
X-Google-Smtp-Source: AAOMgpeN1IScHj3TC8qkGDfEOxymNcR+ig6CeeV1Bvfbgow1bP0My7zPahgXX/2XS8v3xIRg46/53Q==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr7402366wmb.16.1533385331293;
        Sat, 04 Aug 2018 05:22:11 -0700 (PDT)
Received: from [192.168.1.18] (bky33.neoplus.adsl.tpnet.pl. [83.28.192.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm9250044wrq.45.2018.08.04.05.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 05:22:10 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 1/2] di: bindings: lm3697: Introduce the lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180803150231.7172-1-dmurphy@ti.com>
Message-ID: <b22bf013-f83c-12c1-90e5-8b0dc4145834@gmail.com>
Date:   Sat, 4 Aug 2018 14:22:08 +0200
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
