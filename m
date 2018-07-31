Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D048C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6720841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATose/Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F6720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGaUXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:23:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42561 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeGaUXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:23:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id u202-v6so11478147lff.9;
        Tue, 31 Jul 2018 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NOJpxsmR9ReBXFbLY4RBjZ5vXvjiuyG+zrpa/tFRYg=;
        b=ATose/WtqhJbjF4h5kb/GYn0JShittC1Vu0dcOpEHIfmD4RiAkKO6Cuo6Nvv+518QA
         XKpn8OA968zpQHPkpXgdS3G+E9M3pRR8FJ7S51EK8LM0wEJgeObtyW4YOSXQenFmUMyc
         vyyuBcDysRZjzg7FmUTl0+35kADFAwykrHmb1jOQTb9X4ecVyhcLVzoNvfak3lkC1Tnv
         /kdH1HnxxfWOD8wTWhbeLWI2GkessNiUJvfPF8wL0RF3y/sB6cdZly0vlgXwC/VYHDs1
         JTgXlGL1hA73oZ8caJQuDfuaA3sIcjIM6XBOzmg2ZpUgmHTqDhPTCRQnLQaQ0l0vhgmo
         AY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NOJpxsmR9ReBXFbLY4RBjZ5vXvjiuyG+zrpa/tFRYg=;
        b=iVagrvf4sl49s1LQllxWOlA3EN2b6UGi7h7KhBhmqxJjXOZcqsHHC4XjOHzl09hweX
         47rMJu/I3m1/gFETM1rYvtzv4N5JmjpV+HHRP9d+3s7QEEDb+aEh/gORk//Q8NSCvp20
         YHLlZEgYrV8zEB3hQ2UsXcNo1aRID4r3vBho9T/O+Nse4STLrvZFeihbe7hEY9ejGqN7
         GEDYk0wgybh/l3FEbhT6att+vjUVBRQbgeGD1UZP9zeJC2rd2uhx5sRatHyG6MZ1tzxj
         WvsnnbwddvwDeQSuXHw+fvmvp4SJVvFikQ6YUmnrABNJXBpIz0gDfgOOQUSAvu8KlQ4L
         pSwQ==
X-Gm-Message-State: AOUpUlGe7Sm8MEyzW/CNaJxT3XIIAWLmpdZNMmoyX017Ulzf4s5nLmYd
        ErFIGLfzZfGOdxppW49c87OtcoGngP8bG2XyObA=
X-Google-Smtp-Source: AAOMgpdPTo8lZqC+b86AD7G2eKyGm6qawISlDNi7mS82KfNeAl1dgY9QwbRiLeIZ9b3yxFNfSXKObPHijvVAKSqrGw0=
X-Received: by 2002:a19:e119:: with SMTP id y25-v6mr14784677lfg.3.1533062482245;
 Tue, 31 Jul 2018 11:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 11:41:21
 -0700 (PDT)
In-Reply-To: <20180731103440.GD17455@e110455-lin.cambridge.arm.com>
References: <20180730190137.GA25420@jordon-HP-15-Notebook-PC> <20180731103440.GD17455@e110455-lin.cambridge.arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 00:11:21 +0530
Message-ID: <CAFqt6zbEur=h4pRxs-XNZhTbtwQMdbwwOLmiFDQmhNDVx3msJA@mail.gmail.com>
Subject: Re: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>, malidp@foss.arm.com,
        airlied@linux.ie, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 4:04 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> Hi Souptick,
