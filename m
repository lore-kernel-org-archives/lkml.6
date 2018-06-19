Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4712083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNaRmNhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4712083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937376AbeFSHsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:48:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36917 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937201AbeFSHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:48:35 -0400
Received: by mail-it0-f68.google.com with SMTP id l6-v6so15838309iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9cXZtrmGDYfDcl7fIjQLd2IFmwSiDih91kj5Drs6uSc=;
        b=NNaRmNhM3sNov4dqngIqr+csp302mX9hmG8DdFNhw494YdZ7svbeJHXcnzae2WWCh0
         0dQk9i22Hpsi7LTqHEXTXWNrt/1gpLuthszqdfkbVHxqiBp6XFH1788gbnE2EWKJrNBs
         FnFj7PBHXHTkxVPvIlDJVF1cxVXMFazdEaIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9cXZtrmGDYfDcl7fIjQLd2IFmwSiDih91kj5Drs6uSc=;
        b=rTvCk1VsmX8PdIEMVgcadOpXECAZglZJv/gCjmPr5xHiBbEpP3eBD4GBlElkTZ8Gqm
         8zxftA1hC6MU8ICy2toE4nYTzwjxvtacLxQ25xSZKcLf/8a7p5b359OVCfgYvpXBPmLK
         2L4CK7L45oIOEISOqDUfoCY315Sd0nV1i30pFZGZgw1nCys5GgBcy9KeR8wxDeD0SglC
         7nbg7Rr0O8npKOYheNEBxf+7J0ZlmCPPEZs8Fvi/dXly/kSkTvAzNFv0ituudWToo1JX
         O6MrcQTmvcXelv6vL3J7eM6jWAm9ZQdx06hfAxMIoxHSaNpPQi91gn4ClUzNHNFpL7kn
         vr6w==
X-Gm-Message-State: APt69E0/66fzLq6xXX8puORl4RrkQbsCeDF08hKIv9HcLvlcJYNw6k0I
        i5YQxMkzzHu5Vd5hrMRbTXLhVzENjjpeQs656nNgOEJXu4g=
X-Google-Smtp-Source: ADUXVKKDrULtBpxqI2qRC3WFUmD6UoPH66tLxxq9k7cDIowj38g6x9LD0Z48UdldB+L02cD/gYL3+wOSFpw0GXXV6Ls=
X-Received: by 2002:a24:1d0e:: with SMTP id 14-v6mr11918805itj.50.1529394514667;
 Tue, 19 Jun 2018 00:48:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 00:48:34
 -0700 (PDT)
In-Reply-To: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 09:48:34 +0200
Message-ID: <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 07:07, Guenter Roeck <linux@roeck-us.net> wrote:
> Modern assemblers may take the ISA into account when resolving local
> symbols. This can result in bad address calculations when using badr
> in the wrong location since the offset + 1 may be added twice, resulting
> in an even address target for THUMB instructions. This in turn results
> in an exception at (destination address + 2).
>
> Unhandled exception: IPSR = 00000006 LR = fffffff1
> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
> Hardware name: MPS2 (Device Tree Support)
> PC is at ret_fast_syscall+0x2/0x58
> LR is at tty_ioctl+0x2a5/0x528
> pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
> sp : 21825fa8  ip : 0000001c  fp : 21a95892
> r10: 00000000  r9 : 21824000  r8 : 210091c0
> r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
> r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
> xPSR: 4000000b
> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
> Hardware name: MPS2 (Device Tree Support)
> [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
> [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)
>
> Fix the problem by using a logical or instead of an addition. This is
> less efficient but guaranteed to work.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> RFC: I don't really like this, but my ARM assembler knowledge is quite
> limited. Just dropping the "+ 1" from badr doesn't work because some
> other code needs it (the image hangs completely if I try that).
> Ultimately I don't even know if the invoke_syscall macro should just
> have used adr instead of badr (but then how did this ever work ?).
>
> Seen with various toolchains based on gcc 7.x and binutils 2.30 when
> building and testing MPS2 images.
>

Hello Guenter,

This issue has been discussed before. It appears the binutils people
suddenly started caring about the thumb annotation of local function
symbols, resulting in behavior that is not backwards compatible.

https://marc.info/?l=linux-arm-kernel&m=151143776213636&w=2
https://sourceware.org/bugzilla/show_bug.cgi?id=21458

Can you try the fix below please?

>  arch/arm/include/asm/assembler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 0cd4dccbae78..24c87ff2060f 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -195,7 +195,8 @@
>         .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>         .macro  badr\c, rd, sym
>  #ifdef CONFIG_THUMB2_KERNEL
> -       adr\c   \rd, \sym + 1
> +       adr\c   \rd, \sym
> +       orr     \rd, #1
>  #else
>         adr\c   \rd, \sym
>  #endif
> --
> 2.7.4

----------8<------------
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 16 Jan 2018 12:12:45 +0000
Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit twice

To work around recent issues where ADR references to Thumb function
symbols may or may not have the Thumb bit set already when they are
resolved by GAS, reference the symbol indirectly via a local symbol
typed as 'object', stripping the ARM/Thumb annotation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6ae42ad29518..dd2ff94ad90b 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,13 +195,19 @@
        .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
        .macro  badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-       adr\c   \rd, \sym + 1
+       __badr  \c, \rd, \sym
 #else
        adr\c   \rd, \sym
 #endif
        .endm
        .endr

+       /* this needs to be a separate macro or \@ does not work correctly */
+       .macro  __badr, c, rd, sym
+       .eqv    .Lsym\@, \sym
+       adr\c   \rd, .Lsym\@ + 1
+       .endm
+
 /*
  * Get current thread_info.
  */
