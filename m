Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71EE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ALAHt+0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71EE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGQQww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:52:52 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36589 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeGQQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:52:52 -0400
Received: by mail-io0-f194.google.com with SMTP id k4-v6so1485128iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkfMYeCbokiQrbIifildJl2CLfg7aDjQzDmBkjg/4fk=;
        b=ALAHt+0nnMAqbSPoy2g6Vz/qM2UHiRFjUI7UNOorKKK+SvA3ye2WqnjKJyPD870P1X
         T42qjVW+1SGX/wl2xQ0x+2fVOnmOqGiL3CjQT8HCEa/Qs+rFV0z9H5SFivnZH6a2qzHL
         EyAGMM0zylcKqWrpD8/QIAExP3WrR1VXV5oXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkfMYeCbokiQrbIifildJl2CLfg7aDjQzDmBkjg/4fk=;
        b=Qmbp9E9/kjblgDg371hT6iJ9OjCtR2ndMMJtXSz32/YzXmPS51W1XH/XAyxLOZoaoC
         +skW9gJgLHmRQKGemFq+kNR7Rjtc7QFhPkeeI+uRq3FzTa3ZEPDKsOpIWbPF+DF5QwiZ
         vf4YwSjdq9TKxIgNybpFttOmHOrWMLqFnsb3Ft5d+7nAUDf5VSK6dq1LKYdrTRok7ymT
         5JKARPQvbfkdTD1FBJtsXnHflI86oPe09xOPqo7cm9moZgimLzmNRws76lNxHZ71oRfJ
         XA6gQ3wNuuX7y5Je5yMb06N5r9SohwdZnIKKEZgpIbFSa5lQgemIhji+x5QBocLW4cEf
         E/8A==
X-Gm-Message-State: AOUpUlF6JFNfLcFtLjqlXC70608O2TlrU/0LENCAggcwaxN4YDbGTHeU
        RJvzjiuULDtI7P/I9b4M9IbKTcKU1hbsMsMbVLU=
X-Google-Smtp-Source: AAOMgpczg/Dq+JxX7u7sOji76ktTIwbuEF6Uvynyg5q07jJCBvnbyGpet/S8mrUwstoEg01t/Xemt5C9Lw1bdY7U4Io=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr2130951iov.203.1531844367193;
 Tue, 17 Jul 2018 09:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com> <87va9dyl8y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87va9dyl8y.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 09:19:15 -0700
Message-ID: <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 7:45 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>
> Interesting. I don't see anything as high as 18%, it's more spread out:
>
>      7.81%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated

Oh, see that's the difference.

You're running in a non-root cgroup, I think.

That also means that your scheduler overhead has way more spinlocks,
and in particular, you have that

        raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
        ..
        raw_spin_lock_irqsave(cpu_lock, flags);

there too.

So you have at least twice the spinlocks that my case had, and yes,
the costs are way more spread out because your case has all that
cgroup accounting too.

That said, I don't understand the powerpc memory ordering. I thought
the rules were "isync on lock, lwsync on unlock".

That's what the AIX docs imply, at least.

In particular, I find:

  "isync is not a memory barrier instruction, but the
load-compare-conditional branch-isync sequence can provide this
ordering property"

so why are you doing "sync/lwsync", when it sounds like "isync/lwsync"
(for lock/unlock) is the right thing and would already give memory
barrier semantics?

              Linus
