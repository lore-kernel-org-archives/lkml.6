Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0AC206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfAIEUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:20:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:34319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfAIEUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:20:02 -0500
Received: from homer.simpson.net ([185.191.218.82]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXmpv-1gkXAI3hrD-00WjQE; Wed, 09
 Jan 2019 05:19:49 +0100
Message-ID: <1547007588.17100.17.camel@gmx.de>
Subject: Re: [PATCH 0/1] RFC: sched/fair: skip select_idle_sibling() in
 presence of sync wakeups
From:   Mike Galbraith <efault@gmx.de>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 05:19:48 +0100
In-Reply-To: <20190109034941.28759-1-aarcange@redhat.com>
References: <20190109034941.28759-1-aarcange@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dAGivHZOz0RikDyG6uDqALGgP9m0Nf0x55k23/WgKBKYdXj6/vA
 U8D2PXvZGLf3fk7VFpvPGvb8wzpB/hrzvjZNgWuEWSBu81jCXi9eDgunEbs34WdXtWy449K
 403cWcaH3B9LCsCoy+67MFtM3vVT6BpoF2xbfoCpRbgUKAeANRQZ67XpT2TmmN3mDhIAdYF
 mPra51HNXhQxlu3bSX6oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wP4dotvAZA=:aFGGfzibjfEBtubZ+5fWGa
 R9Gt8wtUGuvNO0m1xNjUV3dsRA1qV4ywId2wG/d7Fc07PqMDuDPyQjHSOEkbkB7piErzEUSLh
 DuehdWkdVS++EAdR5ECsewsmvNjgRXiPDbYA0vC0Jsv/KJIgDdSpC22gV2S1TIxdDTHgipBmW
 Vv6NUUix4Umw66oZaz8tauo1E8c5Q12/Io063Sizj5yKttmps5JYhKzA7kkqpwYTSvVNJChP9
 0I9qSl2EsNQX7QtOY2Figla1U0XMk08xM5PvNUEg0vzH5g6xg9QDQzbLwcmU5zTVHzrADZNSi
 0jzST4aUyxw8yPDVvpj0sme0AUN+MZ03uPgRX701iAAXQlWnPBjadN1JvJ7AVaXL3hXaX4wJk
 NHcDdrwrG4vo2/h5lJ7inHp4vBnBHLwrjHuabv0+hn5QzduwWtw8qMVhkFDmBIk3N//w5WjQl
 4txzcQ6T2rLSR+YuoAROhl0i/S9Y+dqy/I+n1N3fOejhH22t2s1vxqhtTP3VpQPTV0jZOrV+W
 yIMbeDnv5EGpLs5w8HKqBAWHSoXLhGZybxXHxtCdSms6leH5XBYG0s0BQ0jRP0Bawy9NRF/bf
 fUJ7N+egHhNbHHGVmQFZl21DYmpG74tK2xOqmzpUbhawW7z1HTCtntDQZsYiVO/ui8DyFQ17k
 HU80+KaVDqTBbrvLR2m56klu+5937lLDTFRCO+J0sBNWSfgCQQ6AYcw1A2776LWH2VhWYHxAB
 riv45W0mr3lzNuPMx+nUx/t0u9hT49Z5mn0bJ93ouDscZiW5nMwnSNxMyZAkCtamh+LOMw8OZ
 Ld9zkPqvNVygtpuEblVr2J3Ay/ccqFvEE/kRsJrGvFy8AmHuF8ikA7S9Lz47ooRktAKnBiLjl
 0cq/Wb1KevizWveLpbwRTf/XPiWWGzRNxOCkeWP8Lg4xtNTETj8jzTFMNthfy+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 22:49 -0500, Andrea Arcangeli wrote:
> Hello,
> 
> we noticed some unexpected performance regressions in the scheduler by
> switching the guest CPU topology from "-smp 2,sockets=2,cores=1" to
> "-smp 2,sockets=1,cores=2".
> 
> With sockets=2,cores=1 localhost message passing (pipes, AF_UNIX etc..)
> runs serially at 100% CPU load of a single vcpu with optimal
> performance. With sockets=1,cores=2 the load is spread across both
> vcpus and performance is reduced.
> 
> With SCHED_MC=n on older kernels the problem goes away (but that's far
> from ideal for heavily multithreaded workloads which then regress)
> because that basically disables the last part of select_idle_sibling().
> 
> On bare metal with SCHED_MC=y on any recent multicore CPU the
> scheduler (as expected) behaves like sockets=1,cores=2, so it won't
> run the tasks serially.
> 
> The reason is that select_idle_sibling() can disregard the "sync" hint
> and all decisions done up to that point and at the last minute it can
> decide to move the waken task to an arbitrary idle core.
> 
> To test the above theory I implemented this patch which seems to
> confirm the reason the tasks won't run serially anymore with
> sockets=1,cores=2 is select_idle_sibling() overriding the "sync" hint.
> 
> You worked on the wake_affine() before so you may want to review this
> issue, if you agree these sync workloads should run serially even in
> presence of idle cores in the system. I don't know if the current
> behavior is on purpose but if it is, it'd be interesting to know
> why. This is just a RFC.
> 
> To test I used this trivial program.

Which highlights the problem.  That proggy really is synchronous, but
the sync hint is applied to many MANY real world cases where this is
not the case at all.  Sure, you can make things like pipe_test and
nearly nonexistent payload TCP_RR numbers look gorgeous, but that
demolishes concurrency for real applications.

Even when any given wakeup really is a truly synchronous wakeup, does,
say, an application sending a byte down a pipe necessarily mean it's
not going to then execute in parallel with the recipient of that byte? 
I think not.  IMO, the sync hint should die.  The only time it is a win
is for applications that do essentially nothing but context switch.  I
don't think the real world plays a lot of high speed ping pong.

> /*
>  *  pipe-loop.c
>  *
>  *  Copyright (C) 2019 Red Hat, Inc.
>  *
>  *  This work is licensed under the terms of the GNU GPL, version 2.
>  */
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> 
> int main(int argc, char ** argv)
> {
> 	char buf[1];
> 	int n = 1000000;
> 
> 	int pipe1[2], pipe2[2];
> 
> 	pipe(pipe1);
> 	pipe(pipe2);
> 
> 	if (fork()) {
> 		while (n--) {
> 			read(pipe1[0], buf, 1);
> 			write(pipe2[1], buf, 1);
> 		}
> 		wait(NULL);
> 	} else {
> 		while (n--) {
> 			write(pipe1[1], buf, 1);
> 			read(pipe2[0], buf, 1);
> 		}
> 	}
> 
> 	return 0;
> }
> 
> Andrea Arcangeli (1):
>   sched/fair: skip select_idle_sibling() in presence of sync wakeups
> 
>  kernel/sched/fair.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
