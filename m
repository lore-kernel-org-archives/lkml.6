Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7172145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQ44yXYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7172145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeJBAAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:00:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:00:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so9694135pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjFxLEbSrzzNRdUb5i2NywdnyovHqjCF0ZZdimTUJLU=;
        b=kQ44yXYWm4AY8Ssvs5Ig1impinGQxtCa+i21O35W+vZbPuSmeIRlQC3kIU3oEnmKY7
         4EfFZFHQeAqCNGCZVWrRaoutDpHebWF4zmx/7atCv6ovkZxb2ibQ1VqFtMup/wSvVPfL
         DyN2EJmiyJQdDEB9psnVCl2iYHAf6sP9qmjHcj/EQSPuZwZ7NS13kY/gWmxjDv9AJwfk
         36wExmxWXeeZ82kL8sTbLm9p7sTj3sRAFYgBI0rkapmZJbvwYojI3hGaZxfPF/Z7tV+Z
         BpJ04c/vXV6XKWCXduS4h4kxzQGuS9DuigrbbxvHhGX7t17RTFb9+O2reQ+4fa/QYP0v
         XI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjFxLEbSrzzNRdUb5i2NywdnyovHqjCF0ZZdimTUJLU=;
        b=g4YrjksyOgQPv2REHZBUElXSRvQe750LAKNRYx8U3Q0zdP8rFmOayo1ZkLejSDXvyO
         I5H2EgRWdEh8Tf3Cqm/z497YU0suSXXpWa9pKn/K71vz66docuCOZkmk5ZJYYd13rr05
         aah7q9htH2dOMiPPNR2E19iyiea7YDmPML5y87pJ150mgYxl+7rU70rQi8NrBXxIVBNC
         dVZ0mkHQbLjV+1Pcbziaa6sBiRhLav7RK6rvRtzA2vaFlFLdrVdmY38NTlXOCjz/uIN9
         fGBzF2nf0+qAIF5fm+DnJERSKg/Q0ZlU7/TWOG6gupQuBnUhtTubBDadtX5HLXrYeEEE
         rbvQ==
X-Gm-Message-State: ABuFfohNqWB3+AZaUeBAnPdw4VNDx12UTsYgg3C3svGsceIpKqmAJxOz
        8AbD2LKhvXFJ+fADRHtwQJhJCT95gH8KUXbpmYlrhQ==
X-Google-Smtp-Source: ACcGV632m8GzP8e9nJseuB8zv92tyKMY3MvFGmG9JsjQwsYZnUYDSz7VFkT3Cck0PIZF9pmbmA0bWQB+109bLy9nR2U=
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr11131363pgj.255.1538414474569;
 Mon, 01 Oct 2018 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com> <1538387078-21892-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538387078-21892-2-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 10:21:02 -0700
Message-ID: <CAKwvOd=tpuVaEey2cMLJ5=MF6XZ_sYXd-Qw5xww=+LHZ3rWHdQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: add -Wdeclaration-after-statement flag unconditionally
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
> This flag has been here since the pre-git era.  It is documented in
> the GCC 4.6 manual, and it is recognized by Clang and ICC as well.
>
> Let's rip off the cc-option switch, and see if somebody complains
> about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 505a324..8a23fee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -797,7 +797,7 @@ endif
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
>  # warn about C99 declaration after statement
> -KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
> +KBUILD_CFLAGS += -Wdeclaration-after-statement

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
https://godbolt.org/z/TP5722

>
>  # disable pointer signed / unsigned warnings in gcc 4.0
>  KBUILD_CFLAGS += -Wno-pointer-sign
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
