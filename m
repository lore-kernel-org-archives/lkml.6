Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B31B20862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B31B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeKKU3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKKU3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:29:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3D2E308338E;
        Sun, 11 Nov 2018 10:40:53 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9F2E5D736;
        Sun, 11 Nov 2018 10:40:49 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <20181111081725.GA30248@1wt.eu>
        <CAKOZuesi79-4J8bXU2bTY4876DOtL0K4A_Sr=6XsDD8dESPQbw@mail.gmail.com>
Date:   Sun, 11 Nov 2018 11:40:44 +0100
In-Reply-To: <CAKOZuesi79-4J8bXU2bTY4876DOtL0K4A_Sr=6XsDD8dESPQbw@mail.gmail.com>
        (Daniel Colascione's message of "Sun, 11 Nov 2018 00:25:03 -0800")
Message-ID: <87o9avx5g3.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 11 Nov 2018 10:40:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Colascione:

> On Sun, Nov 11, 2018 at 12:17 AM, Willy Tarreau <w@1wt.eu> wrote:
>>
>> On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
>> > [1] https://sourceware.org/
>>
>>
>> Bah, after all, this
>>
>> wipes quite a bit of the shame I feel every time I do something to
>>
>> bypass it :-/
>>
>>
>> The sad thing is that the energy wasted arguing in the bug above could
>>
>> have been better spent designing and implementing a generic solution
>>
>> to expose syscalls without depending on glibc's politics anymore.
>>
>>
>> Willy
>>
>> bugzilla/show_bug.cgi?id=6399 is a
>> >     longstanding example.
>>
>> This one was a sad read and shows that applications will continue to
>> suffer from glibc's prehistorical view on operating systems
>
> Yes. I'm really not sure what glibc's current policies are meant to
> accomplish. They don't serve any useful purpose. There seems to be
> this weird subtext that glibc has leverage to change OS design, and it
> really doesn't. It's a misplaced idealism and ends up just hurting
> everyone.

I'm not sure what this comment tries to accomplish.

glibc tries to serve many masters: Current and past Linux kernel
interfaces, current Hurd kernel interfaces, different versions of POSIX
and C (and even C++), current C/C++ programming practice, historic C
programming practice, current and historic Linux userspace programming,
various platform ABIs, just to name a few.

These requirements are often in conflict.

>> Seeing comments suggesting an application should open
>> /proc/$PID makes me really wonder if people actually want to use slow
>> and insecure applications designed this way.
>
> That's a separate point. Yes, gettid should have a wrapper, but *also*
> we should have an FD-based interface to processes, because outside
> specialized contexts (e.g., parent-child waiting), the traditional
> Unix process API really is impossible to use safely. But that's a
> separate ongoing discussion.

A descriptor-based API would not help glibc that much because there is
an expectation encoded into many C programs that the C library does not
keep permanently open descriptors for its own internal use.

Thanks,
Florian
