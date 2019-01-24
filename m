Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F19218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TOt2kaH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfAXE2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:28:48 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64731 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXE2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:28:48 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0O4SVZJ011188;
        Thu, 24 Jan 2019 13:28:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0O4SVZJ011188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548304111;
        bh=WBMO0N7O44VpX5ttR2NArBNAx1FCiRWJE1QnCFcqW3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TOt2kaH3N6lPrN8EsS3H6zutwsCW52uWX/5yHsdGPEuSOoyM96IE/iZtBD40wtK1+
         bPu8yDgnMBpkSe0oVwSrgNIvqzeIAVJ3f7dVCg9RRss2X9zsTW+DNlZ/QHr7+fJdNj
         7JU60gDORikvtqfEd0N2tJtSqqvggxFMAsNX9Zs22gXWCMDfSehq8AqmizIZ/0exTH
         k3kccofm0wltfVArngJXcIHovSyuBHCFGL2JWqVq5XUJqqcaoPsdrQSvPOEMuebAwv
         4bqZX+XspJFtoSxqwZV+5cQ6eITGLAgevnRqNV0r2wmkCgercnzivTHNvnBMMj121r
         ycuUnuNtWo3Dg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id b74so2740169vsd.9;
        Wed, 23 Jan 2019 20:28:31 -0800 (PST)
X-Gm-Message-State: AJcUukcaVw2jFppLuR9D7t1yQHMd8P7Hz06AF7EULqRqxnmFg4lWBJDT
        PnWcZLy2gTFb4NXPYSTT/bEuaaYVr2HRljlTrKQ=
X-Google-Smtp-Source: ALg8bN5O//fc/Rrj4Sc5BZ6ewj3oKT2vig2YRe8PGNXWabH9n8LXWAHir7KgjsvXnFoWv4V7+t5SgVWABGVPJaJkqkA=
X-Received: by 2002:a67:485:: with SMTP id 127mr2148288vse.54.1548304110425;
 Wed, 23 Jan 2019 20:28:30 -0800 (PST)
MIME-Version: 1.0
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Jan 2019 13:27:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdndZMEUSkoVrSeqDL3rq2NXm83seFXC6a8SjMTNVmOQ@mail.gmail.com>
Message-ID: <CAK7LNAQdndZMEUSkoVrSeqDL3rq2NXm83seFXC6a8SjMTNVmOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kbuild: simplify rules of data compression with
 size appending
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 7:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> All the callers of size_append pass $(filter-out FORCE,$^).
> Move $(filter-out FORCE,$^) to the definition of size_append.
>
> This makes the callers cleaner because $(call ...) is unneeded
> for a macro with no argument.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


> Changes in v2: None
>
>  scripts/Makefile.lib | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ecad15b..ebaa348 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -321,7 +321,7 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>  # append the size as a 32-bit littleendian number as gzip does.
>  size_append = printf $(shell                                           \
>  dec_size=0;                                                            \
> -for F in $1; do                                                                \
> +for F in $(filter-out FORCE,$^); do                                    \
>         fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);  \
>         dec_size=$$(expr $$dec_size + $$fsize);                         \
>  done;                                                                  \
> @@ -335,23 +335,20 @@ printf "%08x\n" $$dec_size |                                              \
>  )
>
>  quiet_cmd_bzip2 = BZIP2   $@
> -cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
> -       bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
>
>  # Lzma
>  # ---------------------------------------------------------------------------
>
>  quiet_cmd_lzma = LZMA    $@
> -cmd_lzma = (cat $(filter-out FORCE,$^) | \
> -       lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
>
>  quiet_cmd_lzo = LZO     $@
> -cmd_lzo = (cat $(filter-out FORCE,$^) | \
> -       lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
>
>  quiet_cmd_lz4 = LZ4     $@
> -cmd_lz4 = (cat $(filter-out FORCE,$^) | \
> -       lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
> +      cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
> +                  $(size_append)) > $@
>
>  # U-Boot mkimage
>  # ---------------------------------------------------------------------------
> @@ -394,8 +391,7 @@ quiet_cmd_uimage = UIMAGE  $@
>  # decompression mode. A BCJ filter isn't used either.
>  quiet_cmd_xzkern = XZKERN  $@
>  cmd_xzkern = (cat $(filter-out FORCE,$^) | \
> -       sh $(srctree)/scripts/xz_wrap.sh && \
> -       $(call size_append, $(filter-out FORCE,$^))) > $@
> +       sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
>
>  quiet_cmd_xzmisc = XZMISC  $@
>  cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
