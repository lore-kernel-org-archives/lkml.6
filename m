Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3605321-1527874645-2-1245041603205816803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527874645; b=AomXQuQzaItWkAjM3uv3cN5dkmmyG9+Fqk1cJrZw1xhWUs1cdW
    w4+/koVIy+c8QkiI3EfxyL9Lqba9QhMKfH49/FKp8QpWjUruNIBVq1YPOM6XyqP0
    0dhpICttidTdyyB4n5CAyzBsbTWjBokblkh7tzLKTBGTJVMqwu2pC34T4i8U06Bd
    x2XwgzaySWyVCETK+mhgVwIB7UG0yTuh9uOdtwfD3p7YDscxgTxt9zwiOToYdRgY
    w4OsEdKnhE8mdUbdEuKz/guLjQkb1O5l965Dlec4UWX3VgPwiCmJScqbi2rIUc5G
    oW1sBbmvyC0ollOIA8613FiV3y9Npa8xLoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1527874645; bh=Qw5f5eN/1TUQ
    hge7ZcWzUXW0vJSs2zcBDxX8vCAYjXU=; b=DpOWSr65r7ecOQM29BHdW+mzSqxp
    A0D92Fk0+NwOo/IMBncaaBGP6YP8gDu+oFQAkJNLM8+k5sqt24ELc3X4NQWsVMmF
    WJldP31an8PXU2NwqX4nURlt0b1Y9jLt7USvd9dBtESnX6KSK8R6UZ+i5Zm7o5Am
    rh2bdV20CaW6s5t2BjoeYK0ysIqw8DvVOlUY/JAap8jeG+Ls6IDXzUzAxTvA5hXR
    6OrogRFGSBW0R6QwcNN2A8CXKrg7uivqKyvypYMqaVZmQHQvXb6wwjSKKd/+6m0B
    2E61FVvRut4cw9IuTSXpkiswliiFXOrDJM38SExO6DNiA5q9qn4uHo9Mew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIdy7Dfr+ZQvPtFEZp1OaRdwYLlTg3bHfigelKbIWWfyCjUq3AdBvrsdJCJIPP0mNPnifm0GrZcUpZoa1iWokDPljirmqhU+Kwt84KYzqLM7cPpPj8n0
    CoUgjn6d5yT87Ma60Wx8zQuzwx3EASa6bUAtdNkZe4Y2BWHwojpnT8NGPIhQOOVy79OWJikfTfmrz91bX6Hs/AbDW7iFisRlwuSwB5poMc36stxsTX7U+3/P
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=1XWaLZrsAAAA:8 a=UPTcwn-lAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=U9LFBA6b5rnr84H2znwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=X8mxt1dpzMw3evLhLOjS:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeFARhW convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Fri, 1 Jun 2018 13:37:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44563 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbeFARhW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Jun 2018 13:37:22 -0400
Date: Fri, 01 Jun 2018 10:36:23 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180601165550.90053-3-ndesaulniers@google.com>
References: <20180601165550.90053-1-ndesaulniers@google.com> <20180601165550.90053-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/3] x86/build: use -std=gnu89 for proper extern inline semantics
To: Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, mka@chromium.org, ndesaulniers@google.com,
        pombredanne@nexb.com, rostedt@goodmis.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, tweek@google.com
CC: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
From: hpa@zytor.com
Message-ID: <A8FE8E99-A531-4E2D-B712-38354140D43D@zytor.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On June 1, 2018 9:55:49 AM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>The top level Makefile explicitly sets the C standard used in the
>kernel
>to gnu89. By overriding KBUILD_CFLAGS, the C standard used for this
>subdir is now implicit based on compiler and compiler version. GCC
>changes this implicit default from gnu89 to gnu11 in v5.1.
>
>This implies that depending on compiler version, parts of the kernel
>are
>being linked together from object files that were compiled with
>different C standard compiler flags.
>
>This is problematic for symbols declared as extern inline, as the
>semantics have switched since gnu89. See also:
>http://blahg.josefsipek.net/?p=529
>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>---
> arch/x86/boot/compressed/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile
>b/arch/x86/boot/compressed/Makefile
>index fa42f895fdde..1a04c7e9add1 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -26,7 +26,7 @@ KCOV_INSTRUMENT		:= n
>targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
>vmlinux.bin.lzma \
> 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
> 
>-KBUILD_CFLAGS := -m$(BITS) -O2
>+KBUILD_CFLAGS := -m$(BITS) -O2 -std=gnu89
> KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
> KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> cflags-$(CONFIG_X86_32) := -march=i386

-fgnu-inlines would be a better option.

We could also simply #define inline inline __attribute__((gnu_inline))
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
