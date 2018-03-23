Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCWTey (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:34:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCWTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:34:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 700F6602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH V3] Input: pm8941-pwrkey: add resin key capabilities
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tirupathi Reddy <tirupath@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1521786192-19487-1-git-send-email-tirupath@codeaurora.org>
 <240c6cbc-886f-94c6-cba4-3c4eb3ed0b45@codeaurora.org>
 <20180323192210.GE255819@dtor-ws>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <6928c292-b10b-3056-af02-f1ab70d8f494@codeaurora.org>
Date: Fri, 23 Mar 2018 12:34:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180323192210.GE255819@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

>>
>>
>> What happens if interrupts comes as soon as you have done the key_init(..)
>> here? I see that you are registering the input device after it, right? Looks
>> like you should do this at the end of probe?
> 
> It should be fine, input devices properly allocated (with
> input_allocate_device() or devm- version) are able to accept events even
> if input device has not been registered yet. It is and advertised
> feature:
> 
> drivers/input/input.c:
> 
> "
>   * input_event() - report new input event
> ...
>   * NOTE: input_event() may be safely used right after input device was
>   * allocated with input_allocate_device(), even before it is registered
>   * with input_register_device(), but the event will not reach any of the
>   * input handlers. Such early invocation of input_event() may be used
>   * to 'seed' initial state of a switch or initial position of absolute
>   * axis, etc.

Thanks. Looks good since input_allocate_device(...) is called before the 
init.

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
