Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEDD204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEDD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeKILBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:01:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:63893 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbeKILBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:01:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 17:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="scan'208";a="98797273"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2018 17:22:48 -0800
Date:   Fri, 9 Nov 2018 09:29:29 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>, boyarsh@altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 201637] New: hangup sinse  'x86/mm: Expand static page
 table for fixmap space' with CONFIG_RANDOMIZE_BASE enabled
Message-ID: <20181109012929.a2qgtkjw5fnyrsz4@shbuild888>
References: <bug-201637-27@https.bugzilla.kernel.org/>
 <20181108142052.b8218ee02560864ef9e640b7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108142052.b8218ee02560864ef9e640b7@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Thu, Nov 08, 2018 at 02:20:52PM -0800, Andrew Morton wrote:
> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu, 08 Nov 2018 13:48:25 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=201637
> > 
> >             Bug ID: 201637
> >            Summary: hangup sinse  'x86/mm: Expand static page table for
> >                     fixmap space' with CONFIG_RANDOMIZE_BASE enabled
> >            Product: Memory Management
> >            Version: 2.5
> >     Kernel Version: 4.9.133
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Other
> >           Assignee: akpm@linux-foundation.org
> >           Reporter: boyarsh@altlinux.org
> >         Regression: No
> > 
> > I have early kernel hungup on x86_64 since 4.9.133 and i've finaly bisected it.
> > 
> > This commit is incompatible with CONFIG_RANDOMIZE_BASE enabled and cause
> > immediate silent hangup during boot. 

Thanks for reporting. The patch revert was queued already. see
https://lkml.org/lkml/2018/11/2/453

And you are right, the problem is related with the kernel address randomization,
the original patch in mainline covers it, and the problem happens during my manual
backporting to 4.9, where I didn't fine head64.c and wrongly assumed KASLR was
not in 4.9 :(   sorry for the trouble. 

Thanks,
Feng



