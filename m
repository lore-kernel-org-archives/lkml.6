Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC738C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F232075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L1iphVxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F232075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeI3USb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:18:31 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32097 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeI3USb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:18:31 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w8UDjCKG015909;
        Sun, 30 Sep 2018 22:45:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w8UDjCKG015909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538315113;
        bh=WkXQpHofE/xMn9r7S8d1Cxb1t61gbThewSEthqbSSUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L1iphVxc5r2PzvbbcaLF0PoY9oxbFJn6tkxsDQ3eXSndH8f7fDMInCAljOgz2877V
         RgDiiEDN+9Vh/0jmTA7Ezhtqpj+owNz4ypyE6rRmzue0sslqwqwzZvbAdHSsUrY7BK
         sCc0seewcehw1AG1grFdr3hr8kJ16/pR8KongqAnZd8M+iit/DKj/fkiTExSVq/Ahn
         5J1YvG3EqO0LtMhlxGf/zaDLBjL59EI7xPlm9jNKicNv5cw7HnbfnoMaoEoCVsWYqx
         DLD53WLsW+44G9KrBKjJR4eCCYacFVnGAubcEyxPb++XlE9B9sdvo/PpcZmK7LrrVj
         LNtKOneOEhZ1w==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id 125-v6so92184vkx.13;
        Sun, 30 Sep 2018 06:45:12 -0700 (PDT)
X-Gm-Message-State: ABuFfohMnhwzjqZ8AYraERpx131oP6Qh9Hb82BdG6rx4RJTMADZRw99p
        vXM0af5uYV/XD31NnWAxegwagk2H7hVt17BjFH8=
X-Google-Smtp-Source: ACcGV63WEZ0qvQzZWzo48DW9p4f6ccuO9ajTuTQALkMVuXyMTGaeAhu5DzR9qNMOagi8J8TeftdwshK6zXWgBs6oweo=
X-Received: by 2002:a1f:cd3:: with SMTP id 202-v6mr2040613vkm.74.1538315111621;
 Sun, 30 Sep 2018 06:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <1536826841-4458-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1536826841-4458-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 30 Sep 2018 22:44:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVDHfS==P0r7tX6Q41HN3=4VfujZVdYOPsvXPR=Ers_Q@mail.gmail.com>
Message-ID: <CAK7LNATVDHfS==P0r7tX6Q41HN3=4VfujZVdYOPsvXPR=Ers_Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unneeded link_multi_deps
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B49=E6=9C=8813=E6=97=A5(=E6=9C=A8) 17:22 Masahiro Yamada <yamada=
.masahiro@socionext.com>:
>
> Since commit c8589d1e9e01 ("kbuild: handle multi-objs dependency
> appropriately"), $^ really represents all the prerequisite of the
> composite object being built.
>
> Hence, $(filter-out FORCE,$^) contains all the objects to link
> together, which is much simpler than link_multi_deps calculation.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  scripts/Makefile.build | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index cb03774..d7fa203 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -485,28 +485,12 @@ targets +=3D $(obj)/lib-ksyms.o
>
>  endif
>
> -#
> -# Rule to link composite objects
> -#
> -#  Composite objects are specified in kbuild makefile as follows:
> -#    <composite-object>-objs :=3D <list of .o files>
> -#  or
> -#    <composite-object>-y    :=3D <list of .o files>
> -#  or
> -#    <composite-object>-m    :=3D <list of .o files>
> -#  The -m syntax only works if <composite object> is a module
> -link_multi_deps =3D                     \
> -$(filter $(addprefix $(obj)/,         \
> -$($(subst $(obj)/,,$(@:.o=3D-objs)))    \
> -$($(subst $(obj)/,,$(@:.o=3D-y)))       \
> -$($(subst $(obj)/,,$(@:.o=3D-m)))), $^)
> -
>  quiet_cmd_link_multi-m =3D LD [M]  $@
> -cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd=
_secanalysis)
> +cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(filter-out FORCE,$^) $=
(cmd_secanalysis)
>
>  $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
> -       @{ echo $(@:.o=3D.ko); echo $(link_multi_deps); \
> +       @{ echo $(@:.o=3D.ko); echo $(filter-out FORCE,$^); \
>            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=3D.mod)
>  $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
>
> --
> 2.7.4
>


--=20
Best Regards
Masahiro Yamada
