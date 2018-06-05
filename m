Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFENVF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:21:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41191 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:21:04 -0400
X-Google-Smtp-Source: ADUXVKJ2eUSpYeEd7DHw7l4dbDGNlGpnhEqKJsfHpsa8D5QTr38KcyOB+ZqE1n3APDIzxllVmnF2PyZnz9uU1cnCoa4=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-13-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-13-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:21:03 +0300
Message-ID: <CAHp75Vc1fvxe5iYOvruZcxDsotkm2j4UyB8mC+xwDXhiVo7F3w@mail.gmail.com>
Subject: Re: [PATCH v2 12/21] drm: i2c: ch7006: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: David Airlie <airlied@linux.ie>
> Cc: Yisheng Xie <xieyisheng1@huawei.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - handle err case before normal case.
>
>  drivers/gpu/drm/i2c/ch7006_drv.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
> index 544a8a2..9eefdfe 100644
> --- a/drivers/gpu/drm/i2c/ch7006_drv.c
> +++ b/drivers/gpu/drm/i2c/ch7006_drv.c
> @@ -464,16 +464,13 @@ static int ch7006_encoder_init(struct i2c_client *client,
>         priv->chip_version = ch7006_read(client, CH7006_VERSION_ID);
>
>         if (ch7006_tv_norm) {
> -               for (i = 0; i < NUM_TV_NORMS; i++) {
> -                       if (!strcmp(ch7006_tv_norm_names[i], ch7006_tv_norm)) {
> -                               priv->norm = i;
> -                               break;
> -                       }
> -               }
> -
> -               if (i == NUM_TV_NORMS)
> +               i = match_string(ch7006_tv_norm_names,
> +                                NUM_TV_NORMS, ch7006_tv_norm);
> +               if (i < 0)
>                         ch7006_err(client, "Invalid TV norm setting \"%s\".\n",
>                                    ch7006_tv_norm);
> +               else
> +                       priv->norm = i;
>         }
>
>         if (ch7006_scale >= 0 && ch7006_scale <= 2)
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
