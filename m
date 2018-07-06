Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24982C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD5222B52
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxu+4BCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD5222B52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeGFX7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:59:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeGFX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HP45WtKWp/afXk90UoJCduXmKoOJ6ddjF10cxKPnwfk=; b=hxu+4BCfwvzwbj/JgjfX9gzRB
        0rICscw0eCywty3CMIj+1rN4r3I3/01VTkiqdsrJw+X5k3hbSscBDuYH4VZwpuKrUEJzyXN76XGV1
        Jb/4UsM7oZiH4T/nn80QEaR7XSLa7PHWrztRHa8M9ZpQ8VU5lO4t/ssJWJd78c7qTa6+fMMexpWb8
        Fi5GW3Nu2xukQOlvtrhTGj5UOhadm7thM/uD8T7YXsTZNIrVcecMa5orBNmsj359qzyrWn8di0uZw
        ieeZU8L7m4KvYMEgQrN9tdjzo2Sq5QbtYJU09nmr6caaUdl4pG2VOUfD1p6kTe+AGKzU4PQSnKrKf
        q9miUCEww==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbad2-0002is-3x; Fri, 06 Jul 2018 23:59:08 +0000
Date:   Fri, 6 Jul 2018 16:59:07 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Message-ID: <20180706235907.GE3041@fury>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:06:14PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 2, 2018 at 4:51 PM,  <Mario.Limonciello@dell.com> wrote:
> 
> >> > So there are some customers who will have issue with power button
> >> > without this patch, so it should be also marked for stable also.
> >> > Also this may be a candidate for 4.18-rcX.
> >> >
> >>
> >> I'm not sure Greg will take this selling point for rather big patch.
> >> From changelog, honestly, I don't see any regression description,
> >> looks like "it wasn't working before change anyway".
> >>
> >
> > Just for adding some context.
> >
> > Some platforms have moved to different interface in ASL in FW upgrade
> > due to deficiencies/bugs present with old interface.  So yes it's platform FW
> > change in behavior that leads to Linux kernel regression.  Windows driver has supported
> > both interfaces for a long time.  Linux kernel however doesn't support this interface until now.
> >
> >> For now, I pushed this to my review and testing queue as is, thanks!
> >
> > If not stable I think it would at least be ideal to try to bring this to 4.18-rcX if possible for
> > compatibility with more platforms that will come with this other interface instead.
> 
> Citing Linus:
> 
> --- 8< --- 8< ---
> So please, people, the "fixes" during the rc series really should be
> things that are _regressions_. If it used to work, and it no longer does,
> then fixing that is a good and proper fix. Or if something oopses or has a
> security implication, then the fix for that is a real fix.
> 
> But if it's something that has never worked, even if it "fixes" some
> behavior, then it's new development, and that should come in during the
> merge window. Just because you think it's a "fix" doesn't mean that it
> really is one, at least in the "during the rc series" sense.
> --- 8< --- 8< ---
> 
> So, if we can sell him that it used to work and firmware fix is a
> Linux regression I'm fine.
> 
> Darren, what do you think?

So if I understand this correctly, we have this timeline.

Linux v4.16
- Machine A works
Linux v4.17
- Machine A works
- Machine A updates firmware
- Machine A stops working
Linux v4.18
- Machine A still doesn't work

So it is not a *Linux kernel* regression.

The patch is too large for standard stable rules.

It is a regression from any user's perspective - the machine worked,
they followed good digital hygiene and updated their firmware, and now
it doesn't. This user will now think twice before they update their BIOS
again, since it may fundamentally change the platform, rather than
committing to only fixing things below the OS Interface layer. :-(

The risk of course is that this introduces new bugs - and as with
anything that still uses _DSM (sigh, why?) that is quite possible due to
the opaque interface. Very unfortunate to see _DSM ADDED to a previously
_DSM free implementation. Linus is right, this is not a fix, this is
feature development.

I strongly advocate for vendors to have more control over their drivers,
but this scenario really frustrates me. I don't think I can justify this
to Linus as a fix. But before we just say "no" (because hey, I want
these fixes available as early as possible too), let's ask Rafael if he
has an opinion or if there is precedent for this in his experience with
ACPI drivers in general:

Rafael?

Finally, we can also just ask Linus. The firmware update broke the power
button, we can get it working again by supporting the new API with this
patch... see what he says.

-- 
Darren Hart
VMware Open Source Technology Center
