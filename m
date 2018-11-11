Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EFBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3F20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AJVTS5p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKKOao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:30:44 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59170 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:30:44 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wAB4h8sY018063;
        Sun, 11 Nov 2018 13:43:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAB4h8sY018063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541911389;
        bh=AMx0IRW0lFgq8CMH/dmn+u4HOsMczgDQa5mYtN7flLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJVTS5p2qonVbWDX3EkhWghHc3PTgNIzdU8D6X18guZlSBNPYgCIiPSDfSLrxk9+r
         PF17sHUAuaN/q+qB9XTrXQFYaJQn0v4geKQuduF1XZw0AxC3dEgLgJGk2KBV+fXWks
         5KT90FT0OW1inQb81oe2v0xSj7igzRPhw3fTEjgNulCVJrWH4k3lB15+aOQZXjW03O
         WhtcKtYlMumJCwtqQP6LsqJJWcv7dy7CRtAxWV6KH0zWUKaWF8xYqQKrAh6yK5PAeO
         W+EU9sxguOBZrKLMMkpS1wZtATTvlzn3Z5XB1xcijv7r6qZHgiIFPfCidfB23n5Nef
         4bz6jJhQFYS1A==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id w72so1288034vkd.5;
        Sat, 10 Nov 2018 20:43:08 -0800 (PST)
X-Gm-Message-State: AGRZ1gIDRbgx2BPEKmS0M4etLo7ynsEz3q961kiy3fHyhhlaR8kXBKR5
        /I1ggrJPa4wdOMT26wHX1n39+ofI/bRG18K7+WA=
X-Google-Smtp-Source: AJdET5cDX5XYmnsJ2KmJRJsTWjDtHH9WfeBegq4CuBNdCMuOEK/TaSBLQjXoGkIt/+QeiZxMaEvT2q5q8aVLweopxWI=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr6540430vkd.74.1541911387201;
 Sat, 10 Nov 2018 20:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20181108194434.16568-1-anders.roxell@linaro.org>
In-Reply-To: <20181108194434.16568-1-anders.roxell@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 11 Nov 2018 13:42:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATU+h3_ytHx4TSUf_breGfxLzHfsOKbGTFprNxYHh9-0g@mail.gmail.com>
Message-ID: <CAK7LNATU+h3_ytHx4TSUf_breGfxLzHfsOKbGTFprNxYHh9-0g@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dvhart@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:45 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> In today's merge_config.sh the order of the config fragment files dictates
> the output of a config option. With this approach we will get different
> .config files depending on the order of the config fragment files.
>
> So doing something like:
> $ ./merge/kconfig/merge_config.sh selftest.config drm.config
>
> Where selftest.config defines DRM=y and drm.config defines DRM=m, the
> result will be "DRM=m".
>
> Rework to add a switch to get builtin '=y' precedence over modules '=m',
> this will result in "DRM=y". If we do something like this:
>
> $ ./merge/kconfig/merge_config.sh -y selftest.config drm.config
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  scripts/kconfig/merge_config.sh | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index da66e7742282..fcd18f642fc7 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -22,6 +22,7 @@
>
>  clean_up() {
>         rm -f $TMP_FILE
> +       rm -f $MERGE_FILE
>         exit
>  }
>  trap clean_up HUP INT TERM
> @@ -32,6 +33,7 @@ usage() {
>         echo "  -m    only merge the fragments, do not execute the make command"
>         echo "  -n    use allnoconfig instead of alldefconfig"
>         echo "  -r    list redundant entries when merging fragments"
> +       echo "  -y    make builtin have precedence over modules"
>         echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
>         echo
>         echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
> @@ -40,6 +42,8 @@ usage() {
>  RUNMAKE=true
>  ALLTARGET=alldefconfig
>  WARNREDUN=false
> +BUILTIN=false
> +BUILTIN_FLAG=false


Could you move the initialization of BUILTIN_FLAG
into the inner for-loop ?



>  OUTPUT=.
>  CONFIG_PREFIX=${CONFIG_-CONFIG_}
>
> @@ -64,6 +68,11 @@ while true; do
>                 shift
>                 continue
>                 ;;
> +       "-y")
> +               BUILTIN=true
> +               shift
> +               continue
> +               ;;
>         "-O")
>                 if [ -d $2 ];then
>                         OUTPUT=$(echo $2 | sed 's/\/*$//')
> @@ -105,13 +114,15 @@ MERGE_LIST=$*
>  SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
>
>  TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
> +MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
>
>  echo "Using $INITFILE as base"
>  cat $INITFILE > $TMP_FILE
>
>  # Merge files, printing warnings on overridden values
> -for MERGE_FILE in $MERGE_LIST ; do
> -       echo "Merging $MERGE_FILE"
> +for ORIG_MERGE_FILE in $MERGE_LIST ; do
> +       cat $ORIG_MERGE_FILE > $MERGE_FILE


This 'cat' should be moved after the check
of the presence of '$ORIG_MERGE_FILE'.


> +       echo "Merging $ORIG_MERGE_FILE"
>         if [ ! -r "$MERGE_FILE" ]; then

This check always returns false now.


>                 echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
>                 exit 1
> @@ -122,15 +133,26 @@ for MERGE_FILE in $MERGE_LIST ; do
>                 grep -q -w $CFG $TMP_FILE || continue
>                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
>                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)

Could you add 'BUILTIN_FLAG=false' here?



> -               if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> -                       echo Value of $CFG is redefined by fragment $MERGE_FILE:
> +               if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
> +                       echo Previous  value: $PREV_VAL
> +                       echo New value:       $NEW_VAL
> +                       echo -y passed, will not demote y to m
> +                       echo
> +                       BUILTIN_FLAG=true
> +               elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> +                       echo Value of $CFG is redefined by fragment $ORIG_MERGE_FILE:
>                         echo Previous  value: $PREV_VAL
>                         echo New value:       $NEW_VAL
>                         echo
>                 elif [ "$WARNREDUN" = "true" ]; then
> -                       echo Value of $CFG is redundant by fragment $MERGE_FILE:
> +                       echo Value of $CFG is redundant by fragment $ORIG_MERGE_FILE:
> +               fi
> +               if [ "$BUILTIN_FLAG" = "false" ]; then
> +                       sed -i "/$CFG[ =]/d" $TMP_FILE
> +               else
> +                       sed -i "/$CFG[ =]/d" $MERGE_FILE
> +                       BUILTIN_FLAG=false


Then this 'BUILTIN_FLAG=false' can go away.

Thanks.


>                 fi
> -               sed -i "/$CFG[ =]/d" $TMP_FILE
>         done
>         cat $MERGE_FILE >> $TMP_FILE
>  done
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
