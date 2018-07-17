Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F14ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA2D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KgY9GqI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA2D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGQTXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:23:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38906 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:23:50 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so605856itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXgjsYoGEi0t/icWaJRMbUapyFLjYc7yBQPgK570efI=;
        b=KgY9GqI8SHLYRmxBgYmdCMfJ94SUc9eUH2rv2ZIZ2picUBTcxYiwElXVLFhDUVP9ok
         X886Y4irw915rmRPPW8g+V588PknRnjV2XRo69E6fUfPDASM9qFzq3mlFkK3yJPqd/Ql
         d00UsCPAMecdauOpwf75U0qwRb7dq/tJJlWAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXgjsYoGEi0t/icWaJRMbUapyFLjYc7yBQPgK570efI=;
        b=KKGSxuSvGXyMWFfm+OBjUavve1za0WyItRSyWHdGkZXyHvDaELJdvG6wWGR9JgcA7c
         01YEW7DN8zrFMjRY/5j+5bMiM+Hs/AVH8o6hGiCEr367lVFBMGC64ZZ0yR3DTVAAPb7C
         TGyqkuHnyjZ4vG68RNSxzjBW9OyKW9B0vH7WkBbruwvT2Mgr5Vk3fwo+fFUKA2aOjN19
         lWkUhFXjqw2aEycfl7YxJdpOjRrDauTm+SUnuHk9lfEq7ma/zDKjyr8D+PfJMwTbydkK
         SnX6uExT0rVl9j79/Nmvh805IMSAcqHcwAMMxk/8Fp9dtC4vbcTOjpxuBqQD+WmXCdOu
         sf0w==
X-Gm-Message-State: AOUpUlFqiWid675CoFIy1ZgXW+Y8c3GxUwG556QQzf8NRzX45xg9bbbS
        68YXnAuJzLeKBwUXQDeBMLf1NAh8gJzI3kAj0WE=
X-Google-Smtp-Source: AAOMgpfNS82jNtnp/bxvLNIMNPAQ0fkAVz1HqFeuSqjUL91VabATzHuk+Hyd6iQeeAyIUbBQ7YvpLhDIkK05qdkD7UM=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr2572971itm.113.1531853392872;
 Tue, 17 Jul 2018 11:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au> <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com> <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
In-Reply-To: <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 11:49:41 -0700
Message-ID: <CA+55aFwTN_qZkpi2pLu3vFqSPA43V049j_Ag=NTiKMz1FhYvhg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Jul 17, 2018 at 11:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (a) lwsync is a memory barrier for all the "easy" cases (ie
> load->store, load->load, and store->load).

That last one should have been "store->store", of course.

So 'lwsync' gives smp_rmb(), smp_wmb(), and smp_load_acquire()
semantics (which are the usual "no barrier needed at all" suspects for
things like x86).

What lwsync lacks is store->load ordering. So:

>  (b) lwsync is *not* a memory barrier for the store->load case.

BUT, this is where isync comes in:

>  (c) isync *is* (when in that *sequence*) a memory barrier for a
> store->load case (and has to be: loads inside a spinlocked region MUST
> NOT be done earlier than stores outside of it!).

which is why I think that a spinlock implementation that uses isync
would give us the semantics we want, without the use of the crazy
expensive 'sync' that Michael tested (and which apparently gets
horrible 10% scheduler performance regressions at least on some
powerpc CPU's).

            Linus
