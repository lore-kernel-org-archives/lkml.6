Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D7C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E0E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJONtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeJONtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15914AD6B;
        Mon, 15 Oct 2018 06:05:25 +0000 (UTC)
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
 <20181015023328.GP2674@linux.ibm.com>
 <20181015024758.GA227989@joelaf.mtv.corp.google.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
Date:   Mon, 15 Oct 2018 09:05:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015024758.GA227989@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.10.2018 05:47, Joel Fernandes wrote:
> On Sun, Oct 14, 2018 at 07:33:28PM -0700, Paul E. McKenney wrote:
>> On Sun, Oct 14, 2018 at 07:13:49PM -0700, Joel Fernandes wrote:
>>> On Sun, Oct 14, 2018 at 07:08:27PM -0700, Joel Fernandes wrote:
>>>> On Sun, Oct 14, 2018 at 04:17:31PM -0700, Paul E. McKenney wrote:
>>>>> On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
>>>>>> The Requirements.html document says "Disabling Preemption Does Not Block
>>>>>> Grace Periods". However this is no longer true with the RCU
>>>>>> consolidation. Lets remove the obsolete (non-)requirement entirely.
>>>>>>
>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>
>>>>> Good catch, queued, thank you!
>>>>
>>>> Thanks! By the way after I sent the patch, I also tried Oleg's experiment to
>>>> confirm that this is indeed obsolete.  :)
>>>>
>>>> One thing interesting came up when I tried synchronize_rcu_expedited()
>>>> instead of synchronize_rcu() in Oleg's experiment, I still saw a multiple
>>>> millisecond delay between when the rcu read section completely and the
>>>> synchronize_rcu_expedited returns:
>>>>
>>>> For example, with synchronize_rcu_expedited, the 'SPIN done' and the 'SYNC
>>>> done' are about 3 millisecond apart:
>>>> [   77.599142] SPIN start
>>>> [   77.601595] SYNC start
>>>> [   82.604950] SPIN done!
>>>> [   82.607836] SYNC done!
>>>>  I saw anywhere from 2-6 milliseconds.
>>>>
>>>> The reason I bring this up is according to Requirements.html: In some cases,
>>>> the multi-millisecond synchronize_rcu() latencies are unacceptable. In these
>>>> cases, synchronize_rcu_expedited() may be used instead,.. so either I messed
>>>> something up in the experiment, or I need to update this part of the document ;-)
>>
>> In normal testing, 2-6 milliseconds is indeed excessive.  Could you please
>> point me at Oleg's experiment?  Also, what CONFIG_PREEMPT setting were
>> you using?  (My guess is CONFIG_PREEMPT=y.)
> 
> The CONFIG_PREEMPT config I am using is CONFIG_PREEMPT=y.
> 
>>> So I realized I'm running in Qemu so it could also be a scheduling delay of
>>> the vcpu thread. So apologies about the noise if the experiment works fine
>>> for you.
>>
>> I used rcuperf, which might not be doing the same thing as Oleg's
>> experiment.
> 
> The experiment is mentioned at:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg912055.html
> 
> If you apply the below diff, it applies cleanly on rcu/dev. And then run:
> taskset 2 perl -e 'syscall 157, 666, 5000' &
> taskset 1 perl -e 'syscall 157, 777'
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cf5c67533ff1..b654b7566ca3 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2261,6 +2261,9 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  	return -EINVAL;
>  }
>  
> +#include <linux/delay.h>
> +
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2274,6 +2277,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  	error = 0;
>  	switch (option) {
> +	case 666:
> +		preempt_disable();
> +		pr_crit("SPIN start\n");
> +		while (arg2--)
> +			mdelay(1);
> +		pr_crit("SPIN done!\n");
> +		preempt_enable();
> +		break;
> +	case 777:
> +		pr_crit("SYNC start\n");
> +		synchronize_rcu();
> +		pr_crit("SYNC done!\n");

But you are using the console printing infrastructure which is rather
heavyweight. Try replacing pr_* calls with trace_printk so that you
write to the lock-free ring buffer, this will reduce the noise from the
heavy console printing infrastructure.


> +		break;
>  	case PR_SET_PDEATHSIG:
>  		if (!valid_signal(arg2)) {
>  			error = -EINVAL;
> 
