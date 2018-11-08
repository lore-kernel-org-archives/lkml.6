Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABAAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIFfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:35:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45153 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeKIFfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:35:46 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKqRq-0000TW-8d; Thu, 08 Nov 2018 20:58:38 +0100
Date:   Thu, 8 Nov 2018 20:58:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, John Stultz <john.stultz@linaro.org>,
        acme@redhat.com, frederic@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
In-Reply-To: <20181108174006.GP4170@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1811082042001.1640@nanos.tec.linutronix.de>
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de> <20181108074012.GD20032@gmail.com> <20181108091251.GL9761@hirez.programming.kicks-ass.net> <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108174006.GP4170@linux.ibm.com>
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

On Thu, 8 Nov 2018, Paul E. McKenney wrote:
> On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> > On Thu, Nov 8, 2018 at 1:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > > > > + - Cc: ``cc-ed-person <person@mail>``
> > > > > +
> > > > > +   If the patch should be backported to stable, then please add a '``Cc:
> > > > > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > > > > +   mail.
> > > >
> > > > Can I suggest a more canonical form:
> > > >
> > > >       Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> > > >
> > > > It would be nice if people adding Cc: stable lines would actually try to
> > > > figure out which exact kernel versions are affected.
> > 
> > I know at least StGit mail does not grok that "#"notation. I've
> > stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> > preferred over "# <KVER>" if only because it can be used to track
> > fixes to commits that have been backported to stable. Is there any
> > reason for "# <KVER>" to continue in a world where we have "Fixes:"?
> 
> I sometimes have fixes that need to be different for different past
> releases.  And there have been cases where RCU patches would apply and
> build cleanly against releases for which it was not appropriate, but
> would have some low-probability failure.  Which meant that it could be
> expected to pass light testing.  :-/
> 
> So I sometimes need a way of saying which versions a given patch applies
> to, independent of the version into which the bug was introduced.

I can understand that you want to limit the scope of automatic backports.

But we really should try to always use of the Fixes: tag. In most cases the
SHA1 of the commit in the fixes tag defines the backport scope. 

For the rare cases where the buggy commit is really old, but you want to
limit the backport scope for a reason then I really like to avoid to
overload the Cc stable tag and have a dedicated tag instead. Something
like:

    Fixes: 1234567890AB ("subsys/comp: Short summary")
    Backport-to: 4.14

and have that backport tag right under the Fixes tag. If the Backport-to
tag is ommitted, the SHA1 defines the scope, but I'm fine with making it
mandatory.

If there is really the special RCU case where each and every stable version
needs some special treatment then say:

    Backport-to: Manual

or whatever sensible word would express it correctly.

The Fixes tag is really valuable when you need to make connections and I
know that the people who are looking into safety-critical Linux value the
tag because it can be used for tracking and for metrics.

Thanks,

	tglx

