Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ECAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939D6206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j/01SRq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939D6206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQUOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:14:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38841 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbeGQUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:14:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so505142wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgN6ZKbAW23bR3AOhVXTv/5v1lbCBLUDDVZIWPOwn5s=;
        b=j/01SRq+AdmleF4dn3pyxT0Q7/Sy6ibXXHeaoSHvA+O0foSqMBI0Piz7nhRQ7efQI0
         Jxe+34klWA5LLSdPjexvhG6pp7eg1leK3KZrwY7LTSoEWolG7z07tIiilWhtYrJor2r7
         1FOgDZcwCGEz4D2YwzPJWdnU9gpnQzkM5B9zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgN6ZKbAW23bR3AOhVXTv/5v1lbCBLUDDVZIWPOwn5s=;
        b=QuiWEzyhgDGDwfRSyr1197KbVw86HrU4B8Od9HnJXP2cw5ymIKTzP3nZcrUuYQlXbT
         oijWqKWeSsCVdo26dgY8gSkw1M0p4D97b8q6FJZjrXg9cY3daPFAGOP/fy5H2JTeMSvC
         8H4MdHPWGAjXYHYwdLqoFfPbEqkoUoghl9gNkKYNoSaivB8osI7kF4XSy4N8Z15452FD
         7b9QTxIVIubXUQqLG670dntWHZ8AoujjzTnCyyyPHuT3wxWYzC9h2v/0DLvZfcbdAkRZ
         UVAAA7gTbmWaANmdncjntXbWHfzo5TNPNP9+AhsMFW1L2i2iIqkblcrKq0YlEtTmy3Ch
         MGoQ==
X-Gm-Message-State: AOUpUlHOKM0DCpPyuHTE3IB8l0ECN9GmN1Paf/dqoVGA09YTravgeTGv
        lyd1TY0/O+66k5Y7jmJSJvveUw==
X-Google-Smtp-Source: AAOMgpeGMiPW1xT0mN9DBA7JF72pIWtYdlFtuWmtbhKYirh31FhUexd4vDW7xIv/tBAsv/qVWU4Vyw==
X-Received: by 2002:a1c:1509:: with SMTP id 9-v6mr2060304wmv.142.1531856416672;
        Tue, 17 Jul 2018 12:40:16 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id u3-v6sm2188277wre.21.2018.07.17.12.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 12:40:11 -0700 (PDT)
Date:   Tue, 17 Jul 2018 21:40:01 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180717194001.GA3781@andrea>
References: <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au>
 <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717183341.GQ12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > That said, I don't understand the powerpc memory ordering. I thought
> > the rules were "isync on lock, lwsync on unlock".
> > 
> > That's what the AIX docs imply, at least.
> > 
> > In particular, I find:
> > 
> >   "isync is not a memory barrier instruction, but the
> > load-compare-conditional branch-isync sequence can provide this
> > ordering property"
> > 
> > so why are you doing "sync/lwsync", when it sounds like "isync/lwsync"
> > (for lock/unlock) is the right thing and would already give memory
> > barrier semantics?
> 
> The PowerPC guys will correct me if I miss something here...

[Same here.]


> 
> The isync provides ordering roughly similar to lwsync, but nowhere near
> as strong as sync, and it is sync that would be needed to cause lock
> acquisition to provide full ordering.

IIRC, ctrl+isync is even *weaker* than lwsync in certain respects, e.g.,
the former doesn't provide A-cumulativity according to the architectural
intent.


>The reason for using lwsync instead
> of isync is that the former proved to be faster on recent hardware.

Interesting; can you add some references about this?

  Andrea


> The reason that the kernel still has the ability to instead generate
> isync instructions is that some older PowerPC hardware does not provide
> the lwsync instruction.  If the hardware does support lwsync, the isync
> instructions are overwritten with lwsync at boot time.
> 
> 							Thanx, Paul
> 
