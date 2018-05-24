Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965397AbeEXIeE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:34:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34399 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965347AbeEXId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:33:56 -0400
X-Google-Smtp-Source: AB8JxZqrVtfqUArGFeSdvrzWDyBnZfTaG0/o+58SuniXOlFD8RNAndvBGKjN4xOSZqoKPhwObdstJLtSp32brhHynbQ=
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46Xmk_m5Y4M_oXigOkf=z-3O+5F3QaA3AQvgAT4DbP4ew@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com> <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
 <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
 <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
 <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
 <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
 <CAB4CAweonk3RseCO2BdAiyc0XjfU6GC+c3W9H3AZkgrJMKbnVQ@mail.gmail.com> <CAD8Lp46Xmk_m5Y4M_oXigOkf=z-3O+5F3QaA3AQvgAT4DbP4ew@mail.gmail.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 24 May 2018 16:33:55 +0800
Message-ID: <CAB4CAwfEyS0j+q_hM8u-XHU_rEFq3604gjsSw4d_4mhaiz=G-A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Daniel Drake <drake@endlessm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
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

On Tue, May 22, 2018 at 9:48 PM, Daniel Drake <drake@endlessm.com> wrote:
> On Tue, May 22, 2018 at 4:11 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> On Tue, May 22, 2018 at 5:18 PM, Andy Shevchenko
>>> Btw, I mistakenly thought that patch in the queue for-next, while it's
>>> not. So, I'm going to drop it now.
>>> Feel free to re-submit a new (better) version.
>>
>> So it's better to handle NOTIFY_KBD_BRTUP, BRTDOWN, BRTTOGGLE
>> (c4, c5, c7) in the driver and no need to pass it up to userspace? I'll work
>> out a patch for this.
>
> Yes, let's explore this approach before submitting another patch to Andy.
>
> Thanks
> Daniel

Hi Andy,
    I've made my change to set the brightness level directly in the
driver, but the
OSD doesn't show correctly correspond to the level value. The brightness shows
OK in /sys/class/led/xxxx/brighness but the OSD always shows level 0. I thought
GNOME should read the brightness from /sys before showing OSD?

Chris
