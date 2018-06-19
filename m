Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D80C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soSNKrSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE0E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937882AbeFSN3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:29:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36759 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937255AbeFSN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:29:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so18119890oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryFV8XLk6eo4bt6lC+G9gHpuGOvM/5p6TO5Thyty7G4=;
        b=soSNKrSROwqK2zFta743uovLvRAXFum/dou4GCObNUbpW+Ehs2vuxg6fglQA7yjEIO
         nlkpxILxYW+M0JbIS5xzcvvLI01pfkKRJo4/FqxVuaEmUQBK9vBomU8B7Tm+KYcokQ7w
         zgCrMdlSuhEKy6aU5OGtVyGKghKXJe4acQUv2DYSPu9/HIFgtw4LTGUfPAhW5PV87T6a
         hbJmGzCLaM0uH/JAQ7jVHvqkN4unv1u9Zkzv1tdmJuohFV6NYGkEcfaBrHcAkRDYHBjJ
         S1GQOF4jRp7/YyFd0ODJIRPdHUSr9JXoYWHVjN3QJWWCmYFw6USvQnnKl4nefsLOMscm
         NLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryFV8XLk6eo4bt6lC+G9gHpuGOvM/5p6TO5Thyty7G4=;
        b=pmCs1VpHg/CZDvU+vYMhoAS2OsBFUt9zr8fc/OW0KowKz/OHSPpNbHJY4XKdRK+lWB
         DxMUpqCwiNt0lXIu/UjiaTOcpUxwI5JQOOgkRKnBEwQMu/xrFBst66hs+m5tG7A/EYfj
         tfyvfqAUwuB3CkxStdy6OuAhdxFX9m/i8bT4hZZncCWBS8G2utcWmgNtAOA3yVzBTjfj
         4NIwiLGwFKcPBmgXGM4NdQ2pyMnGuEBRuoDoC0hyJVLW6q37kGROY7o5eMf8bOjBMQcx
         QiYiSTBmdhVrMUSpYDqV/EzepGfCFhQ/fQ/l5P7uSfzZVuU6JqpQPvIXYwx+aBQYB76Z
         z5kQ==
X-Gm-Message-State: APt69E0x81G+0ia9Be+bZGwBbEO0IFCDq5rjhIKqmcIbFyTP7r0xMhkP
        OcQE96kSKHEbN6KeQHPadGD0eQ==
X-Google-Smtp-Source: ADUXVKIKgWjQzLel4ZfxuOe7BYLoeK69j+Nu7pYusowVdGz2k4sOpO1WH1whQWeCX24vi2gHDtwqMg==
X-Received: by 2002:aca:5c02:: with SMTP id q2-v6mr9844309oib.324.1529414951189;
        Tue, 19 Jun 2018 06:29:11 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r131-v6sm7165330oih.16.2018.06.19.06.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 06:29:09 -0700 (PDT)
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
Date:   Tue, 19 Jun 2018 06:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 06/19/2018 12:48 AM, Ard Biesheuvel wrote:
> On 19 June 2018 at 07:07, Guenter Roeck <linux@roeck-us.net> wrote:
>> Modern assemblers may take the ISA into account when resolving local
>> symbols. This can result in bad address calculations when using badr
>> in the wrong location since the offset + 1 may be added twice, resulting
>> in an even address target for THUMB instructions. This in turn results
>> in an exception at (destination address + 2).
>>
>> Unhandled exception: IPSR = 00000006 LR = fffffff1
>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
>> Hardware name: MPS2 (Device Tree Support)
>> PC is at ret_fast_syscall+0x2/0x58
>> LR is at tty_ioctl+0x2a5/0x528
>> pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
>> sp : 21825fa8  ip : 0000001c  fp : 21a95892
>> r10: 00000000  r9 : 21824000  r8 : 210091c0
>> r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
>> r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
>> xPSR: 4000000b
>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
>> Hardware name: MPS2 (Device Tree Support)
>> [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
>> [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)
>>
>> Fix the problem by using a logical or instead of an addition. This is
>> less efficient but guaranteed to work.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> RFC: I don't really like this, but my ARM assembler knowledge is quite
>> limited. Just dropping the "+ 1" from badr doesn't work because some
>> other code needs it (the image hangs completely if I try that).
>> Ultimately I don't even know if the invoke_syscall macro should just
>> have used adr instead of badr (but then how did this ever work ?).
>>
>> Seen with various toolchains based on gcc 7.x and binutils 2.30 when
>> building and testing MPS2 images.
>>
> 
> Hello Guenter,
> 
> This issue has been discussed before. It appears the binutils people
> suddenly started caring about the thumb annotation of local function
> symbols, resulting in behavior that is not backwards compatible.
> 
> https://marc.info/?l=linux-arm-kernel&m=151143776213636&w=2
> https://sourceware.org/bugzilla/show_bug.cgi?id=21458
> 
> Can you try the fix below please?
> 
>>   arch/arm/include/asm/assembler.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 0cd4dccbae78..24c87ff2060f 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -195,7 +195,8 @@
>>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>>          .macro  badr\c, rd, sym
>>   #ifdef CONFIG_THUMB2_KERNEL
>> -       adr\c   \rd, \sym + 1
>> +       adr\c   \rd, \sym
>> +       orr     \rd, #1
>>   #else
>>          adr\c   \rd, \sym
>>   #endif
>> --
>> 2.7.4
> 
> ----------8<------------
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Tue, 16 Jan 2018 12:12:45 +0000
> Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit twice
> 
> To work around recent issues where ADR references to Thumb function
> symbols may or may not have the Thumb bit set already when they are
> resolved by GAS, reference the symbol indirectly via a local symbol
> typed as 'object', stripping the ARM/Thumb annotation.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 6ae42ad29518..dd2ff94ad90b 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -195,13 +195,19 @@
>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>          .macro  badr\c, rd, sym
>   #ifdef CONFIG_THUMB2_KERNEL
> -       adr\c   \rd, \sym + 1
> +       __badr  \c, \rd, \sym
>   #else
>          adr\c   \rd, \sym
>   #endif
>          .endm
>          .endr
> 
> +       /* this needs to be a separate macro or \@ does not work correctly */
> +       .macro  __badr, c, rd, sym
> +       .eqv    .Lsym\@, \sym
> +       adr\c   \rd, .Lsym\@ + 1

Wild shot, but the following works for me.

	.eqv    .Lsym\@, \sym + 1
	adr\c	\rd, .Lsym\@

Does it make sense ?

Thanks,
Guenter
