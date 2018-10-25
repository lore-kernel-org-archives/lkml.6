Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC11FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B769D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeJZE4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:56:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53261 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJZE4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:56:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFm8s-0006sJ-6z; Thu, 25 Oct 2018 14:22:06 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFm8c-00036L-0y; Thu, 25 Oct 2018 14:22:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     enkechen@cisco.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
        <87sh0vpj5q.fsf@xmission.com>
        <CAG48ez2aJD1wcz3UjhaQvgqhg5UMeQ_-iMZesA=SfhYwUdGGyA@mail.gmail.com>
Date:   Thu, 25 Oct 2018 15:21:23 -0500
In-Reply-To: <CAG48ez2aJD1wcz3UjhaQvgqhg5UMeQ_-iMZesA=SfhYwUdGGyA@mail.gmail.com>
        (Jann Horn's message of "Thu, 25 Oct 2018 15:45:29 +0200")
Message-ID: <87va5plqv0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gFm8c-00036L-0y;;;mid=<87va5plqv0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1989OtyFJm3sh1Atk25SEcrrjFL2OItj6g=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Wed, Oct 24, 2018 at 3:30 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Enke Chen <enkechen@cisco.com> writes:
>> > For simplicity and consistency, this patch provides an implementation
>> > for signal-based fault notification prior to the coredump of a child
>> > process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> > be used by an application to express its interest and to specify the
>> > signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> > signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>> >
>> > Changes to prctl(2):
>> >
>> >    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>> >           Set the child pre-coredump signal of the calling process to
>> >           arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
>> >           This is the signal that the calling process will get prior to
>> >           the coredump of a child process. This value is cleared across
>> >           execve(2), or for the child of a fork(2).
>> >
>> >           When SIGCHLD is specified, the signal code will be set to
>> >           CLD_PREDUMP in such an SIGCHLD signal.
> [...]
>> Ugh.  Your test case is even using signalfd.  So you don't even want
>> this signal to be delivered as a signal.
>
> Just to make sure everyone's on the same page: You're suggesting that
> it might make sense to deliver the pre-dump notification via a new
> type of file instead (along the lines of signalfd, timerfd, eventfd
> and so on)?

My real complaint was that the API was not being tested in the way it
is expected to be used.  Which makes a test pretty much useless as some
aspect userspace could regress and the test would not notice because it
is testing something different.



I do think that a file descriptor based API might be a good alternative
to a signal based API.  The proc connector and signals are not the only
API solution.

The common solution to this problem is that distributions defailt the
rlimit core file size to 0.

Eric
