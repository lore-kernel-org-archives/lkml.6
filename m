Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031405AbeCAOV7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:21:59 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38933 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031229AbeCAOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:21:56 -0500
X-Google-Smtp-Source: AG47ELuOQaeKGwq4ikIX1fLW8Ycp5L/3C3xldoOz0FxoXYD62cJb42vvi/VfAS6b3G3i+8iAy6WhhYopWhbKl5RGNOk=
MIME-Version: 1.0
In-Reply-To: <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com> <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
 <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 16:21:55 +0200
Message-ID: <CAHp75VfLvYJfX=zTy=XUyL3AcvE+h3yTXwjDGdaFQk9mNjF8GA@mail.gmail.com>
Subject: Re: [PATCH v2] sound/pci/ice1712: replace strcpy() with strlcpy()
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 4:17 PM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Replace unsafe usages of strcpy() to copy the name
> argument into the sid.name buffer with strlcpy()
> to guard against possible buffer overflows.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
> index 0dbaccf61f33270608..21806bab4757241a9e 100644
> --- a/sound/pci/ice1712/juli.c
> +++ b/sound/pci/ice1712/juli.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <sound/core.h>
>  #include <sound/tlv.h>
>
> @@ -425,10 +426,9 @@ DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
>  static struct snd_kcontrol *ctl_find(struct snd_card *card,
>                                      const char *name)
>  {
> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       strlcpy(sid.name, name, sizeof(sid.name));
>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);
>  }
> diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
> index d145b5eb7ff86d978d..5bc836241c977feb51 100644
> --- a/sound/pci/ice1712/quartet.c
> +++ b/sound/pci/ice1712/quartet.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <sound/core.h>
>  #include <sound/tlv.h>
>  #include <sound/info.h>
> @@ -785,10 +786,9 @@ DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
>  static struct snd_kcontrol *ctl_find(struct snd_card *card,
>                                      const char *name)
>  {
> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       strlcpy(sid.name, name, sizeof(sid.name));
>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);
>  }
> --
> 2.16.2



-- 
With Best Regards,
Andy Shevchenko
