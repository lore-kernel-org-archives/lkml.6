Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE6C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651B0208B0
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651B0208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeGHAkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 20:40:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45467 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754249AbeGHAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 20:40:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1040389|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.CNeo8kl_1531010368;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNeo8kl_1531010368)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 08 Jul 2018 08:39:29 +0800
Date:   Sun, 8 Jul 2018 08:39:28 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org,
        green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180708003927.GA18424@guoren-Inspiron-7460>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
 <20180707074209.GA32147@guoren>
 <20180707195437.GA3225@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707195437.GA3225@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 09:54:37PM +0200, Andrea Parri wrote:
> Hi Guo,
> 
> On Sat, Jul 07, 2018 at 03:42:10PM +0800, Guo Ren wrote:
> > On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> > > 	CPU0			CPU1
> > > 
> > > 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> > > 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> > > 
> > > must not allow: r1==1 && r2==0
> > CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
> > r2=0?
> 
> The emphasis is on the "must": your implementation __must__ prevent this
> from happening (say, by inserting memory barriers in smp_store_release());
> if your implementation allows the state (r1==1 && r2==0), then the imple-
> mentation is incorrect.
Ok, Got it.

> I'd suggest you have a look at the Linux-kernel memory consistency model
> documentation and the associated tools, starting with:
> 
>   Documentation/memory-barriers.txt
>   tools/memory-model/
Thx for the tips.

> (and please do not hesitate to ask questions about them, if something is
>  unclear).
I'll. Thx again.

 Guo Ren
