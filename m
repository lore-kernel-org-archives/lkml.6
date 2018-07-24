Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743CEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269820875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYqsi34e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2269820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeGXJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:15:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46878 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbeGXJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:15:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so2789669ljj.13;
        Tue, 24 Jul 2018 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FX5Nl84HOtMcSPGnY4P6VR4RqCqQ4f8cd9fyvNRJUGs=;
        b=ZYqsi34eRuBYoaJE5dcjmZbzv8avLlCqfGhBpBv1OaCLqI/31EjZAQH6gUmyj3ospJ
         rh4Pw5fuW5b8UA8m3Xbdi+oyopUie9dxbhX/SpfdGdrktk987MYbVPbh8d6WzLnjKYGH
         1dMJksXJ1MDjCy/12nJm8tvvc45+GoZKyUNES3LMaIcajBKf9pRKZTohyfe0fxbjXjDQ
         YmBMFvt3k/eml5Y5QQV/3Luu5s5gliATi4kNNdqVeuEVZ3A5Ccg39jGhuBWiroZubbWz
         F5/yuAxc8pQeXE7/D/p00lKJTFVVlkqDESu2/4Taf3g5CxxMJDlKVrV+YDZduXo+8pSM
         bjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FX5Nl84HOtMcSPGnY4P6VR4RqCqQ4f8cd9fyvNRJUGs=;
        b=Bh81mYb2xd7ySGiMpfAqGhqvT2p/sU/gsp2TSIAUwliaPoZ2lMWYs88DiSB/uaFkte
         at+5+FqEL+Y1bS4NCtems/du7kw7lqFrZ1kAyVRANDZssmOS2HNA2Xpc8YL7T4pFPK4j
         DZC3An0gkeO9oW+NecJcEFsRYyU8LoAofQNWtUGTQSRInrsR1HsHqGbEwmZ3eWN4EgAj
         qnAcFEDM/jbvD204B8NGd7ys/+Qxbmppz4OSWykqSZloIfoqMwhnJr9cop/9Wls/y25K
         Y1Lg6WuKlDIOL/d+Ikv0qURb6Kr3W4KbVV8IlkxBHKJHcdxKVCF90ZULXDKIBICm2HHa
         VdaA==
X-Gm-Message-State: AOUpUlFTYI1cyiaxWcyKD5em0Iwf3dgICiEn1VDCiLSA8/0OYIw1S5G8
        SXBDw0+Pr44JKmUm3gA9kDcFeVpBlP5tslwLJAZBTg==
X-Google-Smtp-Source: AAOMgpez8Qsv5klELd/G+WtS8cwCuIm0QgK34LzOAVVHRpZDrXzvX8LLfF1B9KAAlZL5MX1q6Ka9k7+B9UeVS2zHxQI=
X-Received: by 2002:a2e:8616:: with SMTP id a22-v6mr11987439lji.43.1532419833252;
 Tue, 24 Jul 2018 01:10:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:57d1:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:10:31
 -0700 (PDT)
In-Reply-To: <20180724062459epcas1p1bf9f47eaccd54be8a8f9e18a18d23550~EOfVjI_Gy1414414144epcas1p1q@epcas1p1.samsung.com>
References: <CGME20180718204725epcas3p1b98f118ad386fbb551ba1f4c10ac2531@epcas3p1.samsung.com>
 <20180718204957.GA14132@jordon-HP-15-Notebook-PC> <20180724062459epcas1p1bf9f47eaccd54be8a8f9e18a18d23550~EOfVjI_Gy1414414144epcas1p1q@epcas1p1.samsung.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 24 Jul 2018 13:40:31 +0530
Message-ID: <CAFqt6zbd74zDwTn4ipSBjqsPyTZMMw7_EL_qbLkFohQWA1KVEQ@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Inki Dae <inki.dae@samsung.com>
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>, airlied@linux.ie,
        kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:54 AM, Inki Dae <inki.dae@samsung.com> wrote:
