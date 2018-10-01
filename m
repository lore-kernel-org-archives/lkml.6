Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36501C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCFE2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUMRl62J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCFE2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeJBADn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:03:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34979 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:03:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so9957415pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSZ1sLmS98NRKhrX9r7fDvdHuw3gY0AXrZq1nHGqIKI=;
        b=eUMRl62J3E3fdkLdvkAY68NJYftRc4mOgT21sbkH7VKI5lrvhUHiWXcT0BPEih+Crv
         lnzOh5WTXE4JaZCtXb0/UOoD10XYOx3gYHhNWvNMsQOK5naqF2Rf8rxNkuz6WetFM+aB
         /Ydke1MXYf0rjFIbTYmrwKT3GRxPHZD8KoHUUxf7gbmBGcG8+CKdLTuCg1D9StMBK4dV
         FKhySu6IoimZCOAYK/2YLUc7m4d3c4s76z7h4uSWm/c6vCSqX6Q4yjUNTV73JSHahRhG
         wIXIu4j7fLpH2+rgEYojxHT3JlsyUU4+4jPqY0bYAqtchOUhQinqn+KWRL0ge68X3ycV
         3JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSZ1sLmS98NRKhrX9r7fDvdHuw3gY0AXrZq1nHGqIKI=;
        b=F6bmOyyqrxVudZjcmdF70h1ZXuh2YSsAnEHQlFUl5qCA9T7PnF79ilv75iDZxQgnEa
         CbVMyizBgHtmDDAPr/QVlQn+NDk8AEGOgCGjs2RUmvqObRsUEpZfcLhzR2mbheudTOvL
         rAbO4kKnXxOu5tfJuLqM0GXc27RqA56i0c/3rxoVBNpi+4DRkyERkdC9oLx8zmeQZ08D
         E8H+ilPdi1PI90o+pK3F2geeWpkDJO/OLi66CwLTbTajNt+re1828JM5QDxjdeHIixG1
         PEbOfC9O+AubwGxoWwdgqrtQpD9LA+4NYMTUd5S+iDmpTRC8xwkOynTy7XZx+ZCvz61c
         7K7g==
X-Gm-Message-State: ABuFfogoM4qa7IshnL+McymwuFUi4fGxNKyRkmIx/ET+bz6wMVSGKh/D
        90C+UOTZxQZG58Uy/7Zkf1v7eno4pBWuKy4q0EEOyg==
X-Google-Smtp-Source: ACcGV60h5LMefZTGWIxJfuHr7VKD7u0Q+fS9ywuLnNA6VWFIqMcRRmKkkRH6M9/U1lVueYYNGyO1q662aw3lyLmCR7g=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr6654298plz.320.1538414694164;
 Mon, 01 Oct 2018 10:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 10:24:42 -0700
Message-ID: <CAKwvOdkefCpuvKuAo5k82rviWnHd3FJBtNPEzSiFsZ98yqmNdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add -Wno-pointer-sign flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> The -Wno-pointer-sign has been here since the pre-git era.  It is
> documented in the GCC 4.6 manual, and it is recognized by Clang
> and ICC as well.
>
> Let's rip off the cc-disable-warning switch, and see if somebody
> complains about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c6d1f2f..505a324 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -800,7 +800,7 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
>
>  # disable pointer signed / unsigned warnings in gcc 4.0
> -KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
> +KBUILD_CFLAGS += -Wno-pointer-sign

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
https://godbolt.org/z/7vpHIf

>
>  # disable stringop warnings in gcc 8+
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
