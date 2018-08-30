Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10DFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595C720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595C720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeH3F4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeH3F4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:56:46 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E1320647;
        Thu, 30 Aug 2018 01:57:02 +0000 (UTC)
Date:   Wed, 29 Aug 2018 21:57:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Message-ID: <20180829215701.5833e815@vmware.local.home>
In-Reply-To: <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
        <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
        <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 16:28:50 -0500
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> On 08/29/2018 09:08 AM, Sebastian Andrzej Siewior wrote:
> > On 2018-08-28 18:28:42 [-0500], Grygorii Strashko wrote:  
> 
> [...]
> 
> >> [    0.912275] [<ffff0000082023cc>] alloc_pages_current+0xcc/0xe0
> >> [    0.912287] [<ffff00000846bb00>] its_allocate_pending_table+0x60/0xa0
> >> [    0.912295] [<ffff00000846e5d8>] its_cpu_init+0x2a0/0x380
> >> [    0.912303] [<ffff00000846b484>] gic_cpu_init.part.6+0x15c/0x170
> >> [    0.912311] [<ffff00000846b4ac>] gic_starting_cpu+0x14/0x20  
> > 
> > This is fixed by
> >    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Make-its_lock-a-raw_spin_lock_t.patch?h=linux-4.18.y-rt-patches  
> [1]
> >    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Move-ITS-pend_page-allocation-int.patch?h=linux-4.18.y-rt-patches  
> [2]
> > 
> > in the v4.18 tree. The first patch was merged upstream. The second will
> > be replaced by the patches Marc Zyngier proposed in
> >    https://lkml.kernel.org/r/3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com
> > 
> > I plan to test + replace those for the next v4.18 release.  
> 
> Thank you. Are there any plans to back port them for 4.14-rt?
> Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.
> 

Next week I plan on looking into the patches that need to be
backported. There's quite a lot of them.

-- Steve
