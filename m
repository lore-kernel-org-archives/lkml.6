Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeEWMP4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:15:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeEWMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:15:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A36FC601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
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
 <20180509170159.29682-2-ilina@codeaurora.org>
 <CAD=FV=UV9tGt9Pvj-zb0CP692=BxgqYVkb4iTj+R4qjjn34tgQ@mail.gmail.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <950ecbb0-90de-b639-ee49-c17f1ad745d1@codeaurora.org>
Date: Wed, 23 May 2018 17:45:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UV9tGt9Pvj-zb0CP692=BxgqYVkb4iTj+R4qjjn34tgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/2018 1:45 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +       int ret;
>> +
>> +       if (!msg || !msg->cmds || !msg->num_cmds ||
>> +           msg->num_cmds > MAX_RPMH_PAYLOAD) {
>> +               WARN_ON(1);
>> +               return -EINVAL;
>> +       }
>> +
>> +       do {
>> +               ret = tcs_write(drv, msg);
>> +               if (ret == -EBUSY) {
>> +                       pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
>> +                                           msg->cmds[0].addr);
>> +                       udelay(10);
>> +               }
>> +       } while (ret == -EBUSY);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(rpmh_rsc_send_data);
> 
> Here and elsewhere in this series: why EXPORT_SYMBOL in this case?
> This is only exported to rpmh.c, right?  You don't need EXPORT_SYMBOL
> for that.  The Makefile puts rpmh.c and rpmh-rsc.c together in the
> same "qcom_rpmh.o", and then even further the KConfig lists this as
> bool so both are builtin to the kernel.
> 
> -Doug

Sure. I Will change in v9.

Thanks for your review Doug,
Raju

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
