Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeEGOqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:46:09 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43714 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:46:06 -0400
X-Google-Smtp-Source: AB8JxZrar1OkTKVDYLYH4MI2n+Qsd6Fa6+WulDohZs7NpKW2xyDbkqGzlaq0BxYJU3JaZ8QlW7ipAwytXUnl84dhBDc=
MIME-Version: 1.0
In-Reply-To: <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com> <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 7 May 2018 08:46:05 -0600
Message-ID: <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>, bberg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, May 7, 2018 at 8:10 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 3, 2018 at 6:04 AM, Chris Chiu <chiu@endlessm.com> wrote:
> > Some Asus laptops like UX550GE has hotkey (Fn+F7) for keyboard
> > backlight toggle. In this UX550GE, the hotkey incremet the level
> > of brightness for each keypress from 1 to 3, and then switch it
> > off when the brightness has been the max. This commit interprets
> > the code 0xc7 generated from hotkey to KEY_KBDILLUMUP to increment
> > the brightness, then pass KEY_KBDILLUMTOGGLE to user space after
> > the brightness max been reached for switching the led off.
> >
>
> Pushed to my review and testing queue, thanks!

We found that GNOME's handling of the toggle key is somewhat imperfect
and it will need modifying before we achieve the
Up-Up-Up-off-Up-Up-Up-off... cycle that we are looking for.

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/issues/41

In that discussion an alternative perspective was raised:

Is it right for the kernel to modify the key sent to userspace, when
it is then relying on the specific userspace action of it changing the
brightness to the next expected level? (and this userspace behaviour
is not even working right in the GNOME case)

Instead, would it make sense for the kernel to always report TOGGLE in
this case, and for GNOME to interpret toggle as simply "cycle through
all the available brightness levels"?

We'd be interested in your thoughts.

Thanks
Daniel
