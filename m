Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15779C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5042086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="emvlvo6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfBHPqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:46:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39650 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBHPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:45:59 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so9836010itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x0ow+hqpKgNG8nZU8pQBR0zcMJQoa157kMMUNcDp/c=;
        b=emvlvo6sKZKjFjBGm2Qm3rOQ1WMI0NTkFeP3ibPwujZxo6PfBN2AKRo5oGenddV46I
         GhhuP3W66EcjctQmyDROcMuMl42f1YuGZDg9kF/NE2jqIYZCFbhldRJDVRDpX9lACo5K
         W7gyOWT3Hm0zn/K3a1RvvjYW/+iyIlGvJoBeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x0ow+hqpKgNG8nZU8pQBR0zcMJQoa157kMMUNcDp/c=;
        b=RGWBJTmklNAy/wk9uYVpNfKWGM9B8Ai/20BQnc+ubPeh5+8cBJwoNtqD0Gvtp8ihmw
         0hfdVSfvGNzsVfH2B1Oyy0YAnxh9rDAfkDtQU22PVP3/EUXS8u6gCJX+7bc9B5MwM6WU
         1XEmMFl0S/k9rgPZ3mx+3nCPM1r2rCoM3lZr6iKNaZqNQLy789kbAQUHNhukyDqjIE4l
         GPa5GCSrr67M1k9ohx9kJ8BxQbDAxpYHFihn3R1iS4vW7yiXGG1r0FzjsozkyfxhJ0K5
         1k0alyHPrjcRe0TYJo9TynMrdea3LREUka/fHxaiZ9/W0ZG5ja4jnhn6Z1ZTrqkneJln
         3c/g==
X-Gm-Message-State: AHQUAub4rW3NoG2vb7CfKBS63VOUdWDYmSdScoZyTIEoGvBNPMvGOw14
        CgP7cDdMoWLWY1ltSpXsMGiycpJWxmY3F91eIYi39g==
X-Google-Smtp-Source: AHgI3IZOCNoBJRDkV+PhsYq3j4GGkxd6kp2abAEWcjIchjALdf7BOLzk6ApdXV6AHc5BBEsuGr9tscBeAlyfqbuOrB0=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr960585ioa.34.1549640758193;
 Fri, 08 Feb 2019 07:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
 <20190208115123.GA19392@kroah.com> <20190208152911.GM23159@phenom.ffwll.local>
In-Reply-To: <20190208152911.GM23159@phenom.ffwll.local>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 8 Feb 2019 16:45:47 +0100
Message-ID: <CAKMK7uE027rMTThQn=OkhBzmT0g0J=j_hoVG7e2hFYFv4=RDgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] component: Add documentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 4:29 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Feb 08, 2019 at 12:51:23PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 08, 2019 at 12:27:56AM +0100, Daniel Vetter wrote:
> > > While typing these I think doing an s/component_master/aggregate/
> > > would be useful:
> > > - it's shorter :-)
> > > - I think component/aggregate is much more meaningful naming than
> > >   component/puppetmaster or something like that. At least to my
> > >   English ear "aggregate" emphasizes much more the "assemble a pile of
> > >   things into something bigger" aspect, and there's not really much
> > >   of a control hierarchy between aggregate and constituing components.
> > >
> > > But that's way more than a quick doc typing exercise ...
> > >
> > > Thanks to Ram for commenting on an initial draft of these docs.
> > >
> > > v2: Review from Rafael:
> > > - git add Documenation/driver-api/component.rst
> > > - lots of polish to the wording + spelling fixes.
> > >
> > > v3: Review from Russell:
> > > - s/framework/helper
> > > - clarify the documentation for component_match_add functions.
> > >
> > > v4: Remove a few superflous "This".
> > >
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: "C, Ramalingam" <ramalingam.c@intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >
> > Thanks for doing this!
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Thanks for reviewing (obviously includes Rafael and Russell too)!
>
> For merging I see two options:
> - All through drm-intel, but will only land in 5.2 because the feature
>   cut-off has already happened for i915. So a bit awkward.
> - Topic branch with the 2 component patches plus the snd-hda/drm-i915
>   patch, so that you/Takashi/drm can pull it in as needed. The drm
>   component doc patch (3/4 in this series) I can pull in later on.
>
> Greg/Takashi, any preferences?

Just realized that for the mei side of this series I need a topic
branch anyway, so topic branch it is. I'll prep that so that CI can
beat on it over the w/e, and we can rebase the i915/mei series on top,
and then send out the topic pull to everyone early next week. You can
then all decide whether you need it or not.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
