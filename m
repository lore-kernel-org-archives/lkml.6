Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeEUWED (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:04:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33151 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeEUWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:04:00 -0400
X-Google-Smtp-Source: AB8JxZqwecEOUDWWgBbop4bJZ7vZrxWlDYf9eMv0sl9U4xrgGLJJajdAYV+eVD3rzbzfmnwdUU7PMDOiKT03N5DvLOI=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-22-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-22-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:03:59 +0300
Message-ID: <CAHp75VctuGKvdG3=mHp7nA3MkYSP+Cxob1gtjYVq03KBcEJ7UQ@mail.gmail.com>
Subject: Re: [PATCH 21/33] drm/nouveau: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

>         if (nouveau_tv_norm) {

> +               i = match_string(nv17_tv_norm_names,
> +                                num_tv_norms, nouveau_tv_norm);

Same comment for logical split, 2nd parameter looks better on the previous line.

> +               if (i >= 0)
> +                       tv_enc->tv_norm = i;
> +               else
>                         NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
>                                 nouveau_tv_norm);

I would rather go with

if (i < 0)
 NV_WARN
else
 ...

>         }


-- 
With Best Regards,
Andy Shevchenko
