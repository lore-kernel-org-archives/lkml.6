Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756184AbeEARfN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:35:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755035AbeEARfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:35:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 994A3601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 1 May 2018 11:35:07 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180501173507.GC23157@codeaurora.org>
References: <20180425214111.GC243180@google.com>
 <20180427173943.GD6380@codeaurora.org>
 <20180427184017.GI243180@google.com>
 <20180427194559.GE6380@codeaurora.org>
 <20180427200605.GJ243180@google.com>
 <20180427213201.GA23157@codeaurora.org>
 <20180427215449.GA133494@google.com>
 <CAD=FV=Wan0G_GG29Q-atBbQS+_7nnbqTndE+yyi_G=scOdGMFA@mail.gmail.com>
 <20180501161010.GB23157@codeaurora.org>
 <CAD=FV=XAPLxFqMvWrvAbpki0AvN_TqKgzBYmZAuomVz-9ieK=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=XAPLxFqMvWrvAbpki0AvN_TqKgzBYmZAuomVz-9ieK=Q@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01 2018 at 10:42 -0600, Doug Anderson wrote:
>Hi,
>
>On Tue, May 1, 2018 at 9:10 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> Yes, this is incorrect in its current form. This is what it should be -
>>
>> static int find_match(const struct tcs_group *tcs, const struct tcs_cmd
>> *cmd,
>>                      int len)
>> {
>>        int i, j;
>>
>>        /* Check for already cached commands */
>>        for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>>                if (tcs->cmd_cache[i] != cmd[0].addr)
>>                        continue;
>>                for (j = 0; j < len; j++) {
>>                        WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
>>                             "Message does not match previous sequence.\n");
>>                        return -EINVAL;
>>                }
>
>If len > 0, won't the above always return -EINVAL?
>
>
>>                if (j == len - 1)
>>                        return i;
>
>Care to explain how you could get here and the test "if (j == len -
>1)" could be false?  ;-P
>
True. Will fix it in the next spin correctly.

--Lina
