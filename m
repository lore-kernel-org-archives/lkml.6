Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcSV4n3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeKJDus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:50:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:50:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id u13-v6so1270468pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTDuuew0NsZhhb2bxhxcr153BE8+fnPPLRQbpDhPrd4=;
        b=UcSV4n3kcdGjr2QJ2lfpleDryWk897/SqMXB+J+CzIh/OoE5iDWlj5xREz6Vk6Zg4G
         9z+uKTR8jM7ZHVkP0TLX1oNQJPYCy7hVjdqftFlCJTA1gZtpiF15c6dgDqipzzEhI4V3
         2QhV+qzP/OwHFyIZLLNwr8KG8l03xKtq+kN9kH1NMYABYnlyckU7Rfi23IHJvBqiM1/S
         VbNcG1cLdh+fJrCm9owbcM9nAU0kO1G/+kxMqsqqKuWeWUjraUy81fCvOakNJVQHG3yK
         s1I8L+1vVFUgtyRwZErYVaXBYxMEwCKP4Qp5dwd0FbTpsHI25Adhmnzz/sfFxqiM/9Yv
         KjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTDuuew0NsZhhb2bxhxcr153BE8+fnPPLRQbpDhPrd4=;
        b=Um+pfidin261FvWTBSlwyTid/8l7/C71ExUvBs8uoOLfWrkxlDBscZ+7Xmba3BlIQR
         gbEuDUBcHWCmUeE3HXJxiK8/30Pkmgva2UMgz5kIYZpsvDzoFxv7ym/9/iUQDP1/4+0V
         PQLhnWIMpdgjKMHoWu4LYirIKoC9G4AUWtStxkTCrir+c0+3YxR9tqO3INVew3SPwg0O
         es0UWbAifMoFLAe5yrjD+cB4uywoKM9sHfIvLmmQN7kMtop+wVPMJwplm4vAf4Sd/4fR
         oIWqtXZsLxNMPF0WMnWDA7R2/5ODRjKZUo7giZMSJqpwgHc4u8ffzbCNe757J2aQsTT7
         vfQQ==
X-Gm-Message-State: AGRZ1gIiArJke27HZ/6EOEyw0tHa1E7wJp8fWnszwFM4L7ciEMepmykg
        LrDQZUTppTo7TftcvC3BY+C30dON8Rhi10u/e7zPyg==
X-Google-Smtp-Source: AJdET5dldSw9wyZPWg7QhrkDHD/f3FbXQ8IIL4M48Yia0wV6zoP78APvYBX63QOd7GjaUk4kWrvQTbPPZfVcBCdQaZM=
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr9868632pfq.227.1541786944730;
 Fri, 09 Nov 2018 10:09:04 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Nov 2018 10:08:53 -0800
Message-ID: <CAKwvOdkfGZDWr5vjNTvn707+Muna3JNKObwOfjjvS2-tAXK2QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: add -no-integrated-as Clang option unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>, joel@jms.id.au,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We are still a way off the Clang's integrated assembler support for
> the kernel. Hence, -no-integrated-as is mandatory to build the kernel
> with Clang. If you had an ancient version of Clang that does not
> recognize this option, you would not be able to compile the kernel
> anyway.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - New patch
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 93315eb..da11700 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -497,8 +497,8 @@ CLANG_GCC_TC        := --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> +KBUILD_CFLAGS += -no-integrated-as
> +KBUILD_AFLAGS += -no-integrated-as

Sorry for the delay in review.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>  endif
>
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
