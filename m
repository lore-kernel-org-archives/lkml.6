Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CBC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27225E61
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcgtJBH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27225E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965516AbeF0PVh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:21:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33484 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964834AbeF0PVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:21:34 -0400
Received: by mail-io0-f195.google.com with SMTP id d185-v6so2269916ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OyEJcaBYlGr1pe/DUkTWY88VpPjStKt/hB5EqVgM4UQ=;
        b=AcgtJBH8IpM8+/773zi6y8ZCZZrivD8JV2rRGpkadvbNpnyu2HwJH2v4AtB29Y/NrO
         mlAcmn30OSRNhydo66u1ZDwUEY8WCJBGR0zakh0x+BjFucL8oi7qPQneu60Xb1WMC86a
         lfiEu9tVK3B2vIKlXa9wcBuWdJRnjQEzyD1ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OyEJcaBYlGr1pe/DUkTWY88VpPjStKt/hB5EqVgM4UQ=;
        b=rNHlKQoTMZ/4FZJV7rQVCAEfb7jj5I47/D9IR5N/P7+VI7aduhuSfEB2945HLyi3Ti
         0Xmlu+0b1L8KKRYnaHEV6rOFBXltDGwQo+N4/jwMXci0K0G7fG+UV+FNjM9CXLOMDZDp
         +x67eEWsaJpqdMSGtpGJhB//zzOWEt4211xGr1JGoZNoSq8pD8bSnMKFRaZ69VR4P0qJ
         n2hnT5EtwJ3EeEHV6mxOEioj8+9LCMNaDM1LE1a24lA5pFr0rDdzoDEvyF/tcBHpL6Cu
         tERmY7LZdC5W9Y3QUVZQuuYO9c5lCnlzeel1D2gIx73IlSNIk4grGz88XM78EUOyWQ0m
         pupA==
X-Gm-Message-State: APt69E1cRjT+L504gEYP6Kub0mxpmNqtGATqMAfS2hssol9o9T77Um4u
        wQySjvLjimkdet9yH8MP+DVHod42kN4dWs8gpamlwYl2
X-Google-Smtp-Source: AAOMgpcCo7MRiU3ueNwghGQz1Q0PMbTVa/7ftUxiR1rrWa8yrwHcUX9BKuXasjJf961oXq15Y95RIj4rII85DvFY1qc=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr5603421iob.60.1530112893657;
 Wed, 27 Jun 2018 08:21:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 08:21:33
 -0700 (PDT)
In-Reply-To: <20180627151339.GD30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-4-ard.biesheuvel@linaro.org> <20180627151339.GD30631@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Jun 2018 17:21:33 +0200
Message-ID: <CAKv+Gu8v4VGzKSQ1F6r6B_U2xhffM1EJQWCJYuf+4-xsf_hjuw@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] module: use relative references for __ksymtab entries
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 17:13, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Tue, Jun 26, 2018 at 08:27:58PM +0200, Ard Biesheuvel wrote:
>> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
>> entries, each consisting of two 64-bit fields containing absolute
>> references, to the symbol itself and to a char array containing
>> its name, respectively.
>
> [...]
>
>> diff --git a/include/linux/export.h b/include/linux/export.h
>> index ea7df303d68d..ae072bc5aacf 100644
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -18,12 +18,6 @@
>>  #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>>
>>  #ifndef __ASSEMBLY__
>> -struct kernel_symbol
>> -{
>> -     unsigned long value;
>> -     const char *name;
>> -};
>> -
>>  #ifdef MODULE
>>  extern struct module __this_module;
>>  #define THIS_MODULE (&__this_module)
>> @@ -54,17 +48,47 @@ extern struct module __this_module;
>>  #define __CRC_SYMBOL(sym, sec)
>>  #endif
>>
>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> +#include <linux/compiler.h>
>> +/*
>> + * Emit the ksymtab entry as a pair of relative references: this reduces
>> + * the size by half on 64-bit architectures, and eliminates the need for
>> + * absolute relocations that require runtime processing on relocatable
>> + * kernels.
>> + */
>> +#define __KSYMTAB_ENTRY(sym, sec)                                    \
>> +     __ADDRESSABLE(sym)                                              \
>> +     asm("   .section \"___ksymtab" sec "+" #sym "\", \"a\"  \n"     \
>> +         "   .balign 8                                       \n"     \
>
> Can we use KSYM_ALIGN here instead of 8, or do we need the 8-byte alignment
> even on 32-bit architectures?
>

We don't *need* 8 byte alignment on any architecture, but since the
structure itself is 8 bytes in size and we have a sizable array of
them, it makes sense to align them to 8 bytes.
