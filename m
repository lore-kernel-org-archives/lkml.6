Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4D2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ArA9hoJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeLTKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:47:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43334 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLTKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:47:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so1175095otr.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AyGiN0vy6KSZA/IIpK8RBlCp7bOX8sj0zolkNqjxi10=;
        b=ArA9hoJWj2hHVk6fGyr79WZy/1m6jEEg4krotqge6MkoLkgoZhV/GSoryp0AdyZz81
         6l1+PW6owi+C8UkYnMIaPqXo91jYNhb8WwkuYpRVoIfXxx0ZTOURv9jDlewLLBKrReAm
         AqDKMkcpJanI+cx23GuNa023HJ1BwqRtQBNh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AyGiN0vy6KSZA/IIpK8RBlCp7bOX8sj0zolkNqjxi10=;
        b=nFEmRY/nKUYlUhKTHKQww+v7mpOVLnhckoMhICHicykncU0CuwbfoEFHWni5uC6asp
         HlHps0Ytp37/bAGyXDvJFaORIQ5RHqeZwtLy45kO6Tf4NFefq5xIHP+Oi9vLKeWTOYla
         0qZ2i2DyV7S6K6d8aGLpAK7hSohma2XMHRAdt28d0vV8Iq2N2J2rHYsvYVEbMDeaY57y
         W0MQAXZmKgloMz/ncBDgi0ia9vgfH78HVmt1M0ecv6vj3z8YDCvZMUAylIOM2oxwpQGA
         gLMiOALJIoCNJvLEwXVTGntwA0sgS4NaZ/f5qAujWn+KSygNOmRbZL4apdWW2XsEym8N
         ND+Q==
X-Gm-Message-State: AA+aEWa2iWVmKsIBt7KYfaLDca6J1efUl5xMDYtdamrLGjMmj5/D6JKu
        wHXYBa435qfQ55F9h9XKR7xs6x8TQcCsqDI5lNNbFw==
X-Google-Smtp-Source: AFSGD/Ud60pSxnAUK7yW/4NAn7bQ8/X4oliXTs7B6qhn4rQ49H+WlyHwvUc97wveSdh6KxQ6P7z3HMvK95FlRCxMTdQ=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr17718231otg.308.1545302846358;
 Thu, 20 Dec 2018 02:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com> <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
