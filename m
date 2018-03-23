Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeCWXyY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:54:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36381 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCWXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:54:22 -0400
X-Google-Smtp-Source: AG47ELuYOyq20/W0BXtC+eUjq8RNaZAIjichLLqt0pdOzi6BSc9oSHlDSFgWtp3eC+5GNZz/EWXCfA==
Subject: Re: [PATCH v2] venus: vdec: fix format enumeration
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Alexandre Courbot <acourbot@chromium.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180319093229.76253-1-acourbot@chromium.org>
 <35d51db4-bbca-e76a-abff-ed74172a5fe2@linaro.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3f82e52d-7e5e-4184-ea36-e76d924ab00c@linaro.org>
Date: Sat, 24 Mar 2018 01:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <35d51db4-bbca-e76a-abff-ed74172a5fe2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Could you take this patch it not too late.

On 20.03.2018 15:42, Stanimir Varbanov wrote:
> Hi Alex,
> 
> Thanks!
> 
> On 03/19/2018 11:32 AM, Alexandre Courbot wrote:
>> find_format_by_index() stops enumerating formats as soon as the index
>> matches, and returns NULL if venus_helper_check_codec() finds out that
>> the format is not supported. This prevents formats to be properly
>> enumerated if a non-supported format is present, as the enumeration will
>> end with it.
>>
>> Fix this by moving the call to venus_helper_check_codec() into the loop,
>> and keep enumerating when it fails.
>>
>> Fixes: 29f0133ec6 media: venus: use helper function to check supported codecs
>>
>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>> ---
>>   drivers/media/platform/qcom/venus/vdec.c | 13 +++++++------
>>   drivers/media/platform/qcom/venus/venc.c | 13 +++++++------
>>   2 files changed, 14 insertions(+), 12 deletions(-)
> 
> Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 

regards,
Stan
