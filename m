Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D15C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1485C2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeKTKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:15:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727583AbeKTKP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:15:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 691C5B037;
        Mon, 19 Nov 2018 23:49:48 +0000 (UTC)
Date:   Tue, 20 Nov 2018 00:49:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <591a5109-ffef-b17f-38e3-12082d229451@intel.com>
Message-ID: <nycvar.YFH.7.76.1811200048480.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811192133240.1669@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811192153470.21108@cbobk.fhfr.pm>
 <49d27ed3-dc44-042c-4941-31dedb2a56d2@linux.intel.com> <alpine.DEB.2.21.1811192353170.1669@nanos.tec.linutronix.de> <591a5109-ffef-b17f-38e3-12082d229451@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Dave Hansen wrote:

> > What? IBPB makes tons of sense even without STIBP.
> 
> I'm lost. :)
> 
> I don't think anyone is talking about using STIBP *everywhere* that IBPB
> is in-use.
> 
> We're just guessing that, if anybody is paranoid enough to ask for IBPB,
> *and* they have SMT, they almost certainly want STIBP too.

I think you are not lost :) and this is exactly what makes sense, and what 
Tim's patchset implements.

-- 
Jiri Kosina
SUSE Labs

