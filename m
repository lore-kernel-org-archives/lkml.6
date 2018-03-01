Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030972AbeCANzN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:55:13 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36831 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030826AbeCANzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:55:11 -0500
X-Google-Smtp-Source: AG47ELtQMAYTTCxVel0PELxnkvt/utdw5z+zzOiJjMK4ytDRCGNd5QIgXqXf3oWZ8P00H6ov5EAob9VamdEpyJ2Y2Ho=
MIME-Version: 1.0
In-Reply-To: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 15:55:09 +0200
Message-ID: <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
Subject: Re: [PATCH] sound/pci/ice1712: replace strcpy() with scnprintf()
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 1:45 PM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Replace unsafe uses of strcpy() to copy the name
> argument into the sid.name buffer with scnprintf()
> to guard against possible buffer overflows.


> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       scnprintf(sid.name, sizeof(sid.name), "%s", name);

So, why not just use strlcpy()?
scnprintf() here adds an overhead for no benefit.

>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);

> -       struct snd_ctl_elem_id sid;
> -       memset(&sid, 0, sizeof(sid));
> -       /* FIXME: strcpy is bad. */
> -       strcpy(sid.name, name);
> +       struct snd_ctl_elem_id sid = {0};
> +
> +       scnprintf(sid.name, sizeof(sid.name), "%s", name);
>         sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>         return snd_ctl_find_id(card, &sid);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
