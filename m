Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56320852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dO6cJZ2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B56320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeGYPxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:53:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61403 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbeGYPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:53:08 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6PEeluR012934;
        Wed, 25 Jul 2018 23:40:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6PEeluR012934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532529648;
        bh=GX8cC0Uu/FTXU6MkQP/GVZVLNCmlz9h22UsmOmNbOSI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dO6cJZ2LWdgyAUbzGvMYG9rJ6RL9HFDcLZcO2iwVIx5NUBiTo1BpDuXsT5OTofcga
         zaCB2iCsVh0WbbDtF2O+ueo3+JbQzuwJOmVtx6KAtvSRymAsXeL6m2ZH0dLfLwE9/Y
         BU/Tj9cIJ+iCwcyclkXCWqkjrlFESghTF6nLMaSyNi/UYvoBKMVJeI7vVulwkO06an
         /aPO3eY7hLlsU3w3UfEA1SDfJAyYQVf31Lg5mglgQyR3DQ6a2Jacpt7+a6BKM6QBt8
         LaKK3YQIyE9awmtkO61WkOVI48O4C8E1/iNARauDZ82aUtx/Jn8vMOkNrk3u9H499k
         7AZS9d2TR8BGg==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id r10-v6so5219919uao.1;
        Wed, 25 Jul 2018 07:40:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlGzyMMlQ0om8ygIOjTk+w6nXVLLo2w24BAuIRhgcrAeyDF1d8sx
        BHTc24iwZnYGNJk4BCfwwUUNi5kG86021cZJ0RI=
X-Google-Smtp-Source: AAOMgpfRFQ2uux57S/Oz5PLML9I/s2ZGhhOe/WOuxEMgpDGDWw0ZIEdZXbMlHojVIJHTqIjqqIrea6HQbIcLrgd63BE=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr14933270uad.82.1532529647103;
 Wed, 25 Jul 2018 07:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 07:40:06
 -0700 (PDT)
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 23:40:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQ4zZEshGfpRH1O=mD2AO6G-OTWBJCLLzWR=1meYhiqw@mail.gmail.com>
Message-ID: <CAK7LNARQ4zZEshGfpRH1O=mD2AO6G-OTWBJCLLzWR=1meYhiqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] kbuild/kconfig: do not update config during installation
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 16:46 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> The main motivation of this patch series is to suppress the syncconfig
> during running installation targets.
>
> V1 consisted of only two patches:
>   https://patchwork.kernel.org/patch/10468105/
>   https://patchwork.kernel.org/patch/10468103/
>
> I noticed that installation targets would continue running
> even if the source tree is not configured at all
> because the inclusion of include/config/auto.conf was optional.
>
> So, I added one more patch in V2:
>  https://patchwork.kernel.org/patch/10483637/
>
> However, kbuild test robot reported a new warning message was displayed:
>
> Makefile:592: include/config/auto.conf: No such file or directory
>
> This warning is displayed only for Make 4.1 or older.
>
> To fix this annoying warning, I changed Kconfig too,
> which leaded to more clean-up, improvements in Kconfig.
>
> So, V3 became a big patch series.
>
> Only a few changes for V4.
>  - I dropped the last patch in v3.
>  - I am keeping include/config/auto.conf as the prerequisite of modules.builtin (11/11)


Applied to linux-kbuild/kconfig.


>
> Masahiro Yamada (11):
>   kconfig: rename file_write_dep and move it to confdata.c
>   kconfig: split out useful helpers in confdata.c
>   kconfig: remove unneeded directory generation from local*config
>   kconfig: create directories needed for syncconfig by itself
>   kconfig: make syncconfig update .config regardless of sym_change_count
>   kconfig: allow all config targets to write auto.conf if missing
>   kbuild: use 'include' directive to load auto.conf from top Makefile
>   kbuild: add .DELETE_ON_ERROR special target
>   kbuild: do not update config when running install targets
>   kbuild: do not update config for 'make kernelrelease'
>   kbuild: remove auto.conf from prerequisite of phony targets
>
>  Makefile                    |  44 +++++++++------
>  scripts/Kbuild.include      |   3 +
>  scripts/kconfig/Makefile    |  16 ++----
>  scripts/kconfig/conf.c      |  39 +++++++------
>  scripts/kconfig/confdata.c  | 135 +++++++++++++++++++++++++++++++++++++-------
>  scripts/kconfig/gconf.c     |   1 +
>  scripts/kconfig/lkc.h       |   1 -
>  scripts/kconfig/lkc_proto.h |   2 +-
>  scripts/kconfig/mconf.c     |   1 +
>  scripts/kconfig/nconf.c     |   1 +
>  scripts/kconfig/qconf.cc    |   2 +
>  scripts/kconfig/util.c      |  30 ----------
>  12 files changed, 177 insertions(+), 98 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
