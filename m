Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4116345-1522437756-2-14407076760006619240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522437755; b=td/QhNDOAd8vYRuO+pI/jEIrGaMPuVARoTIAIkenJ0SpWl3HO7
    MbJFLAuvTBsGxA8dAV5b4hRsrrUKkifkS705xHDVIw23goy2/h61XGCCDrIcnWAC
    WtldXvCxlMrtQrvmNmokOVblrzcnZ9g0Gib1kbYLT8QWvD+LjySdmIxGYRnlZxUv
    T5Kwe2DjP/qyV6vThdLizEsmgmlAq0yyyrnsW10iJaNrUCs0zyD2XB+ooE9EPoJc
    weakIFWWQMhaXbCq/sZy2yRkL7Q1Uzn5HwIdSD/2T/yH57JBD5ET/UZhsc5j0NPR
    1Ca96wOTh6UzQ8ftjtezpdTbpNWSnNa4GYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522437755; bh=dqs096d2cnXUdVF8epT6SxXJ0mo2uz
    Cy0uqy1sXD8es=; b=loezUHZnv//bnPeVq9nY8FzBPBmx8VGTIOB7AelUixkZIO
    4JhVGJQRLNxmJwZrCZld3wo4lyIn+DW3axJoSKWAx29uGShVWn5dGM0ZaMNeAt6t
    wLycb8nT4qFlk0Ybql4U9OHi/+LvcQDVHp9l1/jTWtpgJddwUUEO+dbMWDTF8cvz
    RAICu2Wc0YPFpt5NvowRro6Th0Bt9e4t57RbluKfyZNjk37DnUGElYTX4Qf9iITw
    Bsmi8aOK/epyVbKLPDKWMnP328dZ7SUjf1xjCPRYhFsY+/vrSwDfZOzytQCsmuri
    TSnCdNnVUTTdo/mBA3jRqWRvEMhiwZHlT5eFCr0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCIWBZ7e4JXM1kwo0/WgPzXP5kWM5TUoqEQSdEeY+GgrWa/rp5PVRKQNKws9Hwh/M/9n1RRL7JketRG7Pm5DcEUGm+SuCKgu/tVfvEYIpO6gxqXFRV/s
    mtWyXW5FG807n6vrubp++aGpEkvZCyWOPtRAInFR+3ZemOYPwQyzSs/TDm4KOLY1T7OAVr0YCCvRDdASLXpzEAWyb42aEjgMhg2kTSBK+q6QF3K4//EKCHpc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPcR4RIuqRN3P2qpgJ4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeC3TWV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 15:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeC3TWU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Mar 2018 15:22:20 -0400
Date: Fri, 30 Mar 2018 12:09:51 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        manfred@colorfullife.com
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Subject: Re: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...)
 between pid namespaces
Message-ID: <20180330190951.nfcdwuzp42bl2lfy@linux-n805>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-11-ebiederm@xmission.com>
 <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Mar 2018, Davidlohr Bueso wrote:

>On Fri, 23 Mar 2018, Eric W. Biederman wrote:
>
>>Today the last process to update a semaphore is remembered and
>>reported in the pid namespace of that process.  If there are processes
>>in any other pid namespace querying that process id with GETPID the
>>result will be unusable nonsense as it does not make any
>>sense in your own pid namespace.
>
>Yeah that sounds pretty wrong.
>
>>
>>Due to ipc_update_pid I don't think you will be able to get System V
>>ipc semaphores into a troublesome cache line ping-pong.  Using struct
>>pids from separate process are not a problem because they do not share
>>a cache line.  Using struct pid from different threads of the same
>>process are unlikely to be a problem as the reference count update
>>can be avoided.
>>
>>Further linux futexes are a much better tool for the job of mutual
>>exclusion between processes than System V semaphores.  So I expect
>>programs that  are performance limited by their interprocess mutual
>>exclusion primitive will be using futexes.
>
>You would be wrong. There are plenty of real workloads out there
>that do not use futexes and are care about performance; in the end
>futexes are only good for the uncontended cases, it can also
>destroy numa boxes if you consider the global hash table. Experience
>as shown me that sysvipc sems are quite still used.
>
>>
>>So while it is possible that enhancing the storage of the last
>>rocess of a System V semaphore from an integer to a struct pid
>>will cause a performance regression because of the effect
>>of frequently updating the pid reference count.  I don't expect
>>that to happen in practice.
>
>How's that? Now thanks to ipc_update_pid() for each semop the user
>passes, perform_atomic_semop() will do two atomic updates for the
>cases where there are multiple processes updating the sem. This is
>not uncommon.
>
>Could you please provide some numbers.

