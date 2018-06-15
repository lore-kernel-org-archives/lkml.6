Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C8ACC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E1208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="egME8bPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69E1208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbeFOJZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:25:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53216 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeFOJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:25:23 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so1829911itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q8V1APV7OmfUGCoTrcOz0le7cy/T9LfH7WzeGXWIU78=;
        b=egME8bPD4jO7NRArwMDL95w9mFcA6yrdYenXGrqw0MTbuqCn+mZQ/PtRprAWytyz2k
         LIuzZVVJNbI/wTsQiacNDz3hngdE35ufbhisCl7Ptczyxu9WUrFecwVdoJfMNOCSM0X2
         vR1IKvLh80CJU9svr0FVpOeGC1gQkpw2eaWRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q8V1APV7OmfUGCoTrcOz0le7cy/T9LfH7WzeGXWIU78=;
        b=Xuw8xc1vyI0lBEYrFAK+GPWxTkr7gXcTVKpXpw79z+QfCe7MfFsvO0at3csU+oR8HP
         9e+FoYEs51mvxyXQPlJkB2F9I/Ndt03XX0/TJ3wRpvWx0DsSD59Ll0aka9+AN2WrRaLx
         zKIUL9Co4Pg7Y1m77lEtPYoCZYxxabZsGpuXY5uPm1m4OGGvSrIfgZUquZLaU69efsTj
         aM+I9iGxXuCaOD0bFupypcWSdtRZZJEP2yXq3IoKcygnVe5XU4Eb5dK4WvbeyVTgd51w
         MnG7QzJ4EJB0pEm0F+QXGK38dRztfI2tF8VftjSMt5Yr/n+bKcX25iM2RSj5YfD7Rswy
         lS1g==
X-Gm-Message-State: APt69E2yGpP230PWb60nfCb6meHss1SfUjb76/MQiDMbRiaVcXCoYQsl
        VJG3PTV4i2dxoiJ3maLT3w5GJERaOY6fp8iASwIWzg==
X-Google-Smtp-Source: ADUXVKJ4IEBnxdKHuEFTyNd5cNdimGcO4EUOFSPE/UumpGA2Ss3Zmp71P+xbxOs+6eDcgo8BMLtEoYnBpWEeRnQ/ev4=
X-Received: by 2002:a02:f45:: with SMTP id h66-v6mr122169jad.121.1529054723057;
 Fri, 15 Jun 2018 02:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 02:25:22
 -0700 (PDT)
In-Reply-To: <bd8999bd-a3ae-b7e2-a805-b31d38571ec6@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org> <20180612044052.4402-7-rnayak@codeaurora.org>
 <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org> <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
 <bd8999bd-a3ae-b7e2-a805-b31d38571ec6@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jun 2018 11:25:22 +0200
Message-ID: <CAPDyKFrz=+nnLS+YnrSKzo_UXVgKLoTvH5XQL1o_EV5u3zvw9g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     David Collins <collinsd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David, Rajendra,

