Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C841920C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C841920C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:16:12 -0400
Received: from foss.arm.com ([217.140.101.70]:35398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1FC080D;
        Mon, 20 Aug 2018 03:01:14 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591183F2EA;
        Mon, 20 Aug 2018 03:01:11 -0700 (PDT)
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
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
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
 <20180817144540.GL2960@e110439-lin>
 <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
Message-ID: <0a26a0de-f9e6-ef77-ceac-eb25bbf01664@arm.com>
Date:   Mon, 20 Aug 2018 12:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 05:50 PM, Dietmar Eggemann wrote:
> On 08/17/2018 04:45 PM, Patrick Bellasi wrote:
>> On 17-Aug 15:43, Dietmar Eggemann wrote:
>>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

>> AFAIK the default hierarcy (cgroups v2) has a much more stricy set of
>> requirements for the "delegation model".
> 
> Could be ... I guess I have to study this more.

So I see that this idea with the .effective files is used in Waiman's 
new cpuset cgroupv2 controller proposal.

The cpu controller with you util clamp extension has to be usable under 
cgroupv2 and cgroupv1, I assume?

[...]
