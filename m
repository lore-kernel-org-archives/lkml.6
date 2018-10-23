Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA17C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495B620813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCcmhzHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495B620813
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJXHsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:48:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38340 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbeJXHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:48:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id p7-v6so1340659plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 16:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWYw/fvE0kL/sYUGmpBB4/DDhLvzduRWBbeLKbNQNGM=;
        b=TCcmhzHAdIOM+nx3qtMVoPRzBTnXMWPpue4nWNIq2JgT3JN6spF/SMio4jsRF1gOjY
         ehgr6uiTvpkDV829QQ+V3NpyEEULb8an9Quc3jSJBVGOFmPynT37FnySK86aMaBLi+8d
         3SnSj8N/EMb5S1TMNidjWMmhxT4YgpZORzk40tVtnDY++CpTlUm8HXXA3gR9r93ZVrgK
         lEo20QtDYl1BaXTXdvTuF1NVbwvgm7HgibekVjoT9WAo0CtGsn6oL8hQgBhtL3HXnPQv
         BaJzmFwHdv/Qeyt1yPzzMmfXVTJ8Iq4xoIzzlLPhP7CTMU8OZbrJid2VZ0g5Cxu23nIS
         4Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWYw/fvE0kL/sYUGmpBB4/DDhLvzduRWBbeLKbNQNGM=;
        b=d3jiFUZvTwOrF9Tk1DhjitYqtRv3s1gSHThzw8pnatmGigllGP7KXO/QVcFr5Dhtdv
         fu9cxyGqIXgGsdt/krrzVSS+/GpBFzP6ENFv7Ee++0VaDJlSHHsr309g8HbSlszxZ7ZX
         t4rHnlmv++zVXvB1USYnbQVB5P1VUE5N6d0vt86InRDF0zq3HBstvbtaFsXs852nBOZK
         E8mIqnXUB/T+zjJTUxBjVQFjImHSeyjcDP+EB4Y8iDMm/c0VIlINTaM5Mel5BKVLDKYZ
         150NKBUHwa4O0bdyqysusplWCWTQuBVe6p5VSRq3H38g/GKexGQlswS5G3E/+pArQMkq
         NDsQ==
X-Gm-Message-State: AGRZ1gKdZZFZhgETdTD38vLWI9ipdCNNW9/qYiXV0CK2mp+wiXBQ2DTG
        qgCK7tiWSHLIEt0C9yWcEE1IMtxA0qeMrdeCn/eqQg==
X-Google-Smtp-Source: AJdET5f+h10Dya3DQpF4KGYmDqPcT3UxpHoAGZNdx6uXoYYYX0yvMyTN5MX5iGJK0XmIHMr7GnYIeFNet1TgOSm3BSw=
X-Received: by 2002:a17:902:b106:: with SMTP id q6-v6mr261572plr.238.1540336999067;
 Tue, 23 Oct 2018 16:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181023231125.27976-1-natechancellor@gmail.com>
In-Reply-To: <20181023231125.27976-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Oct 2018 16:23:07 -0700
Message-ID: <CAKwvOdnPbO-CVHCeoz9JWTAVtJOGGMzNv3kPUTYxeFs=uMzH4A@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove -pipe from KBUILD_CFLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, namit@vmware.com,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:11 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
> inline assembly code to work around asm() related GCC inlining bugs")
> added -Wa,- to KBUILD_CFLAGS, which breaks compiling with Clang (hangs
> indefinitely at compiling init/main.o). This happens because while Clang
> accepts -pipe (and has it documented in its list of supported flags), it
> silently ignores it after this 2010 commit (thanks to Nick Desaulniers
> for tracking this down), meaning that gas just infinitely waits for
> stdin and never receives it.
>
> https://github.com/llvm-mirror/clang/commit/c19a12dc3d441bec62eed55e312b76c12d6d9022
>
> Initially, I had suggested just add -Wa,- to KBUILD_CFLAGS when GCC was
> being used but that was before realizing it is because Clang doesn't do
> anything with -pipe. H. Peter Anvin suggested checking to see if -pipe
> gives us any gains out of GCC. Turns out it might actually be hurting:
>
> With -pipe:
>
> real    3m40.813s
> real    3m44.449s
> real    3m39.648s
>
> Without -pipe:
>
> real    3m38.492s
> real    3m38.335s
> real    3m38.975s
>
> The issue of -Wa,- being passed along to gas without -pipe being
> supported should still probably be fixed on the LLVM side (open issue:
> https://bugs.llvm.org/show_bug.cgi?id=39410) but this is not as much of
> a workaround anymore since it helps both GCC and Clang.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/213
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks Nathan for this patch and the timings and HPA for the suggestions.
Tested-and-Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 73f4831283ac..672c689c1faa 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
>  KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
>  endif
>
> -# Speed up the build
> -KBUILD_CFLAGS += -pipe
>  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
>  KBUILD_CFLAGS += -Wno-sign-compare
>  #
> @@ -239,7 +237,7 @@ archheaders:
>  archmacros:
>         $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
>
> -ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
> +ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
>  export ASM_MACRO_FLAGS
>  KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
>
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
