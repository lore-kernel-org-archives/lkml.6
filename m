Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438A82086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q+I4rAox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfANOzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:55:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33814 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfANOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:55:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so7555003wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dUKtJ0j5SOTZ8jJQ2h3d355rKTwlx53nMkQo87lwwho=;
        b=Q+I4rAoxWfiwNcw4eJ5LNisFV+V93y0bjr0VIOJ91pFqlfip9teIA4v4DorELVatbt
         A/8PBVHr6Atz3jPkoOAEDf8tFlg7rZ8AH4LlkpRefLbxa7cLYks1iEDxXb1yRPm+huIz
         iv1adYxzWjOkR31eGfDYZbVlv8M6KoQ56i5L8t4mOyfNIYxSyC4H9Q1Mha+TtS+FBKLU
         V4zLNeMIFt01Aho3sOeEWBHnez60TimaOng/baxGn1GILOQ7kGkETRdvhmxmx+gHXTGz
         9lo5aQZXw1ouafo4KkC+oDFrSuyX/yvze50/JxvBhXjPMP5a7Z9O+pqOppdRzVscfRHp
         Oy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dUKtJ0j5SOTZ8jJQ2h3d355rKTwlx53nMkQo87lwwho=;
        b=LFrHCJTQiPWIUgNhRHX92GC713FUpSCbkttqbm59i9umdfppDGq10PQEhAzdFMV+4a
         82h5Q8+H+ssDGfuMHV8qhSpP0JJGcZccd6jnDpTjCjZWOT66qSYQDazeHGB0RNSA7MyX
         H85Lmzlxo3GgDP5Ntthq4SdrpKyqxICKgYRW8DrjPYtYB2zqqnZxJg5osMmsb3QjvE4n
         5+I5fRZk26I690/M2pFM7Dr3zwHYtaQcWcczdE5jx6Y+kQx2dorIaMDU9RYxyh9xi84A
         sVQgxoLe850Qxcr3vKoQbcpOKBHTANYGg07Dr4KG7H1EbgaO+foEaYIwJgy6Ko1L84s0
         1sMA==
X-Gm-Message-State: AJcUukdkcLQVvGRVJClVvJvY0WJpJHODBVCzMUyZhsYKOjhDph3Qfb+f
        cKXitzMCxrrB61Aep1kpTKrc0g==
X-Google-Smtp-Source: ALg8bN5yT0+tLutbIiD/RqooYANaNjtiE2XDSHwIElREg/SKxQEMRBnIMw4e3CiMNCZ8EjNAAu+NEA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr12136175wmf.3.1547477697115;
        Mon, 14 Jan 2019 06:54:57 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l15sm60070983wrw.4.2019.01.14.06.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 06:54:56 -0800 (PST)
References: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v4] arm64: dts: meson: Fix mmc cd-gpios polarity
In-reply-to: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
Date:   Mon, 14 Jan 2019 15:54:54 +0100
Message-ID: <86zhs3l269.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

On Mon 14 Jan 2019 at 14:44, Loys Ollivier wrote:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification:
> According to SDHCI standard, CD lines are specified as "active low".
> Using the "cd-inverted" property means that the CD line is "active high".
>
> Fix the SD card description for meson by setting the cd-gpios as
> "active low", according to the boards specifications, and dropping the
> "cd-inverted" property.
>
I understood your point on the double op making it a no-op. I chose not
to mention it as it can be somewhat misleading on the reason of this
patch.
That DT code is probably how you found the no-op bug. And that's how I
noticed that the SD description was not perfect.

But imho, that is not why the DTs should be changed. The main
reason is because the previous description is not configuring the CD
lines correctly, according to the specification.

I hope this version is fine for everyone :)
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>
> v4: commit message clarification on the "cd-inverted" property and usage.
>
> v3: fix typos in the commit message.
>
> v2: fix more occurences, also in other meson boards.
>
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
>  14 files changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index e14e0ce7e89f..016641a41694 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -187,8 +187,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 8cd50b75171d..ade2ee09ae96 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -305,8 +305,7 @@
>  	max-frequency = <200000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddio_ao3v3>;
>  	vqmmc-supply = <&vddio_tf>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 4cf7f6e80c6a..25105ac96d55 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..1cc9dc68ef00 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -258,8 +258,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&tflash_vdd>;
>  	vqmmc-supply = <&tf_io>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index ce862266b9aa..0be0f2a5d2fe 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -196,8 +196,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index 93a4acf2c46c..ad4d50bd9d77 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -154,8 +154,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index ec09bb5792b7..2d2db783c44c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -211,8 +211,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vcc_3v3>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> index f1c410e2da2b..796baea7a0bf 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> @@ -131,8 +131,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index db293440e4ca..255cede7b447 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&vcc_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> index 6739697be1de..9cbdb85fb591 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> @@ -183,8 +183,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index a1b31013ab6e..bc811a2faf42 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -137,8 +137,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 3c3a667a8df8..3f086ed7de05 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -356,8 +356,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index f7a1cffab4a8..8acfd40090d2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -147,8 +147,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> index 7212dc4531e4..7fa20a8ede17 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> @@ -170,8 +170,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;


-- 
-L
