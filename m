Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96242217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfBRRXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbfBRRXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:23:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845C3217D9;
        Mon, 18 Feb 2019 17:23:23 +0000 (UTC)
Date:   Mon, 18 Feb 2019 12:23:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace: skip hwasan
Message-ID: <20190218122322.5219d3cb@gandalf.local.home>
In-Reply-To: <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
References: <20190217043434.46233-1-cai@lca.pw>
        <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
        <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
        <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 16:56:44 +0100
Andrey Konovalov <andreyknvl@google.com> wrote:

> On Mon, Feb 18, 2019 at 4:53 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> > On 2/18/19 10:25 AM, Andrey Konovalov wrote:  
> > > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:  
> > >>
> > >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> > >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> > >> because there is a burst of too much pointer access, and then KASAN will
> > >> dereference each byte of the shadow address for the tag checking which
> > >> will kill all the CPUs.  
> > >
> > > Hi Qian,
> > >
> > > Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> > > mm/kasan/Makefile helps with that?  
> >
> > Yes, you nailed it!  
> 
> Great! I'll send the patch.

OK, then I'll ignore the original patch in this thread.

-- Steve
