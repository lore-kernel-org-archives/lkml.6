Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F900C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0125D10
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE0125D10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeFYPlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:41:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeFYPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:40:56 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXTbY-0002dk-Nz; Mon, 25 Jun 2018 17:40:36 +0200
Date:   Mon, 25 Jun 2018 17:40:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
In-Reply-To: <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806251739450.1821@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de> <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
 <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de> <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com> <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Andy Lutomirski wrote:

> On Fri, Jun 22, 2018 at 11:02 AM Bae, Chang Seok
> <chang.seok.bae@intel.com> wrote:
> >
> > > Still setup_cpu_number() sucks.
> >
> > How about setup_cpu_and_node_number()?
> 
> setup_fast_cpu_node_nr()?  setup_cpunr_regs()?  I don't have any
> brilliant ideas.  Thomas?

It's really hard to find a good one. setup_cpu_node_cache() might work, but
it's not brilliant either.

Thanks,

	tglx

