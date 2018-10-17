Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA8EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DCC21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GpZ+SXyh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eo6ks3IA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DCC21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJQVRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:17:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:17:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B059612F8; Wed, 17 Oct 2018 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782503;
        bh=PqZM9/ClNBBrn2QK1rPUvR0PvUsLc8nOoneps/IFJIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GpZ+SXyhA+b3XzU8hLb21Xw/Qdcjbu1A80JVV0j9/wkc6qI769PIjilS99D8/xpcM
         MmSY6fVjXZzjr6nG1Bxpv4mff/uxLXfD1fZLIoeEhLqazu7eebOFZTcB/bsmm0oVdV
         P14TRkW4rulyDYxFafXkQle6rokACulVF+xbg5ZY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B764A6021C;
        Wed, 17 Oct 2018 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782502;
        bh=PqZM9/ClNBBrn2QK1rPUvR0PvUsLc8nOoneps/IFJIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eo6ks3IAY48zxfbRlYgBtnarsRnqlALpb8nZnrSpxyyXvplbajubV3vfaWFAvdJKr
         aoTYBdywsAgL+0UgTh7OuDgdhamTDt9QxKhpmMJGsH1AO7qMBJibDGMQUtWotk83Nl
         S4Wvv/GJ5I1bzPYU7W5b2P0aHzsRilaoGSNTcvj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Oct 2018 18:51:42 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Venus updates - PIL
In-Reply-To: <a31e499a-fa88-67b8-1853-8ea0d9297aa9@linaro.org>
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
 <a31e499a-fa88-67b8-1853-8ea0d9297aa9@linaro.org>
Message-ID: <5c098025f136c25f5b0bb14d79866cf8@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

Thanks for the review and approvals.
I have just posted v12 with the below comments addressed.

Please check and provide your blessings :)

On 2018-10-17 14:40, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> Thanks for the patches and patience!
> 
> On 10/08/2018 04:32 PM, Vikash Garodia wrote:
>> This version of the series
>> * extends the description of firmware subnode in documentation.
>> * renames the flag suggesting the presence of tz and update code
>>   accordingly.
>> 
>> Stanimir Varbanov (1):
>>   venus: firmware: register separate platform_device for firmware 
>> loader
>> 
>> Vikash Garodia (4):
>>   venus: firmware: add routine to reset ARM9
>>   venus: firmware: move load firmware in a separate function
>>   venus: firmware: add no TZ boot and shutdown routine
>>   dt-bindings: media: Document bindings for venus firmware device
>> 
>>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>>  drivers/media/platform/qcom/venus/core.h           |   6 +
>>  drivers/media/platform/qcom/venus/firmware.c       | 235 
>> +++++++++++++++++++--
>>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>>  7 files changed, 274 insertions(+), 43 deletions(-)
>> 
> 
> Tested-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> With the comment addressed in 1/5:
> 
> Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
