Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1712889-1526541037-2-5531102819835732372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526541034; b=TxEs1aBRO3ZZHTN2VjhofvyG+JvyOCxyXrvsuXAKjmbqzZ0dbR
    1wZO3hP9ZwMuaL5FIXjxy1EZ9JTPXPe2gE4+NNPyvoG0DwExxkVO3vfEpFxgFwdO
    oQ+VJKyHwz/C6NhhfGdIn7oGqGfBBEX3Az1wr954sVnKsk8FiGgxdOP0WOl1WhWO
    bqNmAjbrFRMGUV9ESkchEItJXSD5jVHFqNJnuMQtnxUdtKSpfKQ8N8fjprm76Y6J
    gR9wd3DfiWx4IK+DDJWZQ8BHSaSBqHx3Vc3uBonzT7WBksKBSiOF7rJiAXRZN4ll
    1Se8E4rseFFcq4joLxObLJA3FY3N0zNrbNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526541034; bh=2aQOOnj7xyGiR9qDP+Q4kjPJ0BY56X6uEFUGjP25AN
    8=; b=h5Ko/nYj+J3yHkwbmIb0MUcjcoCQV+4QsX0mxySa5sy9RNra4S7wEn+E3I
    k+VkhH+HLy8nib/nGZs7TdupAKAcITuZhg7xsC76gsvsZFTHYrSrQ/T40XoZJ5c8
    woWMttKz7lv6Yfoue1k8bH+NScfD4ceAnD/m1ce7WSFwfgBe7pdIBzUpd+Svk9x7
    xQH2SZDk2T23GJwT6+LOpKkrRJjFQzbQcJCXwhwqDmEmn23dRMdfjyl5QmGYT3vW
    IY6ysuMfpkM9uqE9NGDrX9Zlomj70/pqOG7DbTnJWQfMjBffxMiab8VwkzK1no5Q
    2Y7YB2+YHxE1WQdm7a8KYyMFcv4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=Tg1mNG4l x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=DDILT2UK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=Tg1mNG4l x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=DDILT2UK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPVaKGFgbN04iXM1omeyzZtdOvr+QTxdZOLWrEPPG0IcgLrtifQPvESX5p6qa/ownjjhUZLJLwoctY9GKSAHWlNxOdvkML5K0TUFhVDDVBrmhGhaQNgk
    mPkEkpT8DXJThD7NpNpW8waAl/XBLGlSnQ6/9c3shJ6duHEMv0NLd/hIm/14RpQ/VAMVNQEER69BlFVe90rK75fcXCNLRuq5eYp0djiOh5unCNBhyP27BAMb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=dEsD1QRaNPc7zDRxeLoA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQHKb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 03:10:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54330 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQHKa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 03:10:30 -0400
X-Google-Smtp-Source: AB8JxZpwfZxwzPCeJjkHMzjMagVQrW44jnQDzxxo1A7CNRddLHueJEiKYz4maEeLFHQL3Fc28/tnLUP9Mxx9EszpQK8=
MIME-Version: 1.0
In-Reply-To: <20180517040822.t3zkbb2pxla7jnbp@vireshk-i7>
References: <1526494719-23361-1-git-send-email-vincent.guittot@linaro.org> <20180517040822.t3zkbb2pxla7jnbp@vireshk-i7>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 May 2018 09:10:09 +0200
Message-ID: <CAKfTPtCiUd=PCWvoVvfWE2WaQg9RuA6aqU=e+LhsZhuSHq6oLw@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: fix call to cpufreq_update_util
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17 May 2018 at 06:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16-05-18, 20:18, Vincent Guittot wrote:
>> With commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
>> schedutil governor uses rq->rt.rt_nr_running to detect whether a RT task is
>> currently running on the CPU and to set frequency to max if necessary.
>> cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
>> rq->rt.rt_nr_running as not been updated yet when dequeue_top_rt_rq() is
>> called so schedutil still considers that a RT task is running when the
>> last task is dequeued. The update of rq->rt.rt_nr_running happens later
>> in dequeue_rt_stack()
>>
>> Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
>> Cc: <stable@vger.kernel.org> # v4.16+
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/rt.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 7aef6b4..6e74d3d 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1001,8 +1001,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
>>       sub_nr_running(rq, rt_rq->rt_nr_running);
>>       rt_rq->rt_queued = 0;
>>
>
> Remove this blank line as well ?

Yes good point

>
>> -     /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>> -     cpufreq_update_util(rq, 0);
>>  }
>>
>>  static void
>> @@ -1288,6 +1286,9 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>>               if (on_rt_rq(rt_se))
>>                       __dequeue_rt_entity(rt_se, flags);
>>       }
>> +
>> +     /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>> +     cpufreq_update_util(rq_of_rt_rq(rt_rq_of_se(back)), 0);
>>  }
>>
>>  static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
>> --
>> 2.7.4
>
> --
> viresh
