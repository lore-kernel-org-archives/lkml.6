Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE5C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EA424BDF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EA424BDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeF2UJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:09:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60499 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeF2UJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:09:19 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYzhU-0006lK-6t; Fri, 29 Jun 2018 22:09:00 +0200
Date:   Fri, 29 Jun 2018 22:08:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
In-Reply-To: <20180629190346.GO18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-3-git-send-email-fenghua.yu@intel.com> <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com> <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com>
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

On Fri, 29 Jun 2018, Fenghua Yu wrote:

> On Fri, Jun 29, 2018 at 06:35:39PM +0200, Thomas Gleixner wrote:
> > On Fri, 29 Jun 2018, Dave Hansen wrote:
> > 
> > Plus what enforces proper alignment for the other capability related
> > u32 arrays? 
> 
> Do you want me to enforce unsigned long alignment for all that are used by
> locked BTS/BTR?

If there are variables which might be unaligned and accessed with locked
instructions and you have them identified, then why are you asking whether
they should be fixed?

Ignoring them because they do not trigger #AC right now, is only the
correct answer if you are a follower of the 'works by chance' cult.

Yeah, I know that most of this industry just works by chance....

> Or you think we can push the patches upstream to allow broad test to find
> and fix the issues?

And all testers have access to the emulator running the design of the
silicon with that new feature which will be released in a year from now?

Aside of that we merge the patches when they are ready and done. And AFAICT
there is enough homework to be finished before that.

Thanks,

	tglx


