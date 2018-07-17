Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43CEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6352420837
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fw8ut94W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6352420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:18:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35214 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:18:30 -0400
Received: by mail-it0-f65.google.com with SMTP id q20-v6so613486ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nP+IVL6dzBbjNNvLswznm/EY2YD7ehMimouwsjnS3Ps=;
        b=Fw8ut94W814zvGfTq8XHp9NurUhEa4E5L9UAuOjwHUc6FWt3t+/xUIrzJ8cx6g+nhS
         MVIaxviT6lvuwCxswV5+oJdKsUke7s1H03D7BLonTiVC37KZfJig+vjuu6aYFZrNzTAP
         CL67PBGzqYLxVjNZK0AY2aNznHQzfFk3k8Euw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nP+IVL6dzBbjNNvLswznm/EY2YD7ehMimouwsjnS3Ps=;
        b=g8StP56lX9WK/1+0YMINzG7Kh96/RpPjnBqhJUNpslZNsAfDQXpwJtkdeDcC8HdFp3
         OjIl8u2R1OI1uoVyeeaGrnH08B/kIHICXdY+QYVrukyl+vgXSQ2AjBzbWDhw2Asq2XNW
         WnhcRa7fwnCTGezL46xa0dhqkucT9jZlD6sp1Ef+l955BAbGM/ZiQYu4idnH9fnhZfqZ
         ssJq0djeRwQPA1p7cRdNP3oP4iZUNjAiR1pkqg4a6RYwrzp3V2WSOBzqwkltRq0ZUPs1
         NJe2xshf3ksFGt91/i1FNXxyaSPiw2tzjcEfaztRYfS0uDgtmam0yiChj5Hs80lf6qOp
         GijA==
X-Gm-Message-State: AOUpUlGuKWfTddu6p86kgqN2iEsqsUrodXk7j47X6BEppWRHu7b3gUed
        BcXhaJNfVLdb7IjFhZ4bJypNJ0IZyBnhFcDtwE8=
X-Google-Smtp-Source: AAOMgpdUv8iERgLmw1XKFIfwyiPeBHFbeQhd90X6T2ykWdhQMaVZVzharEF/qZzuALsE3LBpQTwXzPMy0xW9HRkZs0k=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr2567866itb.16.1531853074789;
 Tue, 17 Jul 2018 11:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au> <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com>
In-Reply-To: <20180717183341.GQ12945@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 11:44:23 -0700
Message-ID: <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
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

On Tue, Jul 17, 2018 at 11:31 AM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> The isync provides ordering roughly similar to lwsync, but nowhere near
> as strong as sync, and it is sync that would be needed to cause lock
> acquisition to provide full ordering.

That's only true when looking at isync in isolation.

Read the part I quoted. The AIX documentation implies that the
*sequence* of load-compare-conditional branch-isync is a memory
barrier, even if isync on its own is now.

So I'm just saying that

 (a) isync-on-lock is supposed to be much cheaper than sync-on-lock

 (b) the AIX documentation at least implies that isync-on-lock (when
used together the the whole locking sequence) is actually a memory
barrier

Now, admittedly the powerpc barrier instructions are unfathomable
crazy stuff, so who knows. But:

 (a) lwsync is a memory barrier for all the "easy" cases (ie
load->store, load->load, and store->load).

 (b) lwsync is *not* a memory barrier for the store->load case.

 (c) isync *is* (when in that *sequence*) a memory barrier for a
store->load case (and has to be: loads inside a spinlocked region MUST
NOT be done earlier than stores outside of it!).

So a unlock/lock sequence where the unlock is using lwsync, and the
lock is using isync, should in fact be a full memory barrier (which is
the semantics we're looking for).

So doing performance testing on sync/lwsync (for lock/unlock
respectively) seems the wrong thing to do.  Please test the
isync/lwsync case instead.

Hmm? What am I missing?

              Linus
