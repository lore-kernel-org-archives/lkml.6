Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E921C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8FE20857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFMsbiWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfA3OhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:37:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33510 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3OhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:37:25 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so19572659ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arVfaltGGhilwIKUWy6Q7vN8ggIGDdmhCiGh2x7Au0U=;
        b=SFMsbiWkHyQLpYQco1PkZn9ePlx/1Rav+R+yB7+jYnLbihgdRGSLHq0H1H96MJFlMi
         vkknVYXuxrOzZWzokCWMxLYhBCIEkm7WkpSHuTyRR8LRMyi1dbTo7E9lOIGpDgt3LgxT
         8SEsibvd5wc/Zc7tTzbYD/vc1duZJu0dvOp6C6mF2WTixsgRUSiDBWSsuZ0jlpzlby/w
         Hgyh359OLuevcRkPJ1emLFNXNOnZzklf19DLjNKn9uMCNdER2SjCsEKFZdF+u84QMoOv
         QQmBRG8XcevMy/br8/GK8gz41+5C301juOKq8yF38uYG4U4zFElt7oFXMzOU3QjYO+Wq
         84cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arVfaltGGhilwIKUWy6Q7vN8ggIGDdmhCiGh2x7Au0U=;
        b=IPueCTrHwH+oIxUm+HEGJ4/WQGa3/pw7YqCS6HdGunZDcj/3TNSbYTved8Vc//AiZC
         mVQV6SopnhWICUBawiHy7WVR1haoQ21WUBN9+g3wnjEGiGzqdjmE2HTrftVJpM625EiC
         /Uf49xFg0v39/a38AOsiSBucenrIsrXDqvQvcf0/cyljyJXfvpjqbrxpxrZVRpix6/nu
         kmKk+kApv3BjMdmtosJxw93v78k3AGjg5hOQpf7QhbLpnaHecGgiRwccAkrXLTFDC1Ju
         d92M5NOQNH5+V/wwNqoP3YdMy3n8KqYs7BUR/2eF0YOp9BzpMIWR6h7zgn0cvXFVWcSk
         TVmA==
X-Gm-Message-State: AJcUukdsCXWVyLyPYiQKKzXsNcLnxEhEiSfqXCHBHAtU3lWHd31R6y8d
        Rx37npqSibm8cX6dX0bLG18LpnZiMJC0fMCUFrI=
X-Google-Smtp-Source: AHgI3Iax9V/tlpUv9zRWm1Lg28nrRLPjTv7o+qUMVE0JWO5fkA+XxZo1wnLeDd4kI1qOLL9whlQoBA/dutwMNwFKzVQ=
X-Received: by 2002:a5e:9e4a:: with SMTP id j10mr20458071ioq.165.1548859043472;
 Wed, 30 Jan 2019 06:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar> <1891132.39bZHgSTRL@avalon>
In-Reply-To: <1891132.39bZHgSTRL@avalon>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:07:12 +0530
Message-ID: <CAFqtX7kfsgc+VRuSB_TQhFk4DqCChaR6uBZEsnhuwLPCg_k2xw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/panel: Remove duplicate header
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Archit Taneja <architt@codeaurora.org>, a.hajda@samsung.com,
        airlied@linux.ie, Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 3:09 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Brajeswar,
>
> Thank you for the patch.
>
> On Monday, 24 December 2018 16:32:18 EET Brajeswar Ghosh wrote:
> > Remove drm/drm_panel.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/panel.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > index 7cbaba213ef6..402b318eeeb2 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -15,7 +15,6 @@
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > -#include <drm/drm_panel.h>
>
> While at it, how about sorting headers alphabetically to make sure this won't
> happen again ?
>
> With that change,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If no further comment, can we get this patch in queue for 5.1 ?

>
> >  struct panel_bridge {
> >       struct drm_bridge bridge;
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
