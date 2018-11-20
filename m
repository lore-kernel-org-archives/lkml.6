Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB3CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B701208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B701208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbeKTK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:26:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeKTK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:26:48 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOtSk-00068x-T2; Tue, 20 Nov 2018 01:00:19 +0100
Date:   Tue, 20 Nov 2018 01:00:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
In-Reply-To: <nycvar.YFH.7.76.1811200021000.21108@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1811200047470.1669@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811192133240.1669@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811192153470.21108@cbobk.fhfr.pm>
 <49d27ed3-dc44-042c-4941-31dedb2a56d2@linux.intel.com> <alpine.DEB.2.21.1811192353170.1669@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811200021000.21108@cbobk.fhfr.pm>
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

On Tue, 20 Nov 2018, Jiri Kosina wrote:

> On Tue, 20 Nov 2018, Thomas Gleixner wrote:
> 
> > What? IBPB makes tons of sense even without STIBP.
> 
> On non-SMT, yes. But this patchset ties those two the other (sensible) way 
> around AFAICS ("STIBP iff (IBPB && SMT)").

Errm. No.

The patches disable IBPB if STIBP is not available and that has absolutely
nothing to do with SMT simply because the static key controlling IBPB is
only flipped on when both IBPB and STIBP are available.

For SMT=off STIBP is pointless, but IBPB still makes a lot of sense.

That's a change which is neither documented nor correct.

Thanks,

	tglx


