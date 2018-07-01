Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D055FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E164256AF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Frm0CCl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E164256AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031193AbeGARjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:39:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39803 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031133AbeGARjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:39:45 -0400
Received: by mail-io0-f196.google.com with SMTP id e13-v6so12764936iof.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ksHAGDNVRcFPFtfTGyNZIlTNEz3xNHWReHPNca+znBk=;
        b=Frm0CCl8YgcwUHpOtvcn3ychgl+R6e2NghiV9W/kZU3GxvpQeiHuLKNdLUHYVgl7Pr
         1/9igwYaSvIJFHtLm37yLpm4wNBySPBVesZ746jHs1clpdM/0ps4VIFhLFxk/1Q31d9t
         WvOdxOSvMHNiIutcY/EZp0GILMtsPZW7a4Skw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ksHAGDNVRcFPFtfTGyNZIlTNEz3xNHWReHPNca+znBk=;
        b=pBOzwZJsJY/5RyfWalZQYw3D2kkj/PmYAjzPzFUIm6KeyPgeFUgG8zkQ/6bTIqWXBQ
         0OaJxX62/FQL3tb9XsA+LrtvrkamFb4yrmIY+cgT7iDqG0w232URKJI1/BbSKdoapxUj
         L/ZH2G7I5twpLkk3Rkqvg5GcV9kyruVr/vJr1plXfCJyNqXFPkhefChjq+EnlVtumr01
         RK4c75uDVazQ83r61Xvx/vdj/Yt0Jfz1JAozMoleylomrjr4mOjhA1BgiEk3lxnStTY0
         6f28SYU1FpABgOjNOl/OBqSPIFL7005NYp+PC2KvEXoQduRbLIpt8Nn3zWKIi+8SVP0l
         l1Xg==
X-Gm-Message-State: APt69E2+9u0JIblxj2BY8pqMtzIDtviGKycHT0fjpck4d/H8ndeWsIuI
        9RCy9hMHSFsznitCP6h0sB1hH1ZQW9DeWGVZbofEaw==
X-Google-Smtp-Source: AAOMgpfAHltvI5/UfiMScNeKX4TF9GgL9mJH1bJsDpC1RNjy6j3ZvM+tJux6WZXSpzkjL66Uq//4PgMsniFpeKOeQbU=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr19518883iob.60.1530466783927;
 Sun, 01 Jul 2018 10:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 10:39:43 -0700 (PDT)
In-Reply-To: <20180627151510.GE30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org> <20180627151510.GE30631@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 1 Jul 2018 19:39:43 +0200
Message-ID: <CAKv+Gu-dkVEtRmvZwiAUpxPSHrkTVvzeGhCwczEmxRjcgfd+LQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] add support for relative references in special sections
To:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
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
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 17:15, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
>> This adds support for emitting special sections such as initcall arrays,
>> PCI fixups and tracepoints as relative references rather than absolute
>> references. This reduces the size by 50% on 64-bit architectures, but
>> more importantly, it removes the need for carrying relocation metadata
>> for these sections in relocatable kernels (e.g., for KASLR) that needs
>> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
>> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
>> vs 4 byte relative reference)
>>
>> Patch #3 was sent out before as a single patch. This series supersedes
>> the previous submission. This version makes relative ksymtab entries
>> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
>> than trying to infer from kbuild test robot replies for which architectures
>> it should be blacklisted.
>>
>> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
>> and sets it for the main architectures that are expected to benefit the
>> most from this feature, i.e., 64-bit architectures or ones that use
>> runtime relocations.
>>
>> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
>> ksymtab/kcrctab sections in decompressor and EFI stub objects when
>> rebuilding existing C files to run in a different context.
>
> I had a small question on patch 3, but it's really for my understanding.
> So, for patches 1-3:
>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
>

Thanks all.

Thomas, Ingo,

Except for the below tweak against patch #3 for powerpc, which may
apparently get confused by an input section called .discard without
any suffixes, this series is good to go, but requires your ack to
proceed, so I would like to ask you to share your comments and/or
objections. Also, any suggestions or recommendations regarding the
route these patches should take are highly appreciated.

Ard.


diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2d9c63f41031..61c844d4ab48 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -287,7 +287,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-       static void * __attribute__((section(".discard"), used))        \
+       static void * __attribute__((section(".discard.addressable"), used)) \
                __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;

 /**
