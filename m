Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A5215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6A5215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHGX0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:26:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:26:55 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fn9FI-0007Li-No; Tue, 07 Aug 2018 23:10:24 +0200
Date:   Tue, 7 Aug 2018 23:10:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
In-Reply-To: <20180807183736.GR4238@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com> <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com> <20180807174851.GJ2494@hirez.programming.kicks-ass.net> <20180807183736.GR4238@tassilo.jf.intel.com>
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

On Tue, 7 Aug 2018, Andi Kleen wrote:
> On Tue, Aug 07, 2018 at 07:48:51PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 07, 2018 at 10:35:42AM -0700, Dave Hansen wrote:
> > > On 08/07/2018 10:17 AM, kan.liang@linux.intel.com wrote:
> > > > Denverton and Gemini Lake are platform names and should not be used for
> > > > Processor Family stuff. The microarchitecture codename should be used.
> > > 
> > > Why?
> > > 
> > > Denverton is the platform.  "Goldmont" is literally the
> > > microarchitecture, and you are suggesting moving *to* the
> > > microarchitecture name, which contradicts the description.
> > 
> > All the other (big core) are uarch names. Atom is weird in that it mixes
> > uarch with platform names.
> 
> On most big core the platform/SOC just happens to have the same name as the 
> uarch. But the identifiers really have to be per SOC because that 
> is how Intel model numbers work.
> 
> It should be always the SOC.

Which simply does not work. Look at Goldmont Fam 6 Model 5C. The SoCs
with that Fam/Model combination are:

 - Apollo Lake
 - Broxton (has two platforms: Morganfield and Willowtrail)

It's even worse with Silvermont.

So no, the interesting information is the UARCH and the variant of that,
e.g. UARCH_CLIENT, UARCH_SERVER, UARCH_WHATEVER. All the magic Code Names
and their platform variants are not interesting at all for the Fam/Model
information.

Thanks,

	tglx




