Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="POQz5FR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLCSDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:03:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51987 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeLCSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:03:23 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so10781640itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPQxS0XxDLSnaw0taB+RYXiiiL4z/yQGX6fUNvdjaGs=;
        b=POQz5FR1elTuBExpci88wzIDkssjqYyGIIo1rPlI+LKayXTs9BKbuwu1bCWKvsVub8
         eCeOHSL+TFo4Scm3+hM15Xe1pDBZ4mIailrB7VO9sJFegOO/fnJHUD/GSp+0AgCJvp/W
         54xgZysv8RSZLBzi2CsN6LDfjpm6yTN/jmmy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPQxS0XxDLSnaw0taB+RYXiiiL4z/yQGX6fUNvdjaGs=;
        b=eK3lu1adBqFqvF6zDqNKONneskJArUX+lS+bKUl/nof2cO34boBzGhvoFfy7CdDZS7
         Eb4jkY5ts3F1R8BWtTPSZsFMvG1MeG70hosQOctixU778u9YopyEx0ijRP5uLZLLqWlD
         xl6KIzPFx0Zm6THuvTqWQCe7O0UtQvJuRCfav47q8rRfNir8xuNKod5a6vzkSG/Rkqfn
         4z4W4WlCUkDeOLQucS1ewRDtNWPkwZFwlWdL+B+p/ym48yU0xAOmpUUhhc4995r4Fmvm
         sQ7h6Vx36Dg2RERhsDXw/vRPHHUG/RNCKo1QjogRkCWXP+MTUCdNSA+cv95qdQ0L0Ggs
         +PfA==
X-Gm-Message-State: AA+aEWYHaWRRSx7lUg8tvphPIoLwrWW6On3I1Mk1WTRQhqMhLVGzMPhX
        KbQCOMtf2lZnthUCEsjzqiujDLMq52b3KN6pFshpkImn6RI=
X-Google-Smtp-Source: AFSGD/XXTA2IIc/ug9eT/j4PwiBS4/ANKZwIBZfR6voh1BBJCAzEe1S3j+zxHVSrSEmh2x42uBPNciFT6zxmtmQDtmI=
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr8294425ita.140.1543860196744;
 Mon, 03 Dec 2018 10:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <20181201005759.28093-6-eric@anholt.net>
In-Reply-To: <20181201005759.28093-6-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 18:03:05 +0000
Message-ID: <CAApk1dU5MrxN4XMCkUjaGpNDzrT1pGuRRphpfoF602=7y4FnMg@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/v3d: Add missing fence timeline name for TFU.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018 at 00:58, Eric Anholt <eric@anholt.net> wrote:
>
> We shouldn't be returning v3d-render in for our new queue.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> Fixes: 83d5139982db ("drm/v3d: Add support for submitting jobs to the TFU.")
> ---
>  drivers/gpu/drm/v3d/v3d_fence.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
> index 50bfcf9a8a1a..b0a2a1ae2eb1 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -29,10 +29,16 @@ static const char *v3d_fence_get_timeline_name(struct dma_fence *fence)
>  {
>         struct v3d_fence *f = to_v3d_fence(fence);
>
> -       if (f->queue == V3D_BIN)
> +       switch (f->queue) {
> +       case V3D_BIN:
>                 return "v3d-bin";
> -       else
> +       case V3D_RENDER:
>                 return "v3d-render";
> +       case V3D_TFU:
> +               return "v3d-tfu";
> +       default:
> +               return NULL;
> +       }
>  }
>
>  const struct dma_fence_ops v3d_fence_ops = {
> --
> 2.20.0.rc1
>
