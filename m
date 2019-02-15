Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DAFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C085A21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4lxt5bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbfBOQBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:01:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46470 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfBOQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:01:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so2634879wrs.13;
        Fri, 15 Feb 2019 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5poziK9O5Oug3vQdWW8BPc4uRkJvkttpWR2oJESFLtk=;
        b=I4lxt5bTEpPFtdR1k8oJ8nlIKYZwevamv1pYWibplzry/19j0zwYI/sKt5HQOen6Cl
         +EJERPB2PRTzGQvF3gh18tO16ZSKnpejhwKV+NGWHJpRT3nmqlfqjR/0cBdh9IoXWOW9
         n4Pn8bympn6p2WGhozaWuCXl3QqDQcLeCL64fRLJ4iVNpJ7lAGonOkPARD+BQM9+d1gP
         xgf1HHh3YmMw0NOXcvgoE+i/BUSlUx7bKnS1vgoS21IqhzSEwUvZQwYkOxKrpmXjiWVS
         MmUoGCf/V6blMu/nyY6y15KcG04cMK473fHt0qkzIAfOqZfC7AbHVeWpFi5E1knkEh/M
         Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5poziK9O5Oug3vQdWW8BPc4uRkJvkttpWR2oJESFLtk=;
        b=jfp7C5bryQdWjNm9d61n/Gu3dJA3fQbySHic7369Fr0rr85knbCakWSAEA47HeQmS8
         Mkk6NGG23aE6Z1Zb1+nmdbdLi96DJsldyPrwMyUpH8rfgdGT9f4/hzwGX9nNiIako8Hf
         iUmtWdrjJSnEQK+KIrjWAkhmxd4Guc7rXP5dA+giDQ0dki0bL/OYEtRUix70vnVv6SxA
         ZD0MyRLN5BFIcJ5w+mD1HfsJ2cULnpTGiyq3nY4bxSyDkV9v9VYzt1qQzQUwWa1EEzG8
         rh2MTDNspfJHKWL3DTGEK1+S4TTatEE/B4ivVgxvlGIIFNGGPGDbXmR7CAOolvPOzJzE
         sP1A==
X-Gm-Message-State: AHQUAuaXbLfuCUXLa/rRnJbvZV/A43TMGE1d6B/uoQUPHOL9w6Bdmkoe
        nCoE8KmeC7mcwLXAIHEgshp/5LRUF5j/lZJQ9VQ=
X-Google-Smtp-Source: AHgI3Ibb8IJazatOBdFqZP24pJweLKCllrbfbz4IHB8c0a97RcF8mwhluxuSYd3ji2163LbPm3Qfz3rBV3kAGcWfYCw=
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr7708711wrx.128.1550246476907;
 Fri, 15 Feb 2019 08:01:16 -0800 (PST)
MIME-Version: 1.0
References: <2281684.8tZHfIXjiu@aspire.rjw.lan>
In-Reply-To: <2281684.8tZHfIXjiu@aspire.rjw.lan>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 15 Feb 2019 11:01:04 -0500
Message-ID: <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= 
        <ukrkyi@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
> and the direct-complete optimization is used for the radeon device
> during system-wide suspend, the system doesn't resume.
>
> Preventing direct-complete from being used with the radeon device by
> setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
> go away, which indicates that direct-complete is not safe for the
> radeon driver in general and should not be used with it (at least
> for now).
>
> This fixes a regression introduced by commit c62ec4610c40
> ("PM / core: Fix direct_complete handling for devices with no
> callbacks") which allowed direct-complete to be applied to
> devices without PM callbacks (again) which in turn unlocked
> direct-complete for radeon on HP ProBook 4540s.

Do other similar drivers like amdgpu and nouveau need the same fix?
I'm not too familiar with the direct_complete feature in general.

Alex

>
> Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices=
 with no callbacks")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D201519
> Reported-by: =D0=AF=D1=80=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=A1=D0=B5=D0=
=BC=D1=87=D0=B5=D0=BD=D0=BA=D0=BE <ukrkyi@gmail.com>
> Tested-by: =D0=AF=D1=80=D0=BE=D1=81=D0=BB=D0=B0=D0=B2 =D0=A1=D0=B5=D0=BC=
=D1=87=D0=B5=D0=BD=D0=BA=D0=BE <ukrkyi@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/gpu/drm/radeon/radeon_kms.c
> +++ linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -172,6 +172,7 @@ int radeon_driver_load_kms(struct drm_de
>         }
>
>         if (radeon_is_px(dev)) {
> +               dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
>                 pm_runtime_use_autosuspend(dev->dev);
>                 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
>                 pm_runtime_set_active(dev->dev);
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
