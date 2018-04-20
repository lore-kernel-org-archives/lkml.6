Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDTWot (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:44:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeDTWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:44:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05DE560310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 20 Apr 2018 16:44:45 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180420224445.GB18235@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <dcd4e178-cfd3-1c3f-da7c-1eb66a58cf15@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dcd4e178-cfd3-1c3f-da7c-1eb66a58cf15@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20 2018 at 13:07 -0600, David Collins wrote:
>On 04/18/2018 10:55 PM, Stephen Boyd wrote:
>> Quoting David Collins (2018-03-22 18:30:06)
>>> On 03/21/2018 12:07 PM, Stephen Boyd wrote:
>>>> Quoting David Collins (2018-03-16 18:09:10)
>>>>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>>>>> index 097f617..e0ecd0a 100644

>>>>> +       ret = cmd_db_ready();
>>>>> +       if (ret < 0) {
>>>>> +               if (ret != -EPROBE_DEFER)
>>>>> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
>>>>> +               return ret;
>>>>> +       }
>>>>
>>>> We should just make rpmh parent device call cmd_db_ready() so that these
>>>> devices aren't even populated until then and so that cmd_db_ready() is
>>>> only in one place. Lina?
>>>
>>> Let's see if Lina has qualms about this plan.
>>
>> Sounds like you're ok with it.
>
>Sure, I'll remove this check if Lina agrees to add it in the rpmh driver.
>
We want to make the RSC nodes child of Command DB? That way we probe the
controllers only if the command DB is ready?

I could do that. Just so you know, there is are no strict directives to
use Command DB. If a driver knows the information it needs to pass to
the accelerator, it may choose to skip command DB completely.

Thanks,
Lina
