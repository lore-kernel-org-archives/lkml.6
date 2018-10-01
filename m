Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10B1208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="URa74D9s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G3jgmTIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10B1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeJAWXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:23:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJAWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:23:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7254D60C1D; Mon,  1 Oct 2018 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538408688;
        bh=q15h+YKcFMqb3r1sNrIuc0XDQxrAwGjcUX9M7z0GYT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=URa74D9sRuP4f7zQIWRxtYE/pUBgAA3cazDXxvNIHKDb98pnVW/gCoOxb4PGSQmHQ
         bgzn5qL6b/CYlNamv9zLmuK909+AQoXad6P/ECcVeSiFH+x6PmCDCsg33OdT9KJf7f
         Mqe/wzeXXPRnherj1Nmdc6kl51/2r2rMCQYlmSOg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D998860C5F;
        Mon,  1 Oct 2018 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538408687;
        bh=q15h+YKcFMqb3r1sNrIuc0XDQxrAwGjcUX9M7z0GYT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G3jgmTImJwdS5Oxram/LVwHzv6BF/ASNnfjmO4fXrWG1hIfTrm7oyN6mGKZtA4hIb
         lJaDZzjMuwcPIuFnvZKcrUP8S4EeKrN+xrYYk7M1wAo56ez+kf5O1iUJPziGSjnkU8
         QHCWTMs9SvCPsVuwhTuz8YtW4Zhhbsasl3cyDuaQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 21:14:46 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v9 1/5] venus: firmware: add routine to reset ARM9
In-Reply-To: <cdc7769d-8bea-ac78-355e-07347ac8aaf1@linaro.org>
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
 <1537314192-26892-2-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MXMv_TD2dbxyM+D2p3pWfCJpQ-_FHK6WdkAEgBhwTdL6g@mail.gmail.com>
 <97b94b9b-f028-cb8b-a3db-67626dc517ab@linaro.org>
 <175fcecf3be715d2a20b71746c648f1e@codeaurora.org>
 <CAPBb6MUo6X+L7UYgmw8qUe_2CiZEBKGxaREFhZGRU1jGq0fO=g@mail.gmail.com>
 <cdc7769d-8bea-ac78-355e-07347ac8aaf1@linaro.org>
Message-ID: <a2aacb3257cb4542086043d17128d098@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On 2018-10-01 20:00, Stanimir Varbanov wrote:
> Hi,
> 
> On 09/20/2018 06:31 AM, Alexandre Courbot wrote:
>> On Thu, Sep 20, 2018 at 2:55 AM Vikash Garodia 
>> <vgarodia@codeaurora.org> wrote:
>>> 
>>> On 2018-09-19 20:30, Stanimir Varbanov wrote:
>>>> Hi Alex,
>>>> 
>>>> On 09/19/2018 10:32 AM, Alexandre Courbot wrote:
>>>>> On Wed, Sep 19, 2018 at 8:43 AM Vikash Garodia
>>>>> <vgarodia@codeaurora.org> wrote:
>>>>>> 
>>>>>> Add routine to reset the ARM9 and brings it out of reset. Also
>>>>>> abstract the Venus CPU state handling with a new function. This
>>>>>> is in preparation to add PIL functionality in venus driver.
>>>>>> 
>>>>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/media/platform/qcom/venus/core.h         |  2 ++
>>>>>>  drivers/media/platform/qcom/venus/firmware.c     | 33
>>>>>> ++++++++++++++++++++++++
>>>>>>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
>>>>>>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>>>>>>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
>>>>>>  5 files changed, 57 insertions(+), 9 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/media/platform/qcom/venus/core.h
>>>>>> b/drivers/media/platform/qcom/venus/core.h
>>>>>> index 2f02365..dfd5c10 100644
>>>>>> --- a/drivers/media/platform/qcom/venus/core.h
>>>>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>>>>> @@ -98,6 +98,7 @@ struct venus_caps {
>>>>>>   * @dev:               convenience struct device pointer
>>>>>>   * @dev_dec:   convenience struct device pointer for decoder 
>>>>>> device
>>>>>>   * @dev_enc:   convenience struct device pointer for encoder 
>>>>>> device
>>>>>> + * @no_tz:     a flag that suggests presence of trustzone
>>>>> 
>>>>> Looks like it suggests the absence of trustzone?
>>>>> 
>>>>> Actually I would rename it as use_tz and set it if TrustZone is 
>>>>> used.
>>>>> This would avoid double-negative statements like what we see below.
>>>> 
>>>> I find this suggestion reasonable.
>>> 
>>> Initially i planned to keep it as a positive flag. The reason behind
>>> keeping it
>>> as no_tz was to keep the default value of this flag to 0 indicating 
>>> tz
>>> is present
>>> by default.
>>> I can switch it to use_tz though and set it in firmware_init after 
>>> the
>>> presence of
>>> firmware node is checked.
>> 
>> Making sure the flag is explicitly initialized instead of relying on
>> default initialization is another good reason to have that change
>> IMHO. :)
> 
> Vikash, care to send a new version, or will fix that with follow up 
> patches?

I will provide a new series with the suggested change.

Thanks,
Vikash
