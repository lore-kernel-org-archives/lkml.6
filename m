Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A992075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfAIIsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:48:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfAIIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:48:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gh9XS-0000Yw-9W; Wed, 09 Jan 2019 09:48:38 +0100
Date:   Wed, 9 Jan 2019 09:48:38 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Message-ID: <20190109084837.yxj6f2aigdkafgkh@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
 <1546994355.3632.15.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546994355.3632.15.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 18:39:15 [-0600], Scott Wood wrote:
> On Thu, 2018-12-13 at 17:44 +0100, Sebastian Andrzej Siewior wrote:
> > Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
> > warning if __flush_tlb_all() is invoked in preemptible context. On !RT
> > the warning does not trigger because a spin lock is acquired which
> > disables preemption. On RT the spin lock does not disable preemption and
> > so the warning is seen.
> > 
> > Disable preemption to avoid the warning in __flush_tlb_all().
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> FWIW, that __flush_tlb_all() can probably just be removed.  It was added as
> a partial workaround for an erratum, but since it didn't completely solve
> the problem, hugepages were disabled on the affected chips in commit
> 7a0fc404ae66377 ("x86: Disable large pages on CPUs with Atom erratum
> AAE44").  I was going to send a (non-RT) patch removing the flush but in
> 4.20 commit c0a759abf5a68 ("x86/mm/cpa: Move flush_tlb_all()") reworked the
> code to make it moot.

Let me make a note for next major version.

> -Scott

Sebastian
