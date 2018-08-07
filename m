Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24181C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA192152F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA192152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbeHGUNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:13:13 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39037 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:13:12 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so24165326ita.4;
        Tue, 07 Aug 2018 10:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ozi5odd6kD6Do+yb6M5ZFRUVqI01vQGy0q2pI6bjMbQ=;
        b=OfqnyDwY7+JIgILHbT8FEHliU2KP/5aqhWwkPpOyK2vJia04zhdvUuIs7pSAoQ7xkM
         pHvq90sFGX8BmlEoPJkWUfVj2owTLqNo+jM4Jsna9HG42pUXDWRcFib1Xq1fGd+4DIQP
         wN8agdA9ReqCDO3f2/vqk2NMfzngZprHd8z4E9aUcrMe+/Q9clIMqWrAD3LsIITGes3k
         jDx7/3gz4h7WcA4pO2Aa0HUYJdLPpiZvWcnbjuVkc3KRTCtysX+hlEWtiON9gvby2G8T
         WeswApOj6b/Suh2UtGnck3htQ6YPUW4qVwOCgVIeRRpLGuAwKs8J+Yr3wAL1aoYNRwaT
         Jr3w==
X-Gm-Message-State: AOUpUlFTRwEwe0HIZAOrqtw26UP8Cond1dDdAJPdZWz06MEeB2JPV7JS
        HIRw2M85Ob/z9W+ZEh+tpQ==
X-Google-Smtp-Source: AA+uWPxo/DVLO6ISqD/fJMfE2rd+h/3lB0KsK4PgoEq27wzzQCAGo8ajZjYIsghvsoofq+hytS0nDw==
X-Received: by 2002:a24:598f:: with SMTP id p137-v6mr2930644itb.5.1533664663209;
        Tue, 07 Aug 2018 10:57:43 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e129-v6sm1330046ite.35.2018.08.07.10.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:57:42 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:57:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode
 binding
Message-ID: <20180807175741.GA30886@rob-hp-laptop>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 06:05:09PM +0200, Paweł Chmiel wrote:
> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Make charge-restart-level-microvolt optional.
>   - Make charge-timeout-hours optional.
> 
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 23a3650ff2a2..264040f4ad15 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - max8998,charge-eoc-percent: Setup End of Charge Level.

This should have a vendor prefix and max8998 is not a vendor. Don't 
continue that pattern even if we already have some properties like that.

These seem like perhaps they should be common charger properties.

> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be value from 10 to 45 by 5 step.
> +
> +  Optional properties:
> +  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
> +    If property is not present, this will be disabled.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be one of following values: 100, 150, 200.
> +
> +  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
> +    If property is not present, this will be disabled.
> +    If value equals 0, leave it unchanged.
> +    Otherwise it should be one of following values: 5, 6, 7.
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -99,6 +117,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			max8998,charge-eoc-percent = <0>;
> +			max8998,charge-restart-level-microvolt = <100>;
> +			max8998,charge-timeout-hours = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {
> -- 
> 2.7.4
> 
