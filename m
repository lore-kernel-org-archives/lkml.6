Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D0F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyNNr1A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfA3CwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:52:09 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35639 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfA3CwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:52:08 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so13372482vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaXym7jKLV4bFEKpSUp6GUmt4+cpOLmAC0d6qd/HYls=;
        b=TyNNr1A/x/+AFNyoU9hHzPCPfmOvta2INmLjueHNhAr3HbgzahLn0kmqL7iLZuAYrO
         AS6D1xWTU48PBo5h66NL+R8be4EgFye1xhvvUEkU6NRo3WXuumMkMyE6xu/cxm9xHCpq
         SaGNAtBwHOk77g76Tc8bXwn3tEpyxdpa10nuGfptqzm0snCtQ57Z8drdbpBI8tJrw5Wn
         JDiwHmkQ6Ks43t5USBwBkyIk2sK5wtlmVzLSwDERF+VpTL2hMegjfEnZdghYnQCYTqOs
         eOTL/0eDFlZDKFdqdqPXfu3tCQKcSqG1mnXr/C/PYz7scsPJSquyzdkaaPID92qJQ/Tz
         3y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaXym7jKLV4bFEKpSUp6GUmt4+cpOLmAC0d6qd/HYls=;
        b=M9K8RVKPsiBsiwtElJJrR5UZBHAa/ggoV2LC+F5jZBtd59g3l1Rn6xcVBdPqTzKWR0
         yVRNO7KbBT9qxQNxKvsbMVlVwdgfxPAHrkkXujsaBjATaySAEc8l9FLNKxxwRzRSsENj
         bqSJiIPk1gBZwdQjjsjBEc6exm5BZFCa/5cxb1Dj3VEaju0d/j6hX+VkwO8Ar43H93Hd
         oWFi24uPw+ccZ8H85q5VbssF9vMRVHMO9hIUJHuKTEEIFP5hBKnE1i1HkkSX5x6wgzon
         ZZRlTdSd7uu8vQSKpgGJTQIqVBzHMPSDqG9AqK53272aGG8QT4m9jyn1smkJ16FF8+a9
         8VVw==
X-Gm-Message-State: AJcUukekcSz9nxoP8nUpwHbAmJnercCvHteldme249NRcAKc7Tt8Q1eR
        AcZ3TgAID22obyN0iw5zQ20cOPCoBPexC+VpQEd5jA==
X-Google-Smtp-Source: ALg8bN65F4RqfOR3DVMhKzQhWHcW12NQ5OeBP1N3f5i+LMUtjk3DwqAyiyltn9lDDlpe3Ai0YqKIu2BL2xy48KNXWzo=
X-Received: by 2002:a67:dc92:: with SMTP id g18mr12041965vsk.76.1548816727542;
 Tue, 29 Jan 2019 18:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20190129203046.GA28384@embeddedor>
In-Reply-To: <20190129203046.GA28384@embeddedor>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 30 Jan 2019 12:51:56 +1000
Message-ID: <CACAvsv7KU_fyyvAW3L6aCXPon599=tC4CyXdCF6sVOqqOu3SDA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it, thanks.

On Wed, 30 Jan 2019 at 06:55, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/gpu/drm/nouveau/nouveau_bo.c:1434:53: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 73eff52036d2..a72be71c45b4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -1434,7 +1434,7 @@ nouveau_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_mem_reg *reg)
>                 if (drm->client.mem->oclass < NVIF_CLASS_MEM_NV50 || !mem->kind)
>                         /* untiled */
>                         break;
> -               /* fallthrough, tiled memory */
> +               /* fall through - tiled memory */
>         case TTM_PL_VRAM:
>                 reg->bus.offset = reg->start << PAGE_SHIFT;
>                 reg->bus.base = device->func->resource_addr(device, 1);
> --
> 2.20.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
