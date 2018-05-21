Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeEUWYq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:24:46 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:41458 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeEUWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:24:42 -0400
X-Google-Smtp-Source: AB8JxZodD5rUh2M+odo9wzxjLBizXckOmwEaI248VCQ6fIVz11I1UPUzKZnJgXK1HctGpi6lXs8hylZBaTqQOwjjL4g=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:24:41 +0300
Message-ID: <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

>  static int max98088_get_channel(struct snd_soc_component *component, const char *name)
>  {

> +       int ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
I would rather split this and move an assignment to the line before 'if'

>
>         /* Shouldn't happen */

> +       if (ret < 0)
> +               dev_err(component->dev, "Bad EQ channel name '%s'\n", name);

>         return -EINVAL;

return ret;

?

>  }
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
