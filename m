Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDEWB1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:01:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39284 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeDEWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:01:26 -0400
X-Google-Smtp-Source: AIpwx49quqxTrzIQg+Q8uE029w6clLe9jGBV8ngSvFaTcoZ9uKNNY7GI0K9/SiPX8+sWzK/1Zz9HRw==
Subject: Re: [PATCH 2/3] objtool: Support HOSTCFLAGS and HOSTLDFLAGS
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180329004805.7278-1-labbott@redhat.com>
 <20180329004805.7278-3-labbott@redhat.com>
 <CAK7LNASd5Ano4G0Uay8MffBp0yb5TQ_1C+WaGv57pPv_J15_gQ@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <d9f3c234-27ef-943a-c931-4c597ae84924@redhat.com>
Date: Thu, 5 Apr 2018 15:01:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASd5Ano4G0Uay8MffBp0yb5TQ_1C+WaGv57pPv_J15_gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 09:42 PM, Masahiro Yamada wrote:
> 2018-03-29 9:48 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>> It may be useful to compile host programs with different flags (e.g.
>> hardening). Ensure that objtool picks up the appropriate flags.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
> 
> 
> I saw some similar patches before.
> 
> I thought they are fixing this way
> https://patchwork.kernel.org/patch/10251259/
> 
> but, I am not tacking the progress.
> 
> 
> 

That looks like a different issue since it's still not going to
pick up the HOST{C,LD}FLAGS.

> 
>>   tools/objtool/Makefile | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
>> index e6acc281dd37..0ff3bcac1ca9 100644
>> --- a/tools/objtool/Makefile
>> +++ b/tools/objtool/Makefile
>> @@ -31,8 +31,9 @@ INCLUDES := -I$(srctree)/tools/include \
>>              -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>>              -I$(srctree)/tools/objtool/arch/$(ARCH)/include
>>   WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
>> -CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
>> -LDFLAGS  += -lelf $(LIBSUBCMD)
>> +CFLAGS   += -Wall -Werror $(WARNINGS) $(HOSTCFLAGS) -fomit-frame-pointer -O2 -g \
>> +           $(INCLUDES)
>> +LDFLAGS  += -lelf $(LIBSUBCMD) $(HOSTLDFLAGS)
>>
>>   # Allow old libelf to be used:
>>   elfshdr := $(shell echo '\#include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
>> --
>> 2.16.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
