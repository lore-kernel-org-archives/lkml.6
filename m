Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1030D2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBUS6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:58:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:11454 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUS6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:58:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 10:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,396,1544515200"; 
   d="scan'208";a="148781130"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2019 10:58:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 48D70300F3B; Thu, 21 Feb 2019 10:58:06 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:58:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Parse comma separated list passed in clearcpuid
Message-ID: <20190221185806.GC16922@tassilo.jf.intel.com>
References: <20190221131225.22063-1-prarit@redhat.com>
 <20190221133745.GP32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221133745.GP32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:37:45PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 08:12:25AM -0500, Prarit Bhargava wrote:
> > Users cannot disable multiple CPU features with the kernel parameter
> > clearcpuid=.  For example, "clearcpuid=154 clearcpuid=227" only disables
> > CPUID bit 154.
> > 
> > Previous to commit 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE
> > argument") it was possible to pass multiple clearcpuid options as kernel
> > parameters using individual entries.  With the new code it isn't easy to
> > replicate exactly that behaviour but a comma separated list can be easily
> > implemented, eg) "clearcpuid=154,227"
> > 
> > Make the clearcpuid parse a comma-separated list of values instead of only
> > a single value.
> 
> So I think the feature is broken as is; because it doesn't clear the
> CPUID bits for userspace.

Usually it's enough to make the kernel stop using something. I used it many 
times for this.

People who want to affect user space usually run VMs anyways.

-Andi
