Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756665AbeDZVlf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:41:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50616 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756708AbeDZVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:41:33 -0400
X-Google-Smtp-Source: AB8JxZrbW688MrmoLrows77YBn+E7LXQe95RA8r9s5tIl7ufO3A+J1qp2osvT1DZAli2dKyfQ13ejmZka8YnLRMDXQc=
MIME-Version: 1.0
References: <20180426212807.196279-1-ndesaulniers@google.com>
In-Reply-To: <20180426212807.196279-1-ndesaulniers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 26 Apr 2018 21:41:21 +0000
Message-ID: <CAKwvOdnjgEWDo8vjOiAS_TsEoJFZZagJgaqBAdW99L-Nkr9BxA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: gcov: enable -fno-tree-loop-im if supported
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro and Michal,

The reporter has asked for their email address to be updated to:

psodagud@codeaurora.org

if you're ok with this version of the patch and choose to apply it, can you
please update the commit message. Otherwise, I'll make this change should
we need other changes necessitating a v2.
On Thu, Apr 26, 2018 at 2:29 PM Nick Desaulniers <ndesaulniers@google.com>
wrote:

> Clang does not recognize this compiler option.

> Reported-by: Prasad Sodagudi <psodagud@quicinc.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>   Makefile | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/Makefile b/Makefile
> index 83b6c541565a..7f653c924c18 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -623,7 +623,9 @@ all: vmlinux

>   KBUILD_CFLAGS  += $(call cc-option,-fno-PIE)
>   KBUILD_AFLAGS  += $(call cc-option,-fno-PIE)
> -CFLAGS_GCOV    := -fprofile-arcs -ftest-coverage -fno-tree-loop-im
$(call cc-disable-warning,maybe-uninitialized,)
> +CFLAGS_GCOV    := -fprofile-arcs -ftest-coverage \
> +       $(call cc-option,-fno-tree-loop-im) \
> +       $(call cc-disable-warning,maybe-uninitialized,)
>   export CFLAGS_GCOV CFLAGS_KCOV

>   # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
> --
> 2.17.0.441.gb46fe60e1d-goog



--
Thanks,
~Nick Desaulniers
