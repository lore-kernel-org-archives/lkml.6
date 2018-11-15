Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E4E223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E4E223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeKOXz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:55:58 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39456 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729010AbeKOXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:55:58 -0500
X-IronPort-AV: E=Sophos;i="5.56,236,1539640800"; 
   d="scan'208";a="355837763"
Received: from unknown (HELO hadrien) ([64.114.255.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 14:47:37 +0100
Date:   Thu, 15 Nov 2018 05:47:35 -0800 (PST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stfrench@microsoft.com, Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook: Subsystem
 Profile
In-Reply-To: <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811150544090.2354@hadrien>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com> <alpine.DEB.2.21.1811142146230.9620@hadrien>
 <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2018, Geert Uytterhoeven wrote:

> Hi Julia,
>
> On Thu, Nov 15, 2018 at 6:48 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Wed, 14 Nov 2018, Dan Williams wrote:
> > > As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> > > Profile is proposed as a way to reduce friction between committers and
> > > maintainers and perhaps encourage conversations amongst maintainers
> > > about best practice policies.
> > >
> > > The profile contains short answers to some of the common policy
> > > questions a contributor might have, or that a maintainer might consider
> > > formalizing. The current list of maintenance policies is:
> > >
> > > Overview: General introduction to maintaining the subsystem
> > > Core: List of source files considered core
> > > Leaf: List of source files that consume core functionality
> > > Patches or Pull requests: Simple statement of expected submission format
> > > Last -rc for new feature submissions: Expected lead time for submissions
> > > Last -rc to merge features: Deadline for merge decisions
> > > Non-author Ack / Review Tags Required: Patch review economics
> > > Test Suite: Pass this suite before requesting inclusion
> > > Resubmit Cadence: When to ping the maintainer
> > > Trusted Reviewers: Help for triaging patches
> > > Time Zone / Office Hours: When might a maintainer be available
> > > Checkpatch / Style Cleanups: Policy on pure cleanup patches
> > > Off-list review: Request for review gates
> > > TODO: Potential development tasks up for grabs, or active focus areas
> >
> > How about patch subject lines?  What is the formula that should be used to
> > transform the name(s) of the affected file(s) into an appropriate suject
> > line?
>
> Automating that may be difficult.
> I always use "git log --oneline", and try to derive something sane
> from its output.

Yes, I do likewise.  But there may be some subsystems for which it would
be possible to come up with a more specific policy.  The advantage of what
is proposed here is that it is not necessary to come up with a single
formula that works everywhere.  Even a description in English could be
helpful.

Other subsystem specific properties such as what tree to work on, whether
to CC stable, ordering of variables or header files, etc could also be
useful to mention.  Anything that will cause a maintainer to immediately
reject a patch for syntactic reasons.

julia
