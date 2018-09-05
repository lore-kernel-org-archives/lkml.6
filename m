Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3963C20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3963C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIERc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:32:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIERc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:32:57 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxXSC-0004C7-PW; Wed, 05 Sep 2018 15:02:40 +0200
Date:   Wed, 5 Sep 2018 15:02:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <rong.a.chen@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [LKP] 3f906ba236 [ 71.192813] WARNING: possible circular locking
 dependency detected
In-Reply-To: <20180905090553.GA6655@shao2-debian>
Message-ID: <alpine.DEB.2.21.1809051459130.1416@nanos.tec.linutronix.de>
References: <20180905090553.GA6655@shao2-debian>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, kernel test robot wrote:

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 3f906ba23689a3f824424c50f3ae937c2c70f676
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Mon Jul 10 15:50:09 2017 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Mon Jul 10 16:32:33 2017 -0700

So it identified a more than one year old commit. Great.

> vm86 returned ENOSYS, marking as inactive. 20044 iterations. [F:14867 S:5032 HI:3700] [ 57.651003] synth uevent: /module/pcmcia_core: unknown uevent action string [ 71.189062] [ 71.191953] ====================================================== [ 71.192813] WARNING: possible circular locking dependency detected [ 71.193664] 4.12.0-10480-g3f906ba #1 Not tainted [ 71.194355] ------------------------------------------------------ [ 71.195211] trinity-c0/1666 is trying to acquire lock: [ 71.195958] (mem_hotplug_lock.rw_sem){.+.+.+}, at: show_slab_objects+0x14b/0x440 [ 71.197284] [ 71.197284] but task is already holding lock:

along with completely unparseable information. What am I supposed to do
with this mail?

Thanks,

	tglx
