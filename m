Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449A421725
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449A421725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeGGNn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 09:43:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:3321 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752761AbeGGNnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 09:43:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 06:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,320,1526367600"; 
   d="scan'208";a="243378297"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.118.97])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2018 06:43:53 -0700
Message-ID: <ccb18d853b254f680895c45862274ec8bdd70ab0.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Sat, 07 Jul 2018 06:43:52 -0700
In-Reply-To: <20180706235907.GE3041@fury>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
         <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
         <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
         <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
         <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
         <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
         <20180706235907.GE3041@fury>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 16:59 -0700, Darren Hart wrote:
> On Mon, Jul 02, 2018 at 05:06:14PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 2, 2018 at 4:51 PM,  <Mario.Limonciello@dell.com>
> > wrote:
> > 
> > > > > So there are some customers who will have issue with power
> > > > > button
> > > > > without this patch, so it should be also marked for stable
> > > > > also.
> > > > > Also this may be a candidate for 4.18-rcX.
> > > > > 
> > > > 
> > > > I'm not sure Greg will take this selling point for rather big
> > > > patch.
> > > > From changelog, honestly, I don't see any regression
> > > > description,
> > > > looks like "it wasn't working before change anyway".
> > > > 
> > > 
> > > Just for adding some context.
> > > 
> > > Some platforms have moved to different interface in ASL in FW
> > > upgrade
> > > due to deficiencies/bugs present with old interface.  So yes it's
> > > platform FW
> > > change in behavior that leads to Linux kernel
> > > regression.  Windows driver has supported
> > > both interfaces for a long time.  Linux kernel however doesn't
> > > support this interface until now.
> > > 
> > > > For now, I pushed this to my review and testing queue as is,
> > > > thanks!
> > > 
> > > If not stable I think it would at least be ideal to try to bring
> > > this to 4.18-rcX if possible for
> > > compatibility with more platforms that will come with this other
> > > interface instead.
> > 
> > Citing Linus:
> > 
> > --- 8< --- 8< ---
> > So please, people, the "fixes" during the rc series really should
> > be
> > things that are _regressions_. If it used to work, and it no longer
> > does,
> > then fixing that is a good and proper fix. Or if something oopses
> > or has a
> > security implication, then the fix for that is a real fix.
> > 
> > But if it's something that has never worked, even if it "fixes"
> > some
> > behavior, then it's new development, and that should come in during
> > the
> > merge window. Just because you think it's a "fix" doesn't mean that
> > it
> > really is one, at least in the "during the rc series" sense.
> > --- 8< --- 8< ---
> > 
> > So, if we can sell him that it used to work and firmware fix is a
> > Linux regression I'm fine.
> > 
> > Darren, what do you think?
> 
> So if I understand this correctly, we have this timeline.
> 
> Linux v4.16
> - Machine A works
> Linux v4.17
> - Machine A works
> - Machine A updates firmware
> - Machine A stops working
> Linux v4.18
> - Machine A still doesn't work
> 
> So it is not a *Linux kernel* regression.
> 
> The patch is too large for standard stable rules.
> 
> It is a regression from any user's perspective - the machine worked,
> they followed good digital hygiene and updated their firmware, and
> now
> it doesn't. This user will now think twice before they update their
> BIOS
> again, since it may fundamentally change the platform, rather than
> committing to only fixing things below the OS Interface layer. :-(
> 
> The risk of course is that this introduces new bugs - and as with
> anything that still uses _DSM (sigh, why?) that is quite possible due
> to
> the opaque interface. Very unfortunate to see _DSM ADDED to a
> previously
> _DSM free implementation. Linus is right, this is not a fix, this is
> feature development.
> 
> I strongly advocate for vendors to have more control over their
> drivers,
> but this scenario really frustrates me. I don't think I can justify
> this
> to Linus as a fix. But before we just say "no" (because hey, I want
> these fixes available as early as possible too), let's ask Rafael if
> he
> has an opinion or if there is precedent for this in his experience
> with
> ACPI drivers in general:
> 
> Rafael?
> 
> Finally, we can also just ask Linus. The firmware update broke the
> power
> button, we can get it working again by supporting the new API with
> this
> patch... see what he says.
Mario can add more.
But I think Dell has released a BIOS fix, so that power button can
still work using non _DSM way. So I think we can wait for normal
release cycle.

Thanks,
Srinivas

> 
