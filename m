Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BC20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392717AbfAPLvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:51:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49712 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392690AbfAPLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:51:41 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id f99fa71f3a8cafa3; Wed, 16 Jan 2019 12:51:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the pm tree
Date:   Wed, 16 Jan 2019 12:50:47 +0100
Message-ID: <4595555.i8zNzpiWno@aspire.rjw.lan>
In-Reply-To: <20190116002257.GE26416@windriver.com>
References: <20190116075540.78cff44e@canb.auug.org.au> <8346227.VjU8HeZdOJ@aspire.rjw.lan> <20190116002257.GE26416@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 16, 2019 1:22:57 AM CET Paul Gortmaker wrote:
> [Re: linux-next: Fixes tags need some work in the pm tree] On 16/01/2019 (Wed 00:06) Rafael J. Wysocki wrote:
> 
> > On Tuesday, January 15, 2019 11:43:05 PM CET Stephen Rothwell wrote:
> > > Hi Rafael,
> > > 
> > > On Tue, 15 Jan 2019 23:13:16 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Tuesday, January 15, 2019 9:55:40 PM CET Stephen Rothwell wrote:
> > > > > [I am experimenting with checking the Fixes tags in commits in linux-next.
> > > > > Please let me know if you think I am being too strict.]
> > > > > 
> > > > > Hi Rafael,
> > > > > 
> > > > > Commits
> > > > > 
> > > > >   62b33d57c534 ("drivers: thermal: int340x_thermal: Make PCI dependency explicit")
> > > > >   cd793ab22a93 ("x86/intel/lpss: Make PCI dependency explicit")
> > > > >   42ac19e7b81e ("ACPI: EC: Look for ECDT EC after calling acpi_load_tables()")
> > > > >   6c29b81b5695 ("platform/x86: apple-gmux: Make PCI dependency explicit")
> > > > >   34783dc0182a ("platform/x86: intel_pmc: Make PCI dependency explicit")
> > > > >   704658d1d3ae ("platform/x86: intel_ips: make PCI dependency explicit")
> > > > >   5df37f3a1aa9 ("vga-switcheroo: make PCI dependency explicit")
> > > > >   da1df6ee4296 ("ata: pata_acpi: Make PCI dependency explicit")
> > > > >   ce97a22a596b ("ACPI / LPSS: Make PCI dependency explicit")
> > > > > 
> > > > > Have malformed Fixes tags:
> > > > > 
> > > > > There should be double quotes around the commit subject.  
> > > > 
> > > > Well, where does this requirement come from?
> > > > 
> > > > It hasn't been there before AFAICS.
> > > 
> > > Documentation/process/submitting-patches.rst has the following, but I
> > > am sure people are happy to discuss changes and it does say "For
> > > example", so maybe I am being to strict?
> > 
> > If that's the source of it, then it's rather weak IMO.
> 
> Rafael, allow me to rewind a bit, and add context you would not have...
> 
> A quick on-the-fly script shows we have a lot of "Fixes:" tags that
> either have bad (rebased/gone) commit IDs and/or non-standard
> formatting.
> 
> The biggest issue is having commits in mainline that reference a commit
> ID in a Fixes: tag that doesn't exist - for one reason or another.  Once
> that is in mainline, we can't correct it.  It is there forever.
> 
> Doing a sanity check for that in linux-next seems like a good place to
> check for this and prevent it.  And if we sanity check for one thing, we
> can sanity check for other common issues.  Hence the less important
> formatting checks.

I agree with that in general, and I'd really appreciate telling me that I
have a non-existing SHA-ID in a Fixes: tag, but is it really a good idea to
make it a fail if someone uses "non-canonical" quoting style in the summary
part?

> > Formal requirements should be documented as such and I would expect that
> > to happen through the usual process: patch submission, review, acceptance etc.
> 
> I'd rather not misinterpret this as a formal requirement.  We just want
> to catch bad SHA IDs in Fixes: and also help our friends doing the
> linux-stable releases so they can parse those Fixes: fields more easily
> and reliably.
> 
> I'd like to think we all can support the work the linux-stable people do
> and stand behind doing whatever we can to help them.  At the same time,
> people (maintainers and submitters) have the choice to ignore the
> e-mails that suggest "Fixes:" changes, if they feel they are invalid.
> And suggestions for improvements in parsing etc etc are always welcome.

IMO, if you don't find the SHA ID given in the tag, it is a fail already.

If you find it, you should at least be able to get a partial match of the
initial part of the original commit summary with what is given in the
summary part of the tag except for some possible quoting characters at
the beginning of it.  That should be reasonably straightforward to implement.

Cheers,
Rafael

