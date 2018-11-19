Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8615820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8615820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeKTEzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:55:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:60362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730202AbeKTEzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFCD0AD54;
        Mon, 19 Nov 2018 18:31:08 +0000 (UTC)
Date:   Mon, 19 Nov 2018 19:31:07 +0100 (CET)
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
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <d4b538ba-ce4f-978c-8ccf-cf89187f265a@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811191929160.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811191556350.1537@nanos.tec.linutronix.de>
 <d4b538ba-ce4f-978c-8ccf-cf89187f265a@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Tim Chen wrote:

> >> +DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
> >> +EXPORT_SYMBOL_GPL(spectre_v2_app_lite);
> > 
> > Why would this be exported? The only usage site outside of this code is in
> > tlb.c which is hardly modular.
> 
> That was my initial thought too.  Ingo suggested to export it in
> review of v2.  Wonder Ingo has some reason?
> 
> https://lore.kernel.org/patchwork/patch/991759/

But why does it have to be exported at all, irrespective whether _GPL() or 
not?

Thanks,

-- 
Jiri Kosina
SUSE Labs

