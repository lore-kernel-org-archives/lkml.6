Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8821523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHNWJFTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C8821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeHYAxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:53:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeHYAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:53:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so4305391pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uuvu11NH8YH24kGqArIE/COOEs5QbC624UmtiN8D7ps=;
        b=gHNWJFTyA+P95G2/Qg9CGDCcB9kTRSWVn2wC1GTkKgxjAe8cSA3waGU/2FqqQY4Xvd
         RWPHw7ldWLHkAopsM61F5MSv54wDZhlWaNJj7VqzNoq2lcKMTgxNbH/IuF25/6eTViCM
         qTZ6yTS7ts2vHEmddUxIxzV6sO1KvraLYFeosHZAcA1InRwclSW1sNJL5pNfcdLpQIEE
         qoGknx8zfrYYiRhY+U2G9xgX+i9oUIdw1n/nk7upaMS3ECecqg0fVU2blaCLRFpd6zCH
         39kfrZUnrLWzvoJ9eAIcOhyjOykUOzpJjmvpKLyz5ejfJQnQqIMu/0bXNdXrmkZN0TAJ
         SfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuvu11NH8YH24kGqArIE/COOEs5QbC624UmtiN8D7ps=;
        b=aqjPQj/7UUx9hyTXXBVFMebLsd43MPdinqMC/C5+0RiOGTbKGBQG00+cl02B0McU92
         EqdR7uq62AdyxRSVebFzsBhczgU5htpNufzzAYCqIBwKLIbc/d8HNr8wx/++wDfoiTJY
         zL1303MoD0OGQFs0dj+bh99FFk/k6tqPDxRNSmGb5RpijiBLom3poOrglhk/8FhBJRw6
         wk3YjhWk5ogquFklKJ3Gi0JQuGrQOYGs/AGK5DI6XCYlSQ7sHcLzRbenNHu+ZCrwxL7g
         N6b2O8s+xT1E5KuIu0T6aPhjvr9oSAhnfFmoKwAGjDiHoZXl3aAFbasEuznndCVFRbPc
         WB3A==
X-Gm-Message-State: APzg51DFsCKL6EVNF458qi0CNcqM1n1u+FZ7D3Ktz7GSrsDbAEbPJk7r
        JiHFBLH9apu7s/leg0QU6srwHQ==
X-Google-Smtp-Source: ANB0VdarTTPiWQLva16XazhXHETfsjuft89dhaZ8MnFMb5oty4lArNRIYRJHx1QQRMs3LROCQ9tLrQ==
X-Received: by 2002:a62:c182:: with SMTP id i124-v6mr3561677pfg.248.1535145451894;
        Fri, 24 Aug 2018 14:17:31 -0700 (PDT)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:fa74:b312:5fef:6cbf])
        by smtp.gmail.com with ESMTPSA id e7-v6sm17747975pgc.55.2018.08.24.14.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 14:17:31 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Juri Lelli <juri.lelli@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
 <20180824065419.GB24860@localhost.localdomain>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <2ddcbabf-d78f-d497-d6d4-8aa6a8947bef@google.com>
