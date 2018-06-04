Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeFDPqK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:46:10 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36837 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeFDPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:46:08 -0400
X-Google-Smtp-Source: ADUXVKJ3qFj8KJUReBLEqoGWD9ueyV/cvpvtvTXcCxnaHvcTxWysTjnAlGW2fxuTXWSwBRG9oUP5QQLEqvHKcfOqEl4=
MIME-Version: 1.0
In-Reply-To: <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
References: <20180604123238.82200-1-chiu@endlessm.com> <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
 <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com> <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
From: Azael Avalos <coproscefalo@gmail.com>
Date: Mon, 4 Jun 2018 09:46:06 -0600
Message-ID: <CAGdLNWESnxQLdxO8P_7q8ueeCXNNQ2LZ2jD+vg0grZkELjyyKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

Let me add my two cents on the Toshiba side.

2018-06-04 8:23 GMT-06:00 Hans de Goede <hdegoede@redhat.com>:

>
> 1) drivers/platform/x86/toshiba_acpi.c
>
> I don't know how the key on Toshiba's behaves on models where
> it is hardwired / under Windows

With Toshiba we have two types of hardware implementations:

1st gen keyboards, supporting AUTO and FN-Z
AUTO - Turns on/off automatically after some (configurable) time
FN-Z - Creates "toshiba::kbd_backlight" and it's toggled by userspace

2nd gen keyborads, supporting AUTO, ON and OFF
AUTO - Ditto
ON - Always on
OFF - Always off

The second gen keyboards are completely driven by hardware,
userspace must be checking sysfs for "kbd_backlight_mode"
changes, however, the Toshiba interface emits the 0x92
ACPI event when we have a kbd mode change, but it's not
currently being transmitted to userspace via netlink.


Saludos
Azael


-- 
-- El mundo apesta y vosotros apestais tambien --
