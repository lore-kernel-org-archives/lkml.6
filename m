Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99853C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486132082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOtRA78R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486132082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJKA0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:26:50 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:34943 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKA0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:26:50 -0400
Received: by mail-qk1-f173.google.com with SMTP id v68-v6so3620159qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GT+jtjkO3Ck66GIOcbpKch6SY+5JFNo2Nzv3WS5kN0U=;
        b=DOtRA78RAZtam14SUYrN8c8WEtSS4cevtMhHSK7BDRuuqbScueo/wPvEWmEqk6UScJ
         J3yX56vIk2LK3qJnumuOdeRC/I1hdHeoJrwSofpWCMB3yxWChM1/QRGOhh+/eGATmrCd
         h9tsr9ewKiRYF++8Jtm1d5Pn3QtuIzBSbEo0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GT+jtjkO3Ck66GIOcbpKch6SY+5JFNo2Nzv3WS5kN0U=;
        b=BAO9Gf3ASAUrEm40kK64r0qzHw7xqigfZPz95bRjnqoL5vhIrenqLXtkpXQFr5n3fY
         gKi1mUvveFFt2m5JXV4BpyjLI2G2Fnii2y02K0haC61rwsm1x6Wq3LVHFw+o+ctaXUay
         7asXOv5M3e+fi21JSxx55+oniqtmNyHCHUs+Jyz2fmeGuYnMVzBbbQQGhA1+luum1/VE
         /jL2Dot48tCRn5FqYf9WCLUNYL0MSQYJupeQ/0c56BqAdAIDgrpFu5WVhhL3b++eogZg
         su04a5A0AMIhvrN3OgSQnaN092Us+O1yqPmjQo/8KqvOuln8dVjW5fQOP09QjJQJwc8t
         561Q==
X-Gm-Message-State: ABuFfogMQABSG2WUZpXQDzEhZOe7Mh+ExA6y2IJ+2CIy/yubL4ZjwJ07
        2jnFBT+DfPqdJG3bJI8ayVyxIQ==
X-Google-Smtp-Source: ACcGV60Q69w0jPJm2yaEuPg8o/GZtga8O3uZJWh322qKVxO9OBQDFjgrNSHYXptwXHquJAwIAazqKg==
X-Received: by 2002:ae9:e102:: with SMTP id g2-v6mr2843645qkm.128.1539191026712;
        Wed, 10 Oct 2018 10:03:46 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id t41-v6sm939574qte.95.2018.10.10.10.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 10:03:45 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Quentin Perret <quentin.perret@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5BBE30F0.5080304@linaro.org>
Date:   Wed, 10 Oct 2018 13:03:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010095459.orw2gse75klpwosx@queper01-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Quentin,
On 10/10/2018 05:55 AM, Quentin Perret wrote:
> Hi Vincent,
> 
> On Wednesday 10 Oct 2018 at 10:50:05 (+0200), Vincent Guittot wrote:
>> The problem with reflecting directly the capping is that it happens
>> far more often than the pace at which cpu_capacity_orig is updated in
>> the scheduler.
> 
> Hmm, how can you be so sure ? That most likely depends on the workload,
> the platform and the thermal governor. Some platforms heat up slowly,
> some quickly. The pace at which the thermal governor will change things
> should depend on that I assume.

Yes I agree. How often a thermal event occurs is indeed dependent on
workload, platform and governors. For e.g. hikey960  the same workload
displays different behavior with and without a fan. What we want is a
generic solution that will work across "spiky" events and more spread
out events. An instantaneous update of cpu_capacity most certainly does
not capture spiky events. Also it can lead to cpu_capacity swinging
wildly from the original value to a much lower value and back again.
Averaging of thermal capacity limitation (Across any pre-determined
duration i.e using Pelt signals or without) takes care of smoothening
the effect of thermal capping and making sure that capping events are
not entirely missed.  For me it is a much more elegant solution than an
instantaneous solution.
Having said that, like you mentioned below, when the thermal capping
goes away, it is not reflected as an instantaneous availability of spare
capacity. It is slowly increased. But it is not necessarily wrong
information. All it tells the scheduler is that during the last
"pre-determined" duration on an average "X" was the capacity available
for a CFS task on this cpu.

> 
>> This means that at the moment when scheduler uses the
>> value, it might not be correct anymore.
> 
> And OTOH, when you remove a cap for example, it will take time before
> the scheduler can see the newly available capacity if you need to wait
> for the signal to decay. So you are using a wrong information too in
> that scenario.
> 
>> Then, this value are also used
>> when building the sched_domain and setting max_cpu_capacity which
>> would also implies the rebuilt the sched_domain topology ...
> 
> Wait what ? I thought the thermal cap was reflected in capacity_of, not
> capacity_orig_of ... You need to rebuild the sched_domain in case of
> thermal pressure ?
> 
> Hmm, let me have a closer look at the patches, I must have missed
> something ...
> 
>> The pace of changing the capping is to fast to reflect that in the
>> whole scheduler topology
> 
> That's probably true in some cases, but it'd be cool to have numbers to
> back up that statement, I think.
> 
> Now, if you do need to rebuild the sched domain topology every time you
> update the thermal pressure, I think the PELT HL is _way_ too short for
> that ... You can't rebuild the whole thing every 32ms or so. Or am I
> misunderstanding something ?
> 
>>> Thara, have you tried to experiment with a simpler implementation as
>>> suggested by Ingo ?
>>>
>>> Also, assuming that we do want to average things, do we actually want to
>>> tie the thermal ramp-up time to the PELT half life ? That provides
>>> nice maths properties wrt the other signals, but it's not obvious to me
>>> that this thermal 'constant' should be the same on all platforms. Or
>>> maybe it should ?
>>
>> The main interest of using PELT signal is that thermal pressure will
>> evolve at the same pace as other signals used in the scheduler.
> 
> Right, I think this is a nice property too (assuming that we actually
> want to average things out).
> 
>> With
>> thermal pressure, we have the exact same problem as with RT tasks. The
>> thermal will cap the max frequency which will cap the utilization of
>> the tasks running on the CPU
> 
> Well, the nature of the signal is slightly different IMO. Yes it's
> capacity, but you're no actually measuring time spent on the CPU. All
> other PELT signals are based on time, this thermal thing isn't, so it is
> kinda different in a way. And I'm still wondering if it could be helpful
> to be able to have a different HL for that thermal signal. That would
> 'break' the nice maths properties we have, yes, but is it a problem or is
> it actually helpful to cope with the thermal characteristics of
> different platforms ?


> 
> Thanks,
> Quentin
> 


-- 
Regards
Thara