Date:   Fri, 24 Aug 2018 14:17:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180824065419.GB24860@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 11:54 PM, Juri Lelli wrote:
>> I tried to catch this issue on my Arm64 Juno board using pi_test (and a
>> slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from
>> rt-tests but wasn't able to do so.
>>
>> # pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs
>>
>> Starting PI Stress Test
>> Number of thread groups: 1
>> Duration of test run: 1 seconds
>> Number of inversions per group: 1
>>       Admin thread SCHED_FIFO priority 4
>> 1 groups of 3 threads will be created
>>        High thread SCHED_FIFO priority 3
>>         Med thread SCHED_FIFO priority 2
>>         Low thread SCHED_OTHER nice 0
>>
>> # ./pip_stress
>>
>> In both cases, the cfs task entering  rt_mutex_setprio() is queued, so
>> dequeue_task_fair()->dequeue_entity(), which subtracts cfs_rq->min_vruntime
>> from se->vruntime, is called on it before it gets the rt prio.
>>
>> Maybe it requires a very specific use of the pthread library to provoke this
>> issue by making sure that the cfs tasks really blocks/sleeps?
> 
> Maybe one could play with rt-app to recreate such specific use case?
> 
> https://github.com/scheduler-tools/rt-app/blob/master/doc/tutorial.txt#L459

This was reproduced for me on tip of mainline by using the program at 
the end of this mail. It was run in a 2 CPU virtualbox VM. Relevant 
annotated bits of the trace:

low-prio thread vruntime is 752ms
   pi-vruntime-tes-598   [001] d...   520.572459: sched_stat_runtime: 
comm=pi-vruntime-tes pid=598 runtime=29953 [ns] vruntime=752888705 [ns]

low-prio thread waits on a_sem
   pi-vruntime-tes-598   [001] d...   520.572465: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=598 prev_prio=120 prev_state=D ==> 
next_comm=swapper/1 next_pid=0 next_prio=120

high prio thread finishes wakeup, then sleeps for 1ms
            <idle>-0     [000] dNh.   520.572483: sched_wakeup: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
            <idle>-0     [000] d...   520.572486: sched_switch: 
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=597 next_prio=19
   pi-vruntime-tes-597   [000] d...   520.572498: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=597 prev_prio=19 prev_state=D ==> 
next_comm=swapper/0 next_pid=0 next_prio=120

high prio thread wakes up after 1ms sleep, posts a_sem which starts to 
wake low-prio thread, then tries to grab pi_mutex, which low-prio thread has
            <idle>-0     [000] d.h.   520.573876: sched_waking: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
            <idle>-0     [000] dNh.   520.573879: sched_wakeup: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
            <idle>-0     [000] d...   520.573887: sched_switch: 
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=597 next_prio=19
   pi-vruntime-tes-597   [000] d...   520.573895: sched_waking: 
comm=pi-vruntime-tes pid=598 prio=120 target_cpu=001

low-prio thread pid 598 gets pi_mutex priority inheritance, this happens 
while low-prio thread is in waking state
   pi-vruntime-tes-597   [000] d...   520.573911: sched_pi_setprio: 
comm=pi-vruntime-tes pid=598 oldprio=120 newprio=19

high-prio thread sleeps on pi_mutex
   pi-vruntime-tes-597   [000] d...   520.573919: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=597 prev_prio=19 prev_state=D ==> 
next_comm=swapper/0 next_pid=0 next_prio=120

low-prio thread finishes wakeup
            <idle>-0     [001] dNh.   520.573932: sched_wakeup: 
comm=pi-vruntime-tes pid=598 prio=19 target_cpu=001
            <idle>-0     [001] d...   520.573936: sched_switch: 
prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=598 next_prio=19

low-prio thread releases pi-mutex, loses pi boost, high-prio thread 
wakes for pi-mutex
   pi-vruntime-tes-598   [001] d...   520.573946: sched_pi_setprio: 
comm=pi-vruntime-tes pid=598 oldprio=19 newprio=120
   pi-vruntime-tes-598   [001] dN..   520.573954: sched_waking: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000

low-prio thread vruntime is 1505ms
   pi-vruntime-tes-598   [001] dN..   520.573966: sched_stat_runtime: 
comm=pi-vruntime-tes pid=598 runtime=20150 [ns] vruntime=1505797560 [ns]

The timing is quite sensitive since the task being boosted has to be 
caught in the TASK_WAKING state. The program:

/*
   * Test case for vruntime management during rtmutex priority inheritance
   * promotion and demotion.
   *
   * build with -lpthread
   */

#define _GNU_SOURCE
#include <pthread.h>
#include <semaphore.h>
#include <sched.h>
#include <stdio.h>
#include <unistd.h>

#define ERROR_CHECK(x) \
          if (x) \
                  fprintf(stderr, "Error at line %d", __LINE__);

pthread_mutex_t pi_mutex;
sem_t a_sem;
sem_t b_sem;

void *rt_thread_func(void *arg) {
          int policy;
          int i = 0;
          cpu_set_t cpuset;

          CPU_ZERO(&cpuset);
          CPU_SET(0, &cpuset);
          ERROR_CHECK(pthread_setaffinity_np(pthread_self(), 
sizeof(cpu_set_t),
                                             &cpuset));

          while(i++ < 100) {
                  sem_wait(&b_sem);
                  usleep(1000);
                  sem_post(&a_sem);
                  pthread_mutex_lock(&pi_mutex);
                  pthread_mutex_unlock(&pi_mutex);
          }
}

void *low_prio_thread_func(void *arg) {
          int i = 0;
          cpu_set_t cpuset;

          CPU_ZERO(&cpuset);
          CPU_SET(1, &cpuset);
          ERROR_CHECK(pthread_setaffinity_np(pthread_self(), 
sizeof(cpu_set_t),
                                             &cpuset));
          while(i++ < 100) {
                  pthread_mutex_lock(&pi_mutex);
                  sem_post(&b_sem);
                  sem_wait(&a_sem);
                  pthread_mutex_unlock(&pi_mutex);
          }
}

int main()
{
          pthread_t rt_thread;
          pthread_t low_prio_thread;
          pthread_attr_t rt_thread_attrs;
          pthread_attr_t low_prio_thread_attrs;
          struct sched_param rt_thread_sched_params;
          struct sched_param low_prio_thread_sched_params;

          pthread_mutexattr_t mutex_attrs;

          sem_init(&a_sem, 0, 0);
          sem_init(&b_sem, 0, 0);

          ERROR_CHECK(pthread_mutexattr_init(&mutex_attrs));
          ERROR_CHECK(pthread_mutexattr_setprotocol(&mutex_attrs,
                                                    PTHREAD_PRIO_INHERIT));
          ERROR_CHECK(pthread_mutex_init(&pi_mutex, &mutex_attrs));

          rt_thread_sched_params.sched_priority = 80;
          low_prio_thread_sched_params.sched_priority = 0;

          pthread_attr_init(&rt_thread_attrs);
          pthread_attr_init(&low_prio_thread_attrs);

          ERROR_CHECK(pthread_attr_setinheritsched(&rt_thread_attrs,
                                                   PTHREAD_EXPLICIT_SCHED));
          ERROR_CHECK(pthread_attr_setinheritsched(&low_prio_thread_attrs,
                                                   PTHREAD_EXPLICIT_SCHED));

          ERROR_CHECK(pthread_attr_setschedpolicy(&rt_thread_attrs,
                                                  SCHED_FIFO));
          ERROR_CHECK(pthread_attr_setschedpolicy(&low_prio_thread_attrs,
                                                  SCHED_OTHER));

          ERROR_CHECK(pthread_attr_setschedparam(&rt_thread_attrs,
                                                 &rt_thread_sched_params));
          ERROR_CHECK(pthread_attr_setschedparam(&low_prio_thread_attrs,
  &low_prio_thread_sched_params));

          ERROR_CHECK(pthread_create(&rt_thread, &rt_thread_attrs,
                                     rt_thread_func, NULL));
          ERROR_CHECK(pthread_create(&low_prio_thread, 
&low_prio_thread_attrs,
                                     low_prio_thread_func, NULL));

          ERROR_CHECK(pthread_join(rt_thread, NULL));
          ERROR_CHECK(pthread_join(low_prio_thread, NULL));

          return 0;
}
