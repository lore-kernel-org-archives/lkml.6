Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2403EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D205A23DF3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAiv5LgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D205A23DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbeGEIoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:44:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34968 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeGEIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:44:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id v3-v6so5863819wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BBXtZzioIdlCsSor9pn99TCvPwac/URVNnLCgPLo8dw=;
        b=RAiv5LgYi5iNcEoxJaFBdt2d16zuOJJJ7L3T3RAJkTrpT2Rm9wxndlkIPr4jRuAzjG
         Jwu40M6h6wY+U7aUrlA0LRHXD9iTvANWOPOe7wiZ+XUGv4hm66saQE1HNy0tZTMag6fT
         zj4vU1nVeaBgAOAvxIUImsQWovfcYoP5jL+Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBXtZzioIdlCsSor9pn99TCvPwac/URVNnLCgPLo8dw=;
        b=mk4EqdDpT/OjUIljhcPMFhisHKzOdFwshEBcinV6qeCDWyYBiih1migd3upwaU1+Ik
         wdY3nHnFVl4KYzgksAhNEbO3PL3DQhK/9XILpKK8pk+1UTkDZ5bP4f3iP+eBW1dnqOfr
         GnXrKpSJGZkzCDHXSqzCBCUiNf3lXHDGI3w30ScbTMNyf7286UNEgmUqgqQIVMpFh2dR
         BW1jqhvSGDZEr1KyO77N1Dmt9vGHS29soyu2l0RxcaHxZ4Mnu71sAbMwQctG5BmsEjAB
         0rFStB9y296m6L2T1hS4U6UjJD8KmeTIeayQ4kkNmmYFlsFruiCar2GyVoZKpzbc5qGW
         +Aqw==
X-Gm-Message-State: APt69E2Mpv5VpxOKLB8jdE2JfaW6WAPiVjuzyERHQ66lFhxxI0cgBjuI
        RqJQg9BZ0u0wsdSW7YMcuy4t9whuvBo=
X-Google-Smtp-Source: AAOMgpdJC/KYMtJouikbdB9wQ1qlvhRCGujPCVQ/6178Ymt5qYAmNNTqt+p4ehfhBoTZKXPnDDmUtw==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr3330835wmd.37.1530780259770;
        Thu, 05 Jul 2018 01:44:19 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:84b1:bd51:47a2:fc02? ([2001:41d0:fe90:b800:84b1:bd51:47a2:fc02])
        by smtp.googlemail.com with ESMTPSA id b1-v6sm7464898wma.23.2018.07.05.01.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 01:44:19 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: hi6220: Add all CPUs in cooling maps
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b3d817e6-f694-0a63-afce-a8ec9c78aace@linaro.org>
Date:   Thu, 5 Jul 2018 10:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 07:09, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures the CPU0 in the cooling maps. Things work by chance as
> under normal circumstances its the CPU0 which is used by the operating
> systems to probe the cooling devices. But as soon as that ordering
> changes and any other CPU is used to bring up the cooling device, we
> will start seeing errors.
> 
> On the other hand, the hardware is partially defined in DT in these
> cases and we must do a better job by capturing all devices.
> 
> Add all devices (CPUs here) in the cooling maps which are also affected
> by the trip point.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 247024df714f..919d36b91bf3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -886,7 +886,14 @@
>  				cooling-maps {
>  					map0 {
>  						trip = <&target>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

