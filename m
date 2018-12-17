Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC8A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545084909;
	bh=V4jEclokgKm+ROafxsmCAxVxGn2w6lHc+l000zBwyFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IfwZvFjrv8PdHYL+9Zq6xj6KGc5OJpqPv9b3bNlvRQP2OSdxL+PJwkazJoJDQL+JN
	 tLzM5fmWXMv+sCu/3jjwgDwbfwpaJPFZQ+4DCDpTV6xXwQ26pfu5DyLEmw/932bGJT
	 gNr1CgnIHChq/qPvpXd9F7Bwn2rG4VaGFCfpEP94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeLQWPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:15:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37549 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbeLQWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:15:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so354328oia.4;
        Mon, 17 Dec 2018 14:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J/B8oun+KHAVhOm1kX/D4B4VD+5LS8jbpKrt1ggcc4Y=;
        b=smruiwoxfmVbtB5aMOfMrlpE8q6RYUHThaH0n5ICIfyz/kHF62BxOaosiG8q+O88oi
         /t1UtdjqgjK2Yl8ge2pPXtP7MI3YwPMu3xyNI18nlNlS39KvWqwLpv6AYDMjaFlPfFzn
         k2+pAYkOCgpxHYIwBGaO4LGwUY8Skfi+w6wY/9sv5OlHOmg0Owy0FTCQPgsj1B1ABPsi
         SYXlyDoXKaZDqLB2Sy9Bke8UFwFZwkRzqWjO5oPs75YO/PDZP32QboZxLyXdJW8oS8qv
         O4QGsshrVBw5ulzNYPekTtzENF74lE8PiEyo5Vwn/B2nHMSzyRYfzNrVZRLA5WeghP42
         U5EA==
X-Gm-Message-State: AA+aEWZBOB52PqQfiMBalZiln6uGo1Q2JqpVM6U9JGWxpzvDT89GjjSC
        mvrIjf6BsdsOT+CEizfTiw==
X-Google-Smtp-Source: AFSGD/XEh/ctX59reAbXLa6kDM4mVw4TyvR1QFIX2TNEylkKFSKcFStRZfVW273MC1u4mlg2F6da7w==
X-Received: by 2002:aca:c0c6:: with SMTP id q189mr6138964oif.226.1545084903536;
        Mon, 17 Dec 2018 14:15:03 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id x92sm8386076ota.55.2018.12.17.14.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:15:02 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:15:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        thierry.reding@gmail.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 6/8] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181217221502.GA30121@bogus>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-6-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-6-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:06:47PM +0100, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. And corrects a
> typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ++++++++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 32 +++++++++----------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++++++++
>  3 files changed, 51 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> new file mode 100644
> index 000000000000..480e66422625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> @@ -0,0 +1,21 @@
> +STMPE ADC driver
> +----------------
> +
> +Required properties:
> + - compatible: "st,stmpe-adc"
> +
> +Optional properties:
> +Note that the ADC is shared with the STMPE touchscreen. ADC related settings
> +have to be done in the mfd.
> +- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
> +  requestable due to different usage (e.g. touch)
> +
> +Node name must be stmpe_adc and should be child node of stmpe node to
> +which it belongs.
> +
> +Example:
> +
> +	stmpe_adc {
> +		compatible = "st,stmpe-adc";
> +		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
> +	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 1d3f84308142..8e2b240882fa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,18 +5,6 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time	: ADC conversion time in number of clock.
> -				0 -> 36 clocks		4 -> 80 clocks (recommended)
> -				1 -> 44 clocks		5 -> 96 clocks
> -				2 -> 56 clocks		6 -> 144 clocks
> -				3 -> 64 clocks
> -- st,mod-12b		: ADC Bit mode
> -				0 -> 10bit ADC		1 -> 12bit ADC
> -- st,ref-sel		: ADC reference source
> -				0 -> internal		1 -> external
> -- st,adc-freq		: ADC Clock speed
> -				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> -				1 -> 3.25 MHz
>  - st,ave-ctrl		: Sample average control
>  				0 -> 1 sample
>  				1 -> 2 samples
> @@ -40,17 +28,29 @@ Optional properties:
>  				0 -> 20 mA (typical 35mA max)
>  				1 -> 50 mA (typical 80 mA max)
>  
> +Optional properties common with MFD (deprecated):
> + - st,sample-time	: ADC conversion time in number of clock.
> +				0 -> 36 clocks		4 -> 80 clocks (recommended)
> +				1 -> 44 clocks		5 -> 96 clocks
> +				2 -> 56 clocks		6 -> 124 clocks
> +				3 -> 64 clocks
> + - st,mod-12b		: ADC Bit mode
> +				0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel		: ADC reference source
> +				0 -> internal		1 -> external
> + - st,adc-freq		: ADC Clock speed
> +				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +				1 -> 3.25 MHz
> +
>  Node name must be stmpe_touchscreen and should be child node of stmpe node to
>  which it belongs.
>  
> +Note that common ADC settings of stmpe_touchscreen will take precedence.

This isn't clear. The parent or child properties take precedence?

> +
>  Example:
>  
>  	stmpe_touchscreen {
>  		compatible = "st,stmpe-ts";
> -		st,sample-time = <4>;
> -		st,mod-12b = <1>;
> -		st,ref-sel = <0>;
> -		st,adc-freq = <1>;

It would be nice to see an example with both ADC and touchscreen.

>  		st,ave-ctrl = <1>;
>  		st,touch-det-delay = <2>;
>  		st,settling = <2>;
> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index a46e7177195d..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -14,6 +14,20 @@ Optional properties:
>   - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
>   - irq-gpio			: If present, which GPIO to use for event IRQ
>  
> +Optional properties for devices with touch and ADC (STMPE811|STMPE610):
> + - st,sample-time		: ADC conversion time in number of clock.
> +					0 -> 36 clocks		4 -> 80 clocks (recommended)
> +					1 -> 44 clocks		5 -> 96 clocks
> +					2 -> 56 clocks		6 -> 124 clocks
> +					3 -> 64 clocks
> + - st,mod-12b			: ADC Bit mode
> +					0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel			: ADC reference source
> +					0 -> internal		1 -> external
> + - st,adc-freq			: ADC Clock speed
> +					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +					1 -> 3.25 MHz
> +
>  Example:
>  
>  	stmpe1601: stmpe1601@40 {
> -- 
> 2.19.2
> 
