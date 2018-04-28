Return-Path: <sdias@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpTWNx24BRd9lGINFMg8BN3HMDwsfZyuWTA/CkAdGqqO3deBgL2SGGM+QwqJoTbhMz8VO00
ARC-Seal: i=1; a=rsa-sha256; t=1524925700; cv=none;
        d=google.com; s=arc-20160816;
        b=jPT1FWFu/KPHqGRSLusmvq4RBwNPvXvhnE3hRZY8Q8f8T2BUYMxAOmSuFCN9P+9AqG
         1jfEclzuWlz7MiyXmR+V8WDxQmjpTE1NSRtNI68yLBI8RA2mkdCvfxAkGi4ouqODL58T
         NhWmCIGX39z8jhd4HJ0VkTN4a0Av/FseMnIdwgLx5IZXisH3rm6UU8dBJhdRZBROBA53
         3mZ5HXb4f1UVBXbjrd8QBBCJ7tfipGb1PQhDO02LSTzAghMU7gR9Fp0IHlgiGbIaOE5p
         UxC97EMaD+7qGY3BC98lztI6oa4TBy8Tae6M296A0swISY2gSarksO63w5eNHEo+hQ1t
         GB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=CDWjnad+YP8nZEVvEes6lb8wHPwDtoykdLtH9Mnqkjk=;
        b=rvngbapSOWObfKAT4UCSJfXxcRG3hOwy78qKCDyI6q8Q5o332WAO7jKMq04/1IBgIt
         hQICB9+4w2D8hnjfTc/R0PIEe9GgXwCMjQpkwCCtx0GCCZCgViVm3EAtFyUxqQJWZaoV
         oZ6edQPhPL4kStsQSODhSvZI2p+tAJ6eUyDu3MEULJPErYv4ot7hUbzsQSFSTdUfCrck
         Yc8nTVOr7dz1YAHzN2JCfsy/+QLX8W9Cmc/Jakur10pCwHeAQ+n6gMPU1R233i+1zDLU
         foMwhqUdyVfymTwLi07ZkodXEXzxF7xr8e8AbvOLHrfO62UaccjLYYDZ1qJnqjjthWsl
         vO/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PIytoDb0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BI+wow7/;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PIytoDb0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BI+wow7/;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0A8E60556
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
 <20180427072211.GA6735@kroah.com>
From: Sujeev Dias <sdias@codeaurora.org>
Message-ID: <71afaf61-4f93-8ebd-bcef-5b1a391890d4@codeaurora.org>
Date: Sat, 28 Apr 2018 07:28:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180427072211.GA6735@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306474861315?=
X-GMAIL-MSGID: =?utf-8?q?1599000491091076883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for quick feedback


On 04/27/2018 12:22 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 26, 2018 at 07:23:28PM -0700, Sujeev Dias wrote:
>> MHI Host Interface is a communication protocol to be used by the host
>> to control and communcate with modem over a high speed peripheral bus.
>> This module will allow host to communicate with external devices that
>> support MHI protocol.
>>
>> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> No one else has ever reviewed this code before?  That's not good, please
> at the very least, have someone else at your company go over it first.
> I don't want to be the ones having to point out all of the "obvious"
> issues :)
>
This code has gone thru rigorous code review and testing, before I 
submit next patch
I will have multiple people sign off on it.
>> ---
>>   Documentation/00-INDEX                        |    2 +
>>   Documentation/devicetree/bindings/bus/mhi.txt |  141 +++
>>   Documentation/mhi.txt                         |  235 ++++
>>   drivers/bus/Kconfig                           |   17 +
>>   drivers/bus/Makefile                          |    1 +
>>   drivers/bus/mhi/Makefile                      |    8 +
>>   drivers/bus/mhi/core/Makefile                 |    1 +
>>   drivers/bus/mhi/core/mhi_boot.c               |  593 ++++++++++
>>   drivers/bus/mhi/core/mhi_dtr.c                |  177 +++
>>   drivers/bus/mhi/core/mhi_init.c               | 1290 +++++++++++++++++++++
>>   drivers/bus/mhi/core/mhi_internal.h           |  732 ++++++++++++
>>   drivers/bus/mhi/core/mhi_main.c               | 1476 +++++++++++++++++++++++++
>>   drivers/bus/mhi/core/mhi_pm.c                 | 1177 ++++++++++++++++++++
>>   include/linux/mhi.h                           |  694 ++++++++++++
>>   include/linux/mod_devicetable.h               |   11 +
>>   15 files changed, 6555 insertions(+)
> And a 6555 line patch is a bit hard to consume all at once.  Can't this
> be split up into much more reviewable chunks?  Look at how some of the
> other new bus subsystems got added to the tree recently.  They were
> submitted in longer patch series, but smaller sized patches
> individually.  That makes things much easier to review.
>
> For example, there is no reason your debugfs stuff needs to be in this
> initial patch.  That should be in a separate one, right?  Same for
> firmware download.  Please take the time to break this up into logical
> steps.
>
> Like my son's math teacher keeps telling him, "show your work, not just
> an answer at the bottom of the page".
>
> Also, it is required by the DT maintainers to split that file alone up
> into a separate patch to be even considered for merging.
>
> One thing I can tell you right now that isn't acceptable:
That is interesting because internally it's separated, and I squash them 
thinking
it was preferred. I will separate them out to functional blocks
>> +#ifdef CONFIG_MHI_DEBUG
> Don't have a separate config option for debugging.  No one will enable
> it, which makes it pointless.   Everything has to be dynamic these days.
Intention was to completely compile out MHI_VERB messages because we 
have those messages in
data path.  For release build, we wanted to reduce as much mips as 
possible. However, for
debugging these messages are extremely helpful.

I will look into tracepoints...
>> +
>> +#define MHI_VERB(fmt, ...) do { \
>> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_VERBOSE) \
>> +			pr_debug("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#else
>> +
>> +#define MHI_VERB(fmt, ...)
>> +
>> +#endif
>> +
>> +#define MHI_LOG(fmt, ...) do {	\
>> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_INFO) \
>> +			pr_info("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
>> +} while (0)
>> +
>> +#define MHI_ERR(fmt, ...) do {	\
>> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_ERROR) \
>> +			pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
>> +#define MHI_CRITICAL(fmt, ...) do { \
>> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_CRITICAL) \
>> +			pr_alert("[C][%s] " fmt, __func__, ##__VA_ARGS__); \
>> +} while (0)
>> +
> And do not roll your own debugging/logging macros.  Use what is given to
> you (dev_info(), dev_err(), dev_dbg()), they are there for a reason.  By
> going around them, you circumvent the whole of the kernel logging
> infrastructure and declare that your tiny bus is somehow more "special"
> than it.
>
> And I doubt you want to make such a statement :)

well :).. I will remove them in next revision.
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Sujeev
-- 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
