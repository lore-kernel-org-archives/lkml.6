Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86079C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3748C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3748C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937763AbeFSPDt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937547AbeFSPDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:03:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2AACAD98;
        Tue, 19 Jun 2018 15:03:44 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] extern inline native_save_fl for paravirt
To:     Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jpoimboe@redhat.com, mka@chromium.org, thomas.lendacky@amd.com,
        tweek@google.com, mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com
References: <20180613210518.113983-1-ndesaulniers@google.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6a36db0d-e790-48d6-183a-263c355531b6@suse.com>
Date:   Tue, 19 Jun 2018 17:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613210518.113983-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 23:05, Nick Desaulniers wrote:
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

For the series:

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
