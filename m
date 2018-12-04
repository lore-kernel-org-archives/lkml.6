Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC5420878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yr8HZAwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC5420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLDMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:01:48 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35235 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:01:48 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so13988040itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Br8Ww1bO3pndK5Z7tGe9HQPUiiL4AhqT0l78xdGXB6E=;
        b=Yr8HZAwTesh8XT0P1LVZcZnnRIT7GEOSF6WxOzehMx/QkSPz6MHjYkZYJKqzFRY8Nk
         85L9q7/WyIow08LvUrJLo+TOggdLL8NB8fr9uvVP96/HkPdpJr6BnzRBoVqpb6EKHBcS
         SL3it57a47e0z5KsuVuHQg5UjhZjMqcv2pfDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Br8Ww1bO3pndK5Z7tGe9HQPUiiL4AhqT0l78xdGXB6E=;
        b=JmeXc5SaE7yqlQ8Ru2rL5dRd/cePfOPUP5wygRaJf04cqPFMxxEGzj2sQkvsWRs0eP
         uwIjCzt0nK5P4Nr/OWF4TrxT19Pjxj2hKMaet/pMDzp4BrA7FsRljNwxCOq3G5r3DblC
         1vcC1gcy7e02J4yconMnN+xLPVHQ2hWsyK8P3CjyjoH+wSjkRRkF0zsJbj39JoYkHb9i
         tJUogj/8XbYcaTWdDDvVcF5Aabf+YQ60OLYy8BnA1T17B0+ngcryG7bDsBQTVDRUhmsq
         T4XbiyLat0eOpuuPGkEsjn6TFPw80ZfWkYgwFvek9xTzpqBIRf2s5Xn1Apz+QoSlrtml
         J2FQ==
X-Gm-Message-State: AA+aEWZ9LrfKxvYfk5vVvt6aTwqYSe26C6hR+W6aKJE8Gxjrl6p1eJ2r
        vVFKevWINTaF3aVpElwPsr3tSBiR4neS9UuyCeYc3w==
X-Google-Smtp-Source: AFSGD/XswTy6ChhoqDq6fe8rx45FGp5673Fv/lxHeh+pwscYNnkcOwMFu4GrXazJAeUtv8eOhkm7xgJA84aHkcs6MhI=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr11855437ith.23.1543924907294;
 Tue, 04 Dec 2018 04:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20181203222438.25417-1-eric@anholt.net> <20181203222438.25417-6-eric@anholt.net>
In-Reply-To: <20181203222438.25417-6-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Tue, 4 Dec 2018 12:01:36 +0000
Message-ID: <CAApk1dXGx4BQOgRHU1F0yR+1oO6FhLGS-JHdCENMNVJ_qLouQg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/v3d: Invalidate the caches from the outside in.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 22:24, Eric Anholt <eric@anholt.net> wrote:
>
> This would be a fairly obscure race, but let's make sure we don't ever
> lose it.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 8a4be9515179..443b1c53117a 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -171,11 +171,15 @@ v3d_invalidate_slices(struct v3d_dev *v3d, int core)
>  void
>  v3d_invalidate_caches(struct v3d_dev *v3d)
>  {
> +       /* Invalidate the caches from the outside in.  That way if
> +        * another CL's concurrent use of nearby memory were to pull
> +        * an invalidated cacheline back in, we wouldn't leave stale
> +        * data in the inner cache.
> +        */
>         v3d_flush_l3(v3d);
> -
>         v3d_invalidate_l2c(v3d, 0);
> -       v3d_invalidate_slices(v3d, 0);
>         v3d_flush_l2t(v3d, 0);
> +       v3d_invalidate_slices(v3d, 0);
>  }
>
>  static void
> --
> 2.20.0.rc1
>