In-Reply-To: <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Dec 2018 11:47:14 +0100
Message-ID: <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Helen Koike <helen.koike@collabora.com>, dnicoara@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:07 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Helen,
>
> On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.com> =
wrote:
> >
> > Hi Tomasz,
> >
> > On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora.com=
> wrote:
> > >>
> > >> Hi Ville
> > >>
> > >> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> > >>>> Allow userspace to identify if the driver supports async update.
> > >>>
> > >>> And what exactly is an "async update"?
> > >>
> > >> I agree we are lacking docs on this, I'll send in the next version a=
s
> > >> soon as we agree on a name (please see below).
> > >>
> > >> For reference:
> > >> https://lists.freedesktop.org/archives/dri-devel/2017-April/138586.h=
tml
> > >>
> > >>>
> > >>> I keep asking people to come up with the a better name for this, an=
d to
> > >>> document what it actually means. Recently I've been think we should
> > >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
> > >>> avoid introducing yet another set of names for the same thing. We'd
> > >>> still want to document things properly though.
> > >>
> > >> Another name it was suggested was "atomic amend", this feature basic=
ally
> > >> allows userspace to complement an update previously sent (i.e. its i=
n
> > >> the queue and wasn't commited yet), it allows adding a plane update =
to
> > >> the next commit. So what do you think in renaming it to "atomic amen=
d"?
> > >
> > > Note that it doesn't seem to be what the code currently is doing. For
> > > example, for cursor updates, it doesn't seem to be working on the
> > > currently pending commit, but just directly issues an atomic async
> > > update call to the planes. The code actually seems to fall back to a
> > > normal sync commit, if there is an already pending commit touching th=
e
> > > same plane or including a modeset.
> >
> > It should fail as discussed at:
> > https://patchwork.freedesktop.org/patch/243088/
> >
> > There was the following code inside the drm_atomic_helper_async_check()
> > in the previous patch which would fallback to a normal commit if there
> > isn't any pending commit to amend:
> >
> > +       if (!old_plane_state->commit)
> > +               return -EINVAL;
> >
> > In the v2 of the patch https://patchwork.freedesktop.org/patch/263712/
> > this got removed, but which means that async update will be enabled
> > anyway. So the following code is wrong:
> >
> > -       if (state->legacy_cursor_update)
> > +       if (state->async_update || state->legacy_cursor_update)
> >                 state->async_update =3D !drm_atomic_helper_async_check(=
dev, state);
> >
> > Does it make sense? If yes I'll fix this in the next version of the
> > Atomic IOCTL patch (and also those two patches should be in the same
> > series, I'll send them together next time).
> >
> > Thanks for pointing this out.
> >
> > Please let me know if you still don't agree on the name "atomic amend",
> > or if I am missing something.
>
> I'll defer it to the DRM maintainers. From Chrome OS perspective, we
> need a way to commit the cursor plane asynchronously from other
> commits any time the cursor changes its position or framebuffer. As
> long as the new API allows that and the maintainers are fine with it,
> I think I should be okay with it too.

If this is just about the cursor, why is the current legacy cursor
ioctl not good enough? It's 2 ioctls instead of one, but I'm not sure
if we want to support having a normal atomic commit and a cursor
update in the same atomic ioctl, coming up with reasonable semantics
for that will be complicated.

Pointer to code that uses this would be better ofc.
-Daniel

> Best regards,
> Tomasz
>
> >
> > Helen
> >
> > >
> > > Best regards,
> > > Tomasz
> > >
> > >> Or do you suggest another name? I am not familiar with vulkan termin=
ology.
> > >>
> > >>
> > >> Thanks
> > >> Helen
> > >>
> > >>>
> > >>>>
> > >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.co=
m>
> > >>>> [prepared for upstream]
> > >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > >>>>
> > >>>> ---
> > >>>> Hi,
> > >>>>
> > >>>> This patch introduces the ASYNC_UPDATE cap, which originated from =
the
> > >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user t=
o
> > >>>> figure that async_update exists.
> > >>>>
> > >>>> This was tested using a small program that exercises the uAPI for =
easy
> > >>>> sanity testing. The program was created by Alexandros and modified=
 by
> > >>>> Enric to test the capability flag [2].
> > >>>>
> > >>>> The test worked on a rockchip Ficus v1.1 board on top of mainline =
plus
> > >>>> the patch to update cursors asynchronously through atomic plus the=
 patch
> > >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
> > >>>>
> > >>>> To test, just build the program and use the --atomic flag to use t=
he cursor
> > >>>> plane with the ATOMIC_AMEND flag. E.g.
> > >>>>
> > >>>>   drm_cursor --atomic
> > >>>>
> > >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> > >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/asyn=
c-capability
> > >>>>
> > >>>> Thanks
> > >>>> Helen
> > >>>>
> > >>>>
> > >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> > >>>>  include/uapi/drm/drm.h      |  1 +
> > >>>>  2 files changed, 12 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioc=
tl.c
> > >>>> index 94bd872d56c4..4a7e0f874171 100644
> > >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> > >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> > >>>> @@ -31,6 +31,7 @@
> > >>>>  #include <drm/drm_ioctl.h>
> > >>>>  #include <drm/drmP.h>
> > >>>>  #include <drm/drm_auth.h>
> > >>>> +#include <drm/drm_modeset_helper_vtables.h>
> > >>>>  #include "drm_legacy.h"
> > >>>>  #include "drm_internal.h"
> > >>>>  #include "drm_crtc_internal.h"
> > >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, =
void *data, struct drm_file *file_
> > >>>>  {
> > >>>>      struct drm_get_cap *req =3D data;
> > >>>>      struct drm_crtc *crtc;
> > >>>> +    struct drm_plane *plane;
> > >>>>
> > >>>>      req->value =3D 0;
> > >>>>
> > >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev,=
 void *data, struct drm_file *file_
> > >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> > >>>>              req->value =3D 1;
> > >>>>              break;
> > >>>> +    case DRM_CAP_ASYNC_UPDATE:
> > >>>> +            req->value =3D 1;
> > >>>> +            list_for_each_entry(plane, &dev->mode_config.plane_li=
st, head) {
> > >>>> +                    if (!plane->helper_private->atomic_async_upda=
te) {
> > >>>> +                            req->value =3D 0;
> > >>>> +                            break;
> > >>>> +                    }
> > >>>> +            }
> > >>>> +            break;
> > >>>>      default:
> > >>>>              return -EINVAL;
> > >>>>      }
> > >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > >>>> index 300f336633f2..ff01540cbb1d 100644
> > >>>> --- a/include/uapi/drm/drm.h
> > >>>> +++ b/include/uapi/drm/drm.h
> > >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> > >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> > >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> > >>>>  #define DRM_CAP_SYNCOBJ             0x13
> > >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> > >>>>
> > >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> > >>>>  struct drm_get_cap {
> > >>>> --
> > >>>> 2.19.1
> > >>>>
> > >>>> _______________________________________________
> > >>>> dri-devel mailing list
> > >>>> dri-devel@lists.freedesktop.org
> > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
