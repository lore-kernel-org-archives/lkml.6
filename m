Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D26C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F4D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F4D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeFSWgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:36:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:5219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbeFSWgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:36:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 15:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="scan'208";a="64631087"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 15:36:40 -0700
Date:   Tue, 19 Jun 2018 15:36:15 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 7/8] x86/lib_user_wait.h: Add APIs for user wait
 instructions
Message-ID: <20180619223615.GB114883@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-8-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191109580.1692@nanos.tec.linutronix.de>
 <20180619222718.GD112652@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806200032430.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806200032430.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:34:32AM +0200, Thomas Gleixner wrote:
> On Tue, 19 Jun 2018, Fenghua Yu wrote:
> > On Tue, Jun 19, 2018 at 11:12:05AM +0200, Thomas Gleixner wrote:
> > > On Fri, 15 Jun 2018, Fenghua Yu wrote:
> > > 
> > > > A few new user wait instructions UMONITOR, UMWAIT, and TPAUSE are
> > > > published in the latest Intel Instruction Set Extensions document.
> > > > 
> > > > Define the APIs for user or kernel to use the instructions.
> > > 
> > > You're not defining APIs. You're adding a pile of misdesigned helper
> > > functions which again add static storage per compilation unit and CPUID
> > > fiddling.
> > > 
> > > If you want to add proper APIs then add the stuff to the VDSO and be done
> > > with it.
> > 
> > The user wait instructions are mainly called by user apps; but they can
> > be used in kernel as well.
> > 
> > I'm planning to provide five APIs to user:
> > 1. If user wait feature is supported
> > 2. nsec to tsc translation
> > 3. umonitor function that exectes UMONITOR instruction
> > 4. umwait function that executes UMWAIT instruction
> > 5. tpause function that executes TPAUSE instruction
> > 
> > Seems 1-2 can be implemented in VDSO. But should I implement 3-5 in
> > VDSO/kernel as well?
> 
> If you want a real API, then yes. If not, then an UAPI header is definitely
> not the place for this.

Sure. I will implement the APIs in VDSO.

Thanks.

-Fenghua
