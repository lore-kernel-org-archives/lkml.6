Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF4224832
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF4224832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeGBOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:12:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:8235 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbeGBOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:12:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 07:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,299,1526367600"; 
   d="scan'208";a="53476955"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 02 Jul 2018 07:12:13 -0700
Date:   Mon, 2 Jul 2018 07:11:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
Message-ID: <20180702141128.GA91188@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-3-git-send-email-fenghua.yu@intel.com>
 <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
 <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de>
 <20180629203844.GA68178@romley-ivt3.sc.intel.com>
 <20180702121859.GL2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702121859.GL2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:18:59PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 29, 2018 at 01:38:44PM -0700, Fenghua Yu wrote:
> > include/linux/efi.h because set_bit() sets bits in efi.flags:
> > -       unsigned long flags;
> > +       unsigned long flags __aligned(unsigned long);
> >  } efi;
> 
> Help me out here; how is the above change not a complete no-op?

You are right. Thomas pointed out 'flags' is already naturally aligned to
unsigned long because its type is unsigned long. So the __aligned()
is no-op.

Thanks.

-Fenghua

