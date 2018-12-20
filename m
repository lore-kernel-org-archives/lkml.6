Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D335C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFF0217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4n1Ydpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeLTQks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:40:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54532 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbeLTQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:40:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2716125wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HjEOoPY3Y9phlyptMc8r8w43+coYeRzwkS3rfQNdtWE=;
        b=s4n1Ydpt11iIEFx/C6EzrPLpYfEmiFQNsVd7hIXgxKA8N3g5PYth7xGC/L6CX3p+Gj
         fLU+ITYTlqn0n+rb+mUOGdN3oZyox+l4AbTL6t2ZfPDZbzr8CgMiaC+Vm1uPlnsCrdCj
         rz1Fr+ze+MyO295bsQ9kLBBHA38wtnlBnrddYOV8iPZFEXRagvM00jX9nRJM8riEBu/5
         8meZGsdA/bsQM0DmsK6qJB8MBagZnfXCyMOimjd0VMTY/k8y+XSz25yduqb33LIDyN+4
         s2YhBXe7EeRPczep+bSlvzE9o1FtkI0gRS2FBaNMK+w0maGKQn2fy6Z8Tr0erYnRMcHr
         HatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HjEOoPY3Y9phlyptMc8r8w43+coYeRzwkS3rfQNdtWE=;
        b=MxzP4GoDC3Jm9DGMcy58EFK4Pzl2ccyeoD1aFmfcPjrP+OR7+eaUV6fo8xsM/ezk46
         4xc/Yj3BYdvyW6/rHSkdRJ8u4EMgYgwTq9XTgUC5KaYIkXlR6agJReK3CEXKMKUn6gnl
         WBjcjDxufgRvrt6iEsJzZEUPtrIgVzE8OBN3IiOg+Z1G8vIVy7ia8UgWuNq3TsVqgaEE
         3YfRbnOn7nVF8WrCsrEcYGDu1CJOhM9+YtWfTLknZ7QCsGsDwewyn2CxQboBo0USQwwh
         if+aUGWVVgLo/gfqDCBaOFGHefe6VqkOLyVKzpcVr80XHzXLM6CQQFIf+3tZz96dbR8o
         98pA==
X-Gm-Message-State: AA+aEWbFdbJ6GHbih9mQYUGCc28lzTCLBOH+gOuMiBiQX2cQi07Fk07S
        vLAs4bqUT93AWGF+roYB1L6Du7nM1CUrba0QHGA=
X-Google-Smtp-Source: AFSGD/XcMUEVRfixW18y2iBu/FB7l9KDq85pomCAvZFQUuKIwoE/msZU1o3eFficjDXBiTEyt59Nnr9yCGQR0PUj0L8=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr11583718wmm.116.1545324045688;
 Thu, 20 Dec 2018 08:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com> <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
In-Reply-To: <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Dec 2018 11:40:33 -0500
Message-ID: <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     Daniel Vetter <daniel@ffwll.ch>, nicholas.kazlauskas@amd.com
Cc:     Tomasz Figa <tfiga@chromium.org>, dnicoara@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Nicholas

On Thu, Dec 20, 2018 at 5:47 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Dec 20, 2018 at 10:07 AM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > Hi Helen,
> >
> > On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.com=
> wrote:
> > >
> > > Hi Tomasz,
> > >
> > > On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > > > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora.c=
om> wrote:
> > > >>
> > > >> Hi Ville
> > > >>
> > > >> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> > > >>>> Allow userspace to identify if the driver supports async update.
> > > >>>
> > > >>> And what exactly is an "async update"?
> > > >>
> > > >> I agree we are lacking docs on this, I'll send in the next version=
 as
