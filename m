Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643E20854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V/pg7Q1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A643E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeGMRcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:32:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36107 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbeGMRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:32:32 -0400
Received: by mail-it0-f68.google.com with SMTP id j185-v6so12524180ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAQ9MBsPAI0VhRcVIa5IuhT/CgMlRAVlCTHkwU3boDM=;
        b=V/pg7Q1r84qWKDvFb8FBI2l7RWR0NVXtQFZtoUXxbJrXs33aRll28nv+BVuYAEgqQb
         G3VQh0L8axB/PEQTzpz/zSO/sjPbElxhxEZqVyawePT9wIPcTJXSkk427prL0LI5pEpQ
         JwTdEIpmLY25zvnUSipviPJzWd6rpOAh4SMAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAQ9MBsPAI0VhRcVIa5IuhT/CgMlRAVlCTHkwU3boDM=;
        b=CajCivQ4zJTPouxeNpD9xcd568wwbwnwndH9MJEyalp7+CfThJYZNnvxTLk7j4vCB8
         ueJqFX9v/KBNr4aga6fOJcws8JOuwTvNGxRmpeeWXcUqLXaGJRjtya8JeoWWDylyxr+D
         khAm2QhjgucoyPN3tYYl2kjwbybdvOwo4BazJL7vH8meSeMjBX5c1jEf+EbGXO1S/9/6
         c+tUpS4qcJabR6/6hFkaz1ZWXhyUWhWcs1vx9OCNLavA/a/9pdpDSbrFV+Sf65CjM90u
         yEAguqUkUgkGBrcajiwmV521DKKzoNIpa42C7Rv0xmHMlqfwY7+0CiZ0mdegpHFs0ljo
         kGeA==
X-Gm-Message-State: AOUpUlFCi/3oKAwRgsf+uNm6ZKJR21s3gZcCJx22JEDaOSdxoV+iN0ZS
        0AMob0e3YRGE3SkQtSXdjI+GihXapUG00l/3iOk=
X-Google-Smtp-Source: AAOMgpcIzh5RKX2dGH8nDHdF6/gcFOjc0edpdhMJ7cM7DRzpfho7FG6oZnkfkLDO8Nz7aRbj1HpQ9lSoxdkDu/e8JfU=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr6057200jas.72.1531502220152;
 Fri, 13 Jul 2018 10:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com> <20180713090637.GA10601@andrea>
 <20180713093524.GC32020@arm.com>
In-Reply-To: <20180713093524.GC32020@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Jul 2018 10:16:48 -0700
Message-ID: <CA+55aFznCVzoc07p2=eP_5NuTKybMm8-_7+gUMNsAoOP70aYtw@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Will Deacon <will.deacon@arm.com>
Cc:     andrea.parri@amarulasolutions.com,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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

On Fri, Jul 13, 2018 at 2:34 AM Will Deacon <will.deacon@arm.com> wrote:
>
> And, since we're stating preferences, I'll reiterate my preference towards:
>
>         * RCsc unlock/lock
>         * RCpc release/acquire

Yes, I think this would be best. We *used* to have pretty heavy-weight
locking rules for various reasons, and we relaxed them for reasons
that weren't perhaps always the right ones.

Locking is pretty heavy-weight in general, and meant to be the "I
don't really have to think about this very much" option. Then not
being serializing enough to confuse people when it allows odd behavior
(on _some_ architectures) does not sound like a great idea.

In contrast, when you do release/acquire or any of the other "I know
what I'm doing" things, I think we want the minimal serialization
implied by the very specialized op.

>         * Not fussed about atomic rmws, but having them closer to RCsc would
>           make it easier to implement and reason about generic locking
>           implementations

I would prefer that rmw's be RCsc by default, but that there are then
"relaxed" versions of it that aren't.

For example, one common case of rmw has nothing to do with any
ordering at all: statistics gathering. It usually has absolutely zero
need for any ordering per se, and all it wants is cache coherence.

Yes, yes, the really crticial stuff we then use percpu counters for
and a lot of clever software, but there's a lot of cases where that
isn't practical or isn't _quite_ important enough.

So "atomic_add()" being RCsc sounds like a nice tight requirement, but
then architectures who can do it cheaper could have
"atomic_add_relaxed()" that has no inherent ordering at all.

But let's see what the powerpc people find about the actual
performance impact of being RCsc on locking. Real numbers for real
loads would be nice.

               Linus
