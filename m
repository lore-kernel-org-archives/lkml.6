Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E00C00449
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E54B2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SckED/wg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NlB30NYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E54B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJJNdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:33:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:33:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9351A60C63; Wed, 10 Oct 2018 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539151963;
        bh=+T79VCL8rQMgdRg0vUhtPIRuPqt6d2LXW1Bs97epAGQ=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=SckED/wg7w7HP0hVQf29py+bQYSSQjl57s11X7TAsM//7A1ZRws80a9LlEMfGXpuB
         j8FHGMXtOgz7dKhxRnIJua4UgUcA7mTRubWyDOLTiHIz4L50+7H5hDFNiRnCQynHUb
         mj2nGQdybx/7pxkNI1b25kZnGlvbm+eKxwx2MyBA=
Received: from [192.168.225.247] (unknown [49.32.132.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95AB76021C;
        Wed, 10 Oct 2018 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539151962;
        bh=+T79VCL8rQMgdRg0vUhtPIRuPqt6d2LXW1Bs97epAGQ=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=NlB30NYKQnaDb0WUzXtwb4iuEg85MIxaJCYD824eSWOeFF7fEtf0QiCkYoUkIbLPA
         nUhgo2d0FLkzqVkjonkJDEbkFSBFZkEqGNXJwbSwwEvPFA9Nx6O/y7mVfyE0hyWGz4
         ETfsGlxdPEmufVIJPYWGNwtqz5mILHqBeEKrPoiY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95AB76021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
 <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
Message-ID: <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
Date:   Wed, 10 Oct 2018 11:42:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 2:22 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-09 10:26:38)
>> Hello Stephen,
>>
>> On 10/8/2018 8:14 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-10-04 05:02:26)
>>>> Add support for the lpass clock controller found on SDM845 based devices.
>>>> This would allow lpass peripheral loader drivers to control the clocks to
>>>> bring the subsystem out of reset.
>>>> LPASS clocks present on the global clock controller would be registered
>>>> with the clock framework based on the device tree flag. Also do not gate
>>>> these clocks if they are left unused.
>>>
>>> Why not gate them? This statement states what the code is doing, not why
>>> it's doing it which is the more crucial information that should be
>>> described in the commit text. Also, please add a comment about it to the
>>> code next to the flag.
>>>
>>> I am concerned that it doesn't make any sense though, so probably it
>>> shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
>>> other larger bug that needs to be fixed.
>>>
>>
>> It does not have any bug, it is just that to access these lpass
>> registers we would need the GCC lpass registers to be enabled. I would
>> update the same in the commit text.
>>
>> During clock late_init these clocks should not be accessed to check the
>> clock status as they would result in unclocked access. The client would
>> request these clocks in the correct order and it would not have any issue.
>>
> 
> That seems like the bug right there. If the LPASS registers can't be
> accessed unless the clks in GCC are enabled then this driver needs to
> turn the clks on before reading/writing registers. Marking the clks as
> ignore unused is skipping around the real problem.
> 

If the driver requests for the clocks they would maintain the order. But 
if the clock late init call is invoked before the driver requests, there 
is no way I could manage this dependency, that is the only reason to 
mark them unused.

>>
>>>>
>>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>>> ---
>>>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>>>> index 08d593e..6379b8b 100644
>>>> --- a/drivers/clk/qcom/gcc-sdm845.c
>>>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>>>> @@ -3583,6 +3611,13 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
>>>>           if (ret)
>>>>                   return ret;
>>>>
>>>> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protected")) {
>>>> +               gcc_sdm845_clocks[GCC_LPASS_Q6_AXI_CLK] =
>>>> +                       &gcc_lpass_q6_axi_clk.clkr;
>>>> +               gcc_sdm845_clocks[GCC_LPASS_SWAY_CLK] =
>>>> +                       &gcc_lpass_sway_clk.clkr;
> 
> For all intents and purposes could we not just mark these two as
> CLK_IS_CRITICAL and then let the LPASS turn these on and off when it
> cares (does it ever do so)? Or even just turn them on once in probe here
> with direct register writes and then not care anymore to touch them
> again? Or do we need to turn these clks on again later on when the
> subsystem crashes to read/write the registers and cycle the clks back on
> and off?
> 
>>>> +       }
>>>> +
>>>>           return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
>>>>    }
>>>>
>>>> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
>>>> new file mode 100644
>>>> index 0000000..f7b9b0f
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
>>>> +               },
>>>> +       },
>>>> +};
>>>> +
>>>> +static int lpass_clocks_sdm845_probe(struct platform_device *pdev, int index,
>>>> +                                    const struct qcom_cc_desc *desc)
>>>> +{
>>>> +       struct regmap *regmap;
>>>> +       struct resource *res;
>>>> +       void __iomem *base;
>>>> +
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>>>> +       base = devm_ioremap_resource(&pdev->dev, res);
>>>> +       if (IS_ERR(base))
>>>> +               return PTR_ERR(base);
>>>> +
>>>> +       regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
>>>> +       if (IS_ERR(regmap))
>>>> +               return PTR_ERR(regmap);
>>>
>>> If this happens again in the future we should move this into the
>>> common.c file and let qcom_cc_probe_index() exist.
>>>
>>
>> Yes, I agree, could submit a patch to add the new function and then
>> clean it up.
> 
> Ok, but please don't do anything now because we don't care yet.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
