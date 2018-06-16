Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD44320891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWYw4XDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeFPMNf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:13:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55244 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbeFPMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:13:32 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so6207680itx.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3EuTKpSUNNUaWwetx3J7S/O0ZWvXjjNxLJZ68M30xk4=;
        b=CWYw4XDCVTDNqiHK4xbi3AwhaiN/a4UYexbjZqMqmLZ90Cswz4lVb76HF2ieDm6H9g
         j83U4I3qwwy0j24AbCjbxlt9pYpO3fQfQswX+MURhOum2eDFPD/wVO7pC35ivQ7fTGes
         tz+jRg+EenwBurZHlfi5D5WTXZAHc0PpOY07o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3EuTKpSUNNUaWwetx3J7S/O0ZWvXjjNxLJZ68M30xk4=;
        b=fqi6f6ePbimA4JQdISp89EDIRb44hg0JRVtxntMGMeheTOT2vhGRo6NYUZVy45NwGY
         pqUp2/6xAVlVOOTxhjzp4QAZNYEoo61O2jP02INWnLE4Q+NxIVUIhnTo/FW67kSMY6P8
         DKRxldYXOGo7Prqp+Tsr0PW5IMDAkwDKEOdhQwnH2i2GBUUM1Mlt4fMYKGr7GQf46MUF
         S7F+qFncyEYlZd/7yBzYLflKx29hl/81rYlSnTUwbIaJzNkrcENK6ACjBypGYkPhW34P
         40ek9pdksgUINTT7Njzc0051xLc7iUygptnuDax1Q+tryGdA/FErhIHH4MwntziCsOvA
         fQ5Q==
X-Gm-Message-State: APt69E369JqDhgVd5Ay24Vrer3lttViBbnFUnzllXQ9AAGjWmIo6Jp69
        3KufbLlefkSdzTDzMrqH+T+toRBpg1CHSy8/ztDbmw==
X-Google-Smtp-Source: ADUXVKLzi4tHloTiD57T8EKyCyiIj44ke2CcZ1jO8NYpaZVnUN0UEhYbKENryEfkrJ4AXalufpkmstvJLB7b2z6V788=
X-Received: by 2002:a02:7b04:: with SMTP id q4-v6mr4068492jac.107.1529151211887;
 Sat, 16 Jun 2018 05:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 05:13:31
 -0700 (PDT)
In-Reply-To: <9193c5c7-78a9-f57c-4529-2346ddaafc13@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org> <20180612044052.4402-7-rnayak@codeaurora.org>
 <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org> <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
 <bd8999bd-a3ae-b7e2-a805-b31d38571ec6@codeaurora.org> <CAPDyKFrz=+nnLS+YnrSKzo_UXVgKLoTvH5XQL1o_EV5u3zvw9g@mail.gmail.com>
 <9193c5c7-78a9-f57c-4529-2346ddaafc13@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 16 Jun 2018 14:13:31 +0200
