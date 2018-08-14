Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F519C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23E120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR7zkarw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23E120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeHNCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:49:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42451 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:49:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so8395402pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g/WEkIgrcndOrdGIppCrlL/szih7TDzyPJh7StmkUlY=;
        b=NR7zkarwAbXiSNfK6ZL8wqJ8Bxfv/qcpskAeRmZp4ODtUCkhAlIB0Te6ocX4E/5lDC
         a0RyFKUhaqaEsi8ZvgwIC7ipcwcRaLmdUjxBJBvEHIfrvNKkzWtfU4JZzqSS8YoMntT6
         7KANf4qUwrzRnkdlCuXG/qrge5JFfFcsL+QXcTLZ4l12/F+PwzPRhpbHjDRIO4RwEoJg
         pJZZ2navJl/8r1X/EPU9q/Y/R9OCcoyKxbYkbp80NogzuFVuD/kt6+bVhs+3sVwbO5Mx
         CULNu6DS18BgrGK49tYWnGnwCr5Qwpn2cOAUIVRDtx7ahzQNQ1Vkwt4d02CAIzqmMt26
         bCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/WEkIgrcndOrdGIppCrlL/szih7TDzyPJh7StmkUlY=;
        b=r9PjNeH22N7hJgLpYqC8vEMNmqy1quVt1wQlpxTceelV99UdPI69msfSd/bG/vrQwg
         C8cfiQPd2yo7GVe6Mr4IlcQ+q4Sakkkff8swMzyXnYx2RUN7qRt4Zd605Y3NOzM9BDPJ
         GGp3+CVHRiiz0YEFa2Yrj62MOBoFf662O+wstCO+zkd644STqsPhDQmcgCjWlkDgR4dJ
         e9ZqBamzyNIGcR8qMWDzMJQ2CqlC/RMZOA8Pj39npAlRNQKF3r7Cbj74x7lcExAP9SGA
         6j6uhxntOmWoEdPLRlm2mOVXLeu2ruxtUZ3EeBxjpgbVJLfCHy8pxzVP9pZKgOV9esMw
         r+PQ==
X-Gm-Message-State: AOUpUlGOqaw0VTAgqySbJoMps5Kn2omSbS65vEjmOIyPSxssHaJcsVUQ
        54xzd48ytE5YoLCWljdvYqElBg==
X-Google-Smtp-Source: AA+uWPx0roAgatQHRRzPAq/EaZpjYaf/gOtkKRnj2aSV7o4wIMKv5r893pgPlxtmT6m23jGJtFg0nQ==
X-Received: by 2002:a63:8341:: with SMTP id h62-v6mr18280638pge.298.1534205109424;
        Mon, 13 Aug 2018 17:05:09 -0700 (PDT)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:fa74:b312:5fef:6cbf])
        by smtp.gmail.com with ESMTPSA id q26-v6sm21542407pff.9.2018.08.13.17.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 17:05:08 -0700 (PDT)
Subject: Re: [RFC] vruntime updated incorrectly when rt_mutex boots prio?
To:     Todd Kjos <tkjos@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     John Dias <joaodias@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Android Kernel Team <kernel-team@android.com>
References: <CA+njcd3z7-jqLvhsBjNWUO9bDrMr_zd13CD2cPdCS0+_kXdc4g@mail.gmail.com>
 <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
 <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <afe2ae95-104f-4b14-c19d-de9bafeef5f2@google.com>
Date:   Mon, 13 Aug 2018 17:05:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 10:40 AM, 'Todd Kjos' via kernel-team wrote:
> This issue was discovered on a 4.9-based android device, but the
> relevant mainline code appears to be the same. The symptom is that
> over time the some workloads become sluggish resulting in missed
> frames or sluggishness. It appears to be the same issue described in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/567836.html.
> 
> Here is the scenario: A task is deactivated while still in the fair
> class. The task is then boosted to RT, so rt_mutex_setprio() is
> called. This changes the task to RT and calls check_class_changed(),
> which eventually calls detach_task_cfs_rq(), which is where
> vruntime_normalized() sees that the task's state is TASK_WAKING, which
> results in skipping the subtraction of the rq's min_vruntime from the
> task's vruntime. Later, when the prio is deboosted and the task is
> moved back to the fair class, the fair rq's min_vruntime is added to
> the task's vruntime, resulting in vruntime inflation.

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

The program:

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
