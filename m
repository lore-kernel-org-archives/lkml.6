Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0AD2089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0AD2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeGPS2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:28:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33562 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:28:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id l10-v6so29784065oii.0;
        Mon, 16 Jul 2018 11:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zkZkiV0dEuVdy/4utKmAcnbbEvS4MsnL7xXbMTJCubw=;
        b=b/3zsERKDoG5JiiUTH5usxgRg7JBzl0d5TW1OBUjASrL+a8j0v5WiUKECPpPW4//7Y
         gq8j7GEiDjxDtON9mB715MDr92jDI/JauXoEDaecz52ZKiX1xBZaVAHnL3medQlbddIT
         aNPcQFHx2I/HYeD/qF/4FWf2Yr4rQ9imOaXI+jY36Bah9K6ohTR+JYSXtsCEC3AwR9F8
         7CMf/iYY3YPaliErzdNpP2MlpOBcPLEuaAYJPJdj4Fhh22mrQE8tDuij3VseOM+cieIS
         jM3drVK3O9SPKguYFy9cXMKtlLs1wwmt8EPPbrHuqs4h5cn2qHbYiVZpVTHqIQr9v9hJ
         lHXA==
X-Gm-Message-State: AOUpUlGh8YUdyj2XDVdzhrJjCCK3vxJ3YWodYEkMBpVJ1xqgaGnjMePc
        NUII1sPPQu91V+sJQHhg2w==
X-Google-Smtp-Source: AAOMgpcZJnN6Km/2lmFOyoykXNlPb8FDFotl6MDkl5BatrQy/LEpGyA5FmCrRxwszHxYj6SzigObzg==
X-Received: by 2002:aca:a993:: with SMTP id s141-v6mr386999oie.72.1531764005336;
        Mon, 16 Jul 2018 11:00:05 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h9-v6sm30193804oic.1.2018.07.16.11.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 11:00:04 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:00:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: max8998: Add charger subnode
 binding
Message-ID: <20180716180003.GA16037@rob-hp-laptop>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:26:53PM +0200, Paweł Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..196e50097a36 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,23 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc-percent: Setup End of Charge Level.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be value from 10 to 45 by 5 step.
> +
> +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> +    If value equals 0, leave it unchanged.
> +    If value equals -1, it will be disabled.

-1 is a bit strange. Why not 'not present' is disabled?

> +    Otherwise it should be one of following values: 100, 150, 200.
> +
> +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> +    If value equals 0, leave it unchanged.
> +    If value equals -1, it will be disabled.
> +    Otherwise it should be one of following values: 5, 6, 7.
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +116,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc-percent = <0>;
> +			max8998,charge-restart-level-microvolt = <(-1)>;
> +			max8998,charge-timeout-hours = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> -- 
> 2.7.4
> 
