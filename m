Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCAEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D6820825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D6820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbeKFEjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:39:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeKFEjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:39:19 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJkNl-0003ig-HI; Mon, 05 Nov 2018 20:17:53 +0100
Date:   Mon, 5 Nov 2018 20:17:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
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
Subject: Re: [Patch v4 03/18] x86/speculation: Reorganize cpu_show_common()
In-Reply-To: <ada2e62c-24bd-4293-17d2-d3e5b9ab6442@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811052016190.1659@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <30b577cf0ceba2ee7612fa7150a86f248b27a08e.1540923609.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811031851010.3160@nanos.tec.linutronix.de>
 <ada2e62c-24bd-4293-17d2-d3e5b9ab6442@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Mon, 5 Nov 2018, Tim Chen wrote:
> On 11/03/2018 11:07 AM, Thomas Gleixner wrote:
> >>  	case X86_BUG_SPECTRE_V2:
> >>  		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> >> -			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> >>  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> >> -			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> >> +			       ibpb_state(), stibp_state(),
> >>  			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
> >>  			       spectre_v2_module_string());
> > 
> > Any particular reason for changing the output ordering here? If yes, then
> > the changelog should mention it. If no, why?
> > 
> I was putting the features related to user application protection together. It
> was not necessary and I can leave it at the same place.

I have no strong opinion either way and changing it should not confuse user
space tools, but please mention it in the changelog if you decide to group it.

Thanks,

	tglx
