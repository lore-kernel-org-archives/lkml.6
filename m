Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D3420843
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D3420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeIAAKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:10:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIAAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:10:41 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvpbt-0003nS-CL; Fri, 31 Aug 2018 22:01:37 +0200
Date:   Fri, 31 Aug 2018 22:01:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Meelis Roos <mroos@linux.ee>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?ISO-8859-7?Q?Re=3A_cmpxchg=2Eh=3A245=3A2=3A_error=3A_=A1asm=A2_?=
 =?ISO-8859-7?Q?operand_has_impossible_constraints?=
In-Reply-To: <alpine.LRH.2.21.1808262340040.22219@math.ut.ee>
Message-ID: <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de>
References: <alpine.LRH.2.21.1808262340040.22219@math.ut.ee>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1936046785-1535745304=:1349"
Content-ID: <alpine.DEB.2.21.1808312159260.1349@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1936046785-1535745304=:1349
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1808312159261.1349@nanos.tec.linutronix.de>

On Mon, 27 Aug 2018, Meelis Roos wrote:

> While trying to compile v4.18-13105-gaba16dc5cf93 with gcc 5.3.1 on a 
> 32-bit x86 configured for AMD K6:

I tried to get hold of that debian gcc 5.3.1 compiler, but no luck so far.

>   CC      mm/slub.o
> In file included from ./arch/x86/include/asm/atomic.h:8:0,
>                  from ./include/linux/atomic.h:7,
>                  from ./arch/x86/include/asm/thread_info.h:54,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/mm.h:10,
>                  from mm/slub.c:13:
> mm/slub.c: In function ¡__slab_free¢:
> ./arch/x86/include/asm/cmpxchg.h:245:2: error: ¡asm¢ operand has impossible constraints
>   asm volatile(pfx "cmpxchg%c4b %2; sete %0"   \

I so love the informative output of GCC on ASM errors ....

What's even more confusing is that the __cmpxchg_double() macro has not
been changed since Jan, 2012.

Thanks,

	tglx
--8323329-1936046785-1535745304=:1349--
