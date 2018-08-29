Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA631C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996C820868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyCPjllY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996C820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeH2NfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:35:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41375 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeH2NfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:35:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so4149745wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XaQFF/xff0yREjpC6ERkVeejCS+syQoLY8fD7LF5qJY=;
        b=fyCPjllY06DtP5R+coW5xxfZXes++UtdeSx02mK0RqnFxJOtSKDDfXBc1BD9Az3dDB
         JtbHi2MJJYJiQuovs26htg4lfDCkgjhCfsVpM5P/gAOQo+xaDmQKQPjx22oLLeSNDcJv
         G46zVCnJWlzeptPB84lZhljTjTqmRMh0P/P6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XaQFF/xff0yREjpC6ERkVeejCS+syQoLY8fD7LF5qJY=;
        b=YYb9TZhnwS7OTpwEGfSZ9YThdX4DRbPQ06cWPoZowhv1KWRMc51jRuRNsvCNmlDNOk
         5zJvRCGOPfmwHF4dI2/8Yo6hynPRicyvOnmtlt3reorSjowPGsyRpQw70r/+W8A96lgq
         XO5itAsXgIviXJe5DQyrmpIitgWPiFn4XvBskdagdizNXh/R7lT8Kd4tu6C94EYcw/0T
         xRvdBeiiQ/X8YK/uXL/Pryc3Ii+78z//cJOCGn65IhyMrKAzeCSPokdMfWuHRQewJdIA
         52cuBf8dVqu1UcChmtJvW8JwMqEnZHqjP45LI2ndkuPCsD+L12Wvupfg0cE/wmii2C9U
         dAMQ==
X-Gm-Message-State: APzg51D3KVLAiUGYAJLj+abBqmyxFTPgbvJff8MRu9jS6zEPXg4yZLCH
        Q5bIECnVTOgjLi0adpmON3eJ/Q==
X-Google-Smtp-Source: ANB0VdYuy+T3r0HniQjnTZeLU6aF/tFZ0xQgbFpZsy9rvzoCNwuShw5welOxB8WiZoYtOOWP3Q7ipw==
X-Received: by 2002:adf:dfca:: with SMTP id q10-v6mr3527664wrn.113.1535535556579;
        Wed, 29 Aug 2018 02:39:16 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r140-v6sm6391410wmd.7.2018.08.29.02.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 02:39:15 -0700 (PDT)
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org, edubezval@gmail.com,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
Date:   Wed, 29 Aug 2018 11:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2018 09:49, Amit Kucheria wrote:
> One thermal zone per cpu is defined

The thermal zones are very close, especially when the CPUs belong to the
same 'cluster'. Very likely the temperature will propagate from one core
to another core, so when one core reaches the trip0, there is good
chance the other cores will be close and cross the trip0 threshold too.

Having multiple thermal zones, one per CPU, may trigger an interrupts
storm with the passive polling timer delay.

Does this board have a cooling device per CPU also ?



> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 01ff146..a75be7c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -340,4 +340,174 @@
>  			};
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +
> +			trips {
> +				cpu_alert1: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit1: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu_alert2: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit2: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 4>;
> +
> +			trips {
> +				cpu_alert3: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit3: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu4-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 7>;
> +
> +			trips {
> +				cpu_alert4: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit4: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu5-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 8>;
> +
> +			trips {
> +				cpu_alert5: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit5: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu6-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 9>;
> +
> +			trips {
> +				cpu_alert6: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit6: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu7-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 10>;
> +
> +			trips {
> +				cpu_alert7: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit7: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

