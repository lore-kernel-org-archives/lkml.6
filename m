Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDACC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F69D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F69D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJBW1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbeJBW1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:27:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC086AE85;
        Tue,  2 Oct 2018 15:43:17 +0000 (UTC)
Date:   Tue, 2 Oct 2018 17:43:16 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jon Masters <jcm@redhat.com>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/2] x86/speculation: Provide application property based
 STIBP protection
In-Reply-To: <1a501628-a232-a126-166e-814c26243f2d@redhat.com>
Message-ID: <nycvar.YFH.7.76.1810021742540.14430@cbobk.fhfr.pm>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com> <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com> <1a501628-a232-a126-166e-814c26243f2d@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Jon Masters wrote:

> > This patch provides an application property based spectre_v2
> > protection with STIBP against attack from another app from
> > a sibling hyper-thread.  For security sensitive non-dumpable
> > app, STIBP will be turned on before switching to it for Intel
> > processors vulnerable to spectre_v2.
> 
> A general comment. I think in practice this will be similar to the
> speculative store buffer bypass (aka "variant 4") issue in terms of
> opt-in mitigation. Many users won't want to take the performance hit of
> having STIBP by default for peer threads. We should make sure that we
> don't force users into a mitigation but retain an option. Whether it's
> default-on or not can be debated, though I think the vendors lean toward
> having default-off with an opt-in, and customers will probably agree. So
> anyway, I encourage a pragmatic approach similar to that for SSBD.

Which is what Tim's patchset is implementing on top.

Thanks,

-- 
Jiri Kosina
SUSE Labs

