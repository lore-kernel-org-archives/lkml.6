Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeFEB7S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:59:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFEB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:59:15 -0400
Date: Mon, 4 Jun 2018 18:59:00 -0700
From: Darren Hart <dvhart@infradead.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle
 support
Message-ID: <20180605015900.GC47042@localhost.localdomain>
References: <20180503030438.51150-1-chiu@endlessm.com>
 <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
 <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
 <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
 <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
 <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
 <CAB4CAweonk3RseCO2BdAiyc0XjfU6GC+c3W9H3AZkgrJMKbnVQ@mail.gmail.com>
 <CAD8Lp46Xmk_m5Y4M_oXigOkf=z-3O+5F3QaA3AQvgAT4DbP4ew@mail.gmail.com>
 <CAB4CAwfEyS0j+q_hM8u-XHU_rEFq3604gjsSw4d_4mhaiz=G-A@mail.gmail.com>
 <2634178c3b1fb2c1174eae0d67419e285e2f7c26.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2634178c3b1fb2c1174eae0d67419e285e2f7c26.camel@sipsolutions.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 11:27:43AM +0200, Benjamin Berg wrote:
> Hi,
> 
> On Thu, 2018-05-24 at 16:33 +0800, Chris Chiu wrote:
> > I've made my change to set the brightness level directly in the
> > driver, but the
> > OSD doesn't show correctly correspond to the level value. The brightness shows
> > OK in /sys/class/led/xxxx/brighness but the OSD always shows level 0. I thought
> > GNOME should read the brightness from /sys before showing OSD?
> 
> Sorry for the late response.
> 
> There is a special mechanism to report that the HW changed the
> brightness. This works using the "brightness_hw_changed" sysfs
> attribute. So you will need to set the LED_BRIGHT_HW_CHANGED flag on
> the LED and then call led_classdev_notify_brightness_hw_changed to make
> it work.
> 
> Userspace should correctly show the OSD when this is done.

This makes sense. Userspace can't be aware of every platforms sys files,
so there needs to be a common mechanism. LED_BRIGHT_HW_CHANGED makes
sense.

-- 
Darren Hart
VMware Open Source Technology Center
