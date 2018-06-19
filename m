Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67B3C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A256E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A256E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeFSW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:27:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:32207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbeFSW1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:27:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 15:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="scan'208";a="64629110"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 15:27:44 -0700
Date:   Tue, 19 Jun 2018 15:27:19 -0700
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
Message-ID: <20180619222718.GD112652@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-8-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191109580.1692@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806191109580.1692@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:12:05AM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Fenghua Yu wrote:
> 
> > A few new user wait instructions UMONITOR, UMWAIT, and TPAUSE are
> > published in the latest Intel Instruction Set Extensions document.
> > 
> > Define the APIs for user or kernel to use the instructions.
> 
> You're not defining APIs. You're adding a pile of misdesigned helper
> functions which again add static storage per compilation unit and CPUID
> fiddling.
> 
> If you want to add proper APIs then add the stuff to the VDSO and be done
> with it.

The user wait instructions are mainly called by user apps; but they can
be used in kernel as well.

I'm planning to provide five APIs to user:
1. If user wait feature is supported
2. nsec to tsc translation
3. umonitor function that exectes UMONITOR instruction
4. umwait function that executes UMWAIT instruction
5. tpause function that executes TPAUSE instruction

Seems 1-2 can be implemented in VDSO. But should I implement 3-5 in
VDSO/kernel as well?

Thanks.

-Fenghua
