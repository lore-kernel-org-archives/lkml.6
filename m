Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5FA2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H81PuHMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeLTJHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:07:46 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43591 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeLTJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:07:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id 80so288342ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vNvlj71Xzg7uet8Ck3Y1b0QWbnp/U5HW3kEXDTpZd0=;
        b=H81PuHMx0y/wHLyEQevXrmd8MpF9teBctCHiDsGDe+dvCIdcOY3dj2jmAoNPpnGuS2
         EA2xm8ytbyJRYYsqzDh17yq686JtqQ2QOK6qG8Ws4FNPAK8cQx3MZnv2fFSWZ2Q78GZw
         DbczrEcAaCc2FPj0RWi/vUzJ6GG9S2RHolIMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vNvlj71Xzg7uet8Ck3Y1b0QWbnp/U5HW3kEXDTpZd0=;
        b=J+eRcXTqt7Hd/ouByyJCfkFTwdv8RDqK+VH1qMtIOJYvkoqvuAkPfYkWWvT66l8JXx
         yFQik5ERB7CBGZnhLSySrY/lxjZCmoQrKr/Y7ysFGIjwvhUA/gfIBrXbwRlcAMAY01eU
         w9GRwBD59a1ACLFoCah6kLscfkrUypk+7Kr7lvsyGs0e+ifb/72gTZtia5rtY19XIheK
         EfK5HqRltMm8Osvl+fWlfHK4pltsrI+d87kccje0mtKnb7UbTKtdUR8McajRK/02Vy4K
         IpHRswzjc7Mlzg7Byk1Z+QoZ1tKarsN+qFfqYBGrGJLbhc584fwRQLeJ45TD2tQU4Cc4
         ZThA==
X-Gm-Message-State: AA+aEWbblwEk75tStyqJXCYUjVt9xFBfycRAr2zyyLMCocDeleNptLRe
        Th0I6679X6eR/DevHv0ScrxkYHA37AQ=
X-Google-Smtp-Source: AFSGD/W3TpRU31svyA8HpFZCOivLROy5q7Ia4XE15Qgt50YCssNcHSuA44bnbRJ57S2c1FZWzwdAQA==
X-Received: by 2002:a25:a207:: with SMTP id b7mr13300547ybi.209.1545296863930;
        Thu, 20 Dec 2018 01:07:43 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id e3sm6940416ywe.63.2018.12.20.01.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:07:42 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id a10so386685ybl.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:07:42 -0800 (PST)
X-Received: by 2002:a25:9907:: with SMTP id z7mr24683775ybn.114.1545296862194;
 Thu, 20 Dec 2018 01:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com> <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com>
In-Reply-To: <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 20 Dec 2018 18:07:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
Message-ID: <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     helen.koike@collabora.com
Cc:     ville.syrjala@linux.intel.com, David Airlie <airlied@linux.ie>,
        dnicoara@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
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

Hi Helen,

