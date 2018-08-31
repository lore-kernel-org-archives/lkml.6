Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6828C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C25204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C25204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIAAyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:54:17 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:55446 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeIAAyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:54:17 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 677049003F;
        Fri, 31 Aug 2018 23:45:05 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 55E9A220A65; Fri, 31 Aug 2018 23:45:03 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 6C2EF2204BE;
        Fri, 31 Aug 2018 23:45:03 +0300 (EEST)
Date:   Fri, 31 Aug 2018 23:45:03 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?ISO-8859-7?Q?Re=3A_cmpxchg=2Eh=3A245=3A2=3A_error=3A_=A1asm=A2_?=
 =?ISO-8859-7?Q?operand_has_impossible_constraints?=
In-Reply-To: <alpine.DEB.2.21.1808312240430.1349@nanos.tec.linutronix.de>
Message-ID: <alpine.LRH.2.21.1808312344390.6505@math.ut.ee>
References: <alpine.LRH.2.21.1808262340040.22219@math.ut.ee> <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de> <alpine.LRH.2.21.1808312308280.6505@math.ut.ee> <alpine.DEB.2.21.1808312225120.1349@nanos.tec.linutronix.de> <alpine.LRH.2.21.1808312335560.6505@math.ut.ee>
 <alpine.DEB.2.21.1808312240430.1349@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 5.3.1-14, seems to be available in 
> > > > http://snapshot.debian.org/package/gcc-5/5.3.1-14/#gcc-5_5.3.1-14 - the 
> > > > whole system is a snapshot of debian unstable when they stoooed 
> > > > supporting pre-686 CPUs.
> > > 
> > > Uurgh. That's going to be a nightmare to set that one up. Let's try to nail
> > > it on your machine then. Can you try to generate the intermediate file by
> > > invoking: make mm/slub.i ?
> > 
> > Here you are.
> 
> Looks unsuspicious. Is this an entitely new issue on 4.19-rc or can you see
> the same with older kernel versions?

4.18 was fine with sea same toolchain, so this is a new issue.

-- 
Meelis Roos (mroos@linux.ee)
