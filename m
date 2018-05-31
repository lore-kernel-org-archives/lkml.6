Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbeEaTCJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:02:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41524 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755875AbeEaTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:02:07 -0400
X-Google-Smtp-Source: ADUXVKI7xzq/FzoDPD177YesLdLsJ2dG/wi1e+v86IRwYJQU0QybTFrZYk9CqPKNGJTTg1sIh7ueq2HJp81ZEAZ+IR0=
MIME-Version: 1.0
In-Reply-To: <s5hmuwf648a.wl-tiwai@suse.de>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VeNgTVT_O_ytF2C_iavkDLz5uxQggxboWpB9f1fgjkYdQ@mail.gmail.com> <s5hmuwf648a.wl-tiwai@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 22:02:05 +0300
Message-ID: <CAHp75VcVMO=s0gxGOZ9UqG-AybPNDac9ePc276VSGHm4WKnaBA@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
To: Takashi Iwai <tiwai@suse.de>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 31 May 2018 20:41:36 +0200,
> Andy Shevchenko wrote:
>> On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:

>> > +               j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
>> > +               if (j >= 0) {
>> > +                       chip->controls[j] = ctl;
>> > +                       ctl->private_free = oxygen_any_ctl_free;
>> > +               }
>>
>> It looks to me you may get rid of j completely by utilizing existing err.
>
> Well, err isn't ideal as it's referred as the actual index.
> That is, the line below looks weird to me:
>         chip->controls[err] = ctl;
>
> Of course, j isn't the best name, either, but at least, keeping the
> same variable makes the code conversion logic clearer.

Works for me either way.
Thanks!

-- 
With Best Regards,
Andy Shevchenko
