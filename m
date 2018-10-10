Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E51C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHk/fng5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCD6214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJKAb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:31:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45459 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKAb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:31:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so6492496qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hL0JQCLgTLaHezBUyjZGPAyqliC9AhU+kpQMvux7zSo=;
        b=DHk/fng5T5KJt+PHrXKDYdFdArLJTa/u77xIZ6X16vW+IhiS9b9gX8z8n8d0I/k03A
         cU2D14V98rLfokaWQYos6fAXoOIg3KC3Q9qNugHdAPm/nlxV316jq9zc5a3BZWjj5jU+
         4X1NzjpJZdL+LbiukGM3V2fBRk9XqUb6yMIeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hL0JQCLgTLaHezBUyjZGPAyqliC9AhU+kpQMvux7zSo=;
        b=FVyv57+CBejgqvjv0j2hTGyeL9GeZKhLVroAdgB0Z5TDxvgdNPb/qjb4Ld4YlHAY6n
         DXtSSpsBanV/CBb0MdpUkbQDN/8M15bM3+6Q4jVNEOc5SJ6gWB+cFmPHWs+Rc60cc+G7
         CdkpqlDiNUiKFS1U0E3DUxfHcoT+rYTEuyIfKDZNleLpEgdL+PLaCaP9QJ4Y5JidLHc3
         bpVPtoG+ImtWaQSmQithZS4Oybo/QxH7zyWRqbLOe2N6l2FeKBbZFNGwgYkU9XI7nCYO
         ZZsSF0FG7RBsmMJjH/SunxuNQtIkKHRnrW+a+x/Hb7A6NMR6DPQbOt18Am/zHbJjaGka
         dbrw==
X-Gm-Message-State: ABuFfogORMOKdAE/0V27NLvKNeCLDixoVG/0n7+C9Yzu9Lbg5LgfPMIh
        jGyUW7d41/dBAQvCJ39Fq4n/ug==
X-Google-Smtp-Source: ACcGV62B0rJQi0604UVRqCPvALpkUWCNG25SpPcV1oKnuFX0viJT+U95fi94nuYi/3m97PuwV6EgbQ==
X-Received: by 2002:aed:2ba7:: with SMTP id e36-v6mr29005223qtd.154.1539191305072;
        Wed, 10 Oct 2018 10:08:25 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id b10-v6sm13838211qkj.25.2018.10.10.10.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 10:08:23 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Juri Lelli <juri.lelli@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
 <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
 <20181010133443.GR9130@localhost.localdomain>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <5BBE3206.2010407@linaro.org>
Date:   Wed, 10 Oct 2018 13:08:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181010133443.GR9130@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 09:34 AM, Juri Lelli wrote:
> On 10/10/18 15:08, Vincent Guittot wrote:
>> On Wed, 10 Oct 2018 at 14:50, Juri Lelli <juri.lelli@gmail.com> wrote:
>>>
>>> On 10/10/18 14:34, Vincent Guittot wrote:
>>>> Hi  Juri,
>>>>
>>>> On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
>>>>>
>>>>> On 10/10/18 14:04, Vincent Guittot wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> The problem was the same with RT, the cfs utilization was lower than
>>>>>> reality because RT steals soem cycle to CFS
>>>>>> So schedutil was selecting a lower frequency when cfs was running
>>>>>> whereas the CPU was fully used.
>>>>>> The same can happen with thermal:
>>>>>> cap the max freq because of thermal
>>>>>> the utilization with decrease.
>>>>>> remove the cap
>>>>>> the utilization is still low and you will select a low OPP because you
>>>>>> don't take into account cycle stolen by thermal like with RT
>>>>>
>>>>> What if we scale frequency component considering the capped temporary
>>>>> max?
>>>>
>>>> Do you mean using a kind of scale_thermal_capacity in accumulate_sum
>>>> when computing utilization ?
>>>
>>> Yeah, something like that I guess. So that we account for temporary
>>> "fake" 1024..
>>
>> But the utilization will not be invariant anymore across the system
> 
> Mmm, I guess I might be wrong, but I was thinking we should be able to
> deal with this similarly to what we do with cpus with different max
> capacities. So, another factor?  Because then, how do we handle other
> ways in which max freq can be restricted (e.g. from userspace as Javi
> was also mentioning)?

IMHO, user-space restrictions should be handled separately. It should
probably reflect as an update of capacity_orig and rebuilding of
scheduler structures as such a restriction is meant to stay for a long
duration.

Regards
Thara
> 


-- 
Regards
Thara
