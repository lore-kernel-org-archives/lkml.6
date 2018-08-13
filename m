Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF50C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F178E2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPJlMIRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F178E2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeHMVfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:35:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37641 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeHMVfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:35:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so13409986ljk.4;
        Mon, 13 Aug 2018 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=60a68KOF7FIBxXTi8aR9FrzMxblPrreo1x0pemlev7g=;
        b=RPJlMIRMBAVHpY1R5JQiSpc+Oup3yaT4W/Q0JXRHTOhiqTYET2vzOk606XnuZrCllh
         56k6jQ34kT04LOLH68jrj7Q5zPGIhRRZ3F6X5fH8wV6rVidRkjgJN2ka52kzej9tsTPH
         LqTxSazcmbzHL7HYV8cQ0WFpUaRLtIAuUYDISP7PoSFJAQg8ukf+krzhfVmRu8aCDDEV
         dZllN46B0pxhUFYE13JszOXaP9CBjRsp0pDwfmitfwkZkuFVLyOMzUen4pSFcvjNn1lG
         OZ3EAJaCZy8+OUHeNBgaLJVSza5i1W11MeH+MRApY4YOdG9LQ//XtbPH0HF3NGVTCM29
         MV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60a68KOF7FIBxXTi8aR9FrzMxblPrreo1x0pemlev7g=;
        b=DFs+pe+KO1Y+tL0tVRkx3d+eOUmAlVUL2j2Dm0eoOpG9KaZ0CfANSI19UWEbx3T4W2
         nO+3ia8nInS2ONj/bW+ULQOqVRAvzd/yY/b97XVuXlgshEF0CXziN7QhpWV6A+AyG4Kh
         RgXXQwACOC3+j+QzVMFv56PcX60snV6hjc0TkggiHBr/f5jDfVqqtck4YbLQnnRmA8Yz
         InpU2Fcv432cUXQ1HqRc84gQMe+N0qLjgmBS1j7g9IkizfnTOHuC9ZJUWt2Z9cGfGIKM
         nz03R4sq4Z+8ww/jbY0LGm8yP0z5+i9DvVNwOjqjV0DnZoIcnaFF2xSRkb++v6G+Kh2F
         QBrw==
X-Gm-Message-State: AOUpUlEIAv2PpsrA/j0gWrv0tJwNzDkGhoDI3nnuFLKFhPEai+CzecMl
        eVCEN3ICi1u1mw2oUAyEn2D6ixlLNQzofeFGQkc=
X-Google-Smtp-Source: AA+uWPwSelJG9OGVJLDoFYVG7IL/8G0j1iK3noPfzTyJePStFspo2i0nWY1fPy2qT71lxtMbi5Lhsk3p4X0KkiToKKs=
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr12640527ljj.103.1534186291991;
 Mon, 13 Aug 2018 11:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 11:51:31
 -0700 (PDT)
In-Reply-To: <20180813171611.GE907@e110455-lin.cambridge.arm.com>
References: <20180730190137.GA25420@jordon-HP-15-Notebook-PC>
 <20180731103440.GD17455@e110455-lin.cambridge.arm.com> <CAFqt6zbEur=h4pRxs-XNZhTbtwQMdbwwOLmiFDQmhNDVx3msJA@mail.gmail.com>
 <CAFqt6zYUN3XRsbhAgp8Lne9j1KTr5Ub0P+WrtLwOOfFPFRHFsA@mail.gmail.com> <20180813171611.GE907@e110455-lin.cambridge.arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 14 Aug 2018 00:21:31 +0530
Message-ID: <CAFqt6zazAWmRj_SCwTgufiVNzCrRz1K5ePwsfivR2eqKy=-gKA@mail.gmail.com>
Subject: Re: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Brian Starkey <brian.starkey@arm.com>, malidp@foss.arm.com,
        airlied@linux.ie, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Aug 13, 2018 at 10:46 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> On Thu, Aug 02, 2018 at 03:25:24PM +0530, Souptick Joarder wrote:
