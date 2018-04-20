Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754016AbeDTHb0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:31:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44604 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbeDTHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:31:24 -0400
X-Google-Smtp-Source: AIpwx4+KUwTcWmyXIKtj2ve2Q8GnjmvMcJfsXbRJU3cgvAF2V1zxFCnPDF0iwm5ClUd5f3pE0nQQIA==
Date: Fri, 20 Apr 2018 09:31:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 3/4] drm/tegra: plane: Add custom colorkey properties
 for older Tegra's
Message-ID: <20180420073119.GJ31310@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <cover.1523880381.git.digetx@gmail.com>
 <d78f7339de922d6a8114c73f0919534f4195f572.1523880381.git.digetx@gmail.com>
 <20180417090040.GY31310@phenom.ffwll.local>
 <6ff89658-28e4-fa9f-173d-4e9a885a7962@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff89658-28e4-fa9f-173d-4e9a885a7962@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 08:08:27PM +0300, Dmitry Osipenko wrote:
> On 17.04.2018 12:00, Daniel Vetter wrote:
> > On Mon, Apr 16, 2018 at 03:16:27PM +0300, Dmitry Osipenko wrote:
> >> Colorkey'ing allows to draw on top of overlapping planes, like for example
> >> on top of a video plane. Older Tegra's have a limited colorkey'ing
> >> capability such that blending features are reduced when colorkey'ing is
> >> enabled. In particular dependent weighting isn't possible, meaning that
> >> cursors plane can't be displayed properly. In most cases it is more useful
> >> to display content on top of video overlay, sacrificing mouse cursor
> >> in the area of three planes intersection with colorkey mismatch. This
> >> patch adds a custom colorkey properties to primary plane and CRTC's of
> >> older Tegra's, allowing userspace like Opentegra Xorg driver to implement
> >> colorkey support for XVideo extension.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > 
> > Since this is your own uapi, where's the userspace per
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> 
> Userspace patches for colorkey and CSC utilization are in my personal github
> repos for now [0][1]. The longterm plan is to get Opentegra driver / libdrm bits
> of [2] to repos on freedesktop.org, which should be considered as upstream. We
> have everything depending on libdrm-tegra and it is currently on hold because of
> upcoming massive rework of Tegra DRM UAPI with further de-staging of jobs
> submission UAPI, that reworking should start with 4.18 kernel.
> 
> For now I wanted to get initial input on the patches. Once everyone is in
> agreement, I'd like to have colorkey / CSC supported by the upstream DRM driver,
> so that at least grate-driver projects could utilize them right now.
> 
> > And why wo we need a tegra-private colorkey property here? I thought
> > other's have been discussing this in the context of other drivers.
> 
> At least older Tegra's have limitations in regards to colorkey, like planes
> blending capabilities are reduced a lot when colorkey'ing is enabled. I'm not
> sure whether we'd want to have it as a generic property, because generic
> userspace should be aware of those limitations, otherwise there is a good chance
> to get undesirable result using colorkey. Though I'm not really sure how widely
> colorkey property could be utilize by userspace and what kind of applications
> that userspace could have for it, maybe having colorkey as a generic property
> would be good enough after all.
> 
> I've looked up the DRI ML archive and seems the most recent colorkey-related
> patches are [3]. These patches are a bit odd to me because by generic property I
> assume a property that is HW-agnostic and the patchset does opposite to it.
> Maybe I'm misunderstanding what is meant by 'generic' property then? Anyway I've
> applied [3] and made Tegra to use that generic property, it works fine. I'll be
> happy to switch to a generic property if we'll consider that it is a viable way.
> 
> [0] https://github.com/digetx/xf86-video-opentegra/commits/ckey
> [1] https://github.com/digetx/libvdpau-tegra/commits/ckey
> [2] https://github.com/grate-driver
> [3] https://patchwork.kernel.org/patch/10117593/

Yes that's the patches I meant, thanks for surfacing them.

Please work together with Laurent, Maxime and Boris on this (jump on that
thread and Cc them on your own patches for the next round). And pls also
work together on a common userspace for this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
