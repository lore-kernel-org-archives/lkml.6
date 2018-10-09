Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0951C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02FE21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0M5zu2N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJIWRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:17:36 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48975 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJIWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:17:36 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w99ExxM8025995;
        Wed, 10 Oct 2018 00:00:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w99ExxM8025995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097200;
        bh=EqLwtVieBTMSBZpDCXpPOCdMKw+P5GfFFeM2l+V5JFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0M5zu2N8i65f4cYhSgzUE5+c36NHxFvvYcEvpwODpxKclneMuZ/rdFghn09WWgeJo
         tXlRN7uyrtNqbEX3DztsvuukTDYWfVhXQ4H2ANSTlIYgQddgluCEMaUY+WUtAr+rwz
         BsAMRtM3S/mI+ao3+aZ8WogR0NYpyoWSNX9P8i3HB98nPGZBYM/6Eiaqp9pcMQdlnb
         gBFXwjOA8TaId7numTU83AKzmDgp/GYA6VdKoxkl40gtTjczPsgCKkssxEwf3n/ib7
         0twwF86tC3hs8dAUMvkoUqkYk2jASl50JsNtMZGooZvJIaw8g5ybeiBIqjCfWsE3BJ
         jpycSLu/s12yw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id c10so1811721vsk.2;
        Tue, 09 Oct 2018 07:59:59 -0700 (PDT)
X-Gm-Message-State: ABuFfogYrGcYF/XTbynPetZwMoPtYWTN+LZg29kVCkrTIetfYpKqKH+h
        g/JDUF1NsDhfoLS7GOnDDyfoY020wGJ0s9LCZLU=
X-Google-Smtp-Source: ACcGV62NJRYtogzmDrr8xg3J5YUqL6xKiKPXanTtl/+3lTOvUGwKLzQJGAEuLINrCvExiMFLxNqCjuw3Giu4bL58z1I=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr10483020vsm.181.1539097198705;
 Tue, 09 Oct 2018 07:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <1538627119-11346-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538627119-11346-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Oct 2018 23:59:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOf8cp=A+VeDBi=Wn-3DBAnd78Uxc5OL_b-MOkc6dJcw@mail.gmail.com>
Message-ID: <CAK7LNATOf8cp=A+VeDBi=Wn-3DBAnd78Uxc5OL_b-MOkc6dJcw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: remove unneeded link_multi_deps
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 1:25 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit c8589d1e9e01 ("kbuild: handle multi-objs dependency
> appropriately"), $^ really represents all the prerequisite of the
> composite object being built.
>
> Hence, $(filter %.o,$^) contains all the objects to link together,
> which is much simpler than link_multi_deps calculation.
>
> Please note $(filter-out FORCE,$^) does not work here.  When a
> single object module is turned into a multi object module, $^ will
> contain header files that were previously included for building the
> single object, and recorded in the .*.cmd file.  $(filter %.o,$^)
> should be used to filter out such headers.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Fix regression reported in linux-next.
>     https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1779047.html


V2 replaced V1.


>  scripts/Makefile.build | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index cb03774..f21b48d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -485,28 +485,12 @@ targets += $(obj)/lib-ksyms.o
>
>  endif
>
> -#
> -# Rule to link composite objects
> -#
> -#  Composite objects are specified in kbuild makefile as follows:
> -#    <composite-object>-objs := <list of .o files>
> -#  or
> -#    <composite-object>-y    := <list of .o files>
> -#  or
> -#    <composite-object>-m    := <list of .o files>
> -#  The -m syntax only works if <composite object> is a module
> -link_multi_deps =                     \
> -$(filter $(addprefix $(obj)/,         \
> -$($(subst $(obj)/,,$(@:.o=-objs)))    \
> -$($(subst $(obj)/,,$(@:.o=-y)))       \
> -$($(subst $(obj)/,,$(@:.o=-m)))), $^)
> -
>  quiet_cmd_link_multi-m = LD [M]  $@
> -cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secanalysis)
> +cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
>
>  $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
> -       @{ echo $(@:.o=.ko); echo $(link_multi_deps); \
> +       @{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
>            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>  $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
