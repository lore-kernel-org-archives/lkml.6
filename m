Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeBQKiX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:38:23 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40193 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBQKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:38:22 -0500
Date: Sat, 17 Feb 2018 11:38:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>, linux-kernel@vger.kernel.org,
        Ismo Toijala <ismo.toijala@gmail.com>, intel-gfx@lists.freedesktop.org,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Archit Taneja <architt@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180217103819.GA23706@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518338788.git.lukas@wunner.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
>   workqueue: Allow retrieval of current task's work struct
>   drm: Allow determining if current task is output poll worker
>   drm/nouveau: Fix deadlock on runtime suspend
>   drm/radeon: Fix deadlock on runtime suspend
>   drm/amdgpu: Fix deadlock on runtime suspend

Pushed to drm-misc-fixes, thanks a lot everyone for the acks,
reviews, testing and comments.

drm-misc maintainers, heads-up:

drm-misc-fixes is still based on 4.15-rc8.  The present series
applies cleanly to both 4.15 and 4.16, so I had no need to have
4.16-rc1 backmerged, but that may be necessary sooner or later.
I did a local test pull into drm-fixes, the shortlog looked sane
and it merged and compiled cleanly.

Please note two other commits are still pending in drm-misc-fixes:

    commit 745fd50f3b044db6a3922e1718306555613164b0
    Author: Daniel Vetter <daniel.vetter@ffwll.ch>
    Date:   Wed Jan 31 12:04:50 2018 +0100

    drm/cirrus: Load lut in crtc_commit

Gustavo sent a pull request for this one on Jan 31 but erroneously
based it on the wrong commit and it ended up not being pulled by Dave.

    commit 54f809cfbd6b4a43959039f5d33596ed3297ce16
    Author: Leo (Sunpeng) Li <sunpeng.li@amd.com>
    Date:   Wed Jan 17 12:51:08 2018 +0100

    drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits

This one has already been pulled by Dave into drm-next for 4.17
as commit 1c6ceeee6ebb but Maarten subsequently cherry-picked
it onto drm-misc-fixes.

Let me know if I've made any mistakes.

Thanks,

Lukas
