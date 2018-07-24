Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6BEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B2220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B2220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeGXKEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:04:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbeGXKEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:04:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D117A9;
        Tue, 24 Jul 2018 01:59:24 -0700 (PDT)
Received: from [10.4.12.120] (e107158-lin.Emea.Arm.com [10.4.12.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA1B43F237;
        Tue, 24 Jul 2018 01:59:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     vincent.guittot@linaro.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, valentin.schneider@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
 <dbd8deec-a79d-5697-0c50-ea1a9ab7e5c9@arm.com>
 <20180723152551.GA29978@e105550-lin.cambridge.arm.com>
 <b75f665f-7d60-5d83-eaf6-88c534afe254@arm.com>
 <20180724083710.GB29978@e105550-lin.cambridge.arm.com>
From:   Qais Yousef <qais.yousef@arm.com>
Message-ID: <0d9598fa-28c1-0851-4d40-2cc97a5317b5@arm.com>
Date:   Tue, 24 Jul 2018 09:59:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724083710.GB29978@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 09:37, Morten Rasmussen wrote:
> On Mon, Jul 23, 2018 at 05:07:50PM +0100, Qais Yousef wrote:
>> On 23/07/18 16:27, Morten Rasmussen wrote:
>>> It does increase the cost of things like hotplug slightly and
>>> repartitioning of root_domains a slightly but I don't see how we can
>>> avoid it if we want generic code to set this flag. If the costs are not
>>> acceptable I think the only option is to make the detection architecture
>>> specific.
>> I think hotplug is already expensive and this overhead would be small in
>> comparison. But this could be called when frequency changes if I understood
>> correctly - this is the one I wasn't sure how 'hot' it could be. I wouldn't
>> expect frequency changes at a very high rate because it's relatively
>> expensive too..
> A frequency change shouldn't lead to a flag change or a rebuild of the
> sched_domain hierarhcy. The situations where the hierarchy should be
> rebuild to update the flag is during boot as we only know the amount of
> asymmetry once cpufreq has been initialized, when cpus are hotplugged
> in/out, and when root_domains change due to cpuset reconfiguration. So
> it should be a relatively rare event.


Ah OK I misunderstood that part then.

The series LGTM then.

-- 
Qais Yousef

