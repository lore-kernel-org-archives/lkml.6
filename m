Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D39C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB6C208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ec3Zf6N0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZbDIG2CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB6C208DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756580AbeFOVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:46:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeFOVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:46:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14677607E4; Fri, 15 Jun 2018 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529099177;
        bh=oAyTSlrfMW7Tjgf1HO2NG4UEFdjFRLZPk0e0MKBubDM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ec3Zf6N0Bgc/DdwyqKqhrPLZlsAjbOkm0wEcn4MLWtpql7Va6VBjb8gbDdYEGRZT+
         S6SL04PHUJfiDiu5Kog+BW6D6eFmyUEY/uXcddb5Qc1VDmFIveGeTbw7f7TUizwDqo
         mI/2v2bxrTGXL/wYM9ZgWjss+Ou6a6S10GzTW3Nk=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D48EA60540;
        Fri, 15 Jun 2018 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529099176;
        bh=oAyTSlrfMW7Tjgf1HO2NG4UEFdjFRLZPk0e0MKBubDM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZbDIG2CEoxhg7OInwd6qhRyOl4MYDhp/RQQFBMXUErio8kWQTedUN8kTW7NrnOVpi
         uqOOkvmx/wikXgXtvtvMoVZ0pqdPkxm/gDMmonPKvVYkavlr9x8OVI9RKjZ8Ipa4Lc
         rhvowYIroOIIL/M627K6kI23+0u/nRth8QDm83no=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D48EA60540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-7-rnayak@codeaurora.org>
 <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org>
 <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
 <bd8999bd-a3ae-b7e2-a805-b31d38571ec6@codeaurora.org>
 <CAPDyKFrz=+nnLS+YnrSKzo_UXVgKLoTvH5XQL1o_EV5u3zvw9g@mail.gmail.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <9193c5c7-78a9-f57c-4529-2346ddaafc13@codeaurora.org>
Date:   Fri, 15 Jun 2018 14:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrz=+nnLS+YnrSKzo_UXVgKLoTvH5XQL1o_EV5u3zvw9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ulf,

