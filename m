Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19199C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9B7206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KBHuuP3V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KBHuuP3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9B7206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeIFQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:06:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:06:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B109860540; Thu,  6 Sep 2018 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536233499;
        bh=kgtWrfzKBbKtI3JSjd7GzbU8vVXauGk2jp7jI4xE/Pc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KBHuuP3VEmQTUIpfpU0UuJvLgtaM7K3mAFToebk9eTE6qA4PlDvdPhVjazB9M0uP1
         lBL14ADMHvz7Rk9ClKhpbHdOJvwA0D1q3922GU0l7tgRHcTYDwE2nK4Mvfd17Y4UDv
         xchMIzW9cia13LCKfXrhGT4NJ4nC9pmoZKncoGfY=
Received: from [192.168.225.247] (unknown [49.44.51.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC10B6024C;
        Thu,  6 Sep 2018 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536233499;
        bh=kgtWrfzKBbKtI3JSjd7GzbU8vVXauGk2jp7jI4xE/Pc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KBHuuP3VEmQTUIpfpU0UuJvLgtaM7K3mAFToebk9eTE6qA4PlDvdPhVjazB9M0uP1
         lBL14ADMHvz7Rk9ClKhpbHdOJvwA0D1q3922GU0l7tgRHcTYDwE2nK4Mvfd17Y4UDv
         xchMIzW9cia13LCKfXrhGT4NJ4nC9pmoZKncoGfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC10B6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
 <1533298874-22863-3-git-send-email-tdas@codeaurora.org>
 <153540431524.129321.12826367247850332291@swboyd.mtv.corp.google.com>
 <15984aab-d815-56bb-af9c-7be9cfd9a103@codeaurora.org>
 <153619871329.119890.8761547440925666785@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a74ae0f1-caa7-9b49-e4f4-32b82e2ba423@codeaurora.org>
Date:   Thu, 6 Sep 2018 17:01:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153619871329.119890.8761547440925666785@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2018 7:21 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-09-05 11:26:10)
>> On 8/28/2018 2:41 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-08-03 05:21:14)
>>>> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
>>>> new file mode 100644
>>>> index 0000000..6f387f9
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
>>> [...]
>>>> +
>>>> +/* CLK_OFF would not toggle until LPASS is not out of reset */
>>>
>>> Can we change the branch ops to check for out of reset or not? Do the
>>> clks even work when LPASS isn't out of reset? Why would the clk APIs
>>> even be called on here if it hadn't taken LPASS out of reset?
>>>
>>
>> The branches need to be turned ON before the LPASS is out of reset.
>> But we would not be able to check the CLK_ENABLE bit.
> 
> Ok. Are the branches actually outputting any clk frequency when LPASS is
> in reset? It sounds like the hardware is broken and we can't ever check
> the halt bits?
> 
Yes, they would output when the reset is pulled for LPASS. These are as 
per the steps to be followed to bring the LPASS out of reset.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
