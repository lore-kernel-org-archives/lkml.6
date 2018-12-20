Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB727C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FA421720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UzwIGU8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeLTQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:54:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51717 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbeLTQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:54:18 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so2987449ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXR3JQ3Ph3O9cSwqTB20o7XXTHCPBFWIVotuqZySN6s=;
        b=UzwIGU8ug0Q0Z/yPPclz3KbaOyLCux3zA4IRZOkDWg/PVf9xhqQA/9T3hdg4MtL6sL
         qrfrpLR8DvMqTvrDOQVcqQz2nK3kxIPShxBEx+qONW5WqKq2hkFlhDif7SE3+7Y6Wv99
         aAOX4z90DY2IPYEr0h4qlnmqXWfKjOfuKmh+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXR3JQ3Ph3O9cSwqTB20o7XXTHCPBFWIVotuqZySN6s=;
        b=a4MOHonvp5TvcGoS+bdpZE7Nl6GUF6dk/bRctV247QZuMQGs7Sly7yLAd870/7Dhfv
         2lFg0CG7Veynyeac8p51NDQy3tKUhwm9i/LJpzLjU27KWjs6vS6oGx4f/mlS6edAqRQ0
         +kAE+wotfVlmRz6/5NR2Q3hO9QeNatCfA4vd2BjORj+zqwU6lJ27YnEnu0g+1cMvUt56
         4irzmAOuwEz5a1hnk8OoQ5s46+1a1ohGM18M2nuzqWhsHQoQOzMkb8pIgpU7hwhhD6pW
         TtSTSKc/wGFpv8w1YMKozNlu+5E3grWd+Xj/vnE6hPdmiNejIejnYL/ywqT1Bx6haSpp
         WBkw==
X-Gm-Message-State: AA+aEWbxUIvu/NCd6mZvbjBj/6WqRPVzj7EKQTdoPLK4NTJ43S2THzH/
        PpNKc3wG9rbJ2HmCgYS1UiujoX27c1qtluvDod7GuA==
X-Google-Smtp-Source: AFSGD/Vupk264Tvi1bKCXWfKYFNbvR17HWUDxv/j3e52vNMidtbkbe9Mon1aCkqYFKE0tt/pXpeStnscbE+6c5ZWa54=
X-Received: by 2002:a24:6115:: with SMTP id s21mr10768841itc.62.1545324856332;
 Thu, 20 Dec 2018 08:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com> <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com> <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
In-Reply-To: <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Dec 2018 17:54:04 +0100
Message-ID: <CAKMK7uHu5XMQzr7ocVEcpDS9H6pQ-BHfHNE51_YK7rLkTQC_9g@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Tomasz Figa <tfiga@chromium.org>, dnicoara@chromium.org,
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