On 06/15/2018 02:25 AM, Ulf Hansson wrote:
> On 14 June 2018 at 20:17, David Collins <collinsd@codeaurora.org> wrote:
>> On 06/13/2018 11:54 PM, Rajendra Nayak wrote:
>>> On 06/14/2018 06:02 AM, David Collins wrote:
>>>> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>> ...
>>>>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>>>>> +{
>>>>> +   struct rpmhpd *pd = domain_to_rpmhpd(domain);
>>>>> +   int ret = 0;
>>>>> +
>>>>> +   mutex_lock(&rpmhpd_lock);
>>>>> +
>>>>> +   if (pd->level[0] == 0)
>>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>>>
>>>> I'm not sure that we want to have the 'pd->level[0] == 0' check,
>>>> especially when considering aggregation with the peer pd.  I understand
>>>> its intention to try to keep enable state and level setting orthogonal.
>>>> However, as it stands now, the final request sent to hardware would differ
>>>> depending upon the order of calls.  Consider the following example.
>>>>
>>>> Initial state:
>>>> pd->level[0] == 0
>>>> pd->corner = 5, pd->enabled = true, pd->active_only = false
>>>> pd->peer->corner = 7, pd->peer->enabled = true, pd->peer->active_only = true
>>>>
>>>> Outstanding requests:
>>>> RPMH_ACTIVE_ONLY_STATE = 7, RPMH_WAKE_ONLY_STATE = 7, RPMH_SLEEP_STATE = 5
>>>>
>>>> Case A:
>>>>      1. set pd->corner = 6
>>>>              --> new value request: RPMH_SLEEP_STATE = 6
>>>>              --> duplicate value requests: RPMH_ACTIVE_ONLY_STATE = 7,
>>>>                      RPMH_WAKE_ONLY_STATE = 7
>>>>      2. power_off pd->peer
>>>>              --> no requests
>>>
>>> I am not sure why there would be no requests, since we do end up aggregating
>>> with pd->peer->corner = 0.
>>> So the final state would be
>>>
>>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>>> RPMH_WAKE_ONLY_STATE = 6
>>> RPMH_SLEEP_STATE = max(6, 0) = 6
>>
>> Argh, my example was ruined by a one character typo.  I meant to have:
>>
>>         Initial state:
>>         pd->level[0] != 0
>>
>>
>>>>
>>>>      Final state:
>>>>      RPMH_ACTIVE_ONLY_STATE = 7
>>>>      RPMH_WAKE_ONLY_STATE = 7
>>>>      RPMH_SLEEP_STATE = 6
>>>>
>>>> Case B:
>>>>      1. power_off pd->peer
>>>>              --> no requests
>>>
>>> Here it would be again be aggregation based on pd->peer->corner = 0
>>> so,
>>> RPMH_ACTIVE_ONLY_STATE = max(5, 0) = 5
>>> RPMH_WAKE_ONLY_STATE = 5
>>> RPMH_SLEEP_STATE = max(5, 0) = 5
>>>
>>>>      2. set pd->corner = 6
>>>>              --> new value requests: RPMH_ACTIVE_ONLY_STATE = 6,
>>>>                     RPMH_WAKE_ONLY_STATE = 6, RPMH_SLEEP_STATE = 6
>>>>
>>>>      Final state:
>>>>      RPMH_ACTIVE_ONLY_STATE = 6
>>>>      RPMH_WAKE_ONLY_STATE = 6
>>>>      RPMH_SLEEP_STATE = 6
>>>
>>> correct,
>>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>>> RPMH_WAKE_ONLY_STATE = 6
>>> RPMH_SLEEP_STATE = max(6, 0) = 6
>>>
>>>>
>>>> Without the check, Linux would vote for the lowest supported level when
>>>> power_off is called.  This seems semantically reasonable given that the
>>>> consumer is ok with the power domain going fully off and that would be the
>>>> closest that we can get.
>>>
>>> So are you suggesting I replace
>>>
>>>>> +   if (pd->level[0] == 0)
>>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>>
>>> with
>>>
>>>>> +   ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
>>
>> Yes, this is the modification that I'm requesting.
>>
>>
>>> I can see what you said above makes sense but if its
>>>> Initial state:
>>>> pd->level[0] != 0
>>>
>>> Was that what you meant?
>>
>> Yes.
> 
> Apologize for jumping into the discussion.
> 
> I have a couple of ideas, that may simplify/improve things related to the above.
> 
> 1) Would it be easier if genpd calls ->set_performance_state(0) before
> it is about to call the ->power_off() callback? Actually Viresh wanted
> that from the start, but I thought it was useless.

This sounds like a relatively reasonable thing to do that falls in line
with the semantics of the API.  It would also necessitate genpd
aggregating performance state requests again when ->power_on() is called
so that ->set_performance_state() can be called with an appropriate value.

I think that the issue that I identified above should be solved outright
within the rpmhpd driver though.  It is a bug in the RPMh-specific active
+ sleep vs active-only aggregation logic.

The feature you are describing here seems more like a power optimization
that would help in the case of consumer disabling the power domain without
scaling down the performance level for a power domain that does not
support enable/disable.

Would this behavior in genpd be implemented per power domain or per consumer?


> 2) When device are becoming runtime suspended, the ->runtime_suspend()
> callback of genpd is invoked (genpd_runtime_suspend()). However, in
> there we don't care to re-evaluate the votes on the performance level,
> but instead rely on the corresponding driver for the device to drop
> the vote. I think it would be a good idea of managing this internally
> in genpd instead, thus, depending on if the aggregated vote can be
> decreased we should call  ->set_performance_state(new-vote). Of
> course, once the device get runtime resumed, the votes needs to be
> restored for the device.

This feature sounds a little risky.  Is it really safe for all cases for
the genpd framework to unilaterally make these kind of decisions for
consumers?  Could there be any interdependencies between resources that
consumers need to enforce that would not be possible if genpd handled
power state reduction automatically (for example two power domains with a
sequencing requirement between them)?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
