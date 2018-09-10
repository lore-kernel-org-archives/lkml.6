Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D852087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D852087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeIJS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:59:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIJS7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:59:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4288vV0Btkz9ttC1;
        Mon, 10 Sep 2018 16:05:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vh5qUSx7XLMk; Mon, 10 Sep 2018 16:05:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4288vT6fzzz9ttBp;
        Mon, 10 Sep 2018 16:05:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 064D68B7B1;
        Mon, 10 Sep 2018 16:05:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OZm3-E2kmn1D; Mon, 10 Sep 2018 16:05:34 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB4938B7A5;
        Mon, 10 Sep 2018 16:05:34 +0200 (CEST)
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
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
 <20180910135604.j2phe7r3k5vs6cik@ltop.local>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
Date:   Mon, 10 Sep 2018 16:05:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910135604.j2phe7r3k5vs6cik@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/09/2018 à 15:56, Luc Van Oostenryck a écrit :
> On Mon, Sep 10, 2018 at 01:19:07PM +0000, Christophe Leroy wrote:
>>
>>
>> On 09/10/2018 11:34 AM, Luc Van Oostenryck wrote:
>>> On Mon, Sep 10, 2018 at 09:56:33AM +0000, Christophe Leroy wrote:
>>>>
>>>> # export REAL_CC=ppc-linux-gcc
>>>> # make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5
>>>> -D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
>>>> scripts/kconfig/conf  --syncconfig Kconfig
>>>> #
>>>> # configuration written to .config
>>>> #
>>>>     UPD     include/config/kernel.release
>>>>     UPD     include/generated/utsrelease.h
>>>>     CC      kernel/bounds.s
>>>>     CC      arch/powerpc/kernel/asm-offsets.s
>>>>     CALL    scripts/checksyscalls.sh
>>>>     CHECK   scripts/mod/empty.c
>>>> Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
>>>> make[2]: *** [scripts/mod/empty.o] Error 1
>>>> make[1]: *** [scripts/mod] Error 2
>>>> make: *** [scripts] Error 2
>>>
>>> OK. Clearly nobody has ever used it so :(
>>> There is an infinite loop because cgcc use the env var CHECK
>>> to call sparse while kbuild use CHECK to call cgcc here.
>>>
>>> The following seems to work here.
>>> $ export REAL_CC=ppc-linux-gcc
>>> $ make CHECK="CHECK=sparse cgcc -target=ppc ...
>>
>> Not yet ...
>>
>> [root@pc16082vm linux-powerpc]# export REAL_CC=ppc-linux-gcc
>> [root@pc16082vm linux-powerpc]# make CHECK="CHECK=sparse cgcc
>> -target=ppc -D_CALL_ELF=2 -D__GNUC__=5 -D__GNUC_MINOR__=4" C=2
>> arch/powerpc/kernel/process.o
>>    CALL    scripts/checksyscalls.sh
>>    CHECK   scripts/mod/empty.c
>> <command-line>:0:0: warning: "__STDC__" redefined
>> <built-in>: note: this is the location of the previous definition
>> /opt/cldk-1.4.0/lib/gcc/ppc-linux/5.4.0/../../../../ppc-linux/lib/crt1.o:(.rodata+0x4):
>> undefined reference to `main'
>> collect2: error: ld returned 1 exit status
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> make[1]: *** [scripts/mod] Error 2
>> make: *** [scripts] Error 2
> 
> OK. Using cgcc creates more problems that it solves and this file
> scripts/mod/empty.c is weird.
> Dropping cgcc and simply giving the GCC version to sparse works for
> me here (the needed defines are given by arch/powerpc/Makefile) but
> for sure I don't have the same environment as you have:
>    $ make CHECK="sparse -D__GNUC__=5 -D__GNUC_MINOR__=4" ...

This time it works, thanks for your help.

Should we find a may to automate that in the Makefile when CROSS_COMPILE 
is defined ?

> 
> Bonne chance,

Merci

Christophe
