Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA65720B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HEiIhWfI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Is5gbo6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfBAAvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:51:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfBAAvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:51:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10DFD6092B; Fri,  1 Feb 2019 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982267;
        bh=RV9CfmcwP8zRx8TUmRdbkhNyhGkS4YjCAsge9hdXd0k=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=HEiIhWfIY5FIOrK1XcFGmQFk6Y/xVX2vsTktWirpsett042RKcFPD25sQxy+Rz7f8
         TF6CoZRdoo0aN4h7g8Rq+EuvfDarCRuxQWZvl1XobgDnlJeqLSSuppS6/kpXo7KLQw
         Tl5SWFkv4Y6d5B15Ixi5sbmVMpVXj7Zydj+Nl8F0=
Received: from [192.168.43.47] (unknown [223.186.125.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98CA960590;
        Fri,  1 Feb 2019 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982263;
        bh=RV9CfmcwP8zRx8TUmRdbkhNyhGkS4YjCAsge9hdXd0k=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Is5gbo6DnMh/w9Mj4NS5cPerYfuXPB3ONJOrcOQY9P4RNWOcyHq/5fAmc69s9ItMQ
         Z25Qm9PTocOXw4DV/xk/XXK8em5vRGCuks2A4f+nhn2n1b0pLe25vG7ooP1d4aujd6
         LY5TuMrSzvZRQQO0lEXIR7OKaQbSQsEmX5AKqNVU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98CA960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <304febd7-da9a-92d6-47bb-d9983d4bc5d4@arm.com>
 <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Message-ID: <0896a3f6-e2c3-49a0-8420-5127972b410b@codeaurora.org>
Date:   Fri, 1 Feb 2019 06:20:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2801964a-ba35-9393-593b-c5108a8825e4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/2019 6:17 AM, Sai Prakash Ranjan wrote:
> On 1/31/2019 11:31 PM, Suzuki K Poulose wrote:
>>
>>
>> On 31/01/2019 14:22, Sai Prakash Ranjan wrote:
>>> Add UCI table for coresight CPU debug module. This patch adds
>>> the UCI entries for Kryo CPUs found on MSM8996 which shares
>>> the same PIDs as ETMs.
>>>
>>> Without this, below error is observed on MSM8996:
>>
>> nit: Subject doesn't match the patch contents. You could simply say :
>>
>> coresight: cpu-debug: Add support for Qualcomm Kryo
>>
> 
> Done.
> 
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c 
>>> b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> index e8819d750938..915d86a39cee 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>>> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>>>       return 0;
>>>   }
>>> +static struct amba_cs_uci_id uci_id_debug[] = {
>>
>> As Stephen mentioned, this must be "const".
>>
>> Rest looks fine.
> 
> Done.
> 

Also it should be changed in Mike's patch I suppose or else:

In file included from 
drivers/hwtracing/coresight/coresight-cpu-debug.c:26:0:
drivers/hwtracing/coresight/coresight-cpu-debug.c:672:29: warning: 
initialization discards ‘const’ qualifier from pointer target type 
[-Wdiscarded-qualifiers]
   CS_AMBA_UCI_ID(0x000f0205, uci_id_debug), /* Qualcomm Kryo */
                              ^
drivers/hwtracing/coresight/coresight-priv.h:192:11: note: in definition 
of macro ‘CS_AMBA_UCI_ID’
    .data = uci_ptr \
            ^~~~~~~
drivers/hwtracing/coresight/coresight-cpu-debug.c:673:29: warning: 
initialization discards ‘const’ qualifier from pointer target type 
[-Wdiscarded-qualifiers]
   CS_AMBA_UCI_ID(0x000f0211, uci_id_debug), /* Qualcomm Kryo */
                              ^
drivers/hwtracing/coresight/coresight-priv.h:192:11: note: in definition 
of macro ‘CS_AMBA_UCI_ID’
    .data = uci_ptr \
            ^~~~~~~

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
