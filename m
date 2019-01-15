Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1334C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbfAOXID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:08:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50558 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391297AbfAOXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:54 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id f8ead82afe91a3c5; Wed, 16 Jan 2019 00:07:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tags need some work in the pm tree
Date:   Wed, 16 Jan 2019 00:06:59 +0100
Message-ID: <8346227.VjU8HeZdOJ@aspire.rjw.lan>
In-Reply-To: <20190116094305.0f66356a@canb.auug.org.au>
References: <20190116075540.78cff44e@canb.auug.org.au> <2774660.l3LIlnjlhl@aspire.rjw.lan> <20190116094305.0f66356a@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 15, 2019 11:43:05 PM CET Stephen Rothwell wrote:
> Hi Rafael,
> 
> On Tue, 15 Jan 2019 23:13:16 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, January 15, 2019 9:55:40 PM CET Stephen Rothwell wrote:
> > > [I am experimenting with checking the Fixes tags in commits in linux-next.
> > > Please let me know if you think I am being too strict.]
> > > 
> > > Hi Rafael,
> > > 
> > > Commits
> > > 
> > >   62b33d57c534 ("drivers: thermal: int340x_thermal: Make PCI dependency explicit")
> > >   cd793ab22a93 ("x86/intel/lpss: Make PCI dependency explicit")
> > >   42ac19e7b81e ("ACPI: EC: Look for ECDT EC after calling acpi_load_tables()")
> > >   6c29b81b5695 ("platform/x86: apple-gmux: Make PCI dependency explicit")
> > >   34783dc0182a ("platform/x86: intel_pmc: Make PCI dependency explicit")
> > >   704658d1d3ae ("platform/x86: intel_ips: make PCI dependency explicit")
> > >   5df37f3a1aa9 ("vga-switcheroo: make PCI dependency explicit")
> > >   da1df6ee4296 ("ata: pata_acpi: Make PCI dependency explicit")
> > >   ce97a22a596b ("ACPI / LPSS: Make PCI dependency explicit")
> > > 
> > > Have malformed Fixes tags:
> > > 
> > > There should be double quotes around the commit subject.  
> > 
> > Well, where does this requirement come from?
> > 
> > It hasn't been there before AFAICS.
> 
> Documentation/process/submitting-patches.rst has the following, but I
> am sure people are happy to discuss changes and it does say "For
> example", so maybe I am being to strict?

If that's the source of it, then it's rather weak IMO.

Formal requirements should be documented as such and I would expect that
to happen through the usual process: patch submission, review, acceptance etc.

Moreover, extending advice on to how submit paches to formatting requirements
for commits feels like a bit of a stretch to me.

> The counter argument is that
> there are various (semi-)automated processes that use these tags and
> being consistent probably makes those processes (and life for those who
> run them) easier.

And frankly I wouldn't expect any of these to even look at the summary
lines as they have not been consistent historically and the SHA-1 ID should
be sufficient to identify the commit in question.

Anyway, I'm not against formalizing the Fixes: tags, but I would rather expect
that to be done in a, well, more formal way.

> ------------------------------------------------------------------------
> If your patch fixes a bug in a specific commit, e.g. you found an issue using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> the SHA-1 ID, and the one line summary.  For example::
> 
>         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
> 
> The following ``git config`` settings can be used to add a pretty format for
> outputting the above style in the ``git log`` or ``git show`` commands::
> 
>         [core]
>                 abbrev = 12
>         [pretty]
>                 fixes = Fixes: %h (\"%s\")
> ------------------------------------------------------------------------

Cheers,
Rafael

