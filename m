Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E1AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0625824069
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kpSN1f5u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hzC57Qqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0625824069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeGDIfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:35:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbeGDIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:35:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 682F360B23; Wed,  4 Jul 2018 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530693331;
        bh=03MxvPnnhxLTEG3tamWL8QA0TGUcYc72rQKPYFRhY4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kpSN1f5urL9KzSG0k9OlBFvoZGP7g4x75vvWA+4rHFpyXNE2HmAdA/St3svbybOc1
         S3fDN6VrzuYbqmSKXlvBu4oJiqWDf3srRlxsEWwIA52o17drO/uJTKDxZwv3GyVzZw
         N+FDJI5M6cNw1kYK2iEk2DoobbT6VfuWoX2Q4yH8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 42E1A60251;
        Wed,  4 Jul 2018 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530693330;
        bh=03MxvPnnhxLTEG3tamWL8QA0TGUcYc72rQKPYFRhY4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hzC57QqvpCV1u19lW52Uw/p8WXYBOQxFIPZmq9xw9kmfz436RXLRx/VNvPpF9iAcp
         9HMf+WNAMZmg5XNRoDvGd9SJHO/CmEcaHhmdUOyMz15bln8ZqBh/rAd0LfF1UZUXzJ
         sT58PbgPdYuNRgbpdEdzJtGM6e6EmNv8BShuFRnU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Jul 2018 14:05:30 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/5] media: venus: add a routine to reset ARM9
In-Reply-To: <894ab678-bc1d-da04-b552-d53301bd3980@linaro.org>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-2-git-send-email-vgarodia@codeaurora.org>
 <894ab678-bc1d-da04-b552-d53301bd3980@linaro.org>
Message-ID: <ff8887de4d2a8bb95635082e88a286af@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

Thanks for the review.

On 2018-06-02 03:45, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> On  1.06.2018 23:26, Vikash Garodia wrote:
>> Add a new routine to reset the ARM9 and brings it
>> out of reset. This is in preparation to add PIL
>> functionality in venus driver.
> 
> please squash this patch with 4/5. I don't see a reason to add a
> function which is not used. Shouldn't this produce gcc warnings?

Will squash the api definition with the patch using it.

>> 
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>   drivers/media/platform/qcom/venus/firmware.c     | 26 
>> ++++++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_venus_io.h |  5 +++++
>>   2 files changed, 31 insertions(+)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c 
>> b/drivers/media/platform/qcom/venus/firmware.c
>> index 521d4b3..7d89b5a 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -14,6 +14,7 @@
>>     #include <linux/device.h>
>>   #include <linux/firmware.h>
>> +#include <linux/delay.h>
>>   #include <linux/kernel.h>
>>   #include <linux/io.h>
>>   #include <linux/of.h>
>> @@ -22,11 +23,36 @@
>>   #include <linux/sizes.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   +#include "core.h"
>>   #include "firmware.h"
>> +#include "hfi_venus_io.h"
>>     #define VENUS_PAS_ID			9
>>   #define VENUS_FW_MEM_SIZE		(6 * SZ_1M)
>>   +static void venus_reset_hw(struct venus_core *core)
> 
> can we rename this to venus_reset_cpu? reset_hw sounds like we reset
> vcodec IPs, so I think we can be more exact here.
> 
>> +{
>> +	void __iomem *reg_base = core->base;
> 
> just 'base', please.
Ok.

>> +
>> +	writel(0, reg_base + WRAPPER_FW_START_ADDR);
>> +	writel(VENUS_FW_MEM_SIZE, reg_base + WRAPPER_FW_END_ADDR);
>> +	writel(0, reg_base + WRAPPER_CPA_START_ADDR);
>> +	writel(VENUS_FW_MEM_SIZE, reg_base + WRAPPER_CPA_END_ADDR);
>> +	writel(0x0, reg_base + WRAPPER_CPU_CGC_DIS);
>> +	writel(0x0, reg_base + WRAPPER_CPU_CLOCK_CONFIG);
>> +
>> +	/* Make sure all register writes are committed. */
>> +	mb();
> 
> the comment says "register writes" hence shouldn't this be wmb? Also
> if we are going to have explicit memory barrier why not use
> writel_relaxed?
>> +
>> +	/*
>> +	 * Need to wait 10 cycles of internal clocks before bringing ARM9
> 
> Do we know what is the minimum frequency of the internal ARM9 clocks?
> I.e does 1us is enough for all venus versions.

ARM9 is yet not brought out of reset at this point. Sleep might be added
to ensure that the register writes are completed. But as Bjorn 
commented,
only way to ensure registers are written is to read them back. I do not 
have
proper justification of sleep as this code was used for many chipset 
bringup.
I can try by removing the sleep and if goes well, we can live without 
it.

>> +	 * out of reset.
>> +	 */
>> +	udelay(1);
>> +
>> +	/* Bring Arm9 out of reset */
> 
> ARM9
> 
>> +	writel_relaxed(0, reg_base + WRAPPER_A9SS_SW_RESET);
> 
> in my opinion we should have a wmb here too
I guess if sleep is removed, we will be left with only the above 
instruction.
so no need to ensure the access order.

> regards,
> Stan
