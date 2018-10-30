Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1ABC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A0A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rtHHHHyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A0A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJaA4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:56:00 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:25840 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:56:00 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9UG1Wn1026048;
        Wed, 31 Oct 2018 01:01:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9UG1Wn1026048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540915293;
        bh=csSMXhMjG7/uDF21k0QboUXvMeiYQ+MmLmbh/gWkjIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtHHHHyM5UqBUP+EKBTM0LEZ438DaX/Zb6aaqwQ2MzSt+L8nMmCJIsn5uR7R4cDgx
         ImYPEfTQeIFOXhQOG+PAAeME3AJ9LayqELeVr4ZL76XnCN198wM1YW7B+jKJSyq/YS
         nglS0+6tCackbjLJ1gG/wKD0wXlnSMbAbNvQ9QsB/zd4V1UYBqtxnMIiXZjeiqkvGa
         MQ/HQ8g7Wu6+vVCi/IbiXJkEmnvE9AqHff2j93gJB1Fkc3SVAqiYyk7nUvgAOqTFaa
         kbuwgIgxEtEnUmDvdr3qRfV7ytAt3ZlaUQl1eZNQa3WoxW7mfJA7o/mysAQCmOfDFZ
         qcLLv8SQpImwg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id d8so3686308ual.2;
        Tue, 30 Oct 2018 09:01:32 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJnxoxdM+JjYX1nLWBL6hv6d11xK8Jt33cWqYMsemvDqd4gooHi
        WIj6GkIC86bNMUzSReQoujSDFuwIM9pWsol2Cnw=
X-Google-Smtp-Source: AJdET5fmZ4h9Aw8PIZTyTcc3BBnxAhbyyJl3L5r1Q9CjJTVXKEW16yE15z6fddODURosNY69rm5q7dt9YJ1ylo/Iy1o=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr1162812uap.6.1540915291458;
 Tue, 30 Oct 2018 09:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <1540829034-17725-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540829034-17725-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 31 Oct 2018 01:00:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEogAqYTZHdtPWk4xZPXKkJPuWX9BF3o_Cy5s0jCB2cg@mail.gmail.com>
Message-ID: <CAK7LNASEogAqYTZHdtPWk4xZPXKkJPuWX9BF3o_Cy5s0jCB2cg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unused cc-fullversion variable
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:05 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The last user of cc-fullversion was removed by commit f2910f0e6835
> ("powerpc: remove old GCC version checks").
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.




>  Documentation/kbuild/makefiles.txt | 15 ---------------
>  scripts/Kbuild.include             |  4 ----
>  2 files changed, 19 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 7b6a2b2..8da26c6 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -537,21 +537,6 @@ more details, with real examples.
>         The third parameter may be a text as in this example, but it may also
>         be an expanded variable or a macro.
>
> -    cc-fullversion
> -       cc-fullversion is useful when the exact version of gcc is needed.
> -       One typical use-case is when a specific GCC version is broken.
> -       cc-fullversion points out a more specific version than cc-version does.
> -
> -       Example:
> -               #arch/powerpc/Makefile
> -               $(Q)if test "$(cc-fullversion)" = "040200" ; then \
> -                       echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
> -                       false ; \
> -               fi
> -
> -       In this example for a specific GCC version the build will error out
> -       explaining to the user why it stops.
> -
>      cc-cross-prefix
>         cc-cross-prefix is used to check if there exists a $(CC) in path with
>         one of the listed prefixes. The first prefix where there exist a
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index ca21a35..19a63db 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -147,10 +147,6 @@ cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo
>  # cc-version
>  cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
>
> -# cc-fullversion
> -cc-fullversion = $(shell $(CONFIG_SHELL) \
> -       $(srctree)/scripts/gcc-version.sh -p $(CC))
> -
>  # cc-ifversion
>  # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
>  cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
