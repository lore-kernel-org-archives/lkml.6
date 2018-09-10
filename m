Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC996C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0A120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0A120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeIJLlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:41:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59412 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeIJLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:41:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 427zCv4sx7z9ttC0;
        Mon, 10 Sep 2018 08:48:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9Zbu56X4XYPd; Mon, 10 Sep 2018 08:48:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 427zCv4MGhz9ttBY;
        Mon, 10 Sep 2018 08:48:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0407C8B78B;
        Mon, 10 Sep 2018 08:49:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0ySsMJ1khwLE; Mon, 10 Sep 2018 08:49:07 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C31CC8B789;
        Mon, 10 Sep 2018 08:49:07 +0200 (CEST)
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     joe@perches.com, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
Date:   Mon, 10 Sep 2018 08:49:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/09/2018 à 20:19, Nick Desaulniers a écrit :
> On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> On Fri, Sep 07, 2018 at 10:22:56AM -0700, Nick Desaulniers wrote:
>>> On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>
>>>> Cc linux-sparse@vger.kernel.org
>>>>
>>>> Le 07/09/2018 à 14:22, Christophe Leroy a écrit :
>>>>> Since commit cafa0010cd51f ("Raise the minimum required gcc version to
>>>>> 4.6"), sparse check fails as follows:
>>>>>
>>>>> [root@pc16082vm linux-powerpc]# make C=2 arch/powerpc/kernel/process.o
>>>>>     CALL    scripts/checksyscalls.sh
>>>>>     CHECK   scripts/mod/empty.c
>>>>> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
>>>>> old - please upgrade it.
>>>>>     CHECK   arch/powerpc/kernel/process.c
>>>>> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
>>>>> old - please upgrade it.
>>>>>
>>>>>
>>>>> I have sparse version 0.5.2
>>>>>
>>>>> What can be done to fix that ?
>>>>>
>>>>> Christophe
>>>
>>> Oof, sorry Christophe.  Looks like that's the latest version of sparse:
>>> https://sparse.wiki.kernel.org/index.php/Main_Page#News
>>>
>>> I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
>>> __GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
>>> expanding them to something, otherwise you'd have seen the error then,
>>> too.  The previous check was GCC < 3.3, now it's GCC < 4.6.
>>
>> Sparse expand these macros to the same version than the compiler used
>> to compile GCC. I find a bit strange though to have sparse v0.5.2 but
>> using an old compiler.
> 
> So Christophe must have a version of gcc < 4.6 installed somewhere?
> Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
> point to an old version of gcc maybe?

Indeed it looks like sparse expand these macros to the version of the 
compiler it was compiled with.

I'm building kernels for a powerpc platforms, with CROSS_COMPILE set to 
ppc-linux- and ppc-linux-gcc being version 5.4

However my build machine is a CentOS6 and the native gcc has version 
4.4.7, so sparse expands that version.

Is there a way to get sparse in line with my cross compiler version and 
not with the local native version ?

Christophe

> 
>>
>> Also, it's worth to look at what is said in this email:
>>    https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com/
>>
>>
>> -- Luc
> 
> 
> 