> > > >> soon as we agree on a name (please see below).
> > > >>
> > > >> For reference:
> > > >> https://lists.freedesktop.org/archives/dri-devel/2017-April/138586=
.html
> > > >>
> > > >>>
> > > >>> I keep asking people to come up with the a better name for this, =
and to
> > > >>> document what it actually means. Recently I've been think we shou=
ld
> > > >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox) =
to
> > > >>> avoid introducing yet another set of names for the same thing. We=
'd
> > > >>> still want to document things properly though.
> > > >>
> > > >> Another name it was suggested was "atomic amend", this feature bas=
ically
> > > >> allows userspace to complement an update previously sent (i.e. its=
 in
> > > >> the queue and wasn't commited yet), it allows adding a plane updat=
e to
> > > >> the next commit. So what do you think in renaming it to "atomic am=
end"?
> > > >
> > > > Note that it doesn't seem to be what the code currently is doing. F=
or
> > > > example, for cursor updates, it doesn't seem to be working on the
> > > > currently pending commit, but just directly issues an atomic async
> > > > update call to the planes. The code actually seems to fall back to =
a
> > > > normal sync commit, if there is an already pending commit touching =
the
> > > > same plane or including a modeset.
> > >
> > > It should fail as discussed at:
> > > https://patchwork.freedesktop.org/patch/243088/
> > >
> > > There was the following code inside the drm_atomic_helper_async_check=
()
> > > in the previous patch which would fallback to a normal commit if ther=
e
> > > isn't any pending commit to amend:
> > >
> > > +       if (!old_plane_state->commit)
> > > +               return -EINVAL;
> > >
> > > In the v2 of the patch https://patchwork.freedesktop.org/patch/263712=
/
> > > this got removed, but which means that async update will be enabled
> > > anyway. So the following code is wrong:
> > >
> > > -       if (state->legacy_cursor_update)
> > > +       if (state->async_update || state->legacy_cursor_update)
> > >                 state->async_update =3D !drm_atomic_helper_async_chec=
k(dev, state);
> > >
> > > Does it make sense? If yes I'll fix this in the next version of the
> > > Atomic IOCTL patch (and also those two patches should be in the same
> > > series, I'll send them together next time).
> > >
> > > Thanks for pointing this out.
> > >
> > > Please let me know if you still don't agree on the name "atomic amend=
",
> > > or if I am missing something.
> >
> > I'll defer it to the DRM maintainers. From Chrome OS perspective, we
> > need a way to commit the cursor plane asynchronously from other
> > commits any time the cursor changes its position or framebuffer. As
> > long as the new API allows that and the maintainers are fine with it,
> > I think I should be okay with it too.
>
> If this is just about the cursor, why is the current legacy cursor
> ioctl not good enough? It's 2 ioctls instead of one, but I'm not sure
> if we want to support having a normal atomic commit and a cursor
> update in the same atomic ioctl, coming up with reasonable semantics
> for that will be complicated.
>
> Pointer to code that uses this would be better ofc.

I haven't followed this thread too closely, but we ended up needing to
add a fast patch for cursor updates to amdgpu's atomic support to
avoid stuttering issues.  Other drivers may end up being affected by
this as well.  See:
https://bugs.freedesktop.org/show_bug.cgi?id=3D106175
Unfortunately, the fast path requires some hacks to handle the ref
counting properly on cursor fbs:
https://patchwork.freedesktop.org/patch/266138/
https://patchwork.freedesktop.org/patch/268298/
It looks like gamma may need similar treatment:
https://bugs.freedesktop.org/show_bug.cgi?id=3D108917

Alex


> -Daniel
>
> > Best regards,
> > Tomasz
> >
> > >
> > > Helen
> > >
> > > >
> > > > Best regards,
> > > > Tomasz
> > > >
> > > >> Or do you suggest another name? I am not familiar with vulkan term=
inology.
> > > >>
> > > >>
> > > >> Thanks
> > > >> Helen
> > > >>
> > > >>>
> > > >>>>
> > > >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.=
com>
> > > >>>> [prepared for upstream]
> > > >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > > >>>>
> > > >>>> ---
> > > >>>> Hi,
> > > >>>>
> > > >>>> This patch introduces the ASYNC_UPDATE cap, which originated fro=
m the
> > > >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user=
 to
> > > >>>> figure that async_update exists.
> > > >>>>
> > > >>>> This was tested using a small program that exercises the uAPI fo=
r easy
> > > >>>> sanity testing. The program was created by Alexandros and modifi=
ed by
> > > >>>> Enric to test the capability flag [2].
> > > >>>>
> > > >>>> The test worked on a rockchip Ficus v1.1 board on top of mainlin=
e plus
> > > >>>> the patch to update cursors asynchronously through atomic plus t=
he patch
> > > >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip drive=
r.
> > > >>>>
> > > >>>> To test, just build the program and use the --atomic flag to use=
 the cursor
> > > >>>> plane with the ATOMIC_AMEND flag. E.g.
> > > >>>>
> > > >>>>   drm_cursor --atomic
> > > >>>>
> > > >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> > > >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/as=
ync-capability
> > > >>>>
> > > >>>> Thanks
> > > >>>> Helen
> > > >>>>
> > > >>>>
> > > >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> > > >>>>  include/uapi/drm/drm.h      |  1 +
> > > >>>>  2 files changed, 12 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_i=
octl.c
> > > >>>> index 94bd872d56c4..4a7e0f874171 100644
> > > >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> > > >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> > > >>>> @@ -31,6 +31,7 @@
> > > >>>>  #include <drm/drm_ioctl.h>
> > > >>>>  #include <drm/drmP.h>
> > > >>>>  #include <drm/drm_auth.h>
> > > >>>> +#include <drm/drm_modeset_helper_vtables.h>
> > > >>>>  #include "drm_legacy.h"
> > > >>>>  #include "drm_internal.h"
> > > >>>>  #include "drm_crtc_internal.h"
> > > >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev=
, void *data, struct drm_file *file_
> > > >>>>  {
> > > >>>>      struct drm_get_cap *req =3D data;
> > > >>>>      struct drm_crtc *crtc;
> > > >>>> +    struct drm_plane *plane;
> > > >>>>
> > > >>>>      req->value =3D 0;
> > > >>>>
> > > >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *de=
v, void *data, struct drm_file *file_
> > > >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> > > >>>>              req->value =3D 1;
> > > >>>>              break;
> > > >>>> +    case DRM_CAP_ASYNC_UPDATE:
> > > >>>> +            req->value =3D 1;
> > > >>>> +            list_for_each_entry(plane, &dev->mode_config.plane_=
list, head) {
> > > >>>> +                    if (!plane->helper_private->atomic_async_up=
date) {
> > > >>>> +                            req->value =3D 0;
> > > >>>> +                            break;
> > > >>>> +                    }
> > > >>>> +            }
> > > >>>> +            break;
> > > >>>>      default:
> > > >>>>              return -EINVAL;
> > > >>>>      }
> > > >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > >>>> index 300f336633f2..ff01540cbb1d 100644
> > > >>>> --- a/include/uapi/drm/drm.h
> > > >>>> +++ b/include/uapi/drm/drm.h
> > > >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> > > >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> > > >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> > > >>>>  #define DRM_CAP_SYNCOBJ             0x13
> > > >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> > > >>>>
> > > >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> > > >>>>  struct drm_get_cap {
> > > >>>> --
> > > >>>> 2.19.1
> > > >>>>
> > > >>>> _______________________________________________
> > > >>>> dri-devel mailing list
> > > >>>> dri-devel@lists.freedesktop.org
> > > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >>>
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
