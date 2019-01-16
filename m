Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD62DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCD5206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UeiglUNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393651AbfAPOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:34:36 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39380 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfAPOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:34:36 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x0GEYCSW020934;
        Wed, 16 Jan 2019 23:34:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x0GEYCSW020934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547649253;
        bh=LeZvenWAyFhQpFAc6vVeaym8dil5fWgTRHvB0UI5JKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UeiglUNBUHfrtsie89ag31RuIsIVtxplGQ6nRZTeEkq6WOihkzHEX8Sg/cmvqFl72
         /ofxuZfbR66yI6pMmPekiRmIF+3U56Dr6uXuAqc6XqMDZLc4C8tj1FZt4sdXN0lG2F
         VgEGJ3QMEAr3zH51VfE/1i7GyjJNLtJ6+aFeQcyk991HP0EfT8Hzlt8ziHPkYxfOg5
         eXW0FrYXqQX3e2Bp4FGyDtoneycWW8GM65HfF3jgiiJQAdmP2G75VJ70/gsQKOO4Ha
         J+e7Cq+N9BsLx3bnCXVOxGzlQzI+ImfL0pnxdP+Cbr6Nq4Gc/QprbzCeyIkXG+4bzf
         lndOFGNoS3c8Q==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id d201so1467617vka.0;
        Wed, 16 Jan 2019 06:34:13 -0800 (PST)
X-Gm-Message-State: AJcUukcPLdVwjgQY1vApk7ww4jXGFpHuK95t1uPsVUFzCvjAT/RWzFW+
        JklDM5kGSVMI0V9EFvh36f5B4ieo9B7zUFEUZd8=
X-Google-Smtp-Source: ALg8bN48zfMaV+AYClsEiSt7txS7WccQZ9Pp9d2+4k0CSh3ouq2pbZgy1dZWwsRLrOuyeCFnNqfUwZHIK9K/ocgjusw=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr3627366vkd.64.1547649251970;
 Wed, 16 Jan 2019 06:34:11 -0800 (PST)
MIME-Version: 1.0
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 16 Jan 2019 23:33:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Message-ID: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module build
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:07 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
> caused kernel panic on PowerPC if an external module is used with
> CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
> for the external module build.
>
> Commit e07db28eea38 ("kbuild: fix single target build for external
> module") turned it into a build error because the 'prepare' target is
> now executed but the 'prepare0' target is missing for the external
> module build.
>
> External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
> also broken in the same way.
>
> Move 'PHONY += prepare0' to the common place. Make is fine with missing
> rule for phony targets.
>
> I minimize the change so it can be easily backported to 4.20.x
>
> To fix v4.20 for external modules of PowerPC, please backport
> e07db28eea38 ("kbuild: fix single target build for external module"),
> and then this commit.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
> Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
> Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
> Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
> Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20
> Reported-by: Samuel Holland <samuel@sholland.org>
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.


>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 499b968..789b332 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -955,6 +955,7 @@ ifdef CONFIG_STACK_VALIDATION
>    endif
>  endif
>
> +PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
>  core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> @@ -1061,8 +1062,7 @@ scripts: scripts_basic scripts_dtc
>  # archprepare is used in arch Makefiles and when processed asm symlink,
>  # version.h and scripts_basic is processed / created.
>
> -# Listed in dependency order
> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
