Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBFC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1F217CF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F1F217CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeGGLvY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:51:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58780 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753687AbeGGLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:51:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1518017|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.CNS-hP._1530964269;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CNS-hP._1530964269)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sat, 07 Jul 2018 19:51:09 +0800
Date:   Sat, 7 Jul 2018 19:51:09 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 06/19] csky: Cache and TLB routines
Message-ID: <20180707115108.GA3861@guoren-Inspiron-7460>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
 <20180705174025.GD2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705174025.GD2530@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:40:25PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_SMP
> > +#define mb()	asm volatile ("sync.is":::"memory")
> > +#else
> > +#define mb()	asm volatile ("sync":::"memory")
> > +#endif
> 
> This is very suspect, please elaborate.
> 
> What I would've expected is:
> 
> #define mb() asm volatile ("sync" ::: "memory")
> 
> #ifdef CONFIG_SMP
> #define __smp_mb() asm volatile ("sync.is" ::: "memory")
> #endif
> 
> Is that in fact what you meant?
> 
> Do you have a reference to your architecture manual and memory model
> description somewhere?
I'll fixup it in next version patch.