I ran this on a 40-core (no ht) Westmere with two benchmarks. The first
is Manfred's sysvsem lockunlock[1] program which uses _processes_ to,
well, lock and unlock the semaphore. The options are a little
unconventional, to keep the "critical region small" and the lock+unlock
frequency high I added busy_in=busy_out=10. Similarly, to get the
worst case scenario and have everyone update the same semaphore, a single
one is used. Here are the results (pretty low stddev from run to run)
for doing 100,000 lock+unlock.

- 1 proc:
   * vanilla
	total execution time: 0.110638 seconds for 100000 loops
   * dirty
	total execution time: 0.120144 seconds for 100000 loops

- 2 proc:
   * vanilla
	total execution time: 0.379756 seconds for 100000 loops
   * dirty
	total execution time: 0.477778 seconds for 100000 loops

- 4 proc:
   * vanilla
	total execution time: 6.749710 seconds for 100000 loops
   * dirty
	total execution time: 4.651872 seconds for 100000 loops

- 8 proc:
   * vanilla
        total execution time: 5.558404 seconds for 100000 loops
   * dirty
	total execution time: 7.143329 seconds for 100000 loops

- 16 proc:
   * vanilla
	total execution time: 9.016398 seconds for 100000 loops
   * dirty
	total execution time: 9.412055 seconds for 100000 loops

- 32 proc:
   * vanilla
	total execution time: 9.694451 seconds for 100000 loops
   * dirty
	total execution time: 9.990451 seconds for 100000 loops

- 64 proc:
   * vanilla
	total execution time: 9.844984 seconds for 100032 loops
   * dirty
	total execution time: 10.016464 seconds for 100032 loops

Lower task counts show pretty massive performance hits of ~9%, ~25%
and ~30% for single, two and four/eight processes. As more are added
I guess the overhead tends to disappear as for one you have a lot
more locking contention going on.


The second workload I ran this patch on was Chris Mason's sem-scalebench[2]
program which uses _threads_ for the sysvsem option (this benchmark is more
about semaphores as a concept rather than sysvsem specific). Dealing with
a single semaphore and increasing thread counts we get:

sembench-sem
                                            vanill                   dirt
                                           vanilla                  dirty
Hmean     sembench-sem-2      286272.00 (   0.00%)   288232.00 (   0.68%)
Hmean     sembench-sem-8      510966.00 (   0.00%)   494375.00 (  -3.25%)
Hmean     sembench-sem-12     435753.00 (   0.00%)   465328.00 (   6.79%)
Hmean     sembench-sem-21     448144.00 (   0.00%)   462091.00 (   3.11%)
Hmean     sembench-sem-30     479519.00 (   0.00%)   471295.00 (  -1.72%)
Hmean     sembench-sem-48     533270.00 (   0.00%)   542525.00 (   1.74%)
Hmean     sembench-sem-79     510218.00 (   0.00%)   528392.00 (   3.56%)

Unsurprisingly, the thread case shows no overhead -- and yes, even better at
times but still noise). Similarly, when completely abusing the systems and doing
64*NCPUS there is pretty much no difference:

              vanill        dirt
             vanilla       dirty
User         1865.99     1819.75
System      35080.97    35396.34
Elapsed      3602.03     3560.50

So at least for a large box this patch hurts the cases where there is low
to medium cpu usage (no more than ~8 processes on a 40 core box) in a non
trivial way. For more processes it doesn't matter. We can confirm that the
case for threads is irrelevant. While I'm not happy about the 30% regression
I guess we can live with this.

Manfred, any thoughts?

Thanks
Davidlohr

[1] https://github.com/manfred-colorfu/ipcscale/blob/master/sem-lockunlock.c
[2] https://github.com/davidlohr/sembench-ng/blob/master/sembench.c
