Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD122C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87D21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfBKSQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:16:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:56729 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfBKSQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:16:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="125617011"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 10:16:35 -0800
Date:   Mon, 11 Feb 2019 10:10:13 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20190211181013.GA103371@romley-ivt3.sc.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
 <20190211105339.GA40840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211105339.GA40840@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:53:39AM +0100, Ingo Molnar wrote:
> > +		do_trap(trapnr, signr, str, regs, error_code, BUS_ADRALN, NULL);
> > +	}
> > +}
> 
> Is there any experience with how frequently this signal is killing 
> user-space processes on a modern distro? Any expectation of how frequent 
> such SIGBUS task terminations are going to be in the field?

We did pretty intensive testing internally (zero day tests, many engineers
and testers use the patches in their dailly work, etc). So far I'm not
aware of any user space process hiting split lock issue. I guess GCC or
other compilers takes care of the issue already. Inline assembly code may
hit the issue if code is not right, but there are fewer inline assembly
code in user space.

So far we only find two kernel split lock issues and fix them in the first
two patches in this patch set. We also find one BIOS split lock issue
internally which has been fixed in production BIOS.

Thanks.

-Fenghua
