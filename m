Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D743BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F10F20862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F10F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeGPWu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:50:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43550 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbeGPWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:50:57 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so77795643oib.10;
        Mon, 16 Jul 2018 15:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=plz8JUgavK+cpxpdrscMLD4IVHJlod6yGJVaAUuFbgs=;
        b=O9uZ9jjqfvdhCTBH7bNMqgyA96F6MbfQbdr5oUbXgA0R+4/CtoNJhFMLQ3rkXICD6s
         tL8DjfWZOG1Z2ulq9ySY1scagjRESX+xs3KHBffP5JNYMRR+v8PG9BzPPFmySpA/pbNw
         x8asmV0HtZut3gBmvHIsqb/zXTEpHQwqZSg6b8O9fGaFxQ4WPzXMUYSlen97YbL6UIhk
         jAhs4Yt0DBk9oFaV4j+HVBE5h23bUV/FOf38LHYMSYT72iCxiBbAYrHQj0W9/GXWqKcL
         FDVHfY7wZrfpG1TvjGsLFCxT8MUwlLd7AlNdNVLhnsCrovWpBZLVNlNtvCkYr1FFIZOu
         pDjA==
X-Gm-Message-State: AOUpUlGOoNZIJju5Y1y6tyRQD+P2jJHdr5+yUI1NsoR3Ut7TWOUN+VfJ
        TChOtGEGSYdcQNtHqx72QA==
X-Google-Smtp-Source: AAOMgpffpwFr1Ai/3gmz/LId2rpl8HoWLXCDflcMtU1q/t3H/qG7jafhxSdRkz9GsUPQXQUpKaZIeg==
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr1339786oia.215.1531779690647;
        Mon, 16 Jul 2018 15:21:30 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f75-v6sm6899908oig.53.2018.07.16.15.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:21:29 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:21:28 -0600
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 3/8] dt-bindings: regulator: document stpmu1 pmic
 regulators
Message-ID: <20180716222128.GA4766@rob-hp-laptop>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-4-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530803657-17684-4-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:14:23PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The STPMU1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  .../bindings/regulator/st,stpmu1-regulator.txt     | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
> new file mode 100644
> index 0000000..888e759
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
> @@ -0,0 +1,72 @@
> +STMicroelectronics STPMU1 Voltage regulators
> +
> +Regulator Nodes are optional depending on needs.
> +
> +Available Regulators in STPMU1 device are:
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
> +- st,mask_reset: stay on during Reset for particular regulator

s/_/-/

What's the type? 'mask' in the name makes it sound like a bitmask.

> +- regulator-pull-down: enable high pull down
> +  if not specified light pull down is used
> +- regulator-over-current-protection:
> +    if set, all regulators are switched off in case of over-current detection
> +    on this regulator,
> +    if not set, the driver only send an over-current event.
> +- interrupt-parent: phandle to the parent interrupt controller
> +- interrupts: index of current limit detection interrupt
> +- <regulator>-supply: phandle to the parent supply/regulator node
> +	each regulator supply can be described except vref_ddr.
> +
> +Example:
> +regulators {
> +	compatible = "st,stpmu1-regulators";
> +
> +	ldo6-supply = <&v3v3>;
> +
> +	vdd_core: regulator@0 {

Drop the unit address.

> +		regulator-compatible = "buck1";
> +		regulator-name = "vdd_core";

I think you have the names backwards here. Plus, regulator-compatible is 
not generally used.

> +		interrupts = <IT_CURLIM_BUCK1 0>;
> +		interrupt-parent = <&pmic>;
> +		st,mask_reset;
> +		regulator-pull-down;
> +		st,pulldown_config = <2>;
> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	v3v3: buck4 {
> +		regulator-compatible = "buck4";
> +		regulator-name = "v3v3";
> +		interrupts = <IT_CURLIM_BUCK4 0>;
> +		interrupt-parent = <&mypmic>;
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	v1v8: ldo6 {
> +		regulator-compatible = "ldo6";
> +		regulator-name = "v1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-over-current-protection;
> +	};
> +
> +};
> -- 
> 1.9.1
