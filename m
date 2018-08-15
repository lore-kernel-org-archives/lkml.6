Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF2FC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E2921580
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E2921580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeHONvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:51:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbeHONvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:51:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51B8F18A;
        Wed, 15 Aug 2018 03:59:59 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0005E3F5BC;
        Wed, 15 Aug 2018 03:59:55 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
 <20180815105428.GA7388@e110439-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
Date:   Wed, 15 Aug 2018 12:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815105428.GA7388@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 12:54 PM, Patrick Bellasi wrote:
> On 15-Aug 11:37, Dietmar Eggemann wrote:
>> On 08/14/2018 06:49 PM, Patrick Bellasi wrote:
>>> Hi Dietmar!
>>>
>>> On 14-Aug 17:44, Dietmar Eggemann wrote:
>>>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[..]

>> If this is only for testing/debugging, I would suggest a simple one line
>> BUG_ON()
> 
> These are (eventually) considered as recoverable errors... thus,
> AFAIK, using BUG_ON is overkilling and discouraged:
>    https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bug.h#L42

Not sure about that. If this refcounting is out of sync, that's 
indicating a serious issue here for me which should be fixed.

>> You find CONFIG_SCHED_DEBUG=y in production kernels as well.
> 
> AFAIK, that setting is discouraged for production kernels...
> Moreover, it's still better to WARN sometimes on a production kernel
> the crash the device, isnt't it?

IMHO, if this is something which should not happen at all, a BUG_ON() is 
the right thing to do here. And you get the call stack to investigate 
why it hit.


