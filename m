Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC89C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE020833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OGWoJydW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JzCh8+IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BE020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeKCM0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 08:26:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKCM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 08:26:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4346760214; Sat,  3 Nov 2018 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541215008;
        bh=DZd8RAHfLF/jEARUpGOZzq0PCTHn6wUfWZvAfRGrwrE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OGWoJydWaneCT24AOJ7m+jkwxOvDbDyU0BH8bX5FOAJGsnLp3HXZFd3SITO0jgJJN
         PU39AX6vkVsl8RhIuZ175T3JavSHdx9Zk1DK+iiAsBUQKG4kMWjRf2Y4TVc/d45LDY
         eMHT1UigVgffY2cDeptebJr37a2Kg8OZ3/NmnKA4=
Received: from [10.79.172.169] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B45B460214;
        Sat,  3 Nov 2018 03:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541215007;
        bh=DZd8RAHfLF/jEARUpGOZzq0PCTHn6wUfWZvAfRGrwrE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JzCh8+IBDFFJyLiXsAhfYpmGBy6ABq5Hc7d0iP8266A/Uld2ExH1eTSisGhjE3oYu
         TP5gTFiuUo7UvbMj28ei+XMheuueutplBUTBrPC+ayiXlgu2tg1nCWmyTqg7tvOfV8
         vgEt1T7dM3tJro/dPNZZY3rAFfKroYQgx3RsOm2c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B45B460214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v8] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1540712140-26913-1-git-send-email-tdas@codeaurora.org>
 <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
 <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <8d495713-d601-dcc8-23ee-dc31185e6a7c@codeaurora.org>
Date:   Sat, 3 Nov 2018 08:46:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/2/2018 10:08 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-28 00:35:40)
>> Add support for the lpass clock controller found on SDM845 based devices.
>> This would allow lpass peripheral loader drivers to control the clocks to
>> bring the subsystem out of reset.
>> LPASS clocks present on the global clock controller would be registered
>> with the clock framework based on the device tree flag. Also do not gate
>> these clocks if they are left unused, as the lpass clocks require the
>> global clock controller lpass clocks to be enabled before they are
>> accessed. Mark the GCC lpass clocks as CRITICAL, for the LPASS clock
>> access.
> 
> Thanks for the useful commit text!
> 
>>
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index 08d593e..9d60474 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -3583,6 +3613,13 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>
>> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protected")) {
> 
> Bjorn told me over IRC that the QSPI clks are also protected on MTP and
> can't be read. So we're now causing MTP to fail on linus' tree. I think
> we need to add a generic property to the GCC node to indicate what clks
> are protected and shouldn't be touched by the OS. The function would go
> and knock out any protected clks by replacing their pointers with NULL.
> The property would be:
> 
>     protected-clocks = <clock-specifier-list>;
> 
> So for this node it would look like:
> 
>     gcc: clock-controller@f000 {
>          reg = <0xf00 0xbaf>;
> 
>          protected-clocks = <&gcc GCC_LPASS_Q6_AXI_CLK>,
>                             <&gcc GCC_LPASS_SWAY_CLK>,
>                             <&gcc GCC_QSPI_CORE_CLK_SRC>,
>                             etc.
>     };
> 
> Sorry for derailing this patch series so late in the process. This patch
> will need to be updated to work with that new DT property instead of
> having a custom qcom property. Otherwise the patch looks good and I
> think we're ready to merge it when the merge window closes and I can
> rewind clk-next.
> 

How about moving the QSPI clocks too under this qcom property? Later 
could add the support?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
