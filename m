Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6AA6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F40208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsdKgc1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F40208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755178AbeFNNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:20:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45292 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbeFNNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:20:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so9367284lfe.12;
        Thu, 14 Jun 2018 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=juoy1xRKOpGTtgYFR0wLSYo+E0x9ADAZykFQD6gR4GQ=;
        b=HsdKgc1RnxcBFUMINkYWjwNH0R3jDN768I6ofEkMpqGo2lWizEU7UHB4Fd/wzDoZs0
         goCABtKXNuSdd/r79jjkXJEY56KChRc3+YEoEKU9mBNM3o+M451ABDVKlyKbdqKMrg53
         pqu5YOYzxhMRKsz+5u48Wfffl+hOFWqqA2Ch/9Ok6acgtX6zOpMTVxPF14kn0eJjCnQq
         Ic4NYrYMnU4BkB8bFxPWwrDWA7PyoGXHnL4sv1XUJW9SmElC8kynp3x1iUvQLDU3r38d
         5mQJ9xVKiI6mWUhyjV+5HPetA3ocAhED9jxA0kovN7YbKsiWGED7S4PTFgLsQNJJ2z2y
         8hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=juoy1xRKOpGTtgYFR0wLSYo+E0x9ADAZykFQD6gR4GQ=;
        b=lkVYpnEpxgwgrWw3+1VEFIBfe9Yp4ZwmnjVhYLn5+Bw7CKkJiFayMHrXzjnzYThYlS
         FzE7Z4aDhVUinxuw2kbCmyVgFGW7yze2nwEgLX8fGjs63QX3bW+tp+Otp9coWRn97Pld
         E/s3csgiizqc4Igou0souKsAHJfKut7GsFDAoR3/6ivVeLBoFbnS5jjgy2y/NVudaebR
         hJDQ2mUDaDvMSms0CU4QieeOpYefkfxGW1pU0tjtx3Nv7kWaT7HCdS1XPyzaJbD2J64G
         Y52H3biYmJ/AMASDPK82A10RRxXCdJQXegxEmCBxqaaNKK/7z/9F1iqcjiywc80e+nxU
         46Tg==
X-Gm-Message-State: APt69E0LNKwpeziystLTbboacY1rYWL8o6TnqZgGSsmYRAbVjhVtb44+
        uxngQgdxQylxC/56CrrdlABJbic88tSYy/zLmlM=
X-Google-Smtp-Source: ADUXVKLddUZ27eVY9aaPsIMb0jusscfIwolKfMS0ntUAtw4lyZ45l3OHTb98Vo6tDq/tf0mdPtwrWjXbqVU+8JHLQVE=
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr1785206ljh.1.1528982454305;
 Thu, 14 Jun 2018 06:20:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 06:20:53 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <20180613210518.113983-1-ndesaulniers@google.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jun 2018 15:20:53 +0200
Message-ID: <CA+icZUWW8yxxdQHC6gkqXnTkW70tLbL1Rmpa5dfVyihWSb9hLQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] extern inline native_save_fl for paravirt
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        manojgupta@google.com, ghackmann@google.com, tstellar@redhat.com,
        keescook@google.com, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, linux-kbuild@vger.kernel.org,
        geert@linux-m68k.org, will.deacon@arm.com, mawilcox@microsoft.com,
        Arnd Bergmann <arnd@arndb.de>, rientjes@google.com,
        acme@redhat.com, pombredanne@nexb.com, aryabinin@virtuozzo.com,
        kstewart@linuxfoundation.org, boris.ostrovsky@oracle.com,
        jan.kiszka@siemens.com, rostedt@goodmis.org,
        kirill.shutemov@linux.intel.com, ard.biesheuvel@linaro.org,
        akataria@vmware.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        jpoimboe@redhat.com, mka@chromium.org, thomas.lendacky@amd.com,
        tweek@google.com, mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:05 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> paravirt depends on a custom calling convention (callee saved), but
> expects this from a static inline function that it then forces to be
> outlined. This is problematic because different compilers or flags can
> then add a stack guard that violates the calling conventions.
>
> Uses extern inline with the out-of-line definition in assembly to
> prevent compilers from adding stack guards to the outlined version.
>
> Other parts of the codebase overwrite KBUILD_CFLAGS, which is *extremely
> problematic* for extern inline, as the sematics are completely the
> opposite depending on what C standard is used.
> http://blahg.josefsipek.net/?p=529
>
> Changes since v4:
>   Take Arnd's and hpa's suggestions properly feature detect gnu_inline
>   attribute to support gcc 4.1.
>
> Changes since v3:
>   Take Joe's suggestion to hoist __inline__ and __inline out of
>   conditional block.
>
> Changes since v2:
>   Take hpa's _ASM_ARG patch into the set in order to simplify cross
>   32b/64b x86 assembly and rebase my final patch to use it.  Apply
>   Sedat's typo fix to commit message and sign off on it. Take Joe's
>   suggestion to simplify __inline__ and __inline. Add Arnd to list of
>   folks who made helpful suggestions.
>
> Changes since v1:
>   Prefer gnu_inline function attribute instead of explicitly setting C
>   standard compiler flag in problematic Makefiles. We should instead
>   carefully evaluate if those Makefiles should be overwriting
>   KBUILD_CFLAGS at all. Dropped the previous first two patches and added
>   a new first patch.
>
> H. Peter Anvin (1):
>   x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>
>
> Nick Desaulniers (2):
>   compiler-gcc.h: add gnu_inline to all inline declarations
>   x86: paravirt: make native_save_fl extern inline
>
>  arch/x86/include/asm/asm.h      | 59 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/irqflags.h |  2 +-
>  arch/x86/kernel/Makefile        |  1 +
>  arch/x86/kernel/irqflags.S      | 26 +++++++++++++++
>  include/linux/compiler-gcc.h    | 29 ++++++++++++----
>  5 files changed, 109 insertions(+), 8 deletions(-)
>  create mode 100644 arch/x86/kernel/irqflags.S
>
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>

Hi Nick,

thanks for v5 of your patchset.

I was able to boot into bare metal.

root@iniza:~# cat /proc/version
Linux version 4.14.49-1-iniza-llvmlinux (sedat.dilek@gmail.com@iniza)
(clang version 7.0.0- (trunk)) #1 SMP 2018-06-14

root@iniza:~# dpkg -l | grep clang-7
ii  clang-7
1:7~svn334344-1~exp1+0~20180609091248.1814~1.gbp8ccab3 amd64        C,
C++ and Objective-C compiler

Feel free to add my Tested-By.

Regards,
- Sedat -
