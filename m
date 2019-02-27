Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C7B2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Iu+UnJyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfB0N2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:28:31 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17374 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfB0N2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:28:31 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1RDSIOv015772;
        Wed, 27 Feb 2019 22:28:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1RDSIOv015772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551274099;
        bh=T7dsBI6ldvf24cOFHdeMYtVhclkQw/5+MQSGS8wolhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iu+UnJyDVAuPfHyCXNp3DZpiO28S09yQNp3gncz70UX6gkkUuJ1SxYlzxNfj5iNZP
         XXGX87VBTGlAjGE5jivcEHwMR7Z4WscWmaZWfPtDAYPzMyaucUdJlaVLMjB3k0SFWY
         EzNyFRri43iES8g8FiqDYp7gNAIdtgLZNbQySrqSd+0ueN3DdkuOGIPKsEdWJRE3L1
         Q0L/wrQ+WrOZyREA3M5D88UmR2TT33egHYhLWGP9R6DMYRchT3zeP7z6LaVeULqUWr
         zhmCM5ANQ4OcbEb6emBeu57Eect+VpIKsVHJxuAf2GdYLFtqLb6THZOHUyl9Oez34k
         aDbMv5wZghNJA==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id r21so8113665uan.11;
        Wed, 27 Feb 2019 05:28:19 -0800 (PST)
X-Gm-Message-State: AHQUAub2F+AOTI48NhtjYPnufahoPUAOZ8KfBeM2WPX5eHC9iFLSDe5U
        e53BBjjtmJs+FFbheQ7a+eLuUp9pWSAR7acW23k=
X-Google-Smtp-Source: AHgI3IZXCIpmXhmvnbTZIqA35U3w5jTdss7Md35JrgOynSal+OnM7l21HFihWOqYMG3Lf6CHYYJhTQBTcwR+Hx1mDZc=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr1773409vsq.181.1551274098321;
 Wed, 27 Feb 2019 05:28:18 -0800 (PST)
MIME-Version: 1.0
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 22:27:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQy=nf6n11_dNQYCe-pq3t99ENyQASziVQFOA0KTtU68g@mail.gmail.com>
Message-ID: <CAK7LNAQy=nf6n11_dNQYCe-pq3t99ENyQASziVQFOA0KTtU68g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kbuild: move tools_silent to a more relevant place
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 4:40 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This would disturb the change the sub-make part. Move it near the
> tools/ target.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.



> Changes in v2: None
>
>  Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index bf4e77b..82091b8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -90,7 +90,6 @@ endif
>
>  ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
>    quiet=silent_
> -  tools_silent=s
>  endif
>
>  export quiet Q KBUILD_VERBOSE
> @@ -1678,6 +1677,11 @@ image_name:
>         @echo $(KBUILD_IMAGE)
>
>  # Clear a bunch of variables before executing the submake
> +
> +ifeq ($(quiet),silent_)
> +tools_silent=s
> +endif
> +
>  tools/: FORCE
>         $(Q)mkdir -p $(objtree)/tools
>         $(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
