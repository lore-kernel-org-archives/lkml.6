Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E90C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EAE20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XrgJsogY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GbniUUI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EAE20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeGIHHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:07:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeGIHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:07:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C52060B72; Mon,  9 Jul 2018 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531120051;
        bh=l/k8+Vv9DQr8FGn859pH5PAC/e9HjD4W3ZSkTOlcppo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XrgJsogY6QH536YAsVfmEp1o4DcLGYgfbSgiwYXqRutT87DGFA+J+fYEEB8Qa6IBx
         z1NgpEeP/ehcrTL2Y0mVLKq4pjFUM2vAjgiLJhF0zxPIi4LOa7uae/weOSIVAraoGI
         vqym2MNhkjo7JEbgRljZDzDSXOO0aeMZlJmP9TiI=
Received: from [10.79.165.52] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47DE9602AE;
        Mon,  9 Jul 2018 07:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531120048;
        bh=l/k8+Vv9DQr8FGn859pH5PAC/e9HjD4W3ZSkTOlcppo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GbniUUI7EV2jlvSL4y1fltSN4nmjv+pLAbu3Y4KQrrg4hubnnGtwyw5Otnkby264i
         saBw3cQ7H0tr9LYn0MRMG/zLoW+TaXeu1qU/+KYtL0OJfjOrpbkwzQg0YAYeGdrMzw
         4rov7LB9yvZsA0+5vWZ54B4qJfFPDHlJ4Xowlk4o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47DE9602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
Date:   Mon, 9 Jul 2018 12:37:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2018 11:46 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-08 20:38:03)
>> Hello Stephen,
>>
>> Thanks for your review comments.
>>
>> On 7/9/2018 5:24 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-06-23 07:19:27)
>>>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
>>>> new file mode 100644
>>>> index 0000000..af437e0
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
>>>> @@ -0,0 +1,674 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>> [...]
>>>> +static struct clk_alpha_pll disp_cc_pll0 = {
>>>> +       .offset = 0x0,
>>>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
>>>> +       .clkr = {
>>>> +               .hw.init = &(struct clk_init_data){
>>>> +                       .name = "disp_cc_pll0",
>>>> +                       .parent_names = (const char *[]){ "bi_tcxo" },
>>>> +                       .num_parents = 1,
>>>> +                       .ops = &clk_alpha_pll_fabia_ops,
>>>> +               },
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
>>>> +       .cmd_rcgr = 0x20d0,
>>>> +       .mnd_width = 0,
>>>> +       .hid_width = 5,
>>>> +       .parent_map = disp_cc_parent_map_0,
>>>> +       .clkr.hw.init = &(struct clk_init_data){
>>>> +               .name = "disp_cc_mdss_byte0_clk_src",
>>>> +               .parent_names = disp_cc_parent_names_0,
>>>> +               .num_parents = 4,
>>>> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>>>
>>> Why is there the no cache flag? Last time I asked I don't think I got
>>> any answer, and there isn't a comment here so please at least add a
>>> comment to the code so we don't forget.
>>>
>>
>> I think you missed my comment from the earlier email. I would add the
>> comment and submit again.
> 
> Hmm.. ok.
> 
>>
>>   > Why is the nocache flag needed? Applies to all clks in this file.
>>   >
>>
>> This flag is required for all RCGs whose PLLs are controlled outside the
>> clock controller. The display code would require the recalculated rate
>> always.
> 
> Right. Why is the PLL controlled outside of the clock controller? The
> rate should propagate upward to the PLL from here, so who's going
> outside of that?
> 
The DSI0/1 PLL are not part of the display clock controller, but in the 
display subsystem which are managed by the DRM drivers. When DRM drivers
query for the rate clock driver should always return the non cached rates.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
