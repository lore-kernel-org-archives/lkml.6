Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84844C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C023EB6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420C023EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGFOHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:07:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57816 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753652AbeGFOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:07:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08794352|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CN6tvVZ_1530886019;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CN6tvVZ_1530886019)
          by smtp.aliyun-inc.com(10.147.40.44);
          Fri, 06 Jul 2018 22:06:59 +0800
Date:   Fri, 6 Jul 2018 22:06:59 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706140659.GB25190@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
 <20180706120323.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:03:23PM +0200, Peter Zijlstra wrote:
> > > Test-and-set with MB acting as ACQUIRE, ok.
> > Em ... Ok, I'll try to use test-and-set function instead of it.
> 
> "test-and-set" is just the name of this type of spinlock implementation.
> 
> You _could_ use the linux test_and_set bitop, but those are defined on
> unsigned long and spinlock_t is generally assumed to be of unsigned int
> size.
> 
> Go with the ticket locks as per below.
Ok, I'll learn it.

> > Ok, I'll try to implement ticket lock in next version patch.
> 
> If you need inspiration, look at:
> 
arch/arm/include/asm/spinlock.h
> 
> Or look at the current version of that file and ignore the LSE version.
> 
> Note that unlock is a store half-word (u16), not having seen your arch
> manual yet I don't know if you even have that.
Nice tips, thank you very much.

 Guo Ren

