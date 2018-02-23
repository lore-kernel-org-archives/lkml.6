Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBWQng (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:43:36 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33054 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeBWQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:43:31 -0500
X-Google-Smtp-Source: AG47ELsz8NAlC+kp4vFN7VL/aFWSITNigatwx69pez5dW0zoOrw+34N+tA4psDs4A94g1MMZto3eqQ==
Date: Fri, 23 Feb 2018 11:43:29 -0500
From: Sean Paul <seanpaul@chromium.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/4] drm: Add writeback connector type
Message-ID: <20180223164329.GO223881@art_vandelay>
References: <20180223131758.18362-1-robdclark@gmail.com>
 <20180223131758.18362-2-robdclark@gmail.com>
 <20180223155935.GJ223881@art_vandelay>
 <CAF6AEGs3EHxzwW4MaYc+LXmKL3amD8pUysamrprPy-F-W8=6AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGs3EHxzwW4MaYc+LXmKL3amD8pUysamrprPy-F-W8=6AQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:25:11AM -0500, Rob Clark wrote:
> On Fri, Feb 23, 2018 at 10:59 AM, Sean Paul <seanpaul@chromium.org> wrote:
> >
> > Have we considered hiding writeback behind a client cap instead?
> 
> It is kinda *almost* unneeded, since the connector reports itself as
> disconnected.
> 
> I'm not sure what the reason was to drop the cap, but I think it would
> be better to have a cap so WB connectors don't show up in, for ex,
> xrandr

Yeah, the disconnected hack is kind of gross, IMO. I hate to introduce churn in
the patch series given that it was initially introduced with the client cap.

There are also cases where we might want to make writeback unavailable, such as
when content protection is enabled. In those cases, it's conceivable that we
might want to use disconnected as a signal to u/s. I suppose we could also just
fail the check, so most of this is just academic.

Sean


> 
> BR,
> -R

-- 
Sean Paul, Software Engineer, Google / Chromium OS
