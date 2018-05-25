Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeEYGuo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:50:44 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:40634 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751791AbeEYGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:50:42 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 
X-HE-Tag: fight46_532e0d2cc445
X-Filterd-Recvd-Size: 4183
Message-ID: <2108eb98b35ab682d44ca7bf40276e93d9566bbf.camel@perches.com>
Subject: Re: [PATCH] gpu: Consistently use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Roger He <Hongbo.He@amd.com>, Dave Airlie <airlied@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org
Date: Thu, 24 May 2018 23:50:34 -0700
In-Reply-To: <87a7so44q5.fsf@intel.com>
References: <9b0f5f5cf6bccc003beef82f0972be655613075d.1527193246.git.joe@perches.com>
         <87a7so44q5.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 09:41 +0300, Jani Nikula wrote:
> On Thu, 24 May 2018, Joe Perches <joe@perches.com> wrote:
> > There is currently a mixture of octal and symbolic permissions uses
> > in files in drivers/gpu/drm and one file in drivers/gpu.
> > 
> > There are ~270 existing octal uses and ~115 S_<FOO> uses.
> > 
> > Convert all the S_<FOO> symbolic permissions to their octal equivalents
> > as using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> > 
> > Done with automated conversion via:
> > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> > 
> > Miscellanea:
> > 
> > o Wrapped modified multi-line calls to a single line where appropriate
> > o Realign modified multi-line calls to open parenthesis
> > o drivers/gpu/drm/msm/adreno/a5xx_debugfs.c has a world-writeable
> >   debug permission for "reset" - perhaps that should be modified
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 98 +++++++++++-----------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  9 +-
> >  drivers/gpu/drm/armada/armada_debugfs.c            |  4 +-
> >  drivers/gpu/drm/drm_debugfs.c                      |  6 +-
> >  drivers/gpu/drm/drm_debugfs_crc.c                  |  4 +-
> >  drivers/gpu/drm/drm_sysfs.c                        |  2 +-
> >  drivers/gpu/drm/i915/gvt/firmware.c                |  2 +-
> >  drivers/gpu/drm/i915/i915_debugfs.c                |  8 +-
> >  drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
> >  drivers/gpu/drm/i915/i915_sysfs.c                  | 22 ++---
> >  drivers/gpu/drm/i915/intel_pipe_crc.c              |  2 +-
> 
> Please send at least i915 changes separately. There's zero reason to
> make our lives harder for this change.

The idea is to avoid unnecessary multiple patches for
individual trees.

But you could do that via something like:

$ git am --include='drivers/gpu/drm/i915/*' <patch>

cheers, Joe