On 14 June 2018 at 20:17, David Collins <collinsd@codeaurora.org> wrote:
> Hello Rajendra,
>
> On 06/13/2018 11:54 PM, Rajendra Nayak wrote:
>> On 06/14/2018 06:02 AM, David Collins wrote:
>>> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
> ...
>>>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>>>> +{
>>>> +   struct rpmhpd *pd = domain_to_rpmhpd(domain);
>>>> +   int ret = 0;
>>>> +
>>>> +   mutex_lock(&rpmhpd_lock);
>>>> +
>>>> +   if (pd->level[0] == 0)
>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>>
>>> I'm not sure that we want to have the 'pd->level[0] == 0' check,
>>> especially when considering aggregation with the peer pd.  I understand
>>> its intention to try to keep enable state and level setting orthogonal.
>>> However, as it stands now, the final request sent to hardware would differ
>>> depending upon the order of calls.  Consider the following example.
>>>
>>> Initial state:
>>> pd->level[0] == 0
>>> pd->corner = 5, pd->enabled = true, pd->active_only = false
>>> pd->peer->corner = 7, pd->peer->enabled = true, pd->peer->active_only = true
>>>
>>> Outstanding requests:
>>> RPMH_ACTIVE_ONLY_STATE = 7, RPMH_WAKE_ONLY_STATE = 7, RPMH_SLEEP_STATE = 5
>>>
>>> Case A:
>>>      1. set pd->corner = 6
>>>              --> new value request: RPMH_SLEEP_STATE = 6
>>>              --> duplicate value requests: RPMH_ACTIVE_ONLY_STATE = 7,
>>>                      RPMH_WAKE_ONLY_STATE = 7
>>>      2. power_off pd->peer
>>>              --> no requests
>>
>> I am not sure why there would be no requests, since we do end up aggregating
>> with pd->peer->corner = 0.
>> So the final state would be
>>
>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>> RPMH_WAKE_ONLY_STATE = 6
>> RPMH_SLEEP_STATE = max(6, 0) = 6
>
> Argh, my example was ruined by a one character typo.  I meant to have:
>
>         Initial state:
>         pd->level[0] != 0
>
>
>>>
>>>      Final state:
>>>      RPMH_ACTIVE_ONLY_STATE = 7
>>>      RPMH_WAKE_ONLY_STATE = 7
>>>      RPMH_SLEEP_STATE = 6
>>>
>>> Case B:
>>>      1. power_off pd->peer
>>>              --> no requests
>>
>> Here it would be again be aggregation based on pd->peer->corner = 0
>> so,
>> RPMH_ACTIVE_ONLY_STATE = max(5, 0) = 5
>> RPMH_WAKE_ONLY_STATE = 5
>> RPMH_SLEEP_STATE = max(5, 0) = 5
>>
>>>      2. set pd->corner = 6
>>>              --> new value requests: RPMH_ACTIVE_ONLY_STATE = 6,
>>>                     RPMH_WAKE_ONLY_STATE = 6, RPMH_SLEEP_STATE = 6
>>>
>>>      Final state:
>>>      RPMH_ACTIVE_ONLY_STATE = 6
>>>      RPMH_WAKE_ONLY_STATE = 6
>>>      RPMH_SLEEP_STATE = 6
>>
>> correct,
>> RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
>> RPMH_WAKE_ONLY_STATE = 6
>> RPMH_SLEEP_STATE = max(6, 0) = 6
>>
>>>
>>> Without the check, Linux would vote for the lowest supported level when
>>> power_off is called.  This seems semantically reasonable given that the
>>> consumer is ok with the power domain going fully off and that would be the
>>> closest that we can get.
>>
>> So are you suggesting I replace
>>
>>>> +   if (pd->level[0] == 0)
>>>> +           ret = rpmhpd_aggregate_corner(pd, 0);
>>
>> with
>>
>>>> +   ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
>
> Yes, this is the modification that I'm requesting.
>
>
>> I can see what you said above makes sense but if its
>>> Initial state:
>>> pd->level[0] != 0
>>
>> Was that what you meant?
>
> Yes.

Apologize for jumping into the discussion.

I have a couple of ideas, that may simplify/improve things related to the above.

1) Would it be easier if genpd calls ->set_performance_state(0) before
it is about to call the ->power_off() callback? Actually Viresh wanted
that from the start, but I thought it was useless.

2) When device are becoming runtime suspended, the ->runtime_suspend()
callback of genpd is invoked (genpd_runtime_suspend()). However, in
there we don't care to re-evaluate the votes on the performance level,
but instead rely on the corresponding driver for the device to drop
the vote. I think it would be a good idea of managing this internally
in genpd instead, thus, depending on if the aggregated vote can be
decreased we should call  ->set_performance_state(new-vote). Of
course, once the device get runtime resumed, the votes needs to be
restored for the device.

What do you think?

[...]

Kind regards
Uffe
