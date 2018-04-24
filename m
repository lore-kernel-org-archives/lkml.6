Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeDXQIn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:08:43 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39908 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeDXQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:08:39 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w3OG8axv024749
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AIpwx4/BI6nCXH4fd8pgwcxBknZbQ4pMrjESFI8I+HWjJ5EALW2CBqY6FIEfsFoVOSk6dLZC7oPxIqP7KfJgLwLzo4o=
MIME-Version: 1.0
In-Reply-To: <1841878132.11493.1524585595039@ox.credativ.com>
References: <20180424084408.28034-1-sedat.dilek@credativ.de>
 <CAK7LNATsJ2kvw4JMS-2WsU7a9wrqcYLmfHPBwQDwbAEVFa8E1g@mail.gmail.com> <1841878132.11493.1524585595039@ox.credativ.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 25 Apr 2018 01:07:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY12vXUXLNgGXwjTFN1pnWF=kft1AYDGp=KxQp2Vr-Qg@mail.gmail.com>
Message-ID: <CAK7LNATY12vXUXLNgGXwjTFN1pnWF=kft1AYDGp=KxQp2Vr-Qg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix typo s/HOST_LOADLIBES/HOST_LOADLIBS
To: Sedat Dilek <sedat.dilek@credativ.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OG8mkg015958

2018-04-25 0:59 GMT+09:00 Sedat Dilek <sedat.dilek@credativ.de>:
>> Masahiro Yamada <yamada.masahiro@socionext.com> hat am 24. April 2018 um 17:51 geschrieben:
>>
>>
>> 2018-04-24 17:44 GMT+09:00 Sedat Dilek <sedat.dilek@credativ.de>:
>> > Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
>> > ---
>> >  Makefile | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 83b6c541565a..e1869dc08288 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -366,7 +366,7 @@ HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>> >                 -fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
>> >  HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
>> >  HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
>> > -HOST_LOADLIBES := $(HOST_LFS_LIBS)
>> > +HOST_LOADLIBS := $(HOST_LFS_LIBS)
>> >
>> >  # Make variables (CC, etc...)
>> >  AS             = $(CROSS_COMPILE)as
>> > @@ -433,7 +433,7 @@ LDFLAGS :=
>> >  GCC_PLUGINS_CFLAGS :=
>> >
>> >  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
>> > -export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
>> > +export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBS
>> >  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
>> >  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>> >
>>
>> Why is this a typo?
>>
>>
>> Our Makefiles use HOST_LOADLIBES consistently.
>>
>
> OK. Do you happen to know why it is LOADLIB*E*S?


I do not know.  Historical convention.

LOADLIBES and/or LDLIBS is conventionally used.

You will see them by running 'make --print-data-base'





> - Sedat -
>
>>
>> $ git grep HOST_LOADLIB
>> Makefile:HOST_LOADLIBES := $(HOST_LFS_LIBS)
>> Makefile:export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
>> scripts/Makefile.host:          $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
>> scripts/Makefile.host:                    $(HOST_LOADLIBES)
>> $(HOSTLOADLIBES_$(@F))
>> scripts/Makefile.host:                    $(HOST_LOADLIBES)
>> $(HOSTLOADLIBES_$(@F))
>> scripts/Makefile.host:                    $(HOST_LOADLIBES)
>> $(HOSTLOADLIBES_$(@F))
>> scripts/Makefile.host:                    $(HOST_LOADLIBES)
>> $(HOSTLOADLIBES_$(@F))
>>
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
>
> --
> Mit freundlichen Grüssen,
> Sedat Dilek
>
> Telefon: +49 2166 9901-153
> E-Mail: sedat.dilek@credativ.de
> Internet: https://www.credativ.de/
>
> GPG-Fingerprint: EA6D E17D D269 AC7E 101D C910 476F 2B3B 0AF7 F86B
>
> credativ GmbH, Trompeterallee 108, 41189 Mönchengladbach
> Handelsregister: Amtsgericht Mönchengladbach, HR-Nummer: HRB 12080, UID-Nummer: DE204566209
> Geschäftsführung: Dr. Michael Meskes, Jörg Folz, Sascha Heuer
>
> **********************************************
> Jetzt neu:
> Elephant Shed - PostgreSQL Appliance
> PostgreSQL und alles was dazugehört
>
> Von Backup über Monitoring bis Reporting:
> https://elephant-shed.io/
> **********************************************
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
