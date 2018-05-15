Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeEOHwz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:52:55 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:32980 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeEOHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:52:54 -0400
X-Google-Smtp-Source: AB8JxZq6C+6So5mWhD3T6nl+Ux1wTUKsdHugGTPQCAxRbCPAX6jJk0zayDXsId67vIXKiJ11LNA/Qc6ptr+mz7jzcaI=
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com> <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
 <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com> <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 10:52:52 +0300
Message-ID: <CAHp75Vf0k7RejUKjbpYcmBa-uqLa6bUcBs2pGHtRD=nnUpyMhw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Benjamin Berg <bberg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 3:25 AM, Daniel Drake <drake@endlessm.com> wrote:
> Hi Andy,
>
> On Mon, May 7, 2018 at 8:46 AM, Daniel Drake <drake@endlessm.com> wrote:
>> > > Some Asus laptops like UX550GE has hotkey (Fn+F7) for keyboard
>> > > backlight toggle. In this UX550GE, the hotkey incremet the level
>> > > of brightness for each keypress from 1 to 3, and then switch it
>> > > off when the brightness has been the max. This commit interprets
>> > > the code 0xc7 generated from hotkey to KEY_KBDILLUMUP to increment
>> > > the brightness, then pass KEY_KBDILLUMTOGGLE to user space after
>> > > the brightness max been reached for switching the led off.
>> > >
>> >
>> > Pushed to my review and testing queue, thanks!
>>
>> We found that GNOME's handling of the toggle key is somewhat imperfect
>> and it will need modifying before we achieve the
>> Up-Up-Up-off-Up-Up-Up-off... cycle that we are looking for.
>>
>> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/issues/41
>>
>> In that discussion an alternative perspective was raised:
>>
>> Is it right for the kernel to modify the key sent to userspace, when
>> it is then relying on the specific userspace action of it changing the
>> brightness to the next expected level? (and this userspace behaviour
>> is not even working right in the GNOME case)
>>
>> Instead, would it make sense for the kernel to always report TOGGLE in
>> this case, and for GNOME to interpret toggle as simply "cycle through
>> all the available brightness levels"?
>
> Any comments on this? I am tempted to send a patch to just make this
> key always emit TOGGLE from the kernel given that we have a tentative
> agreement on implementing the brightness cycle within GNOME.

The patch is slipped to our for-next queue. We have about 1-2 weeks to
fix things there if the initial approach is not what you want.

-- 
With Best Regards,
Andy Shevchenko