> Hi,
>
> 2018=EB=85=84 07=EC=9B=94 19=EC=9D=BC 05:49=EC=97=90 Souptick Joarder =EC=
=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> exynos_drm_fbdev_suspend/resume can be removed
>> as drm_mode_config_helper_suspend/resume has
>> implement the same in generic way.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 32 ++++++++++--------------=
-------
>>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 ----------------
>>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>  3 files changed, 10 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/e=
xynos/exynos_drm_drv.c
>> index a81b4a5..1996ff7 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> @@ -151,39 +151,27 @@ static void exynos_drm_postclose(struct drm_device=
 *dev, struct drm_file *file)
>>  static int exynos_drm_suspend(struct device *dev)
>>  {
>>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>> -     struct exynos_drm_private *private;
>> +     int ret =3D 0;
>>
>> -     if (pm_runtime_suspended(dev) || !drm_dev)
>> -             return 0;
>
> You removes '!drm_dev' not related to this patch.

The same has been checked inside drm_mode_config_helper_suspend(),
so we should avoid double check.

>
>> +     if (pm_runtime_suspended(dev))
>> +             return ret;
>>
>> -     private =3D drm_dev->dev_private;
>> +     ret =3D drm_mode_config_helper_suspend(drm_dev);
>
> Just return drm_mode_config_helper_suspend(drm_dev);

 Ok

>
>>
>> -     drm_kms_helper_poll_disable(drm_dev);
>> -     exynos_drm_fbdev_suspend(drm_dev);
>> -     private->suspend_state =3D drm_atomic_helper_suspend(drm_dev);
>> -     if (IS_ERR(private->suspend_state)) {
>> -             exynos_drm_fbdev_resume(drm_dev);
>> -             drm_kms_helper_poll_enable(drm_dev);
>> -             return PTR_ERR(private->suspend_state);
>> -     }
>> -
>> -     return 0;
>> +     return ret;
>>  }
>>
>>  static int exynos_drm_resume(struct device *dev)
>>  {
>>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>> -     struct exynos_drm_private *private;
>> +     int ret =3D 0;
>>
>> -     if (pm_runtime_suspended(dev) || !drm_dev)
>> -             return 0;
>> +     if (pm_runtime_suspended(dev))
>> +             return ret;
>
> Ditto. You removes '!drm_dev' not related to this patch.

Same reason mentioned above to remove '!drm_dev'

>
>>
>> -     private =3D drm_dev->dev_private;
>> -     drm_atomic_helper_resume(drm_dev, private->suspend_state);
>> -     exynos_drm_fbdev_resume(drm_dev);
>> -     drm_kms_helper_poll_enable(drm_dev);
>> +     ret =3D drm_mode_config_helper_resume(drm_dev);
>
> Ditto. return drm_mode_config_helper_resume(drm_dev);
>
> With this patch, you could remove 'int ret' declaration including one fro=
m exynos_drm_suspend.

Ok, I will add this in v2.

>
> Thanks,
> Inki Dae
>
>>
>> -     return 0;
>> +     return ret;
>>  }
>>  #endif
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm=
/exynos/exynos_drm_fbdev.c
>> index 132dd52..918dd2c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>       private->fb_helper =3D NULL;
>>  }
>>
>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>> -{
>> -     struct exynos_drm_private *private =3D dev->dev_private;
>> -
>> -     console_lock();
>> -     drm_fb_helper_set_suspend(private->fb_helper, 1);
>> -     console_unlock();
>> -}
>> -
>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>> -{
>> -     struct exynos_drm_private *private =3D dev->dev_private;
>> -
>> -     console_lock();
>> -     drm_fb_helper_set_suspend(private->fb_helper, 0);
>> -     console_unlock();
>> -}
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm=
/exynos/exynos_drm_fbdev.h
>> index b338472..6840b6a 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> @@ -19,8 +19,6 @@
>>
>>  int exynos_drm_fbdev_init(struct drm_device *dev);
>>  void exynos_drm_fbdev_fini(struct drm_device *dev);
>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>
>>  #else
>>
>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(stru=
ct drm_device *dev)
>>
>>  #define exynos_drm_output_poll_changed (NULL)
>>
>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>> -{
>> -}
>> -
>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>> -{
>> -}
>> -
>>  #endif
>>
>>  #endif
>>