On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.com> wr=
ote:
>
> Hi Tomasz,
>
> On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora.com> =
wrote:
> >>
> >> Hi Ville
> >>
> >> On 11/27/18 11:34 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> >>>> Allow userspace to identify if the driver supports async update.
> >>>
> >>> And what exactly is an "async update"?
> >>
> >> I agree we are lacking docs on this, I'll send in the next version as
> >> soon as we agree on a name (please see below).
> >>
> >> For reference:
> >> https://lists.freedesktop.org/archives/dri-devel/2017-April/138586.htm=
l
> >>
> >>>
> >>> I keep asking people to come up with the a better name for this, and =
to
> >>> document what it actually means. Recently I've been think we should
> >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
> >>> avoid introducing yet another set of names for the same thing. We'd
> >>> still want to document things properly though.
> >>
> >> Another name it was suggested was "atomic amend", this feature basical=
ly
> >> allows userspace to complement an update previously sent (i.e. its in
> >> the queue and wasn't commited yet), it allows adding a plane update to
> >> the next commit. So what do you think in renaming it to "atomic amend"=
?
> >
> > Note that it doesn't seem to be what the code currently is doing. For
> > example, for cursor updates, it doesn't seem to be working on the
> > currently pending commit, but just directly issues an atomic async
> > update call to the planes. The code actually seems to fall back to a
> > normal sync commit, if there is an already pending commit touching the
> > same plane or including a modeset.
>
> It should fail as discussed at:
> https://patchwork.freedesktop.org/patch/243088/
>
> There was the following code inside the drm_atomic_helper_async_check()
> in the previous patch which would fallback to a normal commit if there
> isn't any pending commit to amend:
>
> +       if (!old_plane_state->commit)
> +               return -EINVAL;
>
> In the v2 of the patch https://patchwork.freedesktop.org/patch/263712/
> this got removed, but which means that async update will be enabled
> anyway. So the following code is wrong:
>
> -       if (state->legacy_cursor_update)
> +       if (state->async_update || state->legacy_cursor_update)
>                 state->async_update =3D !drm_atomic_helper_async_check(de=
v, state);
>
> Does it make sense? If yes I'll fix this in the next version of the
> Atomic IOCTL patch (and also those two patches should be in the same
> series, I'll send them together next time).
>
> Thanks for pointing this out.
>
> Please let me know if you still don't agree on the name "atomic amend",
> or if I am missing something.

I'll defer it to the DRM maintainers. From Chrome OS perspective, we
need a way to commit the cursor plane asynchronously from other
commits any time the cursor changes its position or framebuffer. As
long as the new API allows that and the maintainers are fine with it,
I think I should be okay with it too.

Best regards,
Tomasz

>
> Helen
>
> >
> > Best regards,
> > Tomasz
> >
> >> Or do you suggest another name? I am not familiar with vulkan terminol=
ogy.
> >>
> >>
> >> Thanks
> >> Helen
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>> [prepared for upstream]
> >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>>>
> >>>> ---
> >>>> Hi,
> >>>>
> >>>> This patch introduces the ASYNC_UPDATE cap, which originated from th=
e
> >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
> >>>> figure that async_update exists.
> >>>>
> >>>> This was tested using a small program that exercises the uAPI for ea=
sy
> >>>> sanity testing. The program was created by Alexandros and modified b=
y
> >>>> Enric to test the capability flag [2].
> >>>>
> >>>> The test worked on a rockchip Ficus v1.1 board on top of mainline pl=
us
> >>>> the patch to update cursors asynchronously through atomic plus the p=
atch
> >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
> >>>>
> >>>> To test, just build the program and use the --atomic flag to use the=
 cursor
> >>>> plane with the ATOMIC_AMEND flag. E.g.
> >>>>
> >>>>   drm_cursor --atomic
> >>>>
> >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-=
capability
> >>>>
> >>>> Thanks
> >>>> Helen
> >>>>
> >>>>
> >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> >>>>  include/uapi/drm/drm.h      |  1 +
> >>>>  2 files changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl=
.c
> >>>> index 94bd872d56c4..4a7e0f874171 100644
> >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> >>>> @@ -31,6 +31,7 @@
> >>>>  #include <drm/drm_ioctl.h>
> >>>>  #include <drm/drmP.h>
> >>>>  #include <drm/drm_auth.h>
> >>>> +#include <drm/drm_modeset_helper_vtables.h>
> >>>>  #include "drm_legacy.h"
> >>>>  #include "drm_internal.h"
> >>>>  #include "drm_crtc_internal.h"
> >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, vo=
id *data, struct drm_file *file_
> >>>>  {
> >>>>      struct drm_get_cap *req =3D data;
> >>>>      struct drm_crtc *crtc;
> >>>> +    struct drm_plane *plane;
> >>>>
> >>>>      req->value =3D 0;
> >>>>
> >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, v=
oid *data, struct drm_file *file_
> >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> >>>>              req->value =3D 1;
> >>>>              break;
> >>>> +    case DRM_CAP_ASYNC_UPDATE:
> >>>> +            req->value =3D 1;
> >>>> +            list_for_each_entry(plane, &dev->mode_config.plane_list=
, head) {
> >>>> +                    if (!plane->helper_private->atomic_async_update=
) {
> >>>> +                            req->value =3D 0;
> >>>> +                            break;
> >>>> +                    }
> >>>> +            }
> >>>> +            break;
> >>>>      default:
> >>>>              return -EINVAL;
> >>>>      }
> >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> >>>> index 300f336633f2..ff01540cbb1d 100644
> >>>> --- a/include/uapi/drm/drm.h
> >>>> +++ b/include/uapi/drm/drm.h
> >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> >>>>  #define DRM_CAP_SYNCOBJ             0x13
> >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> >>>>
> >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> >>>>  struct drm_get_cap {
> >>>> --
> >>>> 2.19.1
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
