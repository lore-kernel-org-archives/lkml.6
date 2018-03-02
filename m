Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034444AbeCBQvo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:51:44 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42971 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965207AbeCBQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:51:43 -0500
X-Google-Smtp-Source: AG47ELuwECRR9Xx3naabfwMDDhRbR6fR6aO1sweiFYNxDqkLsZW5EyN+NnVaviMiWpqDLzXdS3ntUU8Gm6VYeJuucjw=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdh-KonisDC7MeTLHnZKqZo+kURS9og22GvJdp0SCJR2g@mail.gmail.com>
References: <62ac821e-290a-6b7c-ef6e-9c5e4c49de36@infradead.org> <CAHp75Vdh-KonisDC7MeTLHnZKqZo+kURS9og22GvJdp0SCJR2g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Mar 2018 17:51:22 +0100
Message-ID: <CANiq72=awLwEWv2E-kqtTQqAPLTQtSUuwAGUeALMp=qQpCE=dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: fix broken menu
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 11:50 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 4:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Having the CHARLCD Kconfig symbol between "menuconfig AUXDISPLAY"
>> and "if AUXDISPLAY" breaks the AUXDISPLAY submenus, so move the
>> CHARLCD Kconfig symbol near the end of the file so that the menu
>> display is continuous.
>>
>> Also include ARM_CHARLCD inside of the if AUXDISPLAY/endif block.
>> Geert says that it should be there.
>>
>> Fixes: 39f8ea46724e ("auxdisplay: charlcd: Extract character LCD core from misc/panel")
>>
>> Cc: stable@vger.kernel.org # v4.12
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy! Picking it up.

Cheers,
Miguel

>> ---
>>  drivers/auxdisplay/Kconfig |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20180228.orig/drivers/auxdisplay/Kconfig
>> +++ linux-next-20180228/drivers/auxdisplay/Kconfig
>> @@ -14,9 +14,6 @@ menuconfig AUXDISPLAY
>>
>>           If you say N, all options in this submenu will be skipped and disabled.
>>
>> -config CHARLCD
>> -       tristate "Character LCD core support" if COMPILE_TEST
>> -
>>  if AUXDISPLAY
>>
>>  config HD44780
>> @@ -157,8 +154,6 @@ config HT16K33
>>           Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
>>           LED controller driver with keyscan.
>>
>> -endif # AUXDISPLAY
>> -
>>  config ARM_CHARLCD
>>         bool "ARM Ltd. Character LCD Driver"
>>         depends on PLAT_VERSATILE
>> @@ -169,6 +164,8 @@ config ARM_CHARLCD
>>           line and the Linux version on the second line, but that's
>>           still useful.
>>
>> +endif # AUXDISPLAY
>> +
>>  config PANEL
>>         tristate "Parallel port LCD/Keypad Panel support"
>>         depends on PARPORT
>> @@ -448,3 +445,6 @@ config PANEL_BOOT_MESSAGE
>>           printf()-formatted message is valid with newline and escape codes.
>>
>>  endif # PANEL
>> +
>> +config CHARLCD
>> +       tristate "Character LCD core support" if COMPILE_TEST
>>
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
