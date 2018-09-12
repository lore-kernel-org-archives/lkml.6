Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5702087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5702087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeILWPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:15:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:59956 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeILWPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:15:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 10:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="89430639"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 12 Sep 2018 10:10:21 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 12 Sep 2018 20:10:20 +0300
Date:   Wed, 12 Sep 2018 20:10:20 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Intel Gfx Mailing List <intel-gfx@freedesktop.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] [REGRESSION 4.19-rc2] sometimes hangs with black
 screen when resuming from suspend or hibernation (was: Re: Linux 4.19-rc2)
Message-ID: <20180912171020.GE5565@intel.com>
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
 <20222492.cP35YpYkb6@merkaba>
 <CAJZ5v0i3gH4H6Su5MPWA3DA_i4mvHEqfw3y=rr0XOpZi5bbqhA@mail.gmail.com>
 <3346308.cXARZRajoW@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3346308.cXARZRajoW@merkaba>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:17:05PM +0200, Martin Steigerwald wrote:
> Cc´d Intel Gfx mailing list, in case somebody there knows something:
> 
> Cc´d Thorsten for regression tracking… forgot initially. Can also open 
> bug report at a later time but so far I cannot provide many details 
> about the issue.
> 
> Rafael J. Wysocki - 11.09.18, 10:17:
> > On Tue, Sep 11, 2018 at 10:01 AM Martin Steigerwald 
> <martin@lichtvoll.de> wrote:
> > > Hi.
> > > 
> > > Linus Torvalds - 02.09.18, 23:45:
> > > > As usual, the rc2 release is pretty small. People are taking a
> > > 
> > > With 4.19-rc2 this ThinkPad T520 with i5 Sandybrdige sometimes hangs
> > > with black screen when resuming from suspend or hibernation.  With
> > > 4.18.1 it did not. Of course there have been userspace related
> > > updates that could be related.
> > > 
> > > I currently have no time to dig into this and on this production
> > > laptop I generally do not do bisects between major kernel releases.
> > > So currently I only answer questions that do not require much time
> > > to answer.
> > > 
> > > For now I switched back to 4.18. If that is stable – and thus likely
> > > no userspace component is related –, I go with 4.19-rc3 or whatever
> > > is most recent version to see if the issue has been fixed already.
> > 
> > There were almost no general changes related to system-wide PM between
> > 4.18 and current, so I would suspect one of the device drivers or the
> > x86 core.  It also may be something like CPU online/offline, however.
> 
> I see. I wondered about intel-gfx driver already. Of course it could 
> also be something else.
> 
> I forgot to mention: The mouse pointer was visible, but the screen 
> remained black.

Did the mouse cursor still move or not?

Could also try suspend without any GUI stuff in the way. Or try the
intel ddx instead of the modesetting ddx (assuming that's what
you're using now) and no compositor to rule out GPU hangs killing
the compositor. The intel ddx can also deal with the GPU not
recovering from a hang by switching to software rendering,
whereas modesetting cannot.

Hmm. Also T520 is an optimus laptop maybe? If there's an nvidia
GPU involved it's going to be hard to get anyone to care. Better
switch that off in the BIOS if you haven't already.

-- 
Ville Syrjälä
Intel
