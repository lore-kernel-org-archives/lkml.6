Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B702175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rfgJ1ptf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B702175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbeKNJCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:02:20 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31892 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:02:19 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wADN1Z0S007981;
        Wed, 14 Nov 2018 08:01:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wADN1Z0S007981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542150096;
        bh=IKFzWWZFr/HGcuJb5Gl9EUKlyma44b2x1Dkaoq6IGh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfgJ1ptfVee2gV+nLOxWgRpr41uNLPAd23YJhEuElTVXuFbtU2ycNe9z3nRkGuqVv
         0W+PPZD/zCV082IbCmtdjeRbTbFNRAjvp+V582haVNsouDy1R5aeNIyo5B/6bY6nTd
         iXrwsfAcJBnN+/+vZPma1oMkbF4N+vruAns9ArMjgMFcn7b78q677LhvmmTJHbSplL
         TYkgut4dRe8VHQ0WvkXHHzhVNpnRHAJaCYfym03GFx9e7uUduddOsNoyAmZGmdSf5K
         MrYscb42jPe3RL6W9qpLSIbGPxRqvPprUm7Z8HWkdVBFgbKbH5I/R7iz93KWiQjIor
         EyyIOIa1SNUcA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id z23so4783231uam.1;
        Tue, 13 Nov 2018 15:01:35 -0800 (PST)
X-Gm-Message-State: AGRZ1gLpgx07XwdhV4dJ8asyaP1AT0u0l5aWbdksdvKhA3Rotc17B+Hd
        TayUjtPQwmioTA7236CrZ49+B4NNzk+HFP8ZUzc=
X-Google-Smtp-Source: AJdET5fvyNxtaJD4vqodJWgpAHRvCLCeFLnU3qO+USGdtjjFaw63fj14zury/5sCeb40E2dAwFs8sc9gj9HUqsyfJ3I=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr3421412uaa.55.1542150094302;
 Tue, 13 Nov 2018 15:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20181112083855.27917-1-anders.roxell@linaro.org>
In-Reply-To: <20181112083855.27917-1-anders.roxell@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:00:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=LuFkCYXFNAJCTrbOAiasd=uJ6A+mTQw9gjqEgB3w6A@mail.gmail.com>
Message-ID: <CAK7LNAQ=LuFkCYXFNAJCTrbOAiasd=uJ6A+mTQw9gjqEgB3w6A@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dvhart@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:39 PM Anders Roxell <anders.roxell@linaro.org> wrote:
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


Applied to linux-kbuild. Thanks!


>  scripts/kconfig/merge_config.sh | 37 ++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index 0ef906499646..9b89791b202c 100755
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
> @@ -40,6 +42,7 @@ usage() {
>  RUNMAKE=true
>  ALLTARGET=alldefconfig
>  WARNREDUN=false
> +BUILTIN=false
>  OUTPUT=.
>  CONFIG_PREFIX=${CONFIG_-CONFIG_}
>
> @@ -64,6 +67,11 @@ while true; do
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
> @@ -106,32 +114,45 @@ SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
>  SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
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
> -       if [ ! -r "$MERGE_FILE" ]; then
> -               echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
> +for ORIG_MERGE_FILE in $MERGE_LIST ; do
> +       echo "Merging $ORIG_MERGE_FILE"
> +       if [ ! -r "$ORIG_MERGE_FILE" ]; then
> +               echo "The merge file '$ORIG_MERGE_FILE' does not exist.  Exit." >&2
>                 exit 1
>         fi
> +       cat $ORIG_MERGE_FILE > $MERGE_FILE
>         CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
>
>         for CFG in $CFG_LIST ; do
>                 grep -q -w $CFG $TMP_FILE || continue
>                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
>                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
> -               if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> -                       echo Value of $CFG is redefined by fragment $MERGE_FILE:
> +               BUILTIN_FLAG=false
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
