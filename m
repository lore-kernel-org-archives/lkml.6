Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697A1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sYHd2Dn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfAXE31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:29:27 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:39860 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:29:27 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0O4TCtN010653;
        Thu, 24 Jan 2019 13:29:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0O4TCtN010653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548304153;
        bh=2tiIoYOXYtIStQwfw2CBjobfrN1piCCtPngE1L8fUoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sYHd2Dn/b7gTX1YjVPBPS2yYTZmDft9v9xY9UKCo6/zswWlUdojtEqrIXt/WtGnsX
         Vm0D0Y8R29ZKLPQoO1l9gNNL3qRcQr+AmhMC/cUFKfv43wLR4QlIPkBNLUN9POeJbm
         giOQxYCO2yS5+45DLNB31rIkH04tYeiMplrHa1DnbEPI4nQifko3zSh2scZk9JR6Bi
         T2OE8wO0p1Gmz239oMkM3gV6FC5b964RA+qNaCVi+nOicdp6NWRW9d8WSwuCceTThl
         CwHkrcJNJt56yAIbrv19jBu6uy4vZjYtKPTr/vLvhSJttEbS50QAZpfX70PJXgHm1/
         Tu+8o/q5Amn9g==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id x28so2734580vsh.12;
        Wed, 23 Jan 2019 20:29:12 -0800 (PST)
X-Gm-Message-State: AJcUukdRyOOPGtUDhguXMlueC6Qv1kSc48YK75ZKrCA+tMVrjaEKjHVw
        h7o1d/z9ZAsDPWCGnnr22H6iP3dCrLKAI5RcFJA=
X-Google-Smtp-Source: ALg8bN6BRHS5I6RiBIOAoW3OzHjglT8Sge2I84KX59TDI3LQoViaqjchudc3sdMVC97LfkPYT5zECFTQU28yUHg8EOc=
X-Received: by 2002:a67:a858:: with SMTP id r85mr1980222vse.215.1548304151676;
 Wed, 23 Jan 2019 20:29:11 -0800 (PST)
MIME-Version: 1.0
References: <1547607401-20118-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547607401-20118-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Jan 2019 13:28:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPGoBLqGbujYA5uvEDzLXdzU919_+jgJaD5Vwr++8tPw@mail.gmail.com>
Message-ID: <CAK7LNASPGoBLqGbujYA5uvEDzLXdzU919_+jgJaD5Vwr++8tPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: skip 'addtree' and 'flags' magic for external
 module build
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 1:18 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> When building an external module, $(obj) is the absolute path to it.
>
> The header search paths from ccflags-y etc. should not be tweaked.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.

(2/2 was discarded.)


>  scripts/Makefile.host |  6 ++++--
>  scripts/Makefile.lib  | 11 ++++++-----
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 0393f75..a115259 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -67,13 +67,15 @@ _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
>  _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
>                   $(HOSTCXXFLAGS_$(basetarget).o)
>
> -ifeq ($(KBUILD_SRC),)
>  __hostc_flags  = $(_hostc_flags)
>  __hostcxx_flags        = $(_hostcxx_flags)
> -else
> +
> +ifeq ($(KBUILD_EXTMOD),)
> +ifneq ($(KBUILD_SRC),)
>  __hostc_flags  = -I$(obj) $(call flags,_hostc_flags)
>  __hostcxx_flags        = -I$(obj) $(call flags,_hostcxx_flags)
>  endif
> +endif
>
>  hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
>  hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 12b88d0..ecad15b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -137,14 +137,14 @@ _c_flags += $(if $(patsubst n%,, \
>         $(CFLAGS_KCOV))
>  endif
>
> -# If building the kernel in a separate objtree expand all occurrences
> -# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
> -
> -ifeq ($(KBUILD_SRC),)
>  __c_flags      = $(_c_flags)
>  __a_flags      = $(_a_flags)
>  __cpp_flags     = $(_cpp_flags)
> -else
> +
> +# If building the kernel in a separate objtree expand all occurrences
> +# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
> +ifeq ($(KBUILD_EXTMOD),)
> +ifneq ($(KBUILD_SRC),)
>
>  # -I$(obj) locates generated .h files
>  # $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
> @@ -155,6 +155,7 @@ __c_flags   = $(if $(obj),$(call addtree,-I$(src)) -I$(obj)) \
>  __a_flags      = $(call flags,_a_flags)
>  __cpp_flags     = $(call flags,_cpp_flags)
>  endif
> +endif
>
>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>                  -include $(srctree)/include/linux/compiler_types.h       \
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
