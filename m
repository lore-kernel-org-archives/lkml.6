Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeBWQtE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:49:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58250 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeBWQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:49:01 -0500
Date: Fri, 23 Feb 2018 16:48:58 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Sean Paul <seanpaul@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/4] drm: Add writeback connector type
Message-ID: <20180223164858.GY9111@e110455-lin.cambridge.arm.com>
References: <20180223131758.18362-1-robdclark@gmail.com>
 <20180223131758.18362-2-robdclark@gmail.com>
 <20180223155935.GJ223881@art_vandelay>
 <CAF6AEGs3EHxzwW4MaYc+LXmKL3amD8pUysamrprPy-F-W8=6AQ@mail.gmail.com>
 <20180223164329.GO223881@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223164329.GO223881@art_vandelay>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:43:29AM -0500, Sean Paul wrote:
> On Fri, Feb 23, 2018 at 11:25:11AM -0500, Rob Clark wrote:
> > On Fri, Feb 23, 2018 at 10:59 AM, Sean Paul <seanpaul@chromium.org> wrote:
> > >
> > > Have we considered hiding writeback behind a client cap instead?
> > 
> > It is kinda *almost* unneeded, since the connector reports itself as
> > disconnected.
> > 
> > I'm not sure what the reason was to drop the cap, but I think it would
> > be better to have a cap so WB connectors don't show up in, for ex,
> > xrandr
> 
> Yeah, the disconnected hack is kind of gross, IMO. I hate to introduce churn in
> the patch series given that it was initially introduced with the client cap.

Haha, that's the reverse of Daniel's position:

https://lists.freedesktop.org/archives/dri-devel/2016-October/120519.html

> 
> There are also cases where we might want to make writeback unavailable, such as
> when content protection is enabled. In those cases, it's conceivable that we
> might want to use disconnected as a signal to u/s. I suppose we could also just
> fail the check, so most of this is just academic.

Not sure what other hardware out there does, but on Mali DP's case you
would be outputing the protected content by putting the display
processor in secure mode, which automatically disables writeback for us.
Or to put in another way, you don't need a writeback framebuffer if you
are in non-secure mode as you can get access to the framebuffer used for
the plane anyway.

Best regards,
Liviu

> 
> Sean
> 
> 
> > 
> > BR,
> > -R
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
