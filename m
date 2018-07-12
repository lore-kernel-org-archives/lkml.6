Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C31C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A217720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A217720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeGLOkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:40:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:56936 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeGLOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:40:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1A04FC009; Thu, 12 Jul 2018 16:30:52 +0200 (CEST)
Date:   Thu, 12 Jul 2018 16:30:37 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] i915/intel_tv_get_modes: fix strncpy
 truncation warning
Message-ID: <20180712143037.GA15484@nautica>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
 <20180712124401.GZ5565@intel.com>
 <20180712135526.GA5463@nautica>
 <20180712141015.GD5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712141015.GD5565@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote on Thu, Jul 12, 2018:
> On Thu, Jul 12, 2018 at 03:55:26PM +0200, Dominique Martinet wrote:
> > This could either be 'this commit' as a whole or if you look only at the
> > commit message 'this strncpy fix' from the title (which is arguably the
> > same), and both interpretations sound fairly understandable in the
> > context of the title line without seeing the patch to me... Although
> > I'll admit this is difficult to judge of that as the author.
> 
> The patch subject is not part of the commit message body though. This is
> made all the more clear when I'm editing the response in vim that doesn't
> even show the mail subject to me. Hence I'm always left in the dark by
> commit messages that aren't fully self contained.

Ah, that is a fair point - I thought you were referring to the patch
itself, not the subject. My mail client does include the subject in the
editor so I hadn't considered that, but I understand where you come from
now and agree.
I will be more mindful of that as the v2 has the same problem.


> > Yes and no, I gave it for referrence but when you update to gcc 8 you
> > will literally see it all over the place.
> > The words "strncpy truncation warning" is really precise once you've
> > seen them a few times and there are litteraly hundred of these warnings
> > in the kernel, some have already been fixed taking a glance at the git
> > log, some with and without the warning message.
> > I don't think it's worth polluting the git log with this many
> > warnings... Which leads to...
> 
> I disagree. Without knowing what exactly is fixed how can you judge 
> whether the patch even makes sense? And later you may get another
> report of the same warning and then you would want to look through
> the git log to see if there's a patch that already fixed it. Quite
> hard to do without the exact warning in the log.

I might just be tired of this specific warning; I've fixed it countless
times in different projects these past few months and it's coming out of
my eyes at this point.

I definitely agree in general, just -Wstringop-truncation has been
showing up everywhere and it's always the same, with many occurences I
don't consider to be bugs (like here because we forcefully terminate the
last byte of the string afterwards), so it's really lost value to me.

I included it as a comment precisely for your first point (so you can tell
the patch makes sense now) but I do not feel any regret not recording
it, and I still stand by what I said: if all you want is examples of
patches that already fix it, I've just had a look at git log in drm
trees and there already have been many fixes, most of which provided a
warning similar to the one I got.

Attaching the full warning messages makes sense if the warning is
new/rare but if it's the same as 5 other commits in semi-recent history
I do not see much point.

Anyway, I would be enclined to add it just to comply now but it looks
like Chris already picked the v2 up, so there is not much point in
arguing, sorry for disagreeing.

-- 
Dominique Martinet
