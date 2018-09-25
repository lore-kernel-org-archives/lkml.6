Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9268C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F4420666
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfSwZ40s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F4420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeIZAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:50:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeIZAuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:50:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so11822182pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGiuWKNdvAxS7VGSt6kGx+xo0rQqNbhwpom7U8foitE=;
        b=VfSwZ40sNu6Y9qhN3v7KKgD9kZTg2kiwpJd7tVEPhpkWS3vtRTviolM4dbU/5u8y/W
         vAk0RFfotF/gs/jXvh6WDBWPNCIBVaHijLWyyf5sVTJ+1U2GyWLUlhL5AlCmjLrc3Vx5
         3TAzsZV2k94uABicspwbkd13eVbDQVDIAmQ1fNic7IyWKyWH5qkOY6lWAu6Y+Zy8lLN2
         ozBwJ93G67XkjuNVV0vi3WK5j3/WngC1gglK0er8Sh1BEKQaKs9zx5VI5XMVnnKe4s2r
         YqjB2HKWiCtWOFJX6Dq7gayooBZ4b1mqoqjbNS/PFmjsSzL4iTXSEwtVB/ybZG7lHnkw
         agOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGiuWKNdvAxS7VGSt6kGx+xo0rQqNbhwpom7U8foitE=;
        b=QS0Rzv2q6kHPu4JrZ/rSm5YSAHLJNehl3o/aZwJJdTACj40mR3DzJZf2qV+hxtdrzI
         A5aa5uYhurY7tHy8f/vX+KSuDInpNgqsHr5COxUvgSURSc9uYo6nYUJKmb/pA4gI1BTX
         I30vIa8nLvt1zWkydX89sh7M8SZ1s+tNncknZcaT3mL+In1eFCMHjenBTX0JFId6E7iX
         G64CqGaHk90z4BEW5GOUEtTdinRfc7lef4tixIfSRva8YZI4KiWX2KwfieUkIX5V4df4
         kwpHZOnYlPBC/S6eUUVhDVZVBPphY3lvha6LKdGW2EfoZcBmdalHwsBZyQdAZx1u80ib
         HS5A==
X-Gm-Message-State: ABuFfogFir0t1wpyucuffncsc0E9WLjtrCZRBQL7s+adzR8qfg1VSiJg
        Y2eO3Bv00RhtJNlvat7WIkd5NKfHskfd1Wf8VF+t2w==
X-Google-Smtp-Source: ACcGV60NFfpspQ6vEiqZQAdtVUUj4RdlzjBrv6oL+jZMJhTMHyZAx3BsgeMFeNWYfCe8gaySaS6X78aoEtQzGZg9/Rw=
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr2410733plz.238.1537900891106;
 Tue, 25 Sep 2018 11:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180907202618.258569-1-ndesaulniers@google.com>
In-Reply-To: <20180907202618.258569-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 11:41:19 -0700
Message-ID: <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, bp@suse.de
Cc:     hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review.

On Fri, Sep 7, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Since this file steamrolls KBUILD_CFLAGS, we have to redefine these
> symbols. This will prevent warnings in source files in this directory
> when Clang supports asm goto.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/boot/compressed/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 28764dacf018..158c0b4e178a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -56,6 +56,13 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>  endif
>  LDFLAGS_vmlinux := -T
>
> +# check for 'asm goto'
> +ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> +  CC_HAVE_ASM_GOTO := 1
> +  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> +  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
> +endif
> +
>  hostprogs-y    := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>
> --
> 2.19.0.rc2.392.g5ba43deb5a-goog
>


-- 
Thanks,
~Nick Desaulniers
