Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C90C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EF620818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EF620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeKHGXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:23:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKHGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:23:52 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKUnb-0008Lo-E8; Wed, 07 Nov 2018 21:51:39 +0100
Date:   Wed, 7 Nov 2018 21:51:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
In-Reply-To: <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107124855.328133e7@lwn.net> <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
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

Dan,

On Wed, 7 Nov 2018, Dan Williams wrote:
> On Wed, Nov 7, 2018 at 11:49 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > The stuff that is truly specific to tip seems fairly minimal:
> >
> >   - what goes into tip
> >   - the reverse fir tree thing
> >   - tail comments, or the distaste thereabouts
> >   - subject-line prefixes
> >
> > Having a tip-specific document that contains only those (plus whatever
> > else I forgot to list) would, IMO, make it much more likely that readers
> > would actually notice (and follow) the stuff that's specific to tip.
> >
> > See what I'm getting at here?  Am I totally out to lunch on this?
> 
> Not at all, and this is one of the thrusts of my talk next week at
> Plumbers. I *do* want to propose that sub-systems document all their
> local quirks. Then we can refactor the common ones into a global
> document, have some discussion fodder if some sub-system specific
> rules can be unified, and otherwise leave the freedom for individual
> sub-systems to be different as long as it's documented.

That was the intention here. I know that there is quite some stuff in that
document which could/should go into common documentation, but I have no
idea how much of it can be agreed on and how much different other
subsystems are looking at this. It's a braindump of all the things which
nag me/us in the daily business of patch juggling.

Jon, I agree that we should aim for as much consistency as we can. Though
if you look e.g. at comment style to begin with, then there is already
quite some disagreement. Changelog styles are a similar thing. Even if it's
somehow documented in the general documentation, some maintainers care and
others do not. The tip tree - and I have to admit especially myself - cares
a lot. I truly hate it when I have to look at useless, misleading or
uncomprehensible changelogs written by that Gleixner dude 10+ years ago.

We surely can spend a lot of time in bike shedding discussions how the
generally agreed guidelines should look like. But that would still leave
the contributors standing in the rain for a long time.

So I agree with Dan, that we should collect as much documentation from
subsystems/maintainers and get it into the tree so we can:

   - give contributors immediate access to subsystem/maintainer specific
     quirks

   - extract common views and move them into the general guidelines

   - have a clear idea which kind of things need to be discussed and agreed
     on and what might be left in the susbsystem/maintainer specific
     interpretation/expectation realm.

Thanks,

	tglx
