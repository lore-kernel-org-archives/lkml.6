Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756022AbeEaSlk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:41:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39632 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755894AbeEaSlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:41:37 -0400
X-Google-Smtp-Source: ADUXVKKwYdX8n1LCphy80vuEjXQAvKWXa2Dhl/qq9R20dIjOQ3QK7vAnMO7JmurNMewPl6WDpp8+Vhe4N4hrydE0xRg=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:41:36 +0300
Message-ID: <CAHp75VeNgTVT_O_ytF2C_iavkDLz5uxQggxboWpB9f1fgjkYdQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.

Sorry, didn't notice before one thing:

> +               j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
> +               if (j >= 0) {
> +                       chip->controls[j] = ctl;
> +                       ctl->private_free = oxygen_any_ctl_free;
> +               }

It looks to me you may get rid of j completely by utilizing existing err.

-- 
With Best Regards,
Andy Shevchenko
