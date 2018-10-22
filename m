Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D6C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB36220779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhvvM6ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB36220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeJVQjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:39:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35498 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeJVQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:39:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so36135672ljj.2;
        Mon, 22 Oct 2018 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JESEI1vU4oZdzddJ8Qq5SBbvbaMPZuaPbM00oY40CAc=;
        b=IhvvM6niOhnbiztLBMNxg1rF5r7Nl+qirLIXWkkeUzHMUlBJBoEoOiCJZCeR6DxELW
         LtkkaNRDybPdobfZikVVLwH0bf1orCkIUYpvXF9zRnoP8jGtg+Ih0127NOgouqqKBUTD
         Uqs2zHy01V5o21c1UOmUXLW7Y4gSA4ZRdJm0LLMGWJy/zWxrnnCWqjMFERvOdIIsMKIP
         PVa4G+4pxHZBN4sMHvOl0lHs3eP4wjKZnfMevOy+OmYbeylMUio08VfstT7pLfFdhAwg
         OqqtHU31m91r4WiHLvy9lLA8wRBrSI+dTFtQqVupR0LJKkamm7/ZcDoUaX8XXIr0vNJ+
         Fg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JESEI1vU4oZdzddJ8Qq5SBbvbaMPZuaPbM00oY40CAc=;
        b=sFXZ2DO2tdioRMLvL+7KfwHQQp5B1TMVH9koI5HWDTPDnaR5U/0oPSqiiYTH/u9Yvh
         nkrlfsRUFbmxOCKDmpTeyVU58erZZ6At6qhqbVW/7XXWprlfZAfOBECn0WjMBLdGwp+V
         HJ/E+uBuBx/FidSQCPlehmi2QfLQl6SdyFJiX8izpI04KXPCbqv2ibY/1xVn3lMOHmyZ
         99zNx+bMiKlnD4Hxbl8wwBCKAYV0K7w9kPfoUV+lG1b3DbAROgfwR1GrgkOi+lCDbqxn
         Fx2k0d/lZQTgFVEH4fdpJeEiXYc3dkz8bMMdDiMde3O4VtqqeZnUg3tJQh4zF1JYVcoW
         v8FQ==
X-Gm-Message-State: ABuFfoh8Gn5WhkpS6SZNyz2Aykpop/ejJeqFEu5gDUxXBVIw4sQtGFmH
        RkIuqlNA4HD90si0rZ0cf2yfk+TYGHkFcVtuW40=
X-Google-Smtp-Source: ACcGV63ccUqVMfEv+12aij/UJK70uMtRhGWDrkblJyz4qP/WnbTrtY6lfLn6YzT/EgArXnUnxMpo6YbVV2WJAU/pKB4=
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr22377980lji.149.1540196508487;
 Mon, 22 Oct 2018 01:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC>
 <20809880.gF2CxujBy3@avalon> <20181001065220.GE11082@phenom.ffwll.local>
 <26527911.hs5tlrnKDc@avalon> <042a6076-62e2-c029-2a09-f1123d9ac403@tronnes.org>
 <CAFqt6zZ9vZ8qDpockDyUgqxJxA-d6ajyufzBUCPzKkxv0Vnu_Q@mail.gmail.com> <20181011081849.GR31561@phenom.ffwll.local>
In-Reply-To: <20181011081849.GR31561@phenom.ffwll.local>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 22 Oct 2018 13:51:35 +0530
Message-ID: <CAFqt6zaaEWb-vQ6BVhYg1GgsxwKX=4H661OHU3Qfbk0FD3Cz9g@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     noralf@tronnes.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Oct 11, 2018 at 1:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Oct 08, 2018 at 09:57:52PM +0530, Souptick Joarder wrote:
> > Hi Laurent,
> > On Mon, Oct 1, 2018 at 6:12 PM Noralf Tr=C3=B8nnes <noralf@tronnes.org>=
 wrote:
