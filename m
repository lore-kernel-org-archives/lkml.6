Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ABAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211920850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeL/AmHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLDUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35572 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:20:06 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so16557501itp.0;
        Tue, 04 Dec 2018 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJsommO8I6R+msvNioVU2g70SMEIv6ix+8qTFIrDu8M=;
        b=CeL/AmHULFrK4KLiQsuG9YN4EC857yZ0ogimPFzQ4p4LfhlFwCm46/uEtOOqx0D7Gj
         wJ/szZjUqbKhvQVfISbcmiUNnXUYQfn8pPFmAbyBkjcwb+2uRzChfl/+h8iT6eqOGEV8
         rhOHoeUEFyD9H04JTOXx4V2kiwPemcqdX9b69S8pffzc8DpS8+liOJf0wRaisqEHrK4c
         KfdP462luYmzilN/a4B8Jlps1wSYSGngjm1cJ+5EUMaqNokskv6D+MGGAUt0/p6kHPsi
         2VuBb0Rz436f0NdCRrlxPhGUDY4DOyseGlcr0PNb4u2iOr7JTDvwwIebS8qS4PsyRDyG
         h7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJsommO8I6R+msvNioVU2g70SMEIv6ix+8qTFIrDu8M=;
        b=dbwJDyTn1hiizqeQB7Gw7h0vlx7nyxhp0l+Ohf/eTkxt/IjFCGzDrVJbTvI6vINxAO
         SR3KPPlF5FwvMq3RXFpDp/bLR1ZafBGizKTXzS1+46gVnxb0auBZds48fhSs0J0PY6vL
         IAL6UdYM7NLiJPyaETsZkfsm89lqYBudbOSl4owhrxzwg/nyeZq0UsRjLw1YmVQBGuua
         OLJCUaCoH5lwpiBE6MDIkQsvU4IvH8zPb07z3Hrk9zV51hcy/fSjfIDbnrZsEihOtyva
         s0ONfr3NQeY1x0Jpw2E5CtTnacywmUkf9IYyfPRvzbrvSr2W/fOwSAOqpkgwvwZ9mTvZ
         n0EQ==
X-Gm-Message-State: AA+aEWYr5LMFYIWx44yUKYdzRW+8Y3WMvLmnGHrspan7MiTW6J8ijAos
        Ib5z7ft+xHvPKJ6E2E0fz3mnjLhdqULlOFLmT/c=
X-Google-Smtp-Source: AFSGD/WGVNSLMdi6wNCF5NMBL2KR2/Erg07k9fZXqN6Je0Vfaq27LU7KBvMvjPF791HPBFNhRFQOFbPnDUxGwqBhKlI=
X-Received: by 2002:a02:1509:: with SMTP id j9mr20570006jad.5.1543954803769;
 Tue, 04 Dec 2018 12:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20181204180441.218160-1-dianders@chromium.org>
In-Reply-To: <20181204180441.218160-1-dianders@chromium.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 4 Dec 2018 15:19:51 -0500
Message-ID: <CAF6AEGt2Chk5kjFXyHg4CaxcOzUPZCMz0UzT4se43oYnt5SxJw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Only add available components
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 1:04 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When trying to get the display up on my sdm845 board I noticed that
> the display wouldn't probe if I had the dsi1 node marked as "disabled"
> even though my board doesn't use dsi1.  It looks like the msm code
> adds all nodes to its list of components even if they are disabled.  I
> believe this doesn't work because all registered components need to
> come up before we finish probing.  Let's do like other DRM code and
> only add available components.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


yeah, that seems like a reasonable thing to do

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>
>  drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index b1577e960889..0b828822117b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1190,8 +1190,10 @@ static int add_components_mdp(struct device *mdp_dev,
>                 if (!intf)
>                         continue;
>
> -               drm_of_component_match_add(master_dev, matchptr, compare_of,
> -                                          intf);
> +               if (of_device_is_available(intf))
> +                       drm_of_component_match_add(master_dev, matchptr,
> +                                                  compare_of, intf);
> +
>                 of_node_put(intf);
>         }
>
> --
> 2.20.0.rc1.387.gf8505762e3-goog
>
