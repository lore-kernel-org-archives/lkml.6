Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9962621582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9962621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeI0VTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:19:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52235 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0VTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:19:34 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5XmR-0005xT-3r; Thu, 27 Sep 2018 17:00:39 +0200
Date:   Thu, 27 Sep 2018 17:00:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
In-Reply-To: <20180927145745.GD3439@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809271659410.8118@nanos.tec.linutronix.de>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com> <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com> <20180807174851.GJ2494@hirez.programming.kicks-ass.net> <20180807183736.GR4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de> <20180807221725.GU4238@tassilo.jf.intel.com> <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de> <20180927142519.GB3439@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809271648210.8118@nanos.tec.linutronix.de>
 <20180927145745.GD3439@hirez.programming.kicks-ass.net>
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

On Thu, 27 Sep 2018, Peter Zijlstra wrote:

> On Thu, Sep 27, 2018 at 04:49:18PM +0200, Thomas Gleixner wrote:
> > > Subject: x86/cpu: Sanitize FAM6_ATOM naming
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Tue, 7 Aug 2018 10:17:27 -0700
> > > 
> > > Going primarily by:
> > > 
> > >   https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors#Silvermont_microarchitecture
> > > 
> > > with additional information gleaned from other related pages; notably:
> > > 
> > >  - Bonnell shrink was called Saltwell
> > >  - Moorefield is the Merriefield refresh which makes it Airmont
> > > 
> > > The general naming scheme is: FAM6_ATOM_UARCH_SOCTYPE
> > > 
> > > Cc: x86@kernel.org
> > > Cc: mingo@redhat.com
> > > Cc: ak@linux.intel.com
> > > Cc: tglx@linutronix.de
> > > Cc: dave.hansen@linux.intel.com
> > > Cc: len.brown@intel.com
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Which way do we route that?
> 
> I have it stuck in with some perf patches, does that work?

Sure. We just should do a quick check against -next for the files outside
the tip realm.

Thanks,

	tglx

