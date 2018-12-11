Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D5CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336602084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566408;
	bh=GkpWBNYb1hjyTEuGJIUt+eCY58jbiM/2kUvnBeypgng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KvmTBDPFWnMmm/hp+ZAyFEo/nhfGqvVBGy2m8O/D22v/CylAQjwd8GovaqT7i+UkD
	 jBKedLLJBAg89F45OM2FAcqZBf/mgVMe/Y6SQx8o5MR4LL3kPaA8MwlhU0SLmHVQmp
	 PqD3rzs28Gl2Grlm5WBocw8l+51d/kBu53J3dcks=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336602084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLKWN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:13:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45955 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:13:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so15649692ota.12;
        Tue, 11 Dec 2018 14:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nN8yAZDGpxllb26d975f2FW9kE9LRcPqvm+QF7joPOc=;
        b=OKmWpzQKYiwaXT0irlpfx/cYeWDSJ3z81wexmXZF3huV8LU2Z/rQjlZOh0wi6+SE3v
         3WIV7PTUQAa+PoYUu2/5jgN601SC5QsalUpgCopmBb93/w2KmTlwk6SvaHDeDs3g/cEe
         pzTIZt6romzc7i6EKa1Sn6GCrUMvfuCkVAV6MQrwnld9GoSxT/FyZGz9TfilUmylBUHa
         uhYcq5yWPqPxf9oJQaFWmJeCVrDlJDFfSlSu+QjKt5QDItlc1OMye+LA603/YR/FHSF6
         gIyLNitmS+0aPjks96E6rTAFYayuUMHXBn6PvW4P7bXdlpmgYAGKevVqTWDI214ZEv3k
         r96g==
X-Gm-Message-State: AA+aEWZ1bELFQ3/8ZKJm2/Z9wKO9dUp8h9O34MGa55wSWwpANl7pCkkT
        LpTumhdnEtQU4n/Hjls3Kw==
X-Google-Smtp-Source: AFSGD/Uv8C1JmR/imkDYZ5WwaLCg9OTvdh3dGeiuFtsrdtHqo5GwjvmavM3BDdH0p8VZ3WngYxzc6w==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr12342142otl.12.1544566405284;
        Tue, 11 Dec 2018 14:13:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q203sm10091438oif.33.2018.12.11.14.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:13:24 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:13:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Message-ID: <20181211221324.GA14658@bogus>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for regulator modes and suspend states.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> index ac955dea00d1..4017527619ab 100644
> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> @@ -15,11 +15,17 @@ Optional input supply properties:
>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
>  
>  Any standard regulator properties can be used to configure the single regulator.
> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
> +file.
>  
>  The valid names for regulators are:
>  	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
>  
>  Example:
> +
> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>

This file belongs in this patch.

> +
>  	pmic@5b {
>  		compatible = "active-semi,act8945a";
>  		reg = <0x5b>;
> @@ -32,6 +38,18 @@ Example:
>  				regulator-min-microvolt = <1350000>;
>  				regulator-max-microvolt = <1350000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-min-microvolt=<1400000>;
> +					regulator-suspend-max-microvolt=<1400000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				};
>  			};
>  
>  			vdd_1v2_reg: REG_DCDC2 {
> @@ -39,6 +57,14 @@ Example:
>  				regulator-min-microvolt = <1100000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
>  			};
>  
>  			vdd_3v3_reg: REG_DCDC3 {
> @@ -53,6 +79,14 @@ Example:
>  				regulator-min-microvolt = <2500000>;
>  				regulator-max-microvolt = <2500000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
>  			};
>  
>  			vdd_3v3_lp_reg: REG_LDO2 {
> -- 
> 2.7.4
> 
