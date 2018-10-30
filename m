Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0882C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6549A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJaE31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:29:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42108 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJaE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:29:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id j3so6480945otl.9;
        Tue, 30 Oct 2018 12:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lx0nhDHpummCatYTboeVxzUaTU8JZHfv3IjPGt83rYg=;
        b=KiLpYnX2Gx4j1sxIyfq+LghGukRAh4xlEqjmfe6/vNETQy9GwpJJFHVEwN/OYYVPMF
         NqMegFxlD7k1m93aOGDS8PTvo1+eIr2L1zHLemXgMiyOo2khzez+BucTCD1Whr1sGEII
         gqutAaWtA18aIWUyhxwGGn/hYvebsba23OEo2WZVdIhI+dzvjZaol0E+Fu0gP8QCFOX0
         xzcdVkjZh6YXsERDNcULiSJLqs5RA1EfnyFsEatNKGWqfB8qAL9e53sPMD4/G+IJCdEc
         boH0n0+2GOqSZzQuH0mHYJeVL4LW1PtySXnfMOVJVWKNW2UhpOKnMP7d5UD4YNLy2SL6
         +pDw==
X-Gm-Message-State: AGRZ1gIxfIsSKiXBsVu2X1oUb3pDlRXjvKT0hQL8CKX6T8XSPInx/7iN
        zqH786zwNNvxNxE6ICtTEQ==
X-Google-Smtp-Source: AJdET5fpySO1TPJCdX5zaFK/oN/actWISZWcflf2dbr8VpzzVnMxO35PKAQbNq5PzfOOB1EwsG6PpQ==
X-Received: by 2002:a9d:c63:: with SMTP id 90mr32578otr.328.1540928078119;
        Tue, 30 Oct 2018 12:34:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a75-v6sm635360oih.28.2018.10.30.12.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:34:37 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:34:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Message-ID: <20181030193436.GA29710@bogus>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-4-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540830122-2577-4-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:22:05PM +0000, Pascal PAILLET-LME wrote:
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v5:
> * describe regulator-active-discharge is available for power switches
> * remove interrupt parents
> 
>  .../bindings/regulator/st,stpmic1-regulator.txt    | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> new file mode 100644
> index 0000000..5adc938
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> @@ -0,0 +1,67 @@
> +STMicroelectronics STPMIC1 Voltage regulators
> +
> +Regulator Nodes are optional depending on needs.
> +
> +Available Regulators in STPMIC1 device are:
> +  - buck1 for Buck BUCK1
> +  - buck2 for Buck BUCK2
> +  - buck3 for Buck BUCK3
> +  - buck4 for Buck BUCK4
> +  - ldo1 for LDO LDO1
> +  - ldo2 for LDO LDO2
> +  - ldo3 for LDO LDO3
> +  - ldo4 for LDO LDO4
> +  - ldo5 for LDO LDO5
> +  - ldo6 for LDO LDO6
> +  - vref_ddr for LDO Vref DDR
> +  - boost for Buck BOOST
> +  - pwr_sw1 for VBUS_OTG switch
> +  - pwr_sw2 for SW_OUT switch
> +
> +Switches are fixed voltage regulators with only enable/disable capability.
> +
> +Optional properties:
> +- st,mask-reset: mask reset for this regulator: the regulator configuration
> +  is maintained during pmic reset.
> +- regulator-pull-down: enable high pull down
> +  if not specified light pull down is used
> +- regulator-over-current-protection:
> +    if set, all regulators are switched off in case of over-current detection
> +    on this regulator,
> +    if not set, the driver only sends an over-current event.
> +- interrupt-parent: phandle to the parent interrupt controller

This is not needed as the parent is a parent node with 
'interrupt-controller' property.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +- interrupts: index of current limit detection interrupt
> +- <regulator>-supply: phandle to the parent supply/regulator node
> +	each regulator supply can be described except vref_ddr.
> +- regulator-active-discharge: can be used on pwr_sw1 and pwr_sw2.
> +
> +Example:
> +regulators {
> +	compatible = "st,stpmic1-regulators";
> +
> +	ldo6-supply = <&v3v3>;
> +
> +	vdd_core: buck1 {
> +		regulator-name = "vdd_core";
> +		interrupts = <IT_CURLIM_BUCK1 0>;
> +		st,mask-reset;
> +		regulator-pull-down;
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	v3v3: buck4 {
> +		regulator-name = "v3v3";
> +		interrupts = <IT_CURLIM_BUCK4 0>;
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	v1v8: ldo6 {
> +		regulator-name = "v1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-over-current-protection;
> +	};
> +};
> -- 
> 1.9.1
