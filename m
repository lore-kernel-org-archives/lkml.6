Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8070F208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNv77qP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8070F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeJAVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:08:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbeJAVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:08:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so3510429wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChWApLj41SHvi7aylF3dwTV20y/65nr1724kOYV7Ez8=;
        b=cNv77qP8mUX6kUmAUSbbid/1RphiU7ydbG8uCMqkuGRUbLyb1Hj3zRCH0/ZPECQ7HR
         cPGA5or6D63edhTiBv6JfDUSiK2heZAvXqJ3HTRUDLk+WoN6d9Gdf2ypGc65vAPM4HEP
         GEGp7Z7/vj6Qi8BrTl9P3hkML2tCuky9PC0jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChWApLj41SHvi7aylF3dwTV20y/65nr1724kOYV7Ez8=;
        b=LPydVX+zF23fuk9lv8iKOik2Lfgb4vaRL1LLYjShO7VPTk22FWJBBgGiqQk4mm7uy9
         9R9ZWSnYMfsrbJCQFAElx5sIbGj0FJHek84jo4JN6iKzSxwJIiPqskg6dJdJ06gRKLEx
         6zb5ewNgCXa+Nk8Tk0us7vS1clpJ5pxdByEsZfuH3ykalab25A6csbiar/7FaE4oUHbx
         ar8Gqq/N0WKR5UJN5YOKNt5+azVCFQA/BZOrTQ92N68qi4xsXP9FxTd+4q3La1bLEQTb
         hKfVZal3xgOS6s/BqjjDggcxZmzDZDkjbZs/rMkE6my7dBSX7JYUmz5jzL27CdXIMtcA
         84+w==
X-Gm-Message-State: ABuFfoit39I5VYV1GYQBYhs9fh+0xm2AzT4QhmBtGoU3/AC2LkyAGp1/
        i5TYmorAPJU6yzs9TdLf4tde6A==
X-Google-Smtp-Source: ACcGV62JJ22Ep9x+qr2dXSqf/2KMYX87bw45GvntlCEoQlejkDX8MKPDSiN6Putknt75QGlSkszipA==
X-Received: by 2002:adf:d082:: with SMTP id y2-v6mr7076158wrh.314.1538404243054;
        Mon, 01 Oct 2018 07:30:43 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id w26-v6sm8409668wmi.27.2018.10.01.07.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:30:42 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] venus: firmware: add routine to reset ARM9
To:     Alexandre Courbot <acourbot@chromium.org>, vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media-owner@vger.kernel.org
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
 <1537314192-26892-2-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MXMv_TD2dbxyM+D2p3pWfCJpQ-_FHK6WdkAEgBhwTdL6g@mail.gmail.com>
 <97b94b9b-f028-cb8b-a3db-67626dc517ab@linaro.org>
 <175fcecf3be715d2a20b71746c648f1e@codeaurora.org>
 <CAPBb6MUo6X+L7UYgmw8qUe_2CiZEBKGxaREFhZGRU1jGq0fO=g@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <cdc7769d-8bea-ac78-355e-07347ac8aaf1@linaro.org>
Date:   Mon, 1 Oct 2018 17:30:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MUo6X+L7UYgmw8qUe_2CiZEBKGxaREFhZGRU1jGq0fO=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/20/2018 06:31 AM, Alexandre Courbot wrote:
> On Thu, Sep 20, 2018 at 2:55 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>>
>> On 2018-09-19 20:30, Stanimir Varbanov wrote:
>>> Hi Alex,
>>>
>>> On 09/19/2018 10:32 AM, Alexandre Courbot wrote:
>>>> On Wed, Sep 19, 2018 at 8:43 AM Vikash Garodia
>>>> <vgarodia@codeaurora.org> wrote:
>>>>>
>>>>> Add routine to reset the ARM9 and brings it out of reset. Also
>>>>> abstract the Venus CPU state handling with a new function. This
>>>>> is in preparation to add PIL functionality in venus driver.
>>>>>
>>>>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>>>>> ---
>>>>>  drivers/media/platform/qcom/venus/core.h         |  2 ++
>>>>>  drivers/media/platform/qcom/venus/firmware.c     | 33
>>>>> ++++++++++++++++++++++++
>>>>>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
>>>>>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>>>>>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
>>>>>  5 files changed, 57 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/platform/qcom/venus/core.h
>>>>> b/drivers/media/platform/qcom/venus/core.h
>>>>> index 2f02365..dfd5c10 100644
>>>>> --- a/drivers/media/platform/qcom/venus/core.h
>>>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>>>> @@ -98,6 +98,7 @@ struct venus_caps {
>>>>>   * @dev:               convenience struct device pointer
>>>>>   * @dev_dec:   convenience struct device pointer for decoder device
>>>>>   * @dev_enc:   convenience struct device pointer for encoder device
>>>>> + * @no_tz:     a flag that suggests presence of trustzone
>>>>
>>>> Looks like it suggests the absence of trustzone?
>>>>
>>>> Actually I would rename it as use_tz and set it if TrustZone is used.
>>>> This would avoid double-negative statements like what we see below.
>>>
>>> I find this suggestion reasonable.
>>
>> Initially i planned to keep it as a positive flag. The reason behind
>> keeping it
>> as no_tz was to keep the default value of this flag to 0 indicating tz
>> is present
>> by default.
>> I can switch it to use_tz though and set it in firmware_init after the
>> presence of
>> firmware node is checked.
> 
> Making sure the flag is explicitly initialized instead of relying on
> default initialization is another good reason to have that change
> IMHO. :)

Vikash, care to send a new version, or will fix that with follow up patches?

-- 
regards,
Stan
