Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A80ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52772087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GhT+VVgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52772087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGMUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:13:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeGMUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:13:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id m1-v6so13459299wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/Js3KytNOsqi8HibIuYO/2oMnnNCudNRagaMbRTuYQ=;
        b=GhT+VVgbaAiOoTjtSfPs6IOGU86aNx8DgS3RNWSiDdbn9NV+oqf9PYgDtOF+Q07sq6
         I68tu9jv5GNojizhLidVDCcGEOSRD8xZzSmw/eKGnCoqZ1766z6BaV6Zvn9CXX0ojDdf
         UKKonJziT5VEgGa1smTRXK2MeJBQWCA67vxSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/Js3KytNOsqi8HibIuYO/2oMnnNCudNRagaMbRTuYQ=;
        b=Drx7iCZqwoRsAuUJO4qsLOdyoEeNSZ6srV9J91J/6vxRnm4aW+tngdTPY/wPDz4mYv
         0oAjEdGo3/HLajg0Fx7cyVBQdow2tphBA6MkKVe3v2aovutcFEocGEtT82p5ho5QoLdJ
         ajcHZ176nvW3TetTnxaclw4ekC7U/xxr2XU0+f4RdGWKK/C/eIx3enaSnkz113PeSM3T
         mKB78bfj+dIiBvCALiLQGRb+nvUi9khLaQ6kIkZdMGth5NZwrq6nOsmdseyIJVN81V/z
         CCygdnRbXzLI1fRFCQI/j5kxS4w9ZokcrqLOyG4MqGVd/4kzErhSlN/cWOTTlTTU1J3t
         uaaA==
X-Gm-Message-State: AOUpUlEC6xaAbbvYLaJvW6M21R8lWUhB73StSVXO85h24j4vJsg1OPZ4
        7MaPscABMgfKPs3vSHZqc56laQ==
X-Google-Smtp-Source: AAOMgpd156eH6PRFdK61vKVcDWMbeTuVsPHLrDuoGGFPV23RasE3gkQa4gxC5OORZYGFZmWmVsdI8g==
X-Received: by 2002:adf:f6c4:: with SMTP id y4-v6mr6260907wrp.4.1531511819713;
        Fri, 13 Jul 2018 12:56:59 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id w4-v6sm10329687wrt.40.2018.07.13.12.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 12:56:58 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:56:50 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
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
Message-ID: <20180713195650.GA2408@andrea>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 06:42:39PM +0200, Peter Zijlstra wrote:
> 
> Hi Michael,
> 
> On Fri, Jul 13, 2018 at 11:15:26PM +1000, Michael Ellerman wrote:
> > I reran some numbers today with some slightly updated tests.
> > 
> > It varies quite a bit across machines and CPU revisions.
> > 
> > On one I get:
> > 
> > Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
> > lwsync/lwsync   79,290,859,955  100.0 %   290,160,065,087  145     -
> > lwsync/sync    104,903,703,237  132.3 %   383,966,199,430  192     47
> > 
> > Another:
> > 
> > Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
> > lwsync/lwsync  71,662,395,722   100.0 %   252,403,777,715  126     -
> > lwsync/sync    84,932,987,977   118.5 %   299,141,951,285  150     23
> > 
> > 
> > So 18-32% slower, or 23-47 cycles.
> 
> Very good info. Note that another option is to put the SYNC in lock() it
> doesn't really matter which of the two primitives gets it. I don't
> suppose it really matters for timing either way around.
> 
> > Next week I can do some macro benchmarks, to see if it's actually
> > detectable at all.
> > 
> > The other question is how they behave on a heavily loaded system.
> > 
> > 
> > My personal preference would be to switch to sync, we don't want to be
> > the only arch finding (or not finding!) exotic ordering bugs.
> > 
> > But we'd also rather not make our slow locks any slower than they have
> > to be.
> 
> I completely understand, but I'll get you beer (lots) if you do manage
> to make SYNC happen :-) :-)

One trivia about seems due:  it's of course very easy to stick a full
or a "tso" fence in one's spin_lock() implementation, or to tight the
semantics of such a primitive;  removing this fence, or weakening the
semantics is another matter...

(/me reminding about that spin_is_locked() discussion...)

  Andrea
