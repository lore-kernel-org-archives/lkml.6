Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeFENU1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:20:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45519 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:20:26 -0400
X-Google-Smtp-Source: ADUXVKJ0HjJtX2cVrUoDjRfR5CMCJrzjmmBUcyLqzDEPXLHLEcGDxo7fX0k/X2ug3YY6+bjctJQ7gD60nnDxdt951PQ=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-12-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-12-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:20:25 +0300
Message-ID: <CAHp75Vd+addPE+PT-hOVwqWgW8mAN6AxTrip3_oaKCPkt=gkRA@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] drm/nouveau: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - handle err case before normal case - per Andy
>
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 6d99f11..67ba2ac 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -644,16 +644,13 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
>         int i;
>
>         if (nouveau_tv_norm) {
> -               for (i = 0; i < num_tv_norms; i++) {
> -                       if (!strcmp(nv17_tv_norm_names[i], nouveau_tv_norm)) {
> -                               tv_enc->tv_norm = i;
> -                               break;
> -                       }
> -               }
> -
> -               if (i == num_tv_norms)
> +               i = match_string(nv17_tv_norm_names,
> +                                num_tv_norms, nouveau_tv_norm);
> +               if (i < 0)
>                         NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
>                                 nouveau_tv_norm);
> +               else
> +                       tv_enc->tv_norm = i;
>         }
>
>         drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
