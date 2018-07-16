Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A7BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAE20834
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABAE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeGPUYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:24:04 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54946 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeGPUYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:24:04 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ff9a0-0002XN-00; Mon, 16 Jul 2018 19:54:44 +0000
Date:   Mon, 16 Jul 2018 15:54:44 -0400
From:   Rich Felker <dalias@libc.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alan Cox <alan@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: cpu_no_speculation omissions?
Message-ID: <20180716195444.GN1392@brightrain.aerifal.cx>
References: <20180716160513.GA6080@brightrain.aerifal.cx>
 <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>
 <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com>
 <1531767303.4364.109.camel@linux.intel.com>
 <alpine.DEB.2.21.1807162120181.1693@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807162120181.1693@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:20:58PM +0200, Thomas Gleixner wrote:
> On Mon, 16 Jul 2018, Alan Cox wrote:
> > On Mon, 2018-07-16 at 10:28 -0700, Dave Hansen wrote:
> > > On 07/16/2018 09:56 AM, Thomas Gleixner wrote:
> > > > On Mon, 16 Jul 2018, Rich Felker wrote:
> > > > > At least the Centerton (late-generation Bonnell uarch) Atom
> > > > > family is
> > > > > omitted from the cpu_no_speculation table added by commit
> > > > > fec9434a12f3
> > > > > to arch/x86/kernel/cpu/common.c. Is this intentional? Would a
> > > > > patch
> > > > > adding it and possibly other omissions be welcome?
> > > > 
> > > > Probably. Dave?
> > > 
> > > IIRC, Alan Cox was compiling a list on what is affected vs. not.  He
> > > would know way better than I.
> > 
> > The pre Silvermont atom cores are in order. When I did the original
> > list I didn't bother with all the 32bit cores as we didn't have any
> > 32bit mitigations then.
> 
> At least we should give the users that warm and fuzzy feeling that they are
> not affected.

It's not just fuzzies -- my box was actually affected by slowdown for
mitigation without adding "nopti" to boot command line, which is
rather unfortunate when you're running a severely-slower box already
for the sake of not being affected by these vulnerabilities.

Since Dave asked, mine is a Centerton as I originally mentioned, Atom
S1260, which seems to be the fastest in-order Intel chip with boards
still commercially available. I'm not sure if there are other
omissions that are actually interesting. I have several other Atoms
too, but I think all of those are covered by the existing table.

Rich
