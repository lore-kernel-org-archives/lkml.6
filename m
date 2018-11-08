Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801AAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmvo/hml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F3D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeKIGpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIGpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:45:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81EB32081C;
        Thu,  8 Nov 2018 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541711308;
        bh=0FCJO6of94dflib1N81VdKGKxwPLfueMDNzxES8bLOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmvo/hmlyXY+1aGUFq6JIkSqBfk3tjvzWtCX2bWrNkbtt+KXQ28jRELWIWHZjr4TG
         oRC+x8gMdQHUtqAUYcSMg2iDyUr6HLshCjKEJX6bvW03xrrVDro2v82mJz5kQPHyjn
         Ej/9MNcfFMA0XOD8sUtMnUUJpchCGSgTS4OKBYVI=
Date:   Thu, 8 Nov 2018 13:08:28 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108210828.GD22691@kroah.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com>
 <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
 <20181108174006.GP4170@linux.ibm.com>
 <alpine.DEB.2.21.1811082042001.1640@nanos.tec.linutronix.de>
 <20181108210615.GC22691@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108210615.GC22691@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:06:15PM -0800, Greg KH wrote:
> On Thu, Nov 08, 2018 at 08:58:32PM +0100, Thomas Gleixner wrote:
> > On Thu, 8 Nov 2018, Paul E. McKenney wrote:
> > > On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> > > > On Thu, Nov 8, 2018 at 1:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > > > > > > + - Cc: ``cc-ed-person <person@mail>``
> > > > > > > +
> > > > > > > +   If the patch should be backported to stable, then please add a '``Cc:
> > > > > > > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > > > > > > +   mail.
> > > > > >
> > > > > > Can I suggest a more canonical form:
> > > > > >
> > > > > >       Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> > > > > >
> > > > > > It would be nice if people adding Cc: stable lines would actually try to
> > > > > > figure out which exact kernel versions are affected.
> > > > 
> > > > I know at least StGit mail does not grok that "#"notation. I've
> > > > stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> > > > preferred over "# <KVER>" if only because it can be used to track
> > > > fixes to commits that have been backported to stable. Is there any
> > > > reason for "# <KVER>" to continue in a world where we have "Fixes:"?
> > > 
> > > I sometimes have fixes that need to be different for different past
> > > releases.  And there have been cases where RCU patches would apply and
> > > build cleanly against releases for which it was not appropriate, but
> > > would have some low-probability failure.  Which meant that it could be
> > > expected to pass light testing.  :-/
> > > 
> > > So I sometimes need a way of saying which versions a given patch applies
> > > to, independent of the version into which the bug was introduced.
> > 
> > I can understand that you want to limit the scope of automatic backports.
> > 
> > But we really should try to always use of the Fixes: tag. In most cases the
> > SHA1 of the commit in the fixes tag defines the backport scope. 
> > 
> > For the rare cases where the buggy commit is really old, but you want to
> > limit the backport scope for a reason then I really like to avoid to
> > overload the Cc stable tag and have a dedicated tag instead. Something
> > like:
> > 
> >     Fixes: 1234567890AB ("subsys/comp: Short summary")
> >     Backport-to: 4.14
> 
> Ick, no.  Just stick to the "Fixes:" tag.  My scripts can now track when
> a patch is backported to a stable tree so that I know to apply it to
> older ones despite the original patch showing up in a newer release.
> 
> And yes, those scripts are new, as Sasha is about to point out all of
> the places where I missed this in the past :)

Here's the script if others are curious:
	https://github.com/gregkh/gregkh-linux/blob/master/scripts/fix_in_what_release

Yes, I know it's horrid, I abuse the fact that 'git grep' is very fast
on the stable-queue repo :)

thanks,

greg k-h
