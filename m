Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeEVKLM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:11:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40138 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeEVKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:11:04 -0400
X-Google-Smtp-Source: AB8JxZqo6Dp3VFvRfDWifV/I7yUVFu5fKA2mNqucX60fsl64bapW+jpG3Ay5rU5x9f8Evcjjw+S2YCTLWVo4gCqv9S4=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com> <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
 <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
 <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
 <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com> <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Tue, 22 May 2018 18:11:02 +0800
Message-ID: <CAB4CAweonk3RseCO2BdAiyc0XjfU6GC+c3W9H3AZkgrJMKbnVQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benjamin Berg <bberg@redhat.com>, Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 5:18 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 15, 2018 at 4:41 PM, Benjamin Berg <bberg@redhat.com> wrote:
>
>> I had a quick chat with Bastien about this. The conclusion was that
>> reusing the TOGGLE key may be problematic for gnome-settings-daemon.
>> And the alternative of a new CYCLE key also has some caveats.
>>
>> The most straight forward solution is likely to simply handle the
>> brightness change in the kernel and not report the key to userspace at
>> all. This should work just fine and at least GNOME will show an on
>> screen display in response to the brightness change.
>>
>> Do you think that approach would work well?
>
> Am I right we are waiting for Daniel's answer?
>
> Btw, I mistakenly thought that patch in the queue for-next, while it's
> not. So, I'm going to drop it now.
> Feel free to re-submit a new (better) version.
>
> --
> With Best Regards,
> Andy Shevchenko

So it's better to handle NOTIFY_KBD_BRTUP, BRTDOWN, BRTTOGGLE
(c4, c5, c7) in the driver and no need to pass it up to userspace? I'll work
out a patch for this.

Chris
