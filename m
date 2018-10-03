Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8F6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CD8213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CD8213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJCWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:38:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:38:40 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QS_8ezZQeZ0h; Wed,  3 Oct 2018 17:49:43 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E14C1EC0293;
        Wed,  3 Oct 2018 17:49:43 +0200 (CEST)
Date:   Wed, 3 Oct 2018 17:49:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
Message-ID: <20181003154937.GA22726@zn.tnic>
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
 <20181003154132.GA19272@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003154132.GA19272@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:41:32PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 03, 2018 at 08:10:31AM +0200, Thomas Gleixner wrote:
> > On Tue, 2 Oct 2018, kan.liang@linux.intel.com wrote:
> > 
> > There is another variant of model/stepping micro code verification code in
> > intel_snb_pebs_broken(). Can we please make this table based and use a
> > common function? That's certainly not the last quirk we're going to have.
> > 
> > We already have a table based variant of ucode checking in
> > bad_spectre_microcode(). It's trivial enough to generalize that.
> 
> apic_check_deadline_errata() is another one. That one already uses the
> x86_cpu_id thing, but still plays silly games for steppings. So if we're
> going to build a new microcode table matcher...

intel_snb_pebs_broken() looks like a potential candidate too...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
