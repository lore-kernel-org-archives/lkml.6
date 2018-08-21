Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01222170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjQ55V+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01222170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeHUNJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:09:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36155 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeHUNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:09:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21-v6so3314998lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LiDkFVGtZoY5SY0MH5SVlV2yfG+a7bGuL3Nrdqc8mK4=;
        b=IjQ55V+x8JBphUo+EbyoFPrwjWPaBJJPnR975KEZmta7uPdX7qDtaxPQm5/lkc+XAY
         6KBKVAXD4z2Tpl2EUw/b5IyqJn1VIigFZ37KDAz4OIFHjjKsicBfOWPvxh+PmAV8dCR2
         8N3wtVGA/tUb37SNASzPul2TfF+NaT7Qbr4QPGFCDS//Dgj9X+04JbmIbdB98czCAa3p
         FAOy+gqMllUmUez042FFS1pnO/jHx6H6QXWrjHzNe7D3DXETpdySGY6uX546l2DTshNr
         0+2RM8XuvroZx1iwfGSiDHFgqCw7rmiQrXHculbuX69WuS4TttP24rvARcrSrTSWFnIV
         xLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LiDkFVGtZoY5SY0MH5SVlV2yfG+a7bGuL3Nrdqc8mK4=;
        b=FZqLX1CcKld83qNTAty5GRjE2BXsmMnMmmuzGOLOIqZMuqL06IdhqOn8LPg5bTxPVB
         Sh3RMjnqa7c7gOFTL37YYOXPUpv8tgvG1hJeoZhtSDxKvReoWeYTlb7QHUxF8UOUeHUR
         ikiL41g1JB8lQFIOgoHePT3+4iesTXsh2offDn1pIIy6+3hmxoJa7ORVjskjvdrMIwGB
         a7dySWfGvJweZV6GGksjX64W4fDjwf3d02hmUVmEdGFdIMZxBgLz7N9bmA4mUZZaVAvH
         l5LCpypAgVT5SGYU1j1hrE0Nl8/SgIWlK+CaYYHyaNrPYvrdE/1UHjSgS/29tecJuyvE
         iLsw==
X-Gm-Message-State: AOUpUlHWdRDs3OvQR7pRjxbHfxz8Pbtb9ICRUu3jM24ATL9Kbtxzf3Zr
        CKBo5tSxDb1DcEP/jzQFTSg7GR6Ua7tS7G3mlzQ=
X-Google-Smtp-Source: AA+uWPzoYHQVwQAT7x8i3rQXEJa0QEsZayeLmkUsBkn7sRXg3ZvArYoB2hubJ8NzaY+/LuR9uEj3jU5fLaw/no6hQ50=
X-Received: by 2002:a19:124d:: with SMTP id h74-v6mr13131266lfi.107.1534845021894;
 Tue, 21 Aug 2018 02:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b09:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 02:50:21
 -0700 (PDT)
In-Reply-To: <BYAPR05MB4181991EA79CE952D9F8C398BA320@BYAPR05MB4181.namprd05.prod.outlook.com>
References: <20180811201147.GA14169@jordon-HP-15-Notebook-PC> <BYAPR05MB4181991EA79CE952D9F8C398BA320@BYAPR05MB4181.namprd05.prod.outlook.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 21 Aug 2018 15:20:21 +0530
Message-ID: <CAFqt6zZ86CMdrGBHAob3VN0_Yc+5zdyjpCchroMCrB2J8=D9mg@mail.gmail.com>
Subject: Re: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Convert drm_atomic_helper_suspend/resume()
To:     Deepak Singh Rawat <drawat@vmware.com>
Cc:     "ajitn.linux@gmail.com" <ajitn.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 3:04 AM, Deepak Singh Rawat <drawat@vmware.com> wrote:
> Hi, thanks for the patch. Perhaps can get rid of vmw_kms_resume
> and vmw_kms_suspend, otherwise looks good to me.

Ok, will remove in v2.

>
>>
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> suspend_state can be removed from vmw_private as
>> it will not be used anymore.
>>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |  6 +++---
>>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  1 -
>>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 25 ++-----------------------
>>  3 files changed, 5 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> index bb6dbbe..a317cda 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> @@ -1521,7 +1521,7 @@ static int vmw_pm_freeze(struct device *kdev)
>>               WARN_ON(vmw_request_device_late(dev_priv));
>>               dev_priv->suspend_locked = false;
>>               ttm_suspend_unlock(&dev_priv->reservation_sem);
>> -             if (dev_priv->suspend_state)
>> +             if (dev->mode_config.suspend_state)
>>                       vmw_kms_resume(dev);
>>               if (dev_priv->enable_fb)
>>                       vmw_fb_on(dev_priv);
>> @@ -1558,8 +1558,8 @@ static int vmw_pm_restore(struct device *kdev)
>>       vmw_fence_fifo_up(dev_priv->fman);
>>       dev_priv->suspend_locked = false;
>>       ttm_suspend_unlock(&dev_priv->reservation_sem);
>> -     if (dev_priv->suspend_state)
>> -             vmw_kms_resume(dev_priv->dev);
>> +     if (dev->mode_config.suspend_state)
>> +             vmw_kms_resume(dev);
>>
>>       if (dev_priv->enable_fb)
>>               vmw_fb_on(dev_priv);
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
>> index 1abe217..b8e200b 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
>> @@ -438,7 +438,6 @@ struct vmw_private {
>>       struct vmw_framebuffer *implicit_fb;
>>       struct mutex global_kms_state_mutex;
>>       spinlock_t cursor_lock;
>> -     struct drm_atomic_state *suspend_state;
>>
>>       /*
>>        * Context and surface management.
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
>> index 23beff5..2d011a1 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
>> @@ -3028,19 +3028,7 @@ int vmw_kms_set_config(struct drm_mode_set
>> *set,
>>   */
>>  int vmw_kms_suspend(struct drm_device *dev)
>>  {
>> -     struct vmw_private *dev_priv = vmw_priv(dev);
>> -
>> -     dev_priv->suspend_state = drm_atomic_helper_suspend(dev);
>> -     if (IS_ERR(dev_priv->suspend_state)) {
>> -             int ret = PTR_ERR(dev_priv->suspend_state);
>> -
>> -             DRM_ERROR("Failed kms suspend: %d\n", ret);
>> -             dev_priv->suspend_state = NULL;
>> -
>> -             return ret;
>> -     }
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_suspend(dev);
>>  }
>>
>>
>> @@ -3055,16 +3043,7 @@ int vmw_kms_suspend(struct drm_device *dev)
>>   */
>>  int vmw_kms_resume(struct drm_device *dev)
>>  {
>> -     struct vmw_private *dev_priv = vmw_priv(dev);
>> -     int ret;
>> -
>> -     if (WARN_ON(!dev_priv->suspend_state))
>> -             return 0;
>> -
>> -     ret = drm_atomic_helper_resume(dev, dev_priv->suspend_state);
>> -     dev_priv->suspend_state = NULL;
>> -
>> -     return ret;
>> +     return drm_mode_config_helper_resume(dev);
>>  }
>>
>>  /**
>> --
>> 1.9.1
