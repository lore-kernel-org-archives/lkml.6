Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E0C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492F5278CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492F5278CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937186AbeF2RRa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:17:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:51645 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936159AbeF2RR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:17:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 10:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="68406513"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2018 10:17:22 -0700
Date:   Fri, 29 Jun 2018 10:16:42 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 3/4] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20180629171641.GM18979@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-4-git-send-email-fenghua.yu@intel.com>
 <f528ef21-0e6f-3c76-5fac-bd88279facc0@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D348C9A@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D348C9A@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 09:33:54AM -0700, Luck, Tony wrote:
> >> +	WARN_ONCE(1, "A split lock issue is detected. Please FIX it\n");
> >
> > But, warning here is also not super useful.  Shouldn't we be dumping out
> > the info in 'regs' instead of the current context?  We don't care about
> > the state in the #AC handler, we care about 'regs'.

But WARN dump not only the state in the #AC handler, but also dump the regs
in the current context. And WARN dumps stack.

> 
> Maybe:
> 
> 	WARN_ONCE(1, "split lock detected at %pF\n", regs[EIP]);

Should we dump redundant regs info while WARN shows them all already?

Thanks.

-Fenghua
