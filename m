Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC54AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA02086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CA02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIJOvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:51:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36544 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeIJOvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:51:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4283Pw3ZYgz9ttC6;
        Mon, 10 Sep 2018 11:57:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1-ZewPE5IifL; Mon, 10 Sep 2018 11:57:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4283Pw30VMz9ttBx;
        Mon, 10 Sep 2018 11:57:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE3FB8B78F;
        Mon, 10 Sep 2018 11:58:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Z2ZfvjQkw2WE; Mon, 10 Sep 2018 11:58:04 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DAAB8B798;
        Mon, 10 Sep 2018 11:58:02 +0200 (CEST)
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org,
        linuxppc-dev@lists.ozlabs.org
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
Date:   Mon, 10 Sep 2018 09:56:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180910092835.v5nex5nzfgtl475m@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 09:28 AM, Luc Van Oostenryck wrote:
> On Mon, Sep 10, 2018 at 08:49:07AM +0200, Christophe LEROY wrote:
>> Le 07/09/2018 à 20:19, Nick Desaulniers a écrit :
>>> On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
>>>>
>>>> Sparse expand these macros to the same version than the compiler used
>>>> to compile GCC. I find a bit strange though to have sparse v0.5.2 but
>>>> using an old compiler.
>>>
>>> So Christophe must have a version of gcc < 4.6 installed somewhere?
>>> Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
>>> point to an old version of gcc maybe?
>>
>> Indeed it looks like sparse expand these macros to the version of
>> the compiler it was compiled with.
>>
>> I'm building kernels for a powerpc platforms, with CROSS_COMPILE set
>> to ppc-linux- and ppc-linux-gcc being version 5.4
>>
>> However my build machine is a CentOS6 and the native gcc has version
>> 4.4.7, so sparse expands that version.
> 
> OK, I see.
>   
>> Is there a way to get sparse in line with my cross compiler version
>> and not with the local native version ?
> 
> When cross-compiling, there is also things like the machine word-size
> and the endianness to take in account (they also default to the
> native compiler used to compile sparse itself) as well as a few
> defines (like __PPC64__). To be in line with your cross-compiler
> you can use to the wrapper 'cgcc' (installed with sparse) and call
> it, for example, like this:
> 	$ export REAL_CC=ppc-linux-gcc
> 	$ cgcc -target=ppcc64 -D_CALL_ELF=2 -D__GCC__=5 -D__GCC_MINOR__=4 ...
> or, since this is for the kernel:
> 	$ export REAL_CC=ppc-linux-gcc
> 	$ make CHECK='cgcc -target=ppcc64 ...
> 
> 
> I think this should solve it. Do not hesitate to report any
> difficulties you may encounter.

# export REAL_CC=ppc-linux-gcc
# make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5 
-D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
scripts/kconfig/conf  --syncconfig Kconfig
#
# configuration written to .config
#
   UPD     include/config/kernel.release
   UPD     include/generated/utsrelease.h
   CC      kernel/bounds.s
   CC      arch/powerpc/kernel/asm-offsets.s
   CALL    scripts/checksyscalls.sh
   CHECK   scripts/mod/empty.c
Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

Christophe

> 
> -- Luc
> 
