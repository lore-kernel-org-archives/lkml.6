Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBUDUd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:20:33 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6917 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbeBUDUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:20:32 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37142766"
Subject: Re: why scripts/link-vmlinux.sh has a final build of init/
To: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
 <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com>
 <6f19ae3f-249e-2d20-dcd6-e34c475a2638@cn.fujitsu.com>
 <CAK7LNATofb+-Y=hTQd2B2rGW=-XrQ9wN0+nXozhLpPv+dhWHfg@mail.gmail.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <ccc092fc-3d13-71e1-2029-82b70079807e@cn.fujitsu.com>
Date: Wed, 21 Feb 2018 11:20:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATofb+-Y=hTQd2B2rGW=-XrQ9wN0+nXozhLpPv+dhWHfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: B35A948AE762.A7902
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late.

On 02/14/2018 07:31 PM, Masahiro Yamada wrote:
> 2018-02-13 16:08 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
> 
>> BTW, I still have 2 questions.
>>
>> 1. In final build, why need
>>
>>    GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
>>
>> Doesn't GCC_PLUGINS_CFLAGS already exist in the environment?
>>
>> I also tested the Randomizing Structure Layout plugin with this patch,
>> the plugin seems works in my test.
> 
> 
> I have not tested, but GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
> is probably unnecessary.
> 
> 
> 
>> 2. scripts/link-vmlinux.sh seems just handle only one argument: clean.
>> So why shouldn't it be:
> 
> 
> To detect the change of $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
> because link-vmlinux.sh depends on them.
> 

I understood, I missed the existence of .vmlinux.cmd file.
Thanks very much, Masahiro-san.

-- 
Sincerely,
Cao jin

> 
>> diff --git a/Makefile b/Makefile
>> index ccd981892ef2..21d93b545381 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -998,7 +998,7 @@ ARCH_POSTLINK := $(wildcard
>> $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
>>
>>  # Final link of vmlinux with optional arch pass after final link
>>  cmd_link-vmlinux =                                                 \
>> -       $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
>> +       $(CONFIG_SHELL) $<;                                         \
>>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>>
>>  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
> 
> 
> 
