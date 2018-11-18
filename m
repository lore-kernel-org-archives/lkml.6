Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D89C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D92086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3D92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeKSJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:23:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:53298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbeKSJXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:23:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D98AAFAD;
        Sun, 18 Nov 2018 23:01:27 +0000 (UTC)
Date:   Mon, 19 Nov 2018 00:01:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
In-Reply-To: <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1811190000070.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com> <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Jiri Kosina wrote:

> It's probably not just browsers, but anything running JITed sandboxed 
> code. So the most straightforward way might be the prctl() aproach, where 
> userspace would claim "I do care about this, please fix it up for me". So 
> prctl() + perhaps SECCOMP.

I've just sent SECCOMP handling as a followup to Tim's set.

I still feel like we should make STIBP and IBPB behavior consistent (in a 
sense they should always be used both, or none of them), but that might be 
additional 4.21 optimization.

Thanks,

-- 
Jiri Kosina
SUSE Labs

