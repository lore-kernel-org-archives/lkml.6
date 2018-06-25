Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F725E2B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F725E2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFYQWZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:22:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37047 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbeFYQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:22:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXUFw-0001yR-RA; Mon, 25 Jun 2018 10:22:20 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXUFv-0000Vm-T8; Mon, 25 Jun 2018 10:22:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
        <20180420120605.1612248-2-arnd@arndb.de>
        <20180621154915.GA31947@gmail.com>
        <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
        <20180621161121.GB7222@gmail.com>
        <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
        <20180622021636.GA11266@gmail.com> <87a7rm3eb5.fsf@xmission.com>
        <20180624071258.GB29407@gmail.com> <87y3f31wsv.fsf@xmission.com>
        <20180625091426.GA18351@gmail.com>
Date:   Mon, 25 Jun 2018 11:21:59 -0500
In-Reply-To: <20180625091426.GA18351@gmail.com> (Ingo Molnar's message of
        "Mon, 25 Jun 2018 11:14:26 +0200")
Message-ID: <874lhqzviw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fXUFv-0000Vm-T8;;;mid=<874lhqzviw.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DE+0RRhL3Vnctfqo/Fy/WgIpins+Qfb0=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Ingo Molnar <mingo@kernel.org> writes:
>> 
>> > * Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> >> The trouble with attributes is that means you can't filter your system
>> >> call arguments with seccomp. [...]
>> >
>> > There's nothing keeping seccomp from securely fetching those arguments and 
>> > extending filtering to them as well ...
>> >
>> > Allowing that would make sense for a lot of other system calls as
>> > well.
>> 
>> Possibly.  The challenge is that if the fetch for the kernel to use
>> those arguments is different from the fetch of seccomp to test those
>> arguments you have a time of test vs time of use race.
>
> Those fetched values should obviously then be used to call permitted
> system calls.

Agreed.  To my knowledge no one has figured out how to make that work
yet.  For the most part it has been unnecessary.

>> Given the location of the seccomp hook at the kernel user space border
>> there is no easy way for seccomp to share the fetch with the system
>> call itself.
>> 
>> So I don't see how seccomp could perform the fetch securely.
>
> Looks like more of a seccomp mis-design/mis-implementation than some fundamental 
> problem.

Frankly.  Given that there are some very good solutions in other
operating systems, I think the misdesign is in unix/linux not providing
a good answer to what to do when you need more than 6 arguments to a
system call.

> Mis-designed security features should not hinder system call design.

I certainly agree that seccomp should not be the sole reason for not
doing something.  However there are lots of reasons to avoid
extensibility in general.

Excess extensibility has been the cause of more than one security issue.

Lots of flexibility comes at the price of lots of conditional execution
which tends to explode the test matrix of possibilities to test, with
the result that some combinations are never thought about or tested
because they don't make sense to combine.  Then someone with
mischievious intent see that combination and thinks what happens when I
do this.

Further that conditional execution can frequently be the cause of slow
code as well.

So while there are many nice features of tagged values.  I don't think
they are a general solution.  The lack of seccomp support (today) is
just one downside among many.


I do think it would be nice to have a general pattern for those
system calls that require extensibility.  My gut feel says something
like the L4 pseudo registers (to give a maxium request size)
combined with something like netlink encoding would make a very
nice template for making fast and flexible system calls.

Eric
