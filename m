Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66E2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3wwOvpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeJLXN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:13:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34244 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:13:55 -0400
Received: by mail-it1-f196.google.com with SMTP id l127-v6so21721916ith.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z4Ikpf136Bnbq55yv9w3mZmjl+mxMdtKQOPL53E8VuE=;
        b=T3wwOvprOIFq/PyZD7mv0tAD0oQ08UYzFNcGVjCAYd7ZYkuCjcLyQUzPrYQP4tKuyX
         PdYgxXArZzEXKISRAtGQXiv3IMFu0WHswtM2sNKehVnQQf6HBmz97vrgnsfnAcPeGjts
         TMBxq9SEcSjQZcF93dKWnIec+Gyxu7IfwFhNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z4Ikpf136Bnbq55yv9w3mZmjl+mxMdtKQOPL53E8VuE=;
        b=i1o2J/F/b57lj1niPWrpVOL2G3zcCyuzvA+J0HEFCtvhf80cGillzm98bCoZpdD+o4
         yzEySe/7YX7kSmZY3LRKJTYFpoH7UZuop2S15UeyxQCSTFcgqFHSM5Xmt5VTpmy6H7AR
         Cm3FudYeM+3SXdNdsBttcyll6lhYwaBEPtSQdi4GiXYeaD6ylkjTFz5c9ojNCm4ANtB6
         cP27mVaRfLLPcVBmu3+z8tFJ4MfrRA0fy2JnyRIXZ0E1PsgFVyUwX72z1AlzokOjeQyc
         1eJKGWpH4tPFKZquduv08+rLzljIBfvrNWIq/VSTBFIV7uksj7XWU6inPR9AJizmUJ/u
         D9Sw==
X-Gm-Message-State: ABuFfogxsUCx3HeWku8ISR1yCgVas8XHrInnAj3sxtJ0xQIAngzYpaav
        nWFR8Kcd1+Okg5diF39T8TkIe2Kj1o9R6xsm4oU6lQ==
X-Google-Smtp-Source: ACcGV63Ep2S3KbNUsEEzb58VhPL3R4yzKmafHAAM0Bqp+nKhh6bvEtAUOYxzTzEngEOPjk4/sYl0WvPP8QJZewZHHtg=
X-Received: by 2002:a02:8a11:: with SMTP id j17-v6mr5574478jak.131.1539358851623;
 Fri, 12 Oct 2018 08:40:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5f97:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:40:51
 -0700 (PDT)
In-Reply-To: <CAPDyKFpTbSdyqkKUY0HrkOo_YHcRJZ25FrJxVtzPOJ_aHRaE8Q@mail.gmail.com>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <ec154fa205967507c7352a2d0088346aba562ff2.1539341929.git.viresh.kumar@linaro.org>
 <CAPDyKFpTbSdyqkKUY0HrkOo_YHcRJZ25FrJxVtzPOJ_aHRaE8Q@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 12 Oct 2018 21:10:51 +0530
Message-ID: <CAKohpon+ZV5cc14nL56QgK3-8whM9_5MzTR4v6VpjXxhrwEygg@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] PM / Domains: Add genpd_opp_to_performance_state()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 20:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> The OPP core currently stores the performance state in the consumer
>> device's OPP table, but that is going to change going forward and
>> performance state will rather be set directly in the genpd's OPP table.
>>
>> For that we need to get the performance state for genpd's device
>> structure instead of the consumer device's structure. Add a new helper
>> to do that.
>
> I guess what puzzles me a bit here is that we are using a struct
> device, while we actually should be talking about an OPP cookie
> instead, right?

The OPP cookie wouldn't get us to the platform specific conversion
handler, for that we need something from the genpd itself and so its
structure.

> So the "genpd's device structure" here is not the same as the virtual
> devices created by genpd to support multiple PM domains, right? Or is
> it?

You already found that I believe, it is genpd->dev.

>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  8 ++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 4b5714199490..2c82194d2a30 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2508,6 +2508,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>>  }
>>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>>
>> +/**
>> + * genpd_opp_to_performance_state- Gets performance state of the genpd from its OPP node.
>
> Please rename to:
>
> pm_genpd_opp_to_perfromance_state().

Ok.

>> + *
>> + * @genpd_dev: Genpd's device for which the performance-state needs to be found.
>
> Maybe "genpd_dev" is the correct name to use here, as I understand
> it's actually the device representing the genpd. However, in other
> patches in this series you are also using "genpd_dev", while those
> instead corresponds to the virtual created devices by genpd.

Naming is a mess because I tried to follow the names you followed in
your multiple domain support. You used genpd_dev for the virtual device :)

> I would appreciate if we could make that more clear in the code.
>
> Maybe distinguish them as:
>
> genpd_dev
> genpd_virt_dev
> or just:
>
> dev
> virt_dev

Maybe, perhaps we should change domain.c with same naming for the internal
coding handling multiple domains as well ? I will send the patch for
that if you agree.

>> + * @opp: struct dev_pm_opp of the OPP for which we need to find performance
>> + *     state.
>> + *
>> + * Returns performance state encoded in the OPP of the genpd. This calls
>> + * platform specific genpd->opp_to_performance_state() callback to translate
>> + * power domain OPP to performance state.
>> + *
>> + * Returns performance state on success and 0 on failure.
>> + */
>> +unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
>> +                                           struct dev_pm_opp *opp)
>> +{
>> +       struct generic_pm_domain *genpd = NULL, *temp;
>> +       int state;
>> +
>> +       lockdep_assert_held(&gpd_list_lock);
>
> What's this?

Don't we need to protect with a lock while traversing the below list?
Above is just a check to make sure lock is taken.

>> +
>> +       list_for_each_entry(temp, &gpd_list, gpd_list_node) {
>> +               if (&temp->dev == genpd_dev) {
>> +                       genpd = temp;
>> +                       break;
>> +               }
>> +       }
>
> I think we can do better than this.

I really want to :)

> We really don't want to walk the list of genpds while doing this. The
> caller should already know (if not now, we should fix it) that the
> struct device is used to represent a genpd.

Caller knows that genpd_dev here is genpd->dev really. But it doesn't
have pointer of the genpd itself.

> In other words, I am thinking using a container_of() or a finding a
> function pointer through the struct device, in any case, it would be
> better.

I am stupid. Container-of will work just fine I belive.
