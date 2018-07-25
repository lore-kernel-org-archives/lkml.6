Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90276C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443CA20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7n5LEEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443CA20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeGYNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:19:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39981 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeGYNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:19:59 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so6098467iob.7;
        Wed, 25 Jul 2018 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tZ/tfcBLeBnaAIWrkS1c2ObNIQ0mbtPAlupdU9z0xXI=;
        b=J7n5LEEI+EvzfyLLnMVP7PQxqq7+gj2v01fopGRwtw/y6l5ewptVR/CQVakTpj0/oj
         tnKS0CmfhRLYv1fZLKVC06VRo7IM7Yc4wbkqkdO86joi0UrVqyoKuXnP5e//hvQX65EG
         tVm9F0sXg82SEBhGeTSkrgKWk2dW/stx+8rB9BhzWl6qawpeGjisK7juMVU2i/Z3NN+2
         aqcy1NvlLiiLRdgRQyUiRAFvgLOPUsn/lzg/nf5F/2mxYNKLSO6qhuHX1FNyS4R2ZJy7
         cc7+mha+5A5q9z+Zv+6EbicZ5Psa4d4EOVTwY2zxYVQTHC5f5QFmVcxyUytMjQvEY+hO
         Qigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tZ/tfcBLeBnaAIWrkS1c2ObNIQ0mbtPAlupdU9z0xXI=;
        b=HvQMr5txLoRxXANRfdj1Pflhm/DpZEwpuoWvCSLl2pEGVYMTxdRVw8RZ2woye+zte5
         ew966at5PYYK7rdeAjfrKCjIBsm76IqEEnVG7lcogcLmAQ0njGGRwgn+KjOaYgiumNTa
         ZAn8Rjfn0d6QaweREBmyk2NfX8p6OxvatVbSgfDKJjXRYKb6PNA8kFPCR+IsdAvQGL9r
         S0GRaE6o1EXTg86ZEjGx+vpezGOiy9bUWvEgjGVPWfNw2SMb4xlwiihIfMpQjMnXVCEj
         4IUUMjfEG6dnzSQJc1e/Q0oaQWkO86gvVyLeQ/+6jMffu7+1BGBxCBL6O48XZ/MwEHtH
         +oXg==
X-Gm-Message-State: AOUpUlG5xhPjfncz+UyMOzkID/hJX4h7qQ0/h13Qkn60dH5vSzTNxLpj
        Mp/MdTfFqUyG45kfloajdvBwHBNFYuYydZL9GSQ=
X-Google-Smtp-Source: AAOMgpe0EXd+rdDZXvwURBm27pXZa0bWhHRUqO7BmL87bcrm6iprR2I+YFdFyi/v5uyCZdGrZBN0BZ51FDAe5DIgLpQ=
X-Received: by 2002:a6b:3954:: with SMTP id g81-v6mr15802450ioa.225.1532520514679;
 Wed, 25 Jul 2018 05:08:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:40cb:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 05:08:33
 -0700 (PDT)
In-Reply-To: <20180723145006.5a26207f@canb.auug.org.au>
References: <20180723145006.5a26207f@canb.auug.org.au>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 25 Jul 2018 08:08:33 -0400
Message-ID: <CAF6AEGsX6p853OG-e_PN6umpG0aM0hr0KvecOKJ+bbLi2362nQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-msm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:50 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Rob,
>
> [Dave, this will presumably soon turn up in the drm tree]
>
> After merging the drm-msm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c: In function 'dpu_plane_destroy':
> drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1483:3: error: too few arguments to function 'drm_plane_helper_disable'
>    drm_plane_helper_disable(plane);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/msm/msm_drv.h:43:0,
>                  from drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:24:
> include/drm/drm_plane_helper.h:72:5: note: declared here
>  int drm_plane_helper_disable(struct drm_plane *plane,
>      ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   drm_plane_helper_disable ("drm/msm: Add SDM845 DPU support")
>
> interacting with commit
>
>   070473bcf703 ("drm: add missing ctx argument to plane transitional helpers")
>
> from the drm tree.
>
> I have added this merge fix patch.

This looks like the correct fix.  I'll rebase my msm-next branch to
correct this and the other merge conflict..

BR,
-R

>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 23 Jul 2018 12:47:04 +1000
> Subject: [PATCH] drm: msm: merge fix for drm_plane_helper_disable() API change
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index d3d7ebf0c394..b640e39ebaca 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1480,7 +1480,7 @@ static void dpu_plane_destroy(struct drm_plane *plane)
>
>                 mutex_destroy(&pdpu->lock);
>
> -               drm_plane_helper_disable(plane);
> +               drm_plane_helper_disable(plane, NULL);
>
>                 /* this will destroy the states as well */
>                 drm_plane_cleanup(plane);
> --
> 2.18.0
>
> --
> Cheers,
> Stephen Rothwell