>> On Wed, Aug 1, 2018 at 12:11 AM, Souptick Joarder <jrdr.linux@gmail.com>=
 wrote:
>> > On Tue, Jul 31, 2018 at 4:04 PM, Liviu Dudau <liviu.dudau@arm.com> wro=
te:
>> >> Hi Souptick,
>> >>
>> >> On Tue, Jul 31, 2018 at 12:31:37AM +0530, Souptick Joarder wrote:
>> >>> convert drm_atomic_helper_suspend/resume() to use
>> >>> drm_mode_config_helper_suspend/resume().
>> >>>
>> >>> With this conversion, drm_fbdev_cma_set_suspend_unlocked()
>> >>> will left with no consumer. So this function can be removed.
>> >>>
>> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> >>> ---
>> >>>  drivers/gpu/drm/arm/hdlcd_drv.c       | 26 ++----------------------=
--
>> >>>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
>> >>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>> >>>  include/drm/drm_fb_cma_helper.h       |  2 --
>> >>>  4 files changed, 4 insertions(+), 63 deletions(-)
>> >>>
>> >>> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/h=
dlcd_drv.c
>> >>> index feaa8bc..4e617e0 100644
>> >>> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
>> >>> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
>> >>> @@ -427,37 +427,15 @@ static int hdlcd_remove(struct platform_device=
 *pdev)
>> >>>  static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
>> >>>  {
>> >>>       struct drm_device *drm =3D dev_get_drvdata(dev);
>> >>> -     struct hdlcd_drm_private *hdlcd =3D drm ? drm->dev_private : N=
ULL;
>> >>>
>> >>> -     if (!hdlcd)
>> >>> -             return 0;
>> >>> -
>> >>> -     drm_kms_helper_poll_disable(drm);
>> >>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 1);
>> >>> -
>> >>> -     hdlcd->state =3D drm_atomic_helper_suspend(drm);
>> >>> -     if (IS_ERR(hdlcd->state)) {
>> >>> -             drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
>> >>> -             drm_kms_helper_poll_enable(drm);
>> >>> -             return PTR_ERR(hdlcd->state);
>> >>> -     }
>> >>> -
>> >>> -     return 0;
>> >>> +     return drm_mode_config_helper_suspend(drm);
>> >>>  }
>> >>>
>> >>>  static int __maybe_unused hdlcd_pm_resume(struct device *dev)
>> >>>  {
>> >>>       struct drm_device *drm =3D dev_get_drvdata(dev);
>> >>> -     struct hdlcd_drm_private *hdlcd =3D drm ? drm->dev_private : N=
ULL;
>> >>> -
>> >>> -     if (!hdlcd)
>> >>> -             return 0;
>> >>>
>> >>> -     drm_atomic_helper_resume(drm, hdlcd->state);
>> >>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
>> >>> -     drm_kms_helper_poll_enable(drm);
>> >>> -
>> >>> -     return 0;
>> >>> +     return drm_mode_config_helper_resume(drm);
>> >>>  }
>> >>
>> >> This patch is similar to the one Noralf Tr=C3=B8nnes submitted, and h=
is is
>> >> also cleaning up the state variable in hdlcd_drm_private. The patch h=
as
>> >> been queued as commit f69d9686e5d9 in git://linux-arm.org/linux-ld.gi=
t
>> >> for-upstream/hdlcd and I will send a pull request today for it.
>> >>
>> >> Best regards,
>> >> Liviu
>> >
>> > unable to clone this repository.
>> > can you please post the patchwork link ?
>
> Sorry, I was on holiday until today.
>
>>
>> Liviu, is commit f69d9686e5d9 in
>> git://linux-arm.org/linux-ld.gitfor-upstream/hdlcd
>> contains only changes in drivers/gpu/drm/arm/hdlcd_drv.c driver ??
>
> That's right, that tree only deals with HDLCD changes. The rest of the
> patch is up to you to upstream into drm-misc.
>
> Best regards,
> Liviu