> > >
> > >
> > > Den 01.10.2018 13.56, skrev Laurent Pinchart:
> > > > Hi Daniel,
> > > >
> > > > On Monday, 1 October 2018 09:52:20 EEST Daniel Vetter wrote:
> > > >> On Fri, Sep 28, 2018 at 06:30:35PM +0300, Laurent Pinchart wrote:
> > > >>> On Friday, 28 September 2018 18:05:18 EEST Laurent Pinchart wrote=
:
> > > >>>> On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder wr=
ote:
> > > >>>>> On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> > > >>>>>> convert drm_atomic_helper_suspend/resume() to use
> > > >>>>>> drm_mode_config_helper_suspend/resume().
> > > >>>>>>
> > > >>>>>> remove suspend_state field from the rcar_du_device
> > > >>>>>> structure as it is no more required.
> > > >>>>>>
> > > >>>>>> With this conversion, also drm_fbdev_cma_set_suspend_unlocked(=
)
> > > >>>>>> will left with no consumer. So this function can be removed.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > >>>>> Laurent, any comment on this patch ??
> > > >>>> Sorry for the delay, and thanks for pinging me.
> > > >>>>
> > > >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com=
>
> > > >>>>
> > > >>>> Should I apply this to my tree or do you plan to merge it throug=
h
> > > >>>> drm-misc
> > > >>>> as it touches drm_fb_cma_helper.c ?
> > > >>> I just realized that the same patch got supplied by Noralf Tr=C3=
=B8nnes nearly
> > > >>> a
> > > >>> year ago, and was later superseded by
> > > >>> https://patchwork.freedesktop.org/patch/247861/. I think we shoul=
d thus
> > > >>> apply Noralf's patches instead (once he sends v4 out).
> > > >> I don't think Noralf is still actively working on this, he's busy =
with the
> > > >> fbdev emulation stuff. Probably better if you pick up one of the e=
xisting
> > > >> ones, than waiting another year or so :-)
> > > > Isn't https://patchwork.freedesktop.org/patch/247861/ part of the f=
bdev
> > > > emulation stuff ? That patch series is from less than a month ago, =
so I
> > > > thought it was actively developed.
> > > >
> > > > Let's ask him. Noralf, any comment ? :-)
> > >
> > > I see now that I've caused some confusion here.
> > >
> > > I did some refactoring of the fbdev stuff in the CMA helper last year=
.
> > > In the last series of that work there is this patch:
> > >
> > > [v3,07/11] drm/rcar-du: Use drm_mode_config_helper_suspend/resume()
> > > https://patchwork.freedesktop.org/patch/192414/
> > >
> > > During Christmas I got the idea that maybe it was possible to use a d=
umb
> > > buffer to do generic fbdev emulation. That work took me 6 months befo=
re a
> > > solution using a general internal DRM client was hammered out. By the
> > > time I started to convert drivers I had forgotten about that patch.
> > >
> > > When I wrote the patch (#247861) to convert rcar to the generic fbdev=
, I
> > > just bundled up the suspend/resume change with the fbdev conversion.
> > > Laurent and Sam commented on that bundling, so I said that I would sp=
lit
> > > it up in the next version.
> > >
> > > All that being said, I think that this patch should be applied and I'=
ll
> > > just rebase the rcar fbdev conversion patch on top of that.
> > > It's the easiest for me at least :-)
> > >
> > Any conclusion on this patch ? :-)
>
> Laurent should pick it up and apply to his rcar-du tree I think. We can
> also stuff it into drm-misc as a fallback.

Can we get this patch in queue for 4.20 ?

> -Daniel
>
> >
> > ers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> > > >>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++---------------=
----
> > > >>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
> > > >>>>>>   include/drm/drm_fb_cma_helper.h       |  2 --
> > > >>>>>>   4 files changed, 2 insertions(+), 40 deletions(-)
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> > > >>>>>> b/drivers/gpu/drm/drm_fb_cma_helper.c index 47e0e2f..96efc88 1=
00644
> > > >>>>>> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > > >>>>>> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > > >>>>>> @@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct
> > > >>>>>> drm_fbdev_cma *fbdev_cma)
> > > >>>>>>
> > > >>>>>>                  drm_fb_helper_hotplug_event(&fbdev_cma->fb_he=
lper);
> > > >>>>>>
> > > >>>>>>   }
> > > >>>>>>   EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
> > > >>>>>>
> > > >>>>>> -
> > > >>>>>> -/**
> > > >>>>>> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> > > >>>>>> - *
> > > >>>>>> drm_fb_helper_set_suspend_unlocked
> > > >>>>>> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> > > >>>>>> - * @state: desired state, zero to resume, non-zero to suspend
> > > >>>>>> - *
> > > >>>>>> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> > > >>>>>> - * fb_set_suspend implemented by fbdev core.
> > > >>>>>> - */
> > > >>>>>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > > >>>>>> *fbdev_cma,
> > > >>>>>> -                                       bool state)
> > > >>>>>> -{
> > > >>>>>> -       if (fbdev_cma)
> > > >>>>>> -
> > > >>>>>> drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> > > >>>>>> -                                                  state);
> > > >>>>>> -}
> > > >>>>>> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> > > >>>>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > > >>>>>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f=
 100644
