Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41627FF8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9onU0GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A41627FF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936324AbeF2OuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:50:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53430 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeF2OuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:50:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so2497717wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yPI8a3CQAq4viLCGJF+J9E7iiBtryHBE5KlWuhpyVQY=;
        b=e9onU0GMf4R9Lfp9r6H6cK5RtppQnsW6IA0rvt4vTIVMJxE84C1F9dVwrlidR1Afx6
         sPKe+JZuI987M2ArpYQgRsyyvxOwGCmHAK7QRc1uG+o8SQvhU+I+3wE5KjFn/2HyQey+
         FFAs5XFMSILDdNXtzGlxz7c74WpP30AdDR3/TaovrqbSyvGo2ikkUGtE0c/h+9iCUPgS
         A97T1gBeRa+hSnymrFRP9g4dwoeNldivBnIsZa+N+KOUq3DvepMvNXKjbbXwY49YPh/9
         3zVWb5u7UlUWNx5inFgK5zWYWsUIhHZ30bVJCooyMlAUIsmCsAqW6fm9FHv1guM1GjBi
         bSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yPI8a3CQAq4viLCGJF+J9E7iiBtryHBE5KlWuhpyVQY=;
        b=aVuRU453WPj9aNdxKtkucOfuP3JyKmxXPIMYt8C/B4b69dYVPlnDISzKRfB3E9W+9c
         Nd4HBuqFf/Ux8Z/kwewpxKgyKS6QzwW64uxWyr0OZnhJA1c0u0doNfGDHQbOi4wBdI0N
         kkGJUvZ2whyIsS/NphYad2Wng54fu28VHIlj7dZKnFqDGOda7TfWZ8Pgqprc1UWorCcT
         7y4GntMmnS1l00HTjj+3Ec5B5FmIP/csb7fLnkTVxjlFDXOZEw2ZT7WrEyGvf1f/xt+v
         OJr4rprKoak5LzhfYJ653xl+PYsA4vMb/JMlZGkgPw4zOEj38jc/mh5jvb/LgrXuNMuO
         exwg==
X-Gm-Message-State: APt69E1Q+Dvilg+NIDpsHknXOMIGNxe3h29OR8BgKqPBBh5nhJZN1/XL
        0A+2v2Q9BQEyIu/I4eWCON7Mm+C/F1tdQ5T7CAc=
X-Google-Smtp-Source: AAOMgpc2OL4LJjux7KSbZFXKzMwRs7VhN1dI1Z9ebeoVNofdmJM24buLnvQXWRfgTAil5UykmOsYTz0b1Cmfsks6IX0=
X-Received: by 2002:a1c:7a06:: with SMTP id v6-v6mr2046280wmc.90.1530283815650;
 Fri, 29 Jun 2018 07:50:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8e6b:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 07:50:15
 -0700 (PDT)
In-Reply-To: <20180629142710.2069-1-michel@daenzer.net>
References: <20180629142710.2069-1-michel@daenzer.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 29 Jun 2018 10:50:15 -0400
Message-ID: <CADnq5_NZa=-_Cs6zq=0kk-A9VKa=56Sbg+dUrgdvB5vz77SAnw@mail.gmail.com>
Subject: Re: [PATCH] drm: Use kvzalloc for allocating blob property memory
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:27 AM, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> From: Michel D=C3=A4nzer <michel.daenzer@amd.com>
>
> The property size may be controlled by userspace, can be large (I've
> seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
> physically contiguous.
>
> Signed-off-by: Michel D=C3=A4nzer <michel.daenzer@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/drm_property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_propert=
y.c
> index 1f8031e30f53..cdb10f885a4f 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -532,7 +532,7 @@ static void drm_property_free_blob(struct kref *kref)
>
>         drm_mode_object_unregister(blob->dev, &blob->base);
>
> -       kfree(blob);
> +       kvfree(blob);
>  }
>
>  /**
> @@ -559,7 +559,7 @@ drm_property_create_blob(struct drm_device *dev, size=
_t length,
>         if (!length || length > ULONG_MAX - sizeof(struct drm_property_bl=
ob))
>                 return ERR_PTR(-EINVAL);
>
> -       blob =3D kzalloc(sizeof(struct drm_property_blob)+length, GFP_KER=
NEL);
> +       blob =3D kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KE=
RNEL);
>         if (!blob)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -576,7 +576,7 @@ drm_property_create_blob(struct drm_device *dev, size=
_t length,
>         ret =3D __drm_mode_object_add(dev, &blob->base, DRM_MODE_OBJECT_B=
LOB,
>                                     true, drm_property_free_blob);
>         if (ret) {
> -               kfree(blob);
> +               kvfree(blob);
>                 return ERR_PTR(-EINVAL);
>         }
>
> --
> 2.18.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