As Liviu mentioned, drivers/gpu/drm/arm/hdlcd_drv.c is only changed,
so we left with drivers/gpu/drm/rcar-du/rcar_du_drv.c and remove
drm_fbdev_cma_set_suspend_unlocked().

Would you like to see both rcar_du driver change and removing
drm_fbdev_cma_set_suspend_unlocked() in a single commit ??
or 2 different commit ?

>
>>
>> >
>> >>
>> >>>
>> >>>  static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_r=
esume);
>> >>> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/d=
rm_fb_cma_helper.c
>> >>> index 186d00a..f604a84 100644
>> >>> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
>> >>> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
>> >>> @@ -529,21 +529,3 @@ void drm_fbdev_cma_set_suspend(struct drm_fbdev=
_cma *fbdev_cma, bool state)
>> >>>               drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state=
);
>> >>>  }
>> >>>  EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
>> >>> -
>> >>> -/**
>> >>> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
>> >>> - *                                      drm_fb_helper_set_suspend_u=
nlocked
>> >>> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
>> >>> - * @state: desired state, zero to resume, non-zero to suspend
>> >>> - *
>> >>> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
>> >>> - * fb_set_suspend implemented by fbdev core.
>> >>> - */
>> >>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev=
_cma,
>> >>> -                                     bool state)
>> >>> -{
>> >>> -     if (fbdev_cma)
>> >>> -             drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_help=
er,
>> >>> -                                                state);
>> >>> -}
>> >>> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
>> >>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm=
/rcar-du/rcar_du_drv.c
>> >>> index 02aee6c..288220f 100644
>> >>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_devic=
e *dev)
>> >>>  static int rcar_du_pm_suspend(struct device *dev)
>> >>>  {
>> >>>       struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
>> >>> -     struct drm_atomic_state *state;
>> >>>
>> >>> -     drm_kms_helper_poll_disable(rcdu->ddev);
>> >>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>> >>> -
>> >>> -     state =3D drm_atomic_helper_suspend(rcdu->ddev);
>> >>> -     if (IS_ERR(state)) {
>> >>> -             drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false)=
;
>> >>> -             drm_kms_helper_poll_enable(rcdu->ddev);
>> >>> -             return PTR_ERR(state);
>> >>> -     }
>> >>> -
>> >>> -     rcdu->suspend_state =3D state;
>> >>> -
>> >>> -     return 0;
>> >>> +     return drm_mode_config_helper_suspend(rcdu->ddev);
>> >>>  }
>> >>>
>> >>>  static int rcar_du_pm_resume(struct device *dev)
>> >>>  {
>> >>>       struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
>> >>>
>> >>> -     drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> >>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> >>> -     drm_kms_helper_poll_enable(rcdu->ddev);
>> >>> -
>> >>> -     return 0;
>> >>> +     return drm_mode_config_helper_resume(rcdu->ddev);
>> >>>  }
>> >>>  #endif
>> >>>
>> >>> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cm=
a_helper.h
>> >>> index d532f88a..15c4569 100644
>> >>> --- a/include/drm/drm_fb_cma_helper.h
>> >>> +++ b/include/drm/drm_fb_cma_helper.h
>> >>> @@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct dr=
m_device *dev,
>> >>>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>> >>>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
>> >>>  void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, boo=
l state);
>> >>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev=
_cma,
>> >>> -                                     bool state);
>> >>>
>> >>>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_frameb=
uffer *fb,
>> >>>       unsigned int plane);
>> >>> --
>> >>> 1.9.1
>> >>>
>> >>
>> >> --
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> | I would like to |
>> >> | fix the world,  |
>> >> | but they're not |
>> >> | giving me the   |
>> >>  \ source code!  /
>> >>   ---------------
>> >>     =C2=AF\_(=E3=83=84)_/=C2=AF
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