>
> On Tue, Jul 31, 2018 at 12:31:37AM +0530, Souptick Joarder wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> With this conversion, drm_fbdev_cma_set_suspend_unlocked()
>> will left with no consumer. So this function can be removed.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/arm/hdlcd_drv.c       | 26 ++------------------------
>>  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>>  include/drm/drm_fb_cma_helper.h       |  2 --
>>  4 files changed, 4 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd=
_drv.c
>> index feaa8bc..4e617e0 100644
>> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
>> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
>> @@ -427,37 +427,15 @@ static int hdlcd_remove(struct platform_device *pd=
ev)
>>  static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
>>  {
>>       struct drm_device *drm =3D dev_get_drvdata(dev);
>> -     struct hdlcd_drm_private *hdlcd =3D drm ? drm->dev_private : NULL;
>>
>> -     if (!hdlcd)
>> -             return 0;
>> -
>> -     drm_kms_helper_poll_disable(drm);
>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 1);
>> -
>> -     hdlcd->state =3D drm_atomic_helper_suspend(drm);
>> -     if (IS_ERR(hdlcd->state)) {
>> -             drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
>> -             drm_kms_helper_poll_enable(drm);
>> -             return PTR_ERR(hdlcd->state);
>> -     }
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_suspend(drm);
>>  }
>>
>>  static int __maybe_unused hdlcd_pm_resume(struct device *dev)
>>  {
>>       struct drm_device *drm =3D dev_get_drvdata(dev);
>> -     struct hdlcd_drm_private *hdlcd =3D drm ? drm->dev_private : NULL;
>> -
>> -     if (!hdlcd)
>> -             return 0;
>>
>> -     drm_atomic_helper_resume(drm, hdlcd->state);
>> -     drm_fbdev_cma_set_suspend_unlocked(hdlcd->fbdev, 0);
>> -     drm_kms_helper_poll_enable(drm);
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_resume(drm);
>>  }
>
> This patch is similar to the one Noralf Tr=C3=B8nnes submitted, and his i=
s
> also cleaning up the state variable in hdlcd_drm_private. The patch has
> been queued as commit f69d9686e5d9 in git://linux-arm.org/linux-ld.git
> for-upstream/hdlcd and I will send a pull request today for it.
>
> Best regards,
> Liviu

unable to clone this repository.
can you please post the patchwork link ?

>
>>
>>  static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resum=
e);
>> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_f=
b_cma_helper.c
>> index 186d00a..f604a84 100644
>> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
>> @@ -529,21 +529,3 @@ void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma=
 *fbdev_cma, bool state)
>>               drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
>>  }
>>  EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
>> -
>> -/**
>> - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
>> - *                                      drm_fb_helper_set_suspend_unloc=
ked
>> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
>> - * @state: desired state, zero to resume, non-zero to suspend
>> - *
>> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
>> - * fb_set_suspend implemented by fbdev core.
>> - */
>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma=
,
>> -                                     bool state)
>> -{
>> -     if (fbdev_cma)
>> -             drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
>> -                                                state);
>> -}
>> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rca=
r-du/rcar_du_drv.c
>> index 02aee6c..288220f 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *d=
ev)
>>  static int rcar_du_pm_suspend(struct device *dev)
>>  {
>>       struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
>> -     struct drm_atomic_state *state;
>>
>> -     drm_kms_helper_poll_disable(rcdu->ddev);
>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>> -
>> -     state =3D drm_atomic_helper_suspend(rcdu->ddev);
>> -     if (IS_ERR(state)) {
>> -             drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> -             drm_kms_helper_poll_enable(rcdu->ddev);
>> -             return PTR_ERR(state);
>> -     }
>> -
>> -     rcdu->suspend_state =3D state;
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_suspend(rcdu->ddev);
>>  }
>>
>>  static int rcar_du_pm_resume(struct device *dev)
>>  {
>>       struct rcar_du_device *rcdu =3D dev_get_drvdata(dev);
>>
>> -     drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> -     drm_kms_helper_poll_enable(rcdu->ddev);
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_resume(rcdu->ddev);
>>  }
>>  #endif
>>
>> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_he=
lper.h
>> index d532f88a..15c4569 100644
>> --- a/include/drm/drm_fb_cma_helper.h
>> +++ b/include/drm/drm_fb_cma_helper.h
>> @@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_de=
vice *dev,
>>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
>>  void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool st=
ate);
>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma=
,
>> -                                     bool state);
>>
>>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffe=
r *fb,
>>       unsigned int plane);
>> --
>> 1.9.1
>>
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
