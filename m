Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9083DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0015C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="A5+8Qdzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0015C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeI3UZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:25:06 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26827 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeI3UZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:25:05 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w8UDprnV022001;
        Sun, 30 Sep 2018 22:51:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w8UDprnV022001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538315514;
        bh=LKAXkTaFifrfwH4ca1AKkvb/+hYX94cIkKf+GhzY+O8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A5+8Qdzxubexn+UIbw9RTOYgcCQO7yngdH4Po0n4NS4XphzfY/wg5m5uR7yS679XD
         NhzwOCHTt2p/0cslEhrBLHrd3um51n721zNg2J91LQNvbUZVwpyBPJXJ5rVGnjzT/P
         WGDLQAm0N9f31ngw+nJRnZdn8vk56VQCrUFYwrZs+p84aZjQloXB1nNn1utCGutxyp
         giRsi+jnhpJLO3zhnVKGg3HG9cSVFsqZs9zryCiXo7e8sZ59gTx0XpyDtZN+/r7IBb
         XptvtR9OoTOFBWB+UMHsgHbl0wUnQPhQMPUd1zIA+g+slIvDVIoStDoAWCY/aURhdi
         hCqNfS78iZ2QA==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id w7-v6so3895936uan.9;
        Sun, 30 Sep 2018 06:51:53 -0700 (PDT)
X-Gm-Message-State: ABuFfohfXBe0h/spYR/VHjqirEaFFkidbt9fpMh3w84sjaCV+YkK6ozP
        lYcLhWoqzopuX8AfhvdwmJbKSJnGGGxQhQOFCSA=
X-Google-Smtp-Source: ACcGV60eKoOZjVsc6jL4IX8lri8JOEsia0gknUk8AXeyXBY6TA04rw7QT5cJaQJ5LbDYadunU94JlkNRzyln7O+6aSA=
X-Received: by 2002:ab0:6609:: with SMTP id r9-v6mr2835014uam.6.1538315512738;
 Sun, 30 Sep 2018 06:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <1537260354-30082-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1537260354-30082-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 30 Sep 2018 22:51:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARq9OHJG3Ky9RfGbvBq-9xpNtLQhx-sO6x8sp0CKxGpfQ@mail.gmail.com>
Message-ID: <CAK7LNARq9OHJG3Ky9RfGbvBq-9xpNtLQhx-sO6x8sp0CKxGpfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove VERSION and PATCHLEVEL from $(objtree)/Makefile
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8818=E6=97=A5(=E7=81=AB) 17:46 Masahiro Yamada <yamada=
.masahiro@socionext.com>:
>
> Neither VERSION nor PATCHLEVEL is used in any useful way.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applies to linux-kbuild.


>  Makefile           | 3 +--
>  scripts/mkmakefile | 6 ------
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d2976b5..6e1a059 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -482,8 +482,7 @@ PHONY +=3D outputmakefile
>  outputmakefile:
>  ifneq ($(KBUILD_SRC),)
>         $(Q)ln -fsn $(srctree) source
> -       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile \
> -           $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)
> +       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree) $(ob=
jtree)
>  endif
>
>  ifeq ($(cc-name),clang)
> diff --git a/scripts/mkmakefile b/scripts/mkmakefile
> index e19d656..e2106444 100755
> --- a/scripts/mkmakefile
> +++ b/scripts/mkmakefile
> @@ -7,9 +7,6 @@
>  # Usage
>  # $1 - Kernel src directory
>  # $2 - Output directory
> -# $3 - version
> -# $4 - patchlevel
> -
>
>  test ! -r $2/Makefile -o -O $2/Makefile || exit 0
>  # Only overwrite automatically generated Makefiles
> @@ -25,9 +22,6 @@ fi
>  cat << EOF > $2/Makefile
>  # Automatically generated by $0: don't edit
>
> -VERSION =3D $3
> -PATCHLEVEL =3D $4
> -
>  lastword =3D \$(word \$(words \$(1)),\$(1))
>  makedir :=3D \$(dir \$(call lastword,\$(MAKEFILE_LIST)))
>
> --
> 2.7.4
>


--=20
Best Regards
Masahiro Yamada