On Thu, Dec 20, 2018 at 5:40 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> + Nicholas
>
> On Thu, Dec 20, 2018 at 5:47 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Dec 20, 2018 at 10:07 AM Tomasz Figa <tfiga@chromium.org> wrote=
:
> > >
> > > Hi Helen,
> > >
> > > On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.c=
om> wrote:
> > > >
> > > > Hi Tomasz,
> > > >
> > > > On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > > > > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora=
.com> wrote:
> > > > >>
> > > > >> Hi Ville
> > > > >>
> > > > >> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > > >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> > > > >>>> Allow userspace to identify if the driver supports async updat=
e.
> > > > >>>
> > > > >>> And what exactly is an "async update"?
> > > > >>
> > > > >> I agree we are lacking docs on this, I'll send in the next versi=
on as
> > > > >> soon as we agree on a name (please see below).
> > > > >>
> > > > >> For reference:
> > > > >> https://lists.freedesktop.org/archives/dri-devel/2017-April/1385=
86.html
> > > > >>
> > > > >>>
> > > > >>> I keep asking people to come up with the a better name for this=
, and to
> > > > >>> document what it actually means. Recently I've been think we sh=
ould
> > > > >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox=
) to
> > > > >>> avoid introducing yet another set of names for the same thing. =
We'd
> > > > >>> still want to document things properly though.
> > > > >>
> > > > >> Another name it was suggested was "atomic amend", this feature b=
asically
> > > > >> allows userspace to complement an update previously sent (i.e. i=
ts in
> > > > >> the queue and wasn't commited yet), it allows adding a plane upd=
ate to
> > > > >> the next commit. So what do you think in renaming it to "atomic =
amend"?
> > > > >
> > > > > Note that it doesn't seem to be what the code currently is doing.=
 For
> > > > > example, for cursor updates, it doesn't seem to be working on the
> > > > > currently pending commit, but just directly issues an atomic asyn=
c
> > > > > update call to the planes. The code actually seems to fall back t=
o a
> > > > > normal sync commit, if there is an already pending commit touchin=
g the
> > > > > same plane or including a modeset.
> > > >
> > > > It should fail as discussed at:
> > > > https://patchwork.freedesktop.org/patch/243088/
> > > >
> > > > There was the following code inside the drm_atomic_helper_async_che=
ck()
> > > > in the previous patch which would fallback to a normal commit if th=
ere
> > > > isn't any pending commit to amend:
> > > >
> > > > +       if (!old_plane_state->commit)
> > > > +               return -EINVAL;
> > > >
> > > > In the v2 of the patch https://patchwork.freedesktop.org/patch/2637=
12/
> > > > this got removed, but which means that async update will be enabled
> > > > anyway. So the following code is wrong:
> > > >
> > > > -       if (state->legacy_cursor_update)
> > > > +       if (state->async_update || state->legacy_cursor_update)
> > > >                 state->async_update =3D !drm_atomic_helper_async_ch=
eck(dev, state);
> > > >
> > > > Does it make sense? If yes I'll fix this in the next version of the
> > > > Atomic IOCTL patch (and also those two patches should be in the sam=
e
> > > > series, I'll send them together next time).
> > > >
> > > > Thanks for pointing this out.
> > > >
> > > > Please let me know if you still don't agree on the name "atomic ame=
nd",
> > > > or if I am missing something.
> > >
> > > I'll defer it to the DRM maintainers. From Chrome OS perspective, we
> > > need a way to commit the cursor plane asynchronously from other
> > > commits any time the cursor changes its position or framebuffer. As
> > > long as the new API allows that and the maintainers are fine with it,
> > > I think I should be okay with it too.
> >
> > If this is just about the cursor, why is the current legacy cursor
> > ioctl not good enough? It's 2 ioctls instead of one, but I'm not sure
> > if we want to support having a normal atomic commit and a cursor
> > update in the same atomic ioctl, coming up with reasonable semantics
> > for that will be complicated.
> >
> > Pointer to code that uses this would be better ofc.
>
> I haven't followed this thread too closely, but we ended up needing to
> add a fast patch for cursor updates to amdgpu's atomic support to
> avoid stuttering issues.  Other drivers may end up being affected by
> this as well.  See:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D106175
> Unfortunately, the fast path requires some hacks to handle the ref
> counting properly on cursor fbs:
> https://patchwork.freedesktop.org/patch/266138/
> https://patchwork.freedesktop.org/patch/268298/
> It looks like gamma may need similar treatment:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D108917

Can we get these patches cc'ed to dri-devel so that there's some
common solution? Everyone hacking legacy_cursor_update hacks on their
own doesn't really work well. Or would at least give some visibility
into what's all going on.

Not sure about the gamma thing since we had opposite bugs on i915
about gamma not being vsynced and tearing terribly. Cursor is special
since it tends to be too small to notice tearing.

Thanks, Daniel

> Alex
>
>
> > -Daniel
> >
> > > Best regards,
> > > Tomasz
> > >
> > > >
> > > > Helen
> > > >
> > > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > >> Or do you suggest another name? I am not familiar with vulkan te=
rminology.
> > > > >>
> > > > >>
> > > > >> Thanks
> > > > >> Helen
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabor=
a.com>
> > > > >>>> [prepared for upstream]
> > > > >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > > > >>>>
> > > > >>>> ---
> > > > >>>> Hi,
> > > > >>>>
> > > > >>>> This patch introduces the ASYNC_UPDATE cap, which originated f=
rom the
> > > > >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow us=
er to
> > > > >>>> figure that async_update exists.
> > > > >>>>
> > > > >>>> This was tested using a small program that exercises the uAPI =
for easy
> > > > >>>> sanity testing. The program was created by Alexandros and modi=
fied by
> > > > >>>> Enric to test the capability flag [2].
> > > > >>>>
> > > > >>>> The test worked on a rockchip Ficus v1.1 board on top of mainl=
ine plus
> > > > >>>> the patch to update cursors asynchronously through atomic plus=
 the patch
> > > > >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip dri=
ver.
> > > > >>>>
> > > > >>>> To test, just build the program and use the --atomic flag to u=
se the cursor
> > > > >>>> plane with the ATOMIC_AMEND flag. E.g.
> > > > >>>>
> > > > >>>>   drm_cursor --atomic
> > > > >>>>
> > > > >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> > > > >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/=
async-capability
> > > > >>>>
> > > > >>>> Thanks
> > > > >>>> Helen
> > > > >>>>
> > > > >>>>
> > > > >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> > > > >>>>  include/uapi/drm/drm.h      |  1 +
> > > > >>>>  2 files changed, 12 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm=
_ioctl.c
> > > > >>>> index 94bd872d56c4..4a7e0f874171 100644
> > > > >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> @@ -31,6 +31,7 @@
> > > > >>>>  #include <drm/drm_ioctl.h>
> > > > >>>>  #include <drm/drmP.h>
> > > > >>>>  #include <drm/drm_auth.h>
> > > > >>>> +#include <drm/drm_modeset_helper_vtables.h>
> > > > >>>>  #include "drm_legacy.h"
> > > > >>>>  #include "drm_internal.h"
> > > > >>>>  #include "drm_crtc_internal.h"
> > > > >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *d=
ev, void *data, struct drm_file *file_
> > > > >>>>  {
> > > > >>>>      struct drm_get_cap *req =3D data;
> > > > >>>>      struct drm_crtc *crtc;
> > > > >>>> +    struct drm_plane *plane;
> > > > >>>>
> > > > >>>>      req->value =3D 0;
> > > > >>>>
> > > > >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *=
dev, void *data, struct drm_file *file_
> > > > >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> > > > >>>>              req->value =3D 1;
> > > > >>>>              break;
> > > > >>>> +    case DRM_CAP_ASYNC_UPDATE:
> > > > >>>> +            req->value =3D 1;
> > > > >>>> +            list_for_each_entry(plane, &dev->mode_config.plan=
e_list, head) {
> > > > >>>> +                    if (!plane->helper_private->atomic_async_=
update) {
> > > > >>>> +                            req->value =3D 0;
> > > > >>>> +                            break;
> > > > >>>> +                    }
> > > > >>>> +            }
> > > > >>>> +            break;
> > > > >>>>      default:
> > > > >>>>              return -EINVAL;
> > > > >>>>      }
> > > > >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > > >>>> index 300f336633f2..ff01540cbb1d 100644
> > > > >>>> --- a/include/uapi/drm/drm.h
> > > > >>>> +++ b/include/uapi/drm/drm.h
> > > > >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> > > > >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> > > > >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> > > > >>>>  #define DRM_CAP_SYNCOBJ             0x13
> > > > >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> > > > >>>>
> > > > >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> > > > >>>>  struct drm_get_cap {
> > > > >>>> --
> > > > >>>> 2.19.1
> > > > >>>>
> > > > >>>> _______________________________________________
> > > > >>>> dri-devel mailing list
> > > > >>>> dri-devel@lists.freedesktop.org
> > > > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >>>
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

On Thu, Dec 20, 2018 at 5:40 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> + Nicholas
>
> On Thu, Dec 20, 2018 at 5:47 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Dec 20, 2018 at 10:07 AM Tomasz Figa <tfiga@chromium.org> wrote=
:
> > >
> > > Hi Helen,
> > >
> > > On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.c=
om> wrote:
> > > >
> > > > Hi Tomasz,
> > > >
> > > > On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > > > > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora=
.com> wrote:
> > > > >>
> > > > >> Hi Ville
> > > > >>
> > > > >> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > > >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> > > > >>>> Allow userspace to identify if the driver supports async updat=
e.
> > > > >>>
> > > > >>> And what exactly is an "async update"?
> > > > >>
> > > > >> I agree we are lacking docs on this, I'll send in the next versi=
on as
> > > > >> soon as we agree on a name (please see below).
> > > > >>
> > > > >> For reference:
> > > > >> https://lists.freedesktop.org/archives/dri-devel/2017-April/1385=
86.html
> > > > >>
> > > > >>>
> > > > >>> I keep asking people to come up with the a better name for this=
, and to
> > > > >>> document what it actually means. Recently I've been think we sh=
ould
> > > > >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox=
) to
> > > > >>> avoid introducing yet another set of names for the same thing. =
We'd
> > > > >>> still want to document things properly though.
> > > > >>
> > > > >> Another name it was suggested was "atomic amend", this feature b=
asically
> > > > >> allows userspace to complement an update previously sent (i.e. i=
ts in
> > > > >> the queue and wasn't commited yet), it allows adding a plane upd=
ate to
> > > > >> the next commit. So what do you think in renaming it to "atomic =
amend"?
> > > > >
> > > > > Note that it doesn't seem to be what the code currently is doing.=
 For
> > > > > example, for cursor updates, it doesn't seem to be working on the
> > > > > currently pending commit, but just directly issues an atomic asyn=
c
> > > > > update call to the planes. The code actually seems to fall back t=
o a
> > > > > normal sync commit, if there is an already pending commit touchin=
g the
> > > > > same plane or including a modeset.
> > > >
> > > > It should fail as discussed at:
> > > > https://patchwork.freedesktop.org/patch/243088/
> > > >
> > > > There was the following code inside the drm_atomic_helper_async_che=
ck()
> > > > in the previous patch which would fallback to a normal commit if th=
ere
> > > > isn't any pending commit to amend:
> > > >
> > > > +       if (!old_plane_state->commit)
> > > > +               return -EINVAL;
> > > >
> > > > In the v2 of the patch https://patchwork.freedesktop.org/patch/2637=
12/
> > > > this got removed, but which means that async update will be enabled
> > > > anyway. So the following code is wrong:
> > > >
> > > > -       if (state->legacy_cursor_update)
> > > > +       if (state->async_update || state->legacy_cursor_update)
> > > >                 state->async_update =3D !drm_atomic_helper_async_ch=
eck(dev, state);
> > > >
> > > > Does it make sense? If yes I'll fix this in the next version of the
> > > > Atomic IOCTL patch (and also those two patches should be in the sam=
e
> > > > series, I'll send them together next time).
> > > >
> > > > Thanks for pointing this out.
> > > >
> > > > Please let me know if you still don't agree on the name "atomic ame=
nd",
> > > > or if I am missing something.
> > >
> > > I'll defer it to the DRM maintainers. From Chrome OS perspective, we
> > > need a way to commit the cursor plane asynchronously from other
> > > commits any time the cursor changes its position or framebuffer. As
> > > long as the new API allows that and the maintainers are fine with it,
> > > I think I should be okay with it too.
> >
> > If this is just about the cursor, why is the current legacy cursor
> > ioctl not good enough? It's 2 ioctls instead of one, but I'm not sure
> > if we want to support having a normal atomic commit and a cursor
> > update in the same atomic ioctl, coming up with reasonable semantics
> > for that will be complicated.
> >
> > Pointer to code that uses this would be better ofc.
>
> I haven't followed this thread too closely, but we ended up needing to
> add a fast patch for cursor updates to amdgpu's atomic support to
> avoid stuttering issues.  Other drivers may end up being affected by
> this as well.  See:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D106175
> Unfortunately, the fast path requires some hacks to handle the ref
> counting properly on cursor fbs:
> https://patchwork.freedesktop.org/patch/266138/
> https://patchwork.freedesktop.org/patch/268298/
> It looks like gamma may need similar treatment:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D108917
>
> Alex
>
>
> > -Daniel
> >
> > > Best regards,
> > > Tomasz
> > >
> > > >
> > > > Helen
> > > >
> > > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > >> Or do you suggest another name? I am not familiar with vulkan te=
rminology.
> > > > >>
> > > > >>
> > > > >> Thanks
> > > > >> Helen
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabor=
a.com>
> > > > >>>> [prepared for upstream]
> > > > >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > > > >>>>
> > > > >>>> ---
> > > > >>>> Hi,
> > > > >>>>
> > > > >>>> This patch introduces the ASYNC_UPDATE cap, which originated f=
rom the
> > > > >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow us=
er to
> > > > >>>> figure that async_update exists.
> > > > >>>>
> > > > >>>> This was tested using a small program that exercises the uAPI =
for easy
> > > > >>>> sanity testing. The program was created by Alexandros and modi=
fied by
> > > > >>>> Enric to test the capability flag [2].
> > > > >>>>
> > > > >>>> The test worked on a rockchip Ficus v1.1 board on top of mainl=
ine plus
> > > > >>>> the patch to update cursors asynchronously through atomic plus=
 the patch
> > > > >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip dri=
ver.
> > > > >>>>
> > > > >>>> To test, just build the program and use the --atomic flag to u=
se the cursor
> > > > >>>> plane with the ATOMIC_AMEND flag. E.g.
> > > > >>>>
> > > > >>>>   drm_cursor --atomic
> > > > >>>>
> > > > >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> > > > >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/=
async-capability
> > > > >>>>
> > > > >>>> Thanks
> > > > >>>> Helen
> > > > >>>>
> > > > >>>>
> > > > >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> > > > >>>>  include/uapi/drm/drm.h      |  1 +
> > > > >>>>  2 files changed, 12 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm=
_ioctl.c
> > > > >>>> index 94bd872d56c4..4a7e0f874171 100644
> > > > >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> @@ -31,6 +31,7 @@
> > > > >>>>  #include <drm/drm_ioctl.h>
> > > > >>>>  #include <drm/drmP.h>
> > > > >>>>  #include <drm/drm_auth.h>
> > > > >>>> +#include <drm/drm_modeset_helper_vtables.h>
> > > > >>>>  #include "drm_legacy.h"
> > > > >>>>  #include "drm_internal.h"
> > > > >>>>  #include "drm_crtc_internal.h"
> > > > >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *d=
ev, void *data, struct drm_file *file_
> > > > >>>>  {
> > > > >>>>      struct drm_get_cap *req =3D data;
> > > > >>>>      struct drm_crtc *crtc;
> > > > >>>> +    struct drm_plane *plane;
> > > > >>>>
> > > > >>>>      req->value =3D 0;
> > > > >>>>
> > > > >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *=
dev, void *data, struct drm_file *file_
> > > > >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> > > > >>>>              req->value =3D 1;
> > > > >>>>              break;
> > > > >>>> +    case DRM_CAP_ASYNC_UPDATE:
> > > > >>>> +            req->value =3D 1;
> > > > >>>> +            list_for_each_entry(plane, &dev->mode_config.plan=
e_list, head) {
> > > > >>>> +                    if (!plane->helper_private->atomic_async_=
update) {
> > > > >>>> +                            req->value =3D 0;
> > > > >>>> +                            break;
> > > > >>>> +                    }
> > > > >>>> +            }
> > > > >>>> +            break;
> > > > >>>>      default:
> > > > >>>>              return -EINVAL;
> > > > >>>>      }
> > > > >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > > >>>> index 300f336633f2..ff01540cbb1d 100644
> > > > >>>> --- a/include/uapi/drm/drm.h
> > > > >>>> +++ b/include/uapi/drm/drm.h
> > > > >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> > > > >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> > > > >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> > > > >>>>  #define DRM_CAP_SYNCOBJ             0x13
> > > > >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> > > > >>>>
> > > > >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> > > > >>>>  struct drm_get_cap {
> > > > >>>> --
> > > > >>>> 2.19.1
> > > > >>>>
> > > > >>>> _______________________________________________
> > > > >>>> dri-devel mailing list
> > > > >>>> dri-devel@lists.freedesktop.org
> > > > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >>>
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
