Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0095C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60AD2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3UZ/lWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60AD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLKRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:39:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeLKRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:39:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so6970980pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uR4TcbP1G7PUZ3M6tcneUSP5dBslZpnSSQ/mgoEsoto=;
        b=A3UZ/lWqJHGwcE3EDs5wo2oQdtUt0CSgVp7bSE6liJR8FzbqHwx0wCcpn9Aar4gLjw
         XspvExIK3pVn1CyeFh71Bu894j103eBdOtCgMexZjU88mcEdOvFnuZXrgtC9JpiIaN0v
         dFxjtj9qPQMK4OyiGuOaxTvrbYBWQfuJ0rtx3HnKL90RGGLE55aLG96qnyNsMEljhr5N
         ElI+seUflMmMO+QdViHx1L5VXJJbl+WCRp5qqCwuh7v0arbiaqeyEAxN3oIgLyR22fuK
         1/i6sUXeL9RoAzzSgMCnsis2vtGWCFJV4djOkuv7eVR8q+J9Lgv1VTVw6p9nBj9Vl/D0
         g2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR4TcbP1G7PUZ3M6tcneUSP5dBslZpnSSQ/mgoEsoto=;
        b=Ri6htbUhbdQH7wE1WOBgSSObX3M1qytGxi935PCbjBhtm3MWUCkXFzWA8gwMeIcQCU
         gAIfc4jq/nzBixoRLk9CAUi5Xsnxc3sWa7AYaxdjPR3STo7L8ykstz2q6DW9aWIsH4jN
         Ef+d+70KBlv1vGLJxFwWxV0FL6Llw3FYmH1nPMrd58AmfKPs0breZlxGi17DwfYDfhJn
         3kOFBv9mIhKe2g8SglQxY2/PATQ8R9v8gvoqsqEHFjfd37aJhesrQlYkDYIAoI+Q4Lml
         t71eYUtjcOdGD4gjwH4TMDjEHYIWHngcCAHC49mWCNin79nlJI1fBXBX+nTrKrNW2/6N
         GKPg==
X-Gm-Message-State: AA+aEWabiv8O1/sEQZxb2fcyIdigOTqu4rgXIlm/s7ALc7k21EaAnhRj
        zk3QfF5nXK/lcNKR+3jtlA67416RCGnDLRIN38LE5w==
X-Google-Smtp-Source: AFSGD/UhrFUC4L1ADkCVMcmjZ74w0ZBnHQJO6ioNot0D377Ys+u6rBa3LCKlBa6tubCrxyjjsRggC1oDTGhcDGfxR5U=
X-Received: by 2002:a63:a064:: with SMTP id u36mr15579712pgn.145.1544549996863;
 Tue, 11 Dec 2018 09:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com> <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
In-Reply-To: <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 09:39:45 -0800
Message-ID: <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
To:     richard@nod.at, Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, bp@suse.de
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 5:12 AM tip-bot for ndesaulniers@google.com
<tipbot@zytor.com> wrote:
>
> Commit-ID:  f4313ba52f9caccfda6a55f991c84aba6726b88f
> Gitweb:     https://git.kernel.org/tip/f4313ba52f9caccfda6a55f991c84aba6726b88f
> Author:     ndesaulniers@google.com <ndesaulniers@google.com>
> AuthorDate: Mon, 10 Dec 2018 14:27:16 -0800
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Tue, 11 Dec 2018 13:58:57 +0100
>
> x86/um/vdso: Drop implicit common-page-size linker flag
>
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/x86/um/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it so that one more LLVM
> build issue gets addressed.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Richard Weinberger <richard@nod.at>

I missed Richard's ACK.  Did it occur off list?  I just want to
confirm there's nothing wrong with my email client.  Thank you for
taking the patch either way.

> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-um@lists.infradead.org
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> ---
>  arch/x86/um/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 822ccdba93ad..bf94060fc06f 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -26,7 +26,7 @@ targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
>  CPPFLAGS_vdso.lds += -P -C
>
>  VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> -       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +       -Wl,-z,max-page-size=4096
>
>  $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
>


-- 
Thanks,
~Nick Desaulniers
