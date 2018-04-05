Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDENt2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:49:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50796 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDENt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:49:27 -0400
X-Google-Smtp-Source: AIpwx49Q0Ejih6Ygxz6o98Bh9nMhg+QcbzZij42G5T1OCyV1qsBcVxb/RHsHU65diweNwIe0UTpw3w==
Date: Thu, 5 Apr 2018 15:49:23 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Message-ID: <20180405134923.GX3881@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
 <b87e222a-610e-05de-3ba2-7261831af5ec@vmware.com>
 <20180405100319.GT3881@phenom.ffwll.local>
 <b699fce8-4c76-c997-f989-7406cc3d4c92@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b699fce8-4c76-c997-f989-7406cc3d4c92@vmware.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 01:42:11PM +0200, Thomas Hellstrom wrote:
> On 04/05/2018 12:03 PM, Daniel Vetter wrote:
> > 
> > On the topic of input validation: Should the kernel check in shared code
> > that all the clip rects are sensible, i.e. within the dimensions of the
> > fb? Relying on drivers for that seems like a bad idea.
> 
> I guess we could do that.
> 
> There seems to be different needs for different kinds of iterators, but
> otherwise
> I was thinking that an iterator could just skip invalid rects if found. Then
> we
> don't need a separate validation step, but OTOH user-space won't get
> notified if
> that was intended.
> 
> I'm not 100% sure user-space would do anything sensible with any error
> information, though.

Fix userspace, and ime letting userspace get away with improper uapi usage
is a path full of regrets. That's why I'm advising that we check any
unused field for 0, and any unused bits also. Plus anything else that
userspace could get wrong. Because if it's not checked, someone will get
it wrong, and then we have to keep it working forever.
-Daniel

> 
> /Thomas
> 
> 
> > 
> > That could be done in core code in drm_atomic_plane_check().
> > -Daniel
> > > /Thomas
> > > 
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.freedesktop.org_mailman_listinfo_dri-2Ddevel&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=JV7fhQ4zTiyiKsY8M0Zlf81l7szYePUke8kwSvQv1T8&s=HEcbr-8aoWqRvWGY6RcL1QeAtEyxMRLHbsOtdJFk78I&e=
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
