Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDDC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DQNPX1f+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jtHs1Z6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeGDIKh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:10:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeGDII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:08:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2319660B24; Wed,  4 Jul 2018 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530691707;
        bh=fVpryNB8r09EDxwbPDU2TBjHO3ah4wiPNwQYPzUSjLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DQNPX1f+UJBoO9RclzkPRI+bXyDktmdxydypNEFEA1ZzVhzYi54IYbVKVwe3HlPJU
         3AoNUxxU1216aZyNOBLG+TT8V0p3Vz4k2jANEJoc3kz5DKx6r3XyJ7tknn/v74ioZR
         pc1H36onxKAAQpAes/m/ySjA03Jncpyb/uma3llo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4B65C606AC;
        Wed,  4 Jul 2018 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530691706;
        bh=fVpryNB8r09EDxwbPDU2TBjHO3ah4wiPNwQYPzUSjLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jtHs1Z6pQi5+4y/uXBGQNtlaxtvR75dvn0poF4QHaAvq3iFb85wTMZKsrXa26G/w6
         oK1SInXsEpHxFQpsjnbzeNJCouS695KYoVK5poh9LGQFv9e+4Fb9MM/o6kWs9S17+d
         60t6bajvA274hc7XM0rCkCGulTynBYTQV3sDJSeE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Jul 2018 13:38:26 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org
Subject: Re: [PATCH v2 2/5] media: venus: add a routine to set venus state
In-Reply-To: <be5cc865-608b-dabb-2a3c-b5864c387d64@mm-sol.com>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-3-git-send-email-vgarodia@codeaurora.org>
 <be5cc865-608b-dabb-2a3c-b5864c387d64@mm-sol.com>
Message-ID: <1b9ba366cc8484e4f2ef1510a8f57b38@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

Thanks for your valuable comments.

On 2018-06-04 19:20, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> Thanks for the patch!
> 
> On  1.06.2018 23:26, Vikash Garodia wrote:
>> Add a new routine which abstracts the TZ call to
> 
> Actually the new routine abstracts Venus CPU state, Isn't it?

Yes, its a Venus CPU state controlled by TZ. I can mention it as
an abstraction of venus CPU state.

>> set the video hardware state.
>> 
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h      |  5 +++++
>>   drivers/media/platform/qcom/venus/firmware.c  | 28 
>> +++++++++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/firmware.h  |  1 +
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 13 ++++---------
>>   4 files changed, 38 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/core.h 
>> b/drivers/media/platform/qcom/venus/core.h
>> index 85e66e2..e7bfb63 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -35,6 +35,11 @@ struct reg_val {
>>   	u32 value;
>>   };
>> 
>> +enum tzbsp_video_state {
>> +	TZBSP_VIDEO_SUSPEND = 0,
>> +	TZBSP_VIDEO_RESUME
>> +};
> 
> please move this in firmware.c, for more see below.
> 
>> +
>>   struct venus_resources {
>>   	u64 dma_mask;
>>   	const struct freq_tbl *freq_tbl;
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c 
>> b/drivers/media/platform/qcom/venus/firmware.c
>> index 7d89b5a..b4664ed 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -53,6 +53,34 @@ static void venus_reset_hw(struct venus_core *core)
>>   	/* Bring Arm9 out of reset */
>>   	writel_relaxed(0, reg_base + WRAPPER_A9SS_SW_RESET);
>>   }
>> +
>> +int venus_set_hw_state(enum tzbsp_video_state state, struct 
>> venus_core *core)
> 
> can we put this function this way:
> 
> venus_set_state(struct venus_core *core, bool on)
> 
> so we set the state to On when we are power-up the venus CPU and Off
> when we power-down.
> 
> by this way we really abstract the state, IMO.

Good point. Will do in similar way.

>> +{
>> +	int ret;
>> +	struct device *dev = core->dev;
>> +	void __iomem *reg_base = core->base;
> 
> just 'base' should be enough.

Infact, comment from Jordan, we can remove it altogether.

>> +
>> +	switch (state) {
>> +	case TZBSP_VIDEO_SUSPEND:
>> +		if (qcom_scm_is_available())
> 
> You really shouldn't rely on this function (see the comment from Bjorn
> on first version of this patch series).
> 
> I think we have to replace qcom_scm_is_available() with some flag which
> is reflecting does the firmware subnode is exist or not. In case it is
> not exist the we have to go with TZ scm calls.

As we discussed, will keep it under the check for a valid firmware 
device.
We can avoid the extra flag in that way.

>> +			ret = qcom_scm_set_remote_state(TZBSP_VIDEO_SUSPEND, 0);
>> +		else
>> +			writel_relaxed(1, reg_base + WRAPPER_A9SS_SW_RESET);
>> +		break;
>> +	case TZBSP_VIDEO_RESUME:
>> +		if (qcom_scm_is_available())
>> +			ret = qcom_scm_set_remote_state(TZBSP_VIDEO_RESUME, 0);
>> +		else
>> +			venus_reset_hw(core);
>> +		break;
>> +	default:
>> +		dev_err(dev, "invalid state\n");
>> +		break;
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(venus_set_hw_state);
>> +
> 
> regards,
> Stan
