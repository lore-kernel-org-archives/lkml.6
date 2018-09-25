Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA059C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B75D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B75D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeIZDfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:35:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43134 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeIZDfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:35:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so2753491oie.10;
        Tue, 25 Sep 2018 14:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHGRpJo4QtOEZnGBAR8gpBloSO0oGwlHeq3rF50nCUc=;
        b=g5LxSmRo8vvTKIANEZc+G5ix64wsLjKS8g7yfP54PmcNV0jR/gwyfIOaNdsu28dpMu
         +cno05qZ2172s7VfF/5TxeVe0aUTProsA8IwOdhyC23eqzE+9slBob3ATCMVO5rNKfrE
         UyOx2XsioVa5p9GzxbOeoMXZK0OxeXmEw16GWNi0WW/Fz4xVDk8dQY4lKnPU5LCbLcI/
         Lyy3ePCg4PtUWlf/1EbW8OmiT/1HL/uY4o2B1TDVmHsddgSSFwThcTD7fqbSVIQvjhnS
         EwEgd6BJRUh1LWcOrWvOKCCkO7dd2tNuyBEgSuQ8ZKcS9HrU16fVhTJYdxO7qXoi6bet
         2ROg==
X-Gm-Message-State: ABuFfog6KlOnrxd6873De9nQfp+/hGmrC/PrgPjEN0jr4RPJyHR78FhS
        +3RVu9GlMNH5ijSxr4wgvw==
X-Google-Smtp-Source: ACcGV60MrYIOtGpY2NtCnT2YlzidcDUqIu5WERaB3stTGpo70Reg1GKsThRBsRBMrAdACbSerpI5EA==
X-Received: by 2002:aca:ced5:: with SMTP id e204-v6mr12655oig.169.1537910733691;
        Tue, 25 Sep 2018 14:25:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10-v6sm1158572oif.37.2018.09.25.14.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:25:33 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:25:32 -0500
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
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH V2 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Message-ID: <20180925212532.GA23630@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-4-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325173-16617-4-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:59:44PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * replace _ with - in properties name
> * remove deprecated regulator-compatible from the example
> Rob, the st,mask_reset name is taken from the data-sheet. I have modified the 
> description. I hope there is no confusion with bit masking know.
> 
>  .../bindings/regulator/st,stpmic1-regulator.txt    | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> new file mode 100644
> index 0000000..a3f4762
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> @@ -0,0 +1,68 @@
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

State this is boolean.

> +- regulator-pull-down: enable high pull down
> +  if not specified light pull down is used
> +- regulator-over-current-protection:
> +    if set, all regulators are switched off in case of over-current detection
> +    on this regulator,
> +    if not set, the driver only sends an over-current event.
> +- interrupt-parent: phandle to the parent interrupt controller

This is implied. And actually not needed as the parent node is an 
'interrupt-controller'.

> +- interrupts: index of current limit detection interrupt
> +- <regulator>-supply: phandle to the parent supply/regulator node
> +	each regulator supply can be described except vref_ddr.
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
> +		interrupt-parent = <&pmic>;
> +		st,mask-reset;
> +		regulator-pull-down;
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	v3v3: buck4 {
> +		regulator-name = "v3v3";
> +		interrupts = <IT_CURLIM_BUCK4 0>;
> +		interrupt-parent = <&mypmic>;

Different parent from buck1?
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
