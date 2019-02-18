Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AE7218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G6/IAkOX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cTlpoGxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfBREyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:54:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBREyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:54:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9348060854; Mon, 18 Feb 2019 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550465692;
        bh=owqk7lVRPTa2q/3GtSPz9RH+2MX0SUtcTd29pLPYjZc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=G6/IAkOXagsYPBpq590izPkDhef3nhOhtgB0lHHHuHEq7mxc5cfy9hpsB0eb4QcxP
         GLWJ9hpKo8s4y+ltNCDMzunkwK6emIlJHt92BCWiPonbUXuIJPxttjeGnPfx8g2Gkw
         A6Wky6rB/FPUKgi9x+Zqr29yy9v5KRhHuPRHJwng=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFDD76020B;
        Mon, 18 Feb 2019 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550465691;
        bh=owqk7lVRPTa2q/3GtSPz9RH+2MX0SUtcTd29pLPYjZc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=cTlpoGxXsAQu1GhG0qlLhSKsoLkAZe8EgStBVmaYucHfKPAU6b28buQpcZBb/6Ylo
         cTAxdu+UaxEwNyD1JlX36tNlz1d3aa1K61YZacTA1D+F7OMOKIrjdSnYeB2PqHm12X
         v3FOPVIgYzQUqNRqvZ0rSpNvEwkvhNaRVRvlIHnc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFDD76020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: q6v5_adsp: Remove voting for lpass_aon
 clock
From:   Rohit Kumar <rohitkr@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
 <1543562950-23997-3-git-send-email-rohitkr@codeaurora.org>
 <f6f9b4a2-6205-0ba5-9a3a-b34bd814d303@codeaurora.org>
 <20190107071359.GK31596@builder>
 <214831ef-2139-7b48-1654-537634f898f4@codeaurora.org>
 <d90f7817-294e-a96e-0eb0-293a06e9190a@codeaurora.org>
Message-ID: <bca57260-6e1e-f808-afd4-2d6264e5c3f2@codeaurora.org>
Date:   Mon, 18 Feb 2019 10:24:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d90f7817-294e-a96e-0eb0-293a06e9190a@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,


On 1/30/2019 10:38 AM, Rohit Kumar wrote:
> Hello Bjorn,
>
> On 1/14/2019 4:14 PM, Rohit Kumar wrote:
>>
>> On 1/7/2019 12:43 PM, Bjorn Andersson wrote:
>>> On Thu 03 Jan 20:36 PST 2019, Rohit Kumar wrote:
>>>
>>>> Hello Bjorn,
>>>>
>>>> Can you please review this patch series too.
>>>>
>>>> LPASS_AON clock support is already removed from lpass clock driver.
>>>>
>>> Applied the two patches.
>>
Can you please apply these patches. I don't see them in next.
>>
> I did not see this in next yet. Can you please pick this up.
>
> Thanks,
>
> Rohit
>
>> Hello Bjorn,
>>
>>
>> Can you please point me to the tree where this is applied.
>>
>>
>> Thanks,
>>
>> Rohit
>>
>>> Thanks,
>>> Bjorn
>>>
>>>> Thanks,
>>>>
>>>> Rohit
>>>>
>>>> On 11/30/2018 12:59 PM, Rohit kumar wrote:
>>>>> Lpass_aon clock is on by default. Remove it from lpass
>>>>> clock list to avoid voting for it.
>>>>>
>>>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>>>> ---
>>>>>    drivers/remoteproc/qcom_q6v5_adsp.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>>>>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>>>>> index 79374d1..4829173 100644
>>>>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>>>>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>>>>> @@ -48,7 +48,7 @@
>>>>>    /* list of clocks required by ADSP PIL */
>>>>>    static const char * const adsp_clk_id[] = {
>>>>> -    "sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr", 
>>>>> "lpass_ahbm_aon_cbcr",
>>>>> +    "sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
>>>>>        "qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
>>>>>    };
>>>> -- 
>>>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a 
>>>> member
>>>> of the Code Aurora Forum, hosted by the Linux Foundation.
>>>>
Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

