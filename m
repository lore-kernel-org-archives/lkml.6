Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B9121C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GOAKDwf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B9121C17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeHIH3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:29:50 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33255 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHIH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:29:50 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7956ivq000810;
        Thu, 9 Aug 2018 14:06:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7956ivq000810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533791205;
        bh=Op8ngJJXgu2A2yiwX462/rZyVMZb/2ftkGBiTEgeiHc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GOAKDwf1iLVZ3Bvrmoc8ZGmJxw+1XEJFWnJoDabjqJ/QrBUXL8XhcWcuUHpnLsri3
         C1gVUrZvcDqf9TzZUGHhK6iRe+QxlCFYSy/rLD8fUx4EFhoTLhM741etspNSwKRDOD
         6gAqtdq/j4phYyOuPNGB/AnY5j1CiiD4IYbQR2GF1bxJvjpchAlcUgME7+UYS5rIu5
         WRonsZNoVt8z1WJsj1xnBIi22VgVrKXe19DwEdF6nIyFtMZlhf4pTZac+dioxDv209
         Fsv/QHMNrKxb7dEOd/TyPQsepXvF53aitxD+jFTsKggtRRMrPu6qRc0gJ2fwqnJhSs
         RrBjKsEY9jBpg==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id h1-v6so4936826uao.8;
        Wed, 08 Aug 2018 22:06:44 -0700 (PDT)
X-Gm-Message-State: AOUpUlGyXi4XlJyzKf/E9AOW+TtEA77KwoxkTmgKEZ7v/wdUSXN6PFAA
        HcrJzgtBbOwg5JQpjDmTL+Q0lZcq9Ng4kmXmp8o=
X-Google-Smtp-Source: AA+uWPwFuzr8cTjTtpmFcdOHOJmVNMDP3b3n5e026gqGDutjd1JgPyS83HqL72r+hgWKMcEk6YWBI+k1ztCx2Ag4ET8=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr359171vka.140.1533791203993;
 Wed, 08 Aug 2018 22:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 22:06:03 -0700 (PDT)
In-Reply-To: <patch-1.thread-dc1802.git-dc180286abb1.your-ad-here.call-01533563120-ext-8550@work.hours>
References: <cover.thread-dc1802.your-ad-here.call-01533563120-ext-8550@work.hours>
 <patch-1.thread-dc1802.git-dc180286abb1.your-ad-here.call-01533563120-ext-8550@work.hours>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Aug 2018 14:06:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3O+5C2+sPVey_vX1OtmRQJi-RxUrXh+oxev3720tWxw@mail.gmail.com>
Message-ID: <CAK7LNAQ3O+5C2+sPVey_vX1OtmRQJi-RxUrXh+oxev3720tWxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: allow alternate src for target's implicit prerequisite
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-06 23:37 GMT+09:00 Vasily Gorbik <gor@linux.ibm.com>:
> With kbuild there is no easy way to re-compile source files from another
> directory, which is required for the decompressor on some platforms
> (files like lib/ctype.c, lib/cmdline.c, etc). Writing custom build
> rules for those files is not feasible since original rules are complex
> and kbuild functions and variables are not exposed.
>
> The simplest solution is to reverse include source files either into
> existing files or separate files. That eliminates the need to tackle
> with the kbuild rules, but is ugly.
>
> Here is another solution to that problem, utilizing secondary expansion.
> Build rules are in a form:
> $(obj)/%.o: $(src)/%.c ...
> $(obj)/%.o: $(src)/%.S ...
>
> "src" variable could be changed to cover the need of specifying alternate
> source file directory.
> src := $(if $(SRCDIR_$(@F)),$(SRCDIR_$(@F)),$(src))
>
> So, if there is SRCDIR_<target> set, it will be used, original "src" is
> used otherwise. But that wouldn't work as it is. To be able to utilize
> automatic variables in implicit prerequisite secondary expansion has to
> be used and src value has to be additionally escaped.
>
> Alternate src dir then could be specified in Makefile as:
> obj-y := file1.o file2.o
> SRCDIR_file1.o := file1/src/dir
> SRCDIR_file2.o := file2/src/dir
>
> Which is enough to build $(obj)/file1.o from file1/src/dir/file1.(c|S),
> and $(obj)/file2.o from file2/src/dir/file2.(c|S)


Is this a simple solution compared with existing ones?
Kind of.

However, it is just moving the complexity around
from Makefiles to the core build scripts, after all.


I guess the increase of build time is not too big,
( 1 % or so for the incremental build of allmodconfig)
but I do not like performing the second expansion for every directory
to save some a few Makefiles.



> Secondary expansion has been introduced with make 3.81, which is
> minimal supported version by kbuild itself.
>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  scripts/Makefile.build | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 514ed63ff571..97c6ece96cfb 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -70,6 +70,10 @@ $(warning kbuild: Makefile.build is included improperly)
>  endif
>
>  # ===========================================================================
> +# Allow to specify alternate source directory of target's implicit prerequisite
> +# e.g. 'SRCDIR_cmdline.o := lib'


This does not work for single targets.

'make foo/bar/cmdline.o' works,
but 'make foo/bar/cmdline.i' does not.


> +.SECONDEXPANSION:
> +srcdir := $$(if $$(SRCDIR_$$(@F)),$$(SRCDIR_$$(@F)),$(src))
>


-- 
Best Regards
Masahiro Yamada
