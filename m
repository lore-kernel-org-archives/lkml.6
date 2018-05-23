Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbeEWMWE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:22:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeEWMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:22:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A14E860314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 07/10] drivers: qcom: rpmh: cache sleep/wake state
 requests
To: Doug Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, msivasub@codeaurora.org,
        mkshah@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-8-ilina@codeaurora.org>
 <CAD=FV=VLQRHfWgbVhcCBJxd5iRh+R_kbdtT=fPixK0O_iqYwOg@mail.gmail.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <2c6fc480-7894-2a69-b1ff-fc3cbc96a9a1@codeaurora.org>
Date: Wed, 23 May 2018 17:51:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VLQRHfWgbVhcCBJxd5iRh+R_kbdtT=fPixK0O_iqYwOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/2018 1:48 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>   /**
>>    * struct rpmh_request: the message to be sent to rpmh-rsc
>>    *
>> @@ -54,9 +71,15 @@ struct rpmh_request {
>>    * struct rpmh_ctrlr: our representation of the controller
>>    *
>>    * @drv: the controller instance
>> + * @cache: the list of cached requests
>> + * @lock: synchronize access to the controller data
> 
> nit: this makes it sound like this lock will be grabbed for all calls
> into rpmh-rsc.  In fact, it only protects access to the cache.
> Ideally name it cache_lock and document that it's for protecting the
> cache.
> 
> 
>> +/**
>> + * rpmh_flush: Flushes the buffered active and sleep sets to TCS
>> + *
>> + * @dev: The device making the request
>> + *
>> + * Return: -EBUSY if the controller is busy, probably waiting on a response
>> + * to a RPMH request sent earlier.
>> + *
>> + * This function is generally called from the sleep code from the last CPU
> 
> "is generally" implies that sometimes it's not called from the sleep
> code.  Change to "is always".  If "is generally" is more correct, you
> can't run lockless right?
> 
> 
> -Doug
> 

Yes. Will change in next patch.

Thanks,
Raju
