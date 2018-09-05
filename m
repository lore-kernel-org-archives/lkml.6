Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1490C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677AB20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677AB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIEW6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:58:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeIEW6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:58:15 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxcVj-0002Gp-QV; Wed, 05 Sep 2018 20:26:39 +0200
Date:   Wed, 5 Sep 2018 20:26:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
In-Reply-To: <20180905155823.GL27886@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1809052025250.1416@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm> <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com> <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm> <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com> <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm>
 <20180905155823.GL27886@tassilo.jf.intel.com>
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

On Wed, 5 Sep 2018, Andi Kleen wrote:

> > So, after giving it a bit more thought, I still believe "I want spectre V2 
> > protection" vs. "I do not care about spectre V2 on my system 
> > (=nospectre_v2)" are the sane options we should provide; so I'll respin v4 
> > of my patchset, including the ptrace check in switch_mm() (statically 
> > patched out on !IBPB-capable systems), and we can then later see whether 
> > the LSM implementation, once it exists, should be used instead.
> 
> Please if you repost include plenty of performance numbers for multi threaded
> workloads.  It's ridiculous to even discuss this without them.

Either we care about that problem and provide a proper mechanism to protect
systems or we do not. That's not a performance number problem at all.

Thanks,

	tglx
