Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0E2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F0E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDWBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:01:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbeIDWBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:01:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F661AFA0;
        Tue,  4 Sep 2018 17:35:30 +0000 (UTC)
Date:   Tue, 4 Sep 2018 19:35:29 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
In-Reply-To: <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm> <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Tim Chen wrote:

> > Current ptrace_may_access() implementation assumes that the 'source' task is
> > always the caller (current).
> > 
> > Expose ___ptrace_may_access() that can be used to apply the check on arbitrary
> > tasks.
> 
> Casey recently has proposed putting the decision making of whether to
> do IBPB in the security module.
> 
> https://lwn.net/ml/kernel-hardening/20180815235355.14908-4-casey.schaufler@intel.com/
> 
> That will have the advantage of giving the administrator a more flexibility
> of when to turn on IBPB.  The policy is very similar to what you have proposed here
> but I think the security module is a more appropriate place for the security policy.

Yeah, well, honestly, I have a bit hard time buying the "generic 
sidechannel prevention security module" idea, given how completely 
different in nature all the mitigations have been so far. I don't see that 
trying to abstract this somehow provides more clarity.

So if this should be done in LSM, it'd probably have to be written by 
someone else than me :) who actually understands how the "sidechannel LSM" 
idea works.

Thanks,

-- 
Jiri Kosina
SUSE Labs

