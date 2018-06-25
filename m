Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEEAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489526073
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1489526073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964953AbeFYTky (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:40:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934940AbeFYTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:40:53 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXXLs-0005L0-FZ; Mon, 25 Jun 2018 21:40:40 +0200
Date:   Mon, 25 Jun 2018 21:40:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
In-Reply-To: <e006b351-a2d7-e269-4e1f-d5ffa67d25d6@zytor.com>
Message-ID: <alpine.DEB.2.21.1806252140260.1587@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de> <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
 <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de> <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com> <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com> <alpine.DEB.2.21.1806251739450.1821@nanos.tec.linutronix.de>
 <e006b351-a2d7-e269-4e1f-d5ffa67d25d6@zytor.com>
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

On Mon, 25 Jun 2018, H. Peter Anvin wrote:

> On 06/25/18 08:40, Thomas Gleixner wrote:
> > On Fri, 22 Jun 2018, Andy Lutomirski wrote:
> > 
> >> On Fri, Jun 22, 2018 at 11:02 AM Bae, Chang Seok
> >> <chang.seok.bae@intel.com> wrote:
> >>>
> >>>> Still setup_cpu_number() sucks.
> >>>
> >>> How about setup_cpu_and_node_number()?
> >>
> >> setup_fast_cpu_node_nr()?  setup_cpunr_regs()?  I don't have any
> >> brilliant ideas.  Thomas?
> > 
> > It's really hard to find a good one. setup_cpu_node_cache() might work, but
> > it's not brilliant either.
> > 
> 
> Since this applies to the getcpu(2) system call (in addition to the
> kernel usage), perhaps setup_getcpu()?

Works for me.
