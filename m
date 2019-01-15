Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9E920657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMlYMSr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfAOTZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:25:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:25:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so1789963pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6do1G+1HcuUK3LMqITRrx27AqnStKUBmwH0I4+7yE8=;
        b=PMlYMSr+XF3/kox9jnQ35Yr/n1MR1hfoTCnPNRHmYvA2qbMvaEfCAr6Oe71clLPGR2
         1yT7eMGU7PQ0jQ0O+8F/VyV1tAvTgvlWbh14msZ9ZiHIaRGtgYEyrY3pmHOSYLibuxGA
         r2S8zAHY6QsY6fKbIVmS0xkt2umTU4XL58sj9KR13oiAdAJSAMMc0lHmVl1LKnwpr5cC
         7m2iqE60oaE7UWJ0RtNaYI3l7Gj97LDLtFcbmD/Rz2HRoCS/b0rnmG/UFdlbK977RB5S
         oreQYoyHE7/voAGOVeRus7k03vvLL+nb6FkMT4B+mGnwum+VLXThJZfJYN5743Xb4wDB
         y0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6do1G+1HcuUK3LMqITRrx27AqnStKUBmwH0I4+7yE8=;
        b=r3Ms3tON4Ai0bVj3L26B+U3xQW/LHp9eoCSC8P85kr5ThJM+9k8ktaJ5bx5Abp0L5s
         RV6m4gJUvGf5+OveK32JO/95NagT5DKO99xA6Pi+yZiYH2O4GENlwLAXCm7J54QVCJls
         bgirRsnCsHvg6xRVhIF+y1pMKlxJasgaH+RfPV+PAhT6IdiPVVumfMwDpKWw1igoWXGH
         C1+h7wR8ifeL3RN4YXo4uMh1GGBTPYJcBluVp1DxadmvU7NYja8347poBVsPM432NyGy
         eMbaomvDcosvfDd1vhcm9lpqO0vBjtxup+a74iHVFM5d863qHrutyALXpmlTabVW0tNP
         5vbA==
X-Gm-Message-State: AJcUukesFId1DsMyRL3Y8E+MvvUffsNFPgzsklm89r54KWePXr1gggUr
        YIUBZLHYDiTK3AkjHRaYZfEf3Z5i6RH9X7YXvGS84A==
X-Google-Smtp-Source: ALg8bN50Vby0MCtFjUWiRNWlQc3eoVt0AMjYujKqrycblMySlzzAv5lBbYANSH5kvnxlfp7bN5ti1Hzfb/w6Bd1HCsg=
X-Received: by 2002:a63:a064:: with SMTP id u36mr5206552pgn.145.1547580311461;
 Tue, 15 Jan 2019 11:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20190115183643.120619-1-trong@google.com> <20190115183643.120619-5-trong@google.com>
In-Reply-To: <20190115183643.120619-5-trong@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Jan 2019 11:25:00 -0800
Message-ID: <CAKwvOdkUMpqu3_2bC1DJ47JKg-YVDZDbUOwu63uGkH+wvxA=cg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Tri Vo <trong@android.com>
Cc:     oberpar@linux.ibm.com, Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Masahiro

On Tue, Jan 15, 2019 at 10:37 AM Tri Vo <trong@android.com> wrote:
>
> From: Tri Vo <trong@android.com>
>
> Clang gcov format is only supported by Clang compiler, and Clang
> compiler only supports Clang format.
>
> We set gcov format to depend on which compiler (GCC or Clang) is used.
>
> Automatic format detection behavior is preserved because:
> If GCC is used, one of the GCC gcov formats is selected.
> If Clang is used, Clang gcov format is selected.
>
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  kernel/gcov/Kconfig  | 8 ++------
>  kernel/gcov/Makefile | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index eb428e570923..f71c1adcff31 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -53,6 +53,7 @@ config GCOV_PROFILE_ALL
>  choice
>         prompt "Specify GCOV format"
>         depends on GCOV_KERNEL
> +       depends on CC_IS_GCC
>         ---help---
>         The gcov format is usually determined by the GCC version, and the
>         default is chosen according to your GCC version. However, there are
> @@ -62,7 +63,7 @@ choice
>
>  config GCOV_FORMAT_3_4
>         bool "GCC 3.4 format"
> -       depends on CC_IS_GCC && GCC_VERSION < 40700
> +       depends on GCC_VERSION < 40700
>         ---help---
>         Select this option to use the format defined by GCC 3.4.
>
> @@ -71,11 +72,6 @@ config GCOV_FORMAT_4_7
>         ---help---
>         Select this option to use the format defined by GCC 4.7.
>
> -config GCOV_FORMAT_CLANG
> -       bool "Clang format"
> -       ---help---
> -       Select this option to use the format defined by Clang.
> -
>  endchoice
>
>  endmenu
> diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
> index 83da4765c18d..d66a74b0f100 100644
> --- a/kernel/gcov/Makefile
> +++ b/kernel/gcov/Makefile
> @@ -4,4 +4,4 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
>  obj-y := base.o fs.o
>  obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
>  obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
> -obj-$(CONFIG_GCOV_FORMAT_CLANG) += clang.o
> +obj-$(CONFIG_CC_IS_CLANG) += clang.o

I think this was the suggestion from Masahiro from v1?
-- 
Thanks,
~Nick Desaulniers
