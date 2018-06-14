Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2BD91C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Uss1zP9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDDE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755333AbeFNPJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:09:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:47546 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754914AbeFNPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:09:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6E2C322A16D;
        Thu, 14 Jun 2018 11:09:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id IVj6pLreATBP; Thu, 14 Jun 2018 11:09:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EB9E722A162;
        Thu, 14 Jun 2018 11:09:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EB9E722A162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1528988983;
        bh=Qr000X5fF09c5gGkjPUH3kyUl/xYPqvnb48JjkTHZwk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Uss1zP9qUdOdFqiBRi6S03ZP5/RMWiTMpwkM5syNt3k9jDIWa8t9N0FXoD5qK+RSX
         xh+G1TugXPUKzSorYlGHfwUCQz+wLiFvBd+tPGjnOOM83G9KSrdNQaa/Qp5QwMVaUH
         +gf6O4ErJ57srTneOn7KNAibBkipWoflmzgU4Os7EupXia22j3KPf4IMZezwIkO6Av
         BmaeWU++Vpchr9ntxaZm6LqCRCGw4ATDS9n5yh+jLUUoX/pY/mPvYcN8qx/y4CVJbv
         oT8SdM/PP3Ct0VwfUPP/wHvJ6Ouq3k28HwA29xgJAblB1QaZsVIFYqs42+nIZuc5cd
         6veNxBzjyIxag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4F2ydC12DOuI; Thu, 14 Jun 2018 11:09:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D496622A158;
        Thu, 14 Jun 2018 11:09:42 -0400 (EDT)
Date:   Thu, 14 Jun 2018 11:09:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Message-ID: <1898936021.13117.1528988982788.JavaMail.zimbra@efficios.com>
In-Reply-To: <21eae301-50ff-e95a-f3c7-dedcf2f66842@redhat.com>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com> <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com> <20180614132557.GA15201@amd> <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com> <20180614134959.GA4084@amd> <48a0d905-2568-51b8-80c9-a20ecaa25f9b@redhat.com> <263666353.13077.1528986978282.JavaMail.zimbra@efficios.com> <21eae301-50ff-e95a-f3c7-dedcf2f66842@redhat.com>
Subject: Re: Restartable Sequences system call merged into Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: Restartable Sequences system call merged into Linux
Thread-Index: DgCPD0mMBSqpQL39QHF+/AHtQ6/3dw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 14, 2018, at 10:41 AM, Florian Weimer fweimer@redhat.com wrote:

> On 06/14/2018 04:36 PM, Mathieu Desnoyers wrote:
>> ----- On Jun 14, 2018, at 10:00 AM, Florian Weimer fweimer@redhat.com wrote:
>> 
>>> On 06/14/2018 03:49 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME thread
>>>>>>>     flag, so rseq_handle_notify_resume() can check whether it's in a rseq critical
>>>>>>>     section when returning to user-space,
>>>>>>> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() checks
>>>>>>>     whether it's in a rseq critical section,
>>>>>>> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as well,
>>>>>>
>>>>>> Yes, this is not likely to be noticeable.
>>>>>>
>>>>>> But the proposal wanted to add a syscall to thread creation, right?
>>>>>> And I believe that may be noticeable.
>>>>>
>>>>> Fair point! Do we have a standard benchmark that would stress this ?
>>>>
>>>> Web server performance benchmarks basically test clone() performance
>>>> in many cases.
>>>
>>> Isn't that fork?  I expect that the rseq arena is inherited on fork and
>>> fork-type clone, otherwise it's going to be painful.
>> 
>> On fork or clone creating a new process, the rseq tls area is inherited
>> from the thread that does the fork syscall.
>> 
>> On creation of a new thread with clone, there is no such inheritance.
> 
> Makes sense.  So fork-based (web) servers will not be impacted by the
> additional system call, and thread-based servers likely use a thread
> pool anyway.  I'm not really concerned about the additional system call
> here.

Just for the sake of completeness, there is (of course) no inheritance
on exec(). So glibc would also have to register the rseq TLS in its
constructors.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
