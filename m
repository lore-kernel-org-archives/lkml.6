Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3058C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C4208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827C4208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGHBFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 21:05:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44454 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754249AbeGHBFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 21:05:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1072006|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.CNfJfBg_1531011911;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNfJfBg_1531011911)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 08 Jul 2018 09:05:11 +0800
Date:   Sun, 8 Jul 2018 09:05:11 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180708010511.GB18424@guoren-Inspiron-7460>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180706121716.GO2512@hirez.programming.kicks-ass.net>
 <20180707080845.GA346@guoren>
 <20180707201024.GB3225@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707201024.GB3225@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 10:10:24PM +0200, Andrea Parri wrote:
> On Sat, Jul 07, 2018 at 04:08:47PM +0800, Guo Ren wrote:
> > On Fri, Jul 06, 2018 at 02:17:16PM +0200, Peter Zijlstra wrote:
> 
> > 	CPU0			CPU1
> > 
> > 	WRITE_ONCE(x, 1)	WRITE_ONCE(y, 1)
> > 	r0 = xchg(&y, 2)	r1 = xchg(&x, 2)
> > 
> > must not allow: r0==0 && r1==0
> > So we must add a smp_mb between WRITE_ONCE() and xchg(), right?
> 
> The state (r0==0 && r1==0) _must_ not be allowed in the above snippet (so,
> even without the additional smp_mb() between WRITE_ONCE() and xchg()).  In
> informal terms, xchg() provides the smp_mb().
Got it, thx.

> Compare implementations of xchg() and xchg_relaxed().  The following could
> also be helpful (in addition to the references pointed out earlier):
> 
>   Documentation/atomic_t.txt
Thx for the tip.

 Guo Ren
