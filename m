Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCOGhX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:37:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62131 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCOGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:37:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2F6b8RM003229
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AG47ELu8N7Na4/lvatP+cocTQnR/nDx3A5GrR6U55TZh3yzTqAKdmkeddPA8QTqrmX4nqCh0dKyds4a09LCQ9AWPkGQ=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1803141419550.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
 <1521045861-22418-6-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141419550.28583@knanqh.ubzr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 15:36:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTFjexL0gmtyL0QNpRQUeTPYsjoOxb3+9F20vFaE3Xdg@mail.gmail.com>
Message-ID: <CAK7LNATTFjexL0gmtyL0QNpRQUeTPYsjoOxb3+9F20vFaE3Xdg@mail.gmail.com>
Subject: Re: [PATCH 5/7] kbuild: hide CONFIG_TRIM_UNUSED_KSYMS code from
 external module building
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 3:32 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Thu, 15 Mar 2018, Masahiro Yamada wrote:
>
>> If CONFIG_TRIM_UNUSED_KYMS is enabled, KBUILD_MODULES is set.
>
> Not when you do "make vmlinux" though.

I could not understand this.

Unless I am missing something,
I think this code is always parsed.



>> This code is unneeded for external module building because
>> KBUILD_MODULES is always set.  Move this code inside "ifeq
>> ($(KBUILD_EXTMOD),)" conditional.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>
>> ---
>>
>>  Makefile | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index decc870..e60b16f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -603,13 +603,6 @@ else
>>  include/config/auto.conf: ;
>>  endif # $(dot-config)
>>
>> -# For the kernel to actually contain only the needed exported symbols,
>> -# we have to build modules as well to determine what those symbols are.
>> -# (this can be evaluated only once include/config/auto.conf has been included)
>> -ifdef CONFIG_TRIM_UNUSED_KSYMS
>> -  KBUILD_MODULES := 1
>> -endif
>> -
>>  # The all: target is the default when no target is given on the
>>  # command line.
>>  # This allow a user to issue only 'make' to build a kernel including modules
>> @@ -1010,6 +1003,13 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
>>         "$(MAKE) -f $(srctree)/Makefile vmlinux"
>>  endif
>>
>> +# For the kernel to actually contain only the needed exported symbols,
>> A+# we have to build modules as well to determine what those symbols
> are.
>> +# (this can be evaluated only once include/config/auto.conf has been included)
>> +ifdef CONFIG_TRIM_UNUSED_KSYMS
>> +  KBUILD_MODULES := 1
>> +endif
>> +
>>  autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
>>
>>  $(autoksyms_h):
>> --
>> 2.7.4
>>
>>



-- 
Best Regards
Masahiro Yamada
