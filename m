Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeCSNyE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:54:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55001 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbeCSNxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:53:55 -0400
X-Google-Smtp-Source: AG47ELtWkd2ahJl3fKN9FMzGNnvtcgnntqvQoBg6RRdHTJ230yygK68qcDegtaHNL/sc+BafzKZeCg==
Date: Mon, 19 Mar 2018 14:53:51 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Joe Perches <joe@perches.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
Message-ID: <20180319135351.GL14155@phenom.ffwll.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
 <20180316074150.GE25297@phenom.ffwll.local>
 <1521203342.6119.5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521203342.6119.5.camel@perches.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 05:29:02AM -0700, Joe Perches wrote:
> On Fri, 2018-03-16 at 08:41 +0100, Daniel Vetter wrote:
> > On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
> > > drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> > > arguments that can be removed by creating separate functins.
> > > 
> > > Create specific functions for these calls to reduce x86/64 defconfig
> > > size by ~20k.
> > > 
> > > Modify the existing macros to use the specific calls.
> > > 
> > > new:
> > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> > > 
> > > old:
> > > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > > 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
> > > 
> > > Miscellanea:
> > > 
> > > o intel_display requires a change to use the specific calls.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Impressed with the size of the bikeshed piled on top of this I decided to
> > cut this all short by merging it.
> 
> Thanks.
> 
> There was a similar patch for the DRM_DEV_ macros
> awhile ago that also reduced object code.
> 
> https://lkml.org/lkml/2017/9/25/247
> 
> Never applied.
> 
> Want a remerge resend?

Yeah dropped out of my inbox, resending is easier. Please do so.

In case you wonder, I try to fairly intentionally drop stuff on the floor,
to force other people on dri-devel to not load everything onto me, making
me a bottleneck. But then occasionally a patch drops through all nets
because tracking mailing lists is impossible :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