> > > >>>>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > > >>>>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > > >>>>>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm=
_device
> > > >>>>>> *dev)
> > > >>>>>>
> > > >>>>>>   static int rcar_du_pm_suspend(struct device *dev)
> > > >>>>>>   {
> > > >>>>>>
> > > >>>>>>          struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
> > > >>>>>>
> > > >>>>>> -       struct drm_atomic_state *state;
> > > >>>>>>
> > > >>>>>> -       drm_kms_helper_poll_disable(rcdu->ddev);
> > > >>>>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> > > >>>>>> -
> > > >>>>>> -       state =3D drm_atomic_helper_suspend(rcdu->ddev);
> > > >>>>>> -       if (IS_ERR(state)) {
> > > >>>>>> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev=
,
> > > >>>>>> false);
> > > >>>>>> -               drm_kms_helper_poll_enable(rcdu->ddev);
> > > >>>>>> -               return PTR_ERR(state);
> > > >>>>>> -       }
> > > >>>>>> -
> > > >>>>>> -       rcdu->suspend_state =3D state;
> > > >>>>>> -
> > > >>>>>> -       return 0;
> > > >>>>>> +       return drm_mode_config_helper_suspend(rcdu->ddev);
> > > >>>>>>
> > > >>>>>>   }
> > > >>>>>>
> > > >>>>>>   static int rcar_du_pm_resume(struct device *dev)
> > > >>>>>>   {
> > > >>>>>>
> > > >>>>>>          struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
> > > >>>>>>
> > > >>>>>> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_sta=
te);
> > > >>>>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false)=
;
> > > >>>>>> -       drm_kms_helper_poll_enable(rcdu->ddev);
> > > >>>>>> -
> > > >>>>>> -       return 0;
> > > >>>>>> +       return drm_mode_config_helper_resume(rcdu->ddev);
> > > >>>>>>
> > > >>>>>>   }
> > > >>>>>>   #endif
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > > >>>>>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index b3a25e8..ff25c8d=
 100644
> > > >>>>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > > >>>>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > > >>>>>> @@ -78,7 +78,6 @@ struct rcar_du_device {
> > > >>>>>>
> > > >>>>>>          struct drm_device *ddev;
> > > >>>>>>          struct drm_fbdev_cma *fbdev;
> > > >>>>>>
> > > >>>>>> -       struct drm_atomic_state *suspend_state;
> > > >>>>>>
> > > >>>>>>          struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
> > > >>>>>>          unsigned int num_crtcs;
> > > >>>>>>
> > > >>>>>> diff --git a/include/drm/drm_fb_cma_helper.h
> > > >>>>>> b/include/drm/drm_fb_cma_helper.h index 4a65f0d..8dbbe1e 10064=
4
> > > >>>>>> --- a/include/drm/drm_fb_cma_helper.h
> > > >>>>>> +++ b/include/drm/drm_fb_cma_helper.h
> > > >>>>>> @@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(str=
uct
> > > >>>>>> drm_device *dev,
> > > >>>>>>
> > > >>>>>>   void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_=
cma);
> > > >>>>>>   void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev=
_cma);
> > > >>>>>>
> > > >>>>>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma
> > > >>>>>> *fbdev_cma,
> > > >>>>>> -                                       bool state);
> > > >>>>>>
> > > >>>>>>   struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct
> > > >>>>>>   drm_framebuffer *fb,
> > > >>>>>>
> > > >>>>>>          unsigned int plane);
> > >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
