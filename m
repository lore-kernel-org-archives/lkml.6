Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8056420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqMWms08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfAQIiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:38:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfAQIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:38:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9949511wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUa7v44EgL51hqJdpJbqu9DZEckjKML/2Dfdppi/ENE=;
        b=fqMWms08tAtamGiiA6y4t6ZIt2keKs81seHvpVhDYMWC3D4WpnFk1qAK5yikFmIBFf
         LwiNIQQuXhwhJHNB75wRiva9svb11nqKl2KE3szXtl2xomYQkjQrp3RcW2nPAJG+Iyur
         EqIfK8caZ3jtTiiVu4/TPv3MxJrENPrRz7dpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUa7v44EgL51hqJdpJbqu9DZEckjKML/2Dfdppi/ENE=;
        b=nTrxpSP4YMgKhYJyB7t20OEBFEkLAa0obPCNWPXASBKp9idyKJuFFxjRsd3g4zr4JD
         6yaNvzYVY09mSImWM/YbWtjsohiLfz2KyKqCSPFrrfzoOQC/mYUuNY/eNBcBEbKMooJM
         Sb2bVY/eUDwx54tb8czm311pEO9imoL803rqJg8vT+oYVLY0MjoQFg+FCY/dSQYy0QSc
         R2R+nJb/vh3KrBdeeqdoMmbfPlBKDkd/3ZhOSczWgQgwNvhV3MG1c3K0R1nKrA2Ab04b
         oKpdH9eWwiVD1ldm9F+DMoSZm+c37Ht6VR2rYit2AlZAeEQ04PdxrqiTlubmfYOtVAhd
         hh4w==
X-Gm-Message-State: AJcUukdAppwBockMeIlpHbTunqrKh6pPcYiyWzjGIcprOWxDWb/NbivJ
        BjoA6s5z05ljsCrGDqUy0Mlt3g==
X-Google-Smtp-Source: ALg8bN6+5FHCyE61OT0u4whQA+qc0ReIsDotQjaFj3HTMiktBe1MtVo8XThYvV3D2lTGfHLjIyvnZQ==
X-Received: by 2002:adf:b102:: with SMTP id l2mr10609682wra.296.1547714298758;
        Thu, 17 Jan 2019 00:38:18 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id f2sm94297783wre.34.2019.01.17.00.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 00:38:18 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
Date:   Thu, 17 Jan 2019 09:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117063312.GE25498@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 07:33, Bjorn Andersson wrote:
> On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:
> 
>> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
>> to keep the software model of the clock in line with reality, the
>> framework transverses the clock tree and disables those clocks that
>> were enabled by the firmware but have not been enabled by any device
>> driver.
>>
>> If CPUFREQ is enabled, early during the system boot, it might attempt
>> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
>> a provider, it will then change the rate for this clock.
>>
>> As boot continues, clk_disable_unused_subtree will run. Since it wont
>> find a valid counter (enable_count) for a clock that is actually
>> enabled it will attempt to disable it which will cause the CPU to
>> stop. Notice that in this driver, calls to check whether the clock is
>> enabled are routed via the is_enabled callback which queries the
>> hardware.
>>
> 
> With the CPUFREQ referencing the CPU clock driver, that has decided to
> run off this clock, why is it not refcounted?

COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
to disable the clocks that were enabled by the firwmare and not by the
drivers.

the cpufreq driver does not enable the cpu clock.

so when clk_change_rate is called, the enable_count counter is not
incremented and therefore it just remains null since this was enabled by
the firmware.

I tried doing:

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb..5a9f83e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -124,6 +124,10 @@ static int resources_available(void)
                return ret;
        }

+ ret = clk_prepare_enable(cpu_clk);
+ if (ret)
+         return ret;
+
        clk_put(cpu_clk);

        name = find_supply_name(cpu_dev);


and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
the system wide consequences of that change to cpufreq.

maybe Viresh can comment?

> 
> Regards,
> Bjorn
> 
>> The following commit, rather than marking the clock critical and
>> forcing the clock to be always enabled, addresses the above scenario
>> making sure the clock is not disabled but it continues to rely on the
>> firmware to enable the clock.
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  drivers/clk/qcom/hfpll.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
>> index 0ffed0d..9d92f5d 100644
>> --- a/drivers/clk/qcom/hfpll.c
>> +++ b/drivers/clk/qcom/hfpll.c
>> @@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>>  		.parent_names = (const char *[]){ "xo" },
>>  		.num_parents = 1,
>>  		.ops = &clk_ops_hfpll,
>> +		.flags = CLK_IGNORE_UNUSED,
>>  	};
>>  
>>  	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
>> -- 
>> 2.7.4
>>
> 

