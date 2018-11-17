Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2854720671
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2854720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKQUJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:09:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:37188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbeKQUJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 15:09:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23059AD14;
        Sat, 17 Nov 2018 09:53:37 +0000 (UTC)
Date:   Sat, 17 Nov 2018 10:53:35 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 12/16] x86/speculation: Create PRCTL interface to
 restrict indirect branch speculation
In-Reply-To: <b9f6c3f8186bb830ad5730d83ca482dffaddcf22.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811171049040.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <b9f6c3f8186bb830ad5730d83ca482dffaddcf22.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Tim Chen wrote:

> Create PRCTL interface to restrict an application's indirect branch
> speculation.  This will protect the application against spectre v2 attack
> from another application.
> 
> Invocations:
> Check indirect branch speculation status with
> - prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, 0, 0, 0);
> 
> Enable indirect branch speculation with
> - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> 
> Disable indirect branch speculation with
> - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
> 
> Force disable indirect branch speculation with
> - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
> 
> See Documentation/userspace-api/spec_ctrl.rst.

I think that the fact that this talks about "indirect branch predictions" 
in general terms, but really controls only the SMT aspect of it (STIBP), 
as quite confusing.

So I believe it should either be renamed, or actually control semantics of 
IBPB as well, no?

Thanks,

-- 
Jiri Kosina
SUSE Labs

