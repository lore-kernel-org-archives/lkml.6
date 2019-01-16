Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A32C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52444206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389880AbfAPLfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:35:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54133 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfAPLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:35:25 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a16cbd9eab5cd01e; Wed, 16 Jan 2019 12:35:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tags need some work in the pm tree
Date:   Wed, 16 Jan 2019 12:34:29 +0100
Message-ID: <24595936.XVKUtQNKnv@aspire.rjw.lan>
In-Reply-To: <877ef5zduk.fsf@concordia.ellerman.id.au>
References: <20190116075540.78cff44e@canb.auug.org.au> <8346227.VjU8HeZdOJ@aspire.rjw.lan> <877ef5zduk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 16, 2019 12:43:31 AM CET Michael Ellerman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> > On Tuesday, January 15, 2019 11:43:05 PM CET Stephen Rothwell wrote:
> >> Hi Rafael,
> >> 
> >> On Tue, 15 Jan 2019 23:13:16 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >> >
> >> > On Tuesday, January 15, 2019 9:55:40 PM CET Stephen Rothwell wrote:
> >> > > [I am experimenting with checking the Fixes tags in commits in linux-next.
> >> > > Please let me know if you think I am being too strict.]
> >> > > 
> >> > > Hi Rafael,
> >> > > 
> >> > > Commits
> >> > > 
> >> > >   62b33d57c534 ("drivers: thermal: int340x_thermal: Make PCI dependency explicit")
> >> > >   cd793ab22a93 ("x86/intel/lpss: Make PCI dependency explicit")
> >> > >   42ac19e7b81e ("ACPI: EC: Look for ECDT EC after calling acpi_load_tables()")
> >> > >   6c29b81b5695 ("platform/x86: apple-gmux: Make PCI dependency explicit")
> >> > >   34783dc0182a ("platform/x86: intel_pmc: Make PCI dependency explicit")
> >> > >   704658d1d3ae ("platform/x86: intel_ips: make PCI dependency explicit")
> >> > >   5df37f3a1aa9 ("vga-switcheroo: make PCI dependency explicit")
> >> > >   da1df6ee4296 ("ata: pata_acpi: Make PCI dependency explicit")
> >> > >   ce97a22a596b ("ACPI / LPSS: Make PCI dependency explicit")
> >> > > 
> >> > > Have malformed Fixes tags:
> >> > > 
> >> > > There should be double quotes around the commit subject.  
> >> > 
> >> > Well, where does this requirement come from?
> >> > 
> >> > It hasn't been there before AFAICS.
> >> 
> >> Documentation/process/submitting-patches.rst has the following, but I
> >> am sure people are happy to discuss changes and it does say "For
> >> example", so maybe I am being to strict?
> >
> > If that's the source of it, then it's rather weak IMO.
> >
> > Formal requirements should be documented as such and I would expect that
> > to happen through the usual process: patch submission, review, acceptance etc.
> 
> It is documented, in submitting-patches.rst.
> 
> That was submitted to lkml:
> 
>   https://lore.kernel.org/lkml/1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com/
> 
> And committed by Linus:
> 
>   8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: tag")

Stephen has already quoted from that doc, but it only gives the format of the
summary line as an example.

> How would we make it more formal than that?

Say somewhere that this particular summary formatting is required?

Also, tags are more of a maintainers' thing and SubmittingPatches doesn't look
like the best place for documenting how the maintainers are expected to format
their commits.

> > Moreover, extending advice on to how submit paches to formatting requirements
> > for commits feels like a bit of a stretch to me.
> >
> >> The counter argument is that
> >> there are various (semi-)automated processes that use these tags and
> >> being consistent probably makes those processes (and life for those who
> >> run them) easier.
> >
> > And frankly I wouldn't expect any of these to even look at the summary
> > lines as they have not been consistent historically and the SHA-1 ID should
> > be sufficient to identify the commit in question.
> 
> It usually is, but it's still a good sanity check to have the subject in
> there, especially for cases where the SHA is wrong (though that should
> be less of a problem in future due to Stephen doing these checks).

A human can look at the summary after a script has not found the commit by
ID, but the human then doesn't care about the quoting characters.

Also it is rather straightforward to strip the quoting characters in a script
whatever they are.

My point basically is that in order to call something "malformed", you need
to provide a formal definition of what is expected.  An example in
SubmittingPatches doesn't seem quite sufficient to me for that role.

Cheers,
Rafael

