Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965894AbeCAEeS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 23:34:18 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:45734 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965813AbeCAEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 23:34:16 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w214XwA8027711
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AG47ELu3S6xLH+m7NYwuaX5K8J/QY/fBbyq1QKXtbt8t4mD03wBufDn9u1vXg8NgRSu55Gd8tVeOSd+p2E2XFU0wDTU=
MIME-Version: 1.0
In-Reply-To: <20180228233249.26281-3-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-3-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 13:33:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQSJ1uzgmta76rJwDpi08SB5gwcRPxu_TPw0u0XzgGaJA@mail.gmail.com>
Message-ID: <CAK7LNAQSJ1uzgmta76rJwDpi08SB5gwcRPxu_TPw0u0XzgGaJA@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: add dtc as dependency on .dtb files
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
> If dtc is rebuilt, we should rebuild .dtb files with the new dtc.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Rob Herring <robh@kernel.org>


Hmm, I am not 100% sure about this.

Is there a case where resulted DTBs
depend on DTC version?


If I understand correctly,
DTS and DTB are 1:1
Unlike CC, there is no room for optimization.


Some possibilities could be:
     - specification is updated.
    ( /dts-v1/ in DTS should be updated if so)
  - buggy DTC version generates broken DTBs.



> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1bc2f90cb8c0..6aeb91524c76 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -316,7 +316,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
>         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> -$(obj)/%.dtb: $(src)/%.dts FORCE
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