Message-ID: <CAPDyKFq-OVH1qVgK3MQ0NQwcBEvpBFmP-eGmSgPsKKqr0Jw7zw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     David Collins <collinsd@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 June 2018 at 23:46, David Collins <collinsd@codeaurora.org> wrote:
> Hello Ulf,
>
> On 06/15/2018 02:25 AM, Ulf Hansson wrote:
>> On 14 June 2018 at 20:17, David Collins <collinsd@codeaurora.org> wrote:
>>> On 06/13/2018 11:54 PM, Rajendra Nayak wrote:
>>>> On 06/14/2018 06:02 AM, David Collins wrote:
>>>>> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>>> ...
>>>>>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>>>>>> +{
>>>>>> +   struct rpmhpd *pd = domain_to_rpmhpd(domain);
>>>>>> +   int ret = 0;
>>>>>> +
>>>>>> +   mutex_lock(&rpmhpd_lock);
>>>>>> +
>>>>>> +   if (pd->level[0] == 0)
>>>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>>>>
>>>>> I'm not sure that we want to have the 'pd->level[0] == 0' check,
>>>>> especially when considering aggregation with the peer pd.  I understand
>>>>> its intention to try to keep enable state and level setting orthogonal.
>>>>> However, as it stands now, the final request sent to hardware would differ
>>>>> depending upon the order of calls.  Consider the following example.
>>>>>
>>>>> Initial state:
>>>>> pd->level[0] == 0
>>>>> pd->corner = 5, pd->enabled = true, pd->active_only = false
>>>>> pd->peer->corner = 7, pd->peer->enabled = true, pd->peer->active_only = true
>>>>>
>>>>> Outstanding requests:
>>>>> RPMH_ACTIVE_ONLY_STATE = 7, RPMH_WAKE_ONLY_STATE = 7, RPMH_SLEEP_STATE = 5
>>>>>
>>>>> Case A:
>>>>>      1. set pd->corner = 6
>>>>>              --> new value request: RPMH_SLEEP_STATE = 6
>>>>>              --> duplicate value requests: RPMH_ACTIVE_ONLY_STATE = 7,
>>>>>                      RPMH_WAKE_ONLY_STATE = 7
>>>>>      2. power_off pd->peer
>>>>>              --> no requests
>>>>
>>>> I am not sure why there would be no requests, since we do end up aggregating
>>>> with pd->peer->corner = 0.
>>>> So the final state would be
>>>>
>>>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>>>> RPMH_WAKE_ONLY_STATE = 6
>>>> RPMH_SLEEP_STATE = max(6, 0) = 6
>>>
>>> Argh, my example was ruined by a one character typo.  I meant to have:
>>>
>>>         Initial state:
>>>         pd->level[0] != 0
>>>
>>>
>>>>>
>>>>>      Final state:
>>>>>      RPMH_ACTIVE_ONLY_STATE = 7
>>>>>      RPMH_WAKE_ONLY_STATE = 7
>>>>>      RPMH_SLEEP_STATE = 6
>>>>>
>>>>> Case B:
>>>>>      1. power_off pd->peer
>>>>>              --> no requests
>>>>
>>>> Here it would be again be aggregation based on pd->peer->corner = 0
>>>> so,
>>>> RPMH_ACTIVE_ONLY_STATE = max(5, 0) = 5
>>>> RPMH_WAKE_ONLY_STATE = 5
>>>> RPMH_SLEEP_STATE = max(5, 0) = 5
>>>>
>>>>>      2. set pd->corner = 6
>>>>>              --> new value requests: RPMH_ACTIVE_ONLY_STATE = 6,
>>>>>                     RPMH_WAKE_ONLY_STATE = 6, RPMH_SLEEP_STATE = 6
>>>>>
>>>>>      Final state:
>>>>>      RPMH_ACTIVE_ONLY_STATE = 6
>>>>>      RPMH_WAKE_ONLY_STATE = 6
>>>>>      RPMH_SLEEP_STATE = 6
>>>>
>>>> correct,
>>>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>>>> RPMH_WAKE_ONLY_STATE = 6
>>>> RPMH_SLEEP_STATE = max(6, 0) = 6
>>>>
>>>>>
>>>>> Without the check, Linux would vote for the lowest supported level when
>>>>> power_off is called.  This seems semantically reasonable given that the
>>>>> consumer is ok with the power domain going fully off and that would be the
>>>>> closest that we can get.
>>>>
>>>> So are you suggesting I replace
>>>>
>>>>>> +   if (pd->level[0] == 0)
>>>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>>>
>>>> with
>>>>
>>>>>> +   ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
>>>
>>> Yes, this is the modification that I'm requesting.
>>>
>>>
>>>> I can see what you said above makes sense but if its
>>>>> Initial state:
>>>>> pd->level[0] != 0
>>>>
>>>> Was that what you meant?
>>>
>>> Yes.
>>
>> Apologize for jumping into the discussion.
>>
>> I have a couple of ideas, that may simplify/improve things related to the above.
>>
>> 1) Would it be easier if genpd calls ->set_performance_state(0) before
>> it is about to call the ->power_off() callback? Actually Viresh wanted
>> that from the start, but I thought it was useless.
>
> This sounds like a relatively reasonable thing to do that falls in line
> with the semantics of the API.  It would also necessitate genpd
> aggregating performance state requests again when ->power_on() is called
> so that ->set_performance_state() can be called with an appropriate value.
>
> I think that the issue that I identified above should be solved outright
> within the rpmhpd driver though.  It is a bug in the RPMh-specific active
> + sleep vs active-only aggregation logic.
>
> The feature you are describing here seems more like a power optimization
> that would help in the case of consumer disabling the power domain without
> scaling down the performance level for a power domain that does not
> support enable/disable.

Right. Seems like this isn't needed then.

The genpd driver can just implement the callbacks instead.

>
> Would this behavior in genpd be implemented per power domain or per consumer?
>
>
>> 2) When device are becoming runtime suspended, the ->runtime_suspend()
>> callback of genpd is invoked (genpd_runtime_suspend()). However, in
>> there we don't care to re-evaluate the votes on the performance level,
>> but instead rely on the corresponding driver for the device to drop
>> the vote. I think it would be a good idea of managing this internally
>> in genpd instead, thus, depending on if the aggregated vote can be
>> decreased we should call  ->set_performance_state(new-vote). Of
>> course, once the device get runtime resumed, the votes needs to be
>> restored for the device.
>
> This feature sounds a little risky.  Is it really safe for all cases for
> the genpd framework to unilaterally make these kind of decisions for
> consumers?  Could there be any interdependencies between resources that
> consumers need to enforce that would not be possible if genpd handled
> power state reduction automatically (for example two power domains with a
> sequencing requirement between them)?

In regards to resource/device dependencies, those needs to be properly
manged anyway when using runtime PM. For that we have mechanism for
dealing with parent-childs and the so called device links for
functional dependencies.

For sequencing, that may be an issue, as currently we don't propagate
performance states hierarchically inside genpd. I know Viresh is
looking at addressing this, so perhaps we should come back to this
within that context instead.

Kind regards
Uffe
