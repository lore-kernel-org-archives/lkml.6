Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E528C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74720870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmKT9n7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfA3JIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:08:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35348 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfA3JIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:08:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so20875786wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BSA7YxERtNe2YC7MWj+wV7PgS88YkA2xQTsk66XOsoE=;
        b=BmKT9n7l3o3+rSCnE+mbjXeBa2tqXHxg12FnpYIXCPmKxdrwdelq9E8tHmvsbX9wEV
         Q1mCaFsLpzh2aHBJFIzivbPqWUOyqxigWNtOhyhTpFPcZTEThX9dpePQ+tqXkLf7dhle
         QRFIv7iaGARi6lbOs9cTnxCOHUw/P//R1dX6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BSA7YxERtNe2YC7MWj+wV7PgS88YkA2xQTsk66XOsoE=;
        b=GvYhbUTTIJEfutcqQnqD8Bxu+B3/dMtsZgsDqzkiP3yCDbhGQytME0COvgbbG4nm2w
         RW5SA6b9w+betcK7QTcr+dPOIGbfGf9SU+fgaWxH3Lg6UTeARpXrXgLQgeYIrHRxi3Kq
         8uLXUz6/rnPztI/bSXt97gsar9a1Mh3jeUmwtwYKzS6EerUevLyw8sj9KVvJShlMCEI9
         2CUZ4fQX7QJM7p4Z9Esw+atYtiLr5K5qsl1HsR18GWk+CPaFHZfkME6x+cFvmU+IEqiP
         gX2y9QilGIKU8p5rSsgaZAmw2Al0YGXZgf88IaEWaQ5RbJgwxa4hafBj3n0j8J8hsAPe
         zihw==
X-Gm-Message-State: AJcUukfh7nPteMbUfghRv14tldjQ1NjNjnalNzWUmxPIAcakzL2Xwns4
        c0KQOfSOY78ZMKt4+oYAfvSV6g==
X-Google-Smtp-Source: ALg8bN6rJAKuW4fF48eWGDBDYGeNSxtSMW8lT/QNYzJS4c9As8gv5Fu0pdGKDeNTFV3vy8xqQMhIMQ==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr25846173wmd.143.1548839315555;
        Wed, 30 Jan 2019 01:08:35 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id 199sm1133428wmh.21.2019.01.30.01.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:08:34 -0800 (PST)
Subject: Re: [PATCH v2 10/14] arm64: dts: qcom: qcs404: Add OPP table
To:     Vinod Koul <vkoul@kernel.org>
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net,
        niklas.cassel@linaro.org, georgi.djakov@linaro.org,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        khasim.mohammed@linaro.org
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130044112.GE4635@vkoul-mobl>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <8b80d10a-3433-4749-4d09-cf71ce799d63@linaro.org>
Date:   Wed, 30 Jan 2019 10:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130044112.GE4635@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 05:41, Vinod Koul wrote:
> On 28-01-19, 19:32, Jorge Ramirez-Ortiz wrote:
>> Add a CPU OPP table to qcs404
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> index 9b5c165..4594fea7 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> @@ -62,6 +62,21 @@
>>  		};
>>  	};
>>  
>> +	cpu_opp_table: cpu_opp_table {
> 
> This should be:
>         cpu_opp_table: cpu-opp-table

yes. um I thought I fixed this ..sorry about it.

> 
> IIRC node names are not supposed to have _ and tags not supposed to have
> -, please compile with W=12 to trigger these warnings :)
> 
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-1094400000 {
>> +			opp-hz = /bits/ 64 <1094400000>;
>> +		};
>> +		opp-1248000000 {
>> +			opp-hz = /bits/ 64 <1248000000>;
>> +		};

also need to remove the frequency below. I might have sent the wrong
version of this file

>> +		opp-1401600000 {
>> +			opp-hz = /bits/ 64 <1401600000>;
>> +		};
>> +	};
>> +
>>  	firmware {
>>  		scm: scm {
>>  			compatible = "qcom,scm-qcs404", "qcom,scm";
>> -- 
>> 2.7.4
> 

