Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B96C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449482083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449482083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeIAAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:39:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeIAAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:39:12 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvq3O-0004Nl-Ls; Fri, 31 Aug 2018 22:30:02 +0200
Date:   Fri, 31 Aug 2018 22:30:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Meelis Roos <mroos@linux.ee>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?ISO-8859-7?Q?Re=3A_cmpxchg=2Eh=3A245=3A2=3A_error=3A_=A1asm=A2_?=
 =?ISO-8859-7?Q?operand_has_impossible_constraints?=
In-Reply-To: <alpine.LRH.2.21.1808312308280.6505@math.ut.ee>
Message-ID: <alpine.DEB.2.21.1808312225120.1349@nanos.tec.linutronix.de>
References: <alpine.LRH.2.21.1808262340040.22219@math.ut.ee> <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de> <alpine.LRH.2.21.1808312308280.6505@math.ut.ee>
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

On Fri, 31 Aug 2018, Meelis Roos wrote:
> > > While trying to compile v4.18-13105-gaba16dc5cf93 with gcc 5.3.1 on a 
> > > 32-bit x86 configured for AMD K6:
> > 
> > I tried to get hold of that debian gcc 5.3.1 compiler, but no luck so far.
> 
> 5.3.1-14, seems to be available in 
> http://snapshot.debian.org/package/gcc-5/5.3.1-14/#gcc-5_5.3.1-14 - the 
> whole system is a snapshot of debian unstable when they stoooed 
> supporting pre-686 CPUs.

Uurgh. That's going to be a nightmare to set that one up. Let's try to nail
it on your machine then. Can you try to generate the intermediate file by
invoking: make mm/slub.i ?

Thanks,

	tglx
