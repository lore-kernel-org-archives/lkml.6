Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B86C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1D320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nh97rH3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfAQKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:46:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46184 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfAQKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:46:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so10374712wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wjGNMQ1Xyj/2nk4iZvOiwJXuhvRb1mvppAMZfhe2UI=;
        b=Nh97rH3g4xO4yRnaRfwnZCtw8lMhWS5ifN3UoStuXWV8XreZpBgNFP6v513+F830R7
         1A8fkYGpSLFmKF9JquRLeWu5RmELG9dEJ1uV4op58lJzDxaQpVOpCbmoNPe4RJPQq4et
         daBtCall7K34uaGZbsbxhJ6Jx0tpmnDM2vNXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wjGNMQ1Xyj/2nk4iZvOiwJXuhvRb1mvppAMZfhe2UI=;
        b=YJHJh6rt/qz8iB3TG/FTVuWzBM5qbxE9UE1uFdciFubUlpfjkppzaR+XTGy/QTW+Nq
         RtkMgc7iVHf1pU7hacWgM9Id3DBPPiD8teXeWjGusPd7KTj16tfcWft7ABymFkA6H9x2
         /tcN554oF2Dt0iPmMw+T3hyMqJXpvzcs7EiPlZ5x6HAACJHerL8hsY0WK0aNgxtPJO/Q
         4x77BJC+EqogiFUuiibeQgAdGBp6k2d2svac17KhmLmC76cLTKlxMgSj5h66uPma5/8q
         eQ6tqdHMU8AKXrmICDFOrY0M7qQlQWkGclrVrjUTcHeJJLwABgZUiJNsr4sVF+r8TwkF
         cXZg==
X-Gm-Message-State: AJcUukfRBaTOEHBtKAydPujhr68Of+I1gS4pqDkAg5PvB+TK+hTaz+YX
        KitdxIaZ3R5AqJWM5d4Bh8ZuXrNpxBg=
X-Google-Smtp-Source: ALg8bN4kXbu2kYK3OAMDoQUbHMGQHEGK66MunwyJ6kotzGX991Pg8Wz+m63sdFhnFmh4HpAV3QAiXg==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr12345067wru.154.1547721984108;
        Thu, 17 Jan 2019 02:46:24 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id s16sm63932643wrt.77.2019.01.17.02.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:46:23 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
 <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
Date:   Thu, 17 Jan 2019 11:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 11:08, Viresh Kumar wrote:
> On 17-01-19, 09:38, Jorge Ramirez wrote:
>> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
>> to disable the clocks that were enabled by the firwmare and not by the
>> drivers.
>>
>> the cpufreq driver does not enable the cpu clock.
>>
>> so when clk_change_rate is called, the enable_count counter is not
>> incremented and therefore it just remains null since this was enabled by
>> the firmware.
>>
>> I tried doing:
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index e58bfcb..5a9f83e 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -124,6 +124,10 @@ static int resources_available(void)
>>                 return ret;
>>         }
>>
>> + ret = clk_prepare_enable(cpu_clk);
>> + if (ret)
>> +         return ret;
>> +
>>         clk_put(cpu_clk);
>>
>>         name = find_supply_name(cpu_dev);
>>
>>
>> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
>> the system wide consequences of that change to cpufreq.
> 
> If the cpufreq driver enables it then it should disable it on exit as
> well, right ? And in that case if you unload your driver's module, you
> will hang the system as the clock will get disabled :)

ah, of course, sorry was over-thinking this thing :)

> 
> Every other platform must either be marking it with CLK_IGNORE_UNUSED
> or they must be doing clk_enable from somewhere, maybe the CPU online
> path, not sure though.
> 

since this clock is enabled by the firmware, it seems to me that using
CLK_IGNORE_UNUSED remains the best option.

