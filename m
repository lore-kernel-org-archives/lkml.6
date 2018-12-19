Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeLSPLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:11:46 -0500
Received: from foss.arm.com ([217.140.101.70]:36842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbeLSPLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:11:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4872FEBD;
        Wed, 19 Dec 2018 07:11:45 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 579303F675;
        Wed, 19 Dec 2018 07:11:44 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
 <f2619d92-7367-abd4-97e8-e0f4e7cc96eb@arm.com>
 <CAKfTPtAEi=EBmSUEcYmkfSZVkBviQaJaqZXvt-=XbsgZs5t_OA@mail.gmail.com>
 <4de22c37-fe65-4f5f-929b-320c663ee8b6@arm.com>
 <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
 <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com>
 <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f48118ab-8782-a096-9299-58c6b8d384bb@arm.com>
Date:   Wed, 19 Dec 2018 15:11:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCVqSYOC_GUdBm8_5KNMNEwXdf77mXL4SDB4_G5_iE0iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 15:05, Vincent Guittot wrote:
[...]
>> True, I had a look at the trace and there doesn't seem to be any running
>> task on that CPU. That's a separate matter however - the rounding issues
>> can happen regardless of the wl values.
> 
> But it means that the rounding fix +1 works and your problems comes
> from something else

Oh yes, I never said it didn't work - I was doing some investigation on
the reason as to why we'd need this fix, because it's wasn't explicit from
the commit message.

The rounding errors are countered by the +1, yes, but I'd rather remove
the errors altogether and go for the snippet I suggested in my previous
reply.
