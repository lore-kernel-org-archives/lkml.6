Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994720874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeLSO7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:59:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeLSO7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:59:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C3DEBD;
        Wed, 19 Dec 2018 06:59:41 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCEFB3F675;
        Wed, 19 Dec 2018 06:59:40 -0800 (PST)
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8ea1a96c-c2e0-cc3f-1cec-444706383e77@arm.com>
Date:   Wed, 19 Dec 2018 14:59:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAprHq4YYdJ1gnuoAcNiVFpFPnxYv_=RS6pXs8aYpjcuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2018 13:39, Vincent Guittot wrote:
[...]
>> I used that setup out of convenience for myself, but AFAICT that use-case
>> just stresses that issue.
> 
> After looking at you UC in details, your problem comes from the wl=1
> for cpu0 whereas there is no running task.
> But wl!=0 without running task should not be possible since fdf5f3
> ("wsched/fair: Disable LB_BIAS by default")
> 
> This explain the 1023 instead of 1022
> 
>

True, I had a look at the trace and there doesn't seem to be any running
task on that CPU. That's a separate matter however - the rounding issues
can happen regardless of the wl values.
