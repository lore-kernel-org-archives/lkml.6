Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C38C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EC12175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j16+oaXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EC12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeKLS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:29:34 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39526 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:29:34 -0500
Received: by mail-yw1-f65.google.com with SMTP id v8-v6so4060574ywh.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCNTp6NdhK/2OEEnMGl1WFohLigmw2SBp5SG+241Mos=;
        b=j16+oaXwwhPLmaHLugdMyT4Z40UN04F3hnxOaUz0kYoXeqWPwIuRNnkzW6uOcT1iLD
         tob4ShBXOyTGxwSk7xE0LWAXepCEB4wPlEeRvgsRajZtO32sTxz4gjZAchk78bQOuSqa
         h257CSnKEfJ3Z4AZXeuABXdXzwyBwBbUqbRhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCNTp6NdhK/2OEEnMGl1WFohLigmw2SBp5SG+241Mos=;
        b=XwSFSqQVBMYol4utG66lXhfWcrkfdhd6DpuWyI6zG1sQr1Ma5HdMi8voctuGui/1nM
         eouTd3nY+8s/KHtTYFSRXkvJj+W383kBPK4RqM27LZn7mV5TdgCuSNNUXI6vnxAYLKFG
         gqok4euXU1yqL2lMe5tGB0swEDHxFxHDewqWnb//qrIkskuKIv53kvoNiaVo7IbyTh3T
         40RlZftHV2800Y/oowIDpZHk8zLcrlOTcVqnuIMAU7/1jy0LBmrqKAe1/bUw6Jb7rwVl
         LkpsML38yUSV3HKk3HX9SR7gZqgZF0uhTcQbvLbdP4CDaYysZ6nsQT4SnbkY0zQ0WHjM
         VJ0Q==
X-Gm-Message-State: AGRZ1gIdRVND9Je9WcUhFboDuMTLaD7vgzYPoCNirChNGbdqrJouV+S0
        9yFR/+NJASEXSoKJHhr/lvx6/Da6O5Cko0QXch/SaCJf+YQ=
X-Google-Smtp-Source: AJdET5d93UtDd6/ZzV9Ll1k8SBS8/xXaDD9MpEZp6fXJmWXXKjX9+SbPHRGNgkUFTT5mtEQxzVOyzFjkdHSqR/lDo00=
X-Received: by 2002:a81:8d7:: with SMTP id 206-v6mr18885ywi.425.1542011844117;
 Mon, 12 Nov 2018 00:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20181108194434.16568-1-anders.roxell@linaro.org> <CAK7LNATU+h3_ytHx4TSUf_breGfxLzHfsOKbGTFprNxYHh9-0g@mail.gmail.com>
In-Reply-To: <CAK7LNATU+h3_ytHx4TSUf_breGfxLzHfsOKbGTFprNxYHh9-0g@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 12 Nov 2018 09:37:12 +0100
Message-ID: <CADYN=9KZLwNA8B+y+c3b7+XzVz_H6PBbwZGDVmzvASKbLhKObw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dvhart@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 at 05:43, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Nov 9, 2018 at 4:45 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > In today's merge_config.sh the order of the config fragment files dictates
> > the output of a config option. With this approach we will get different
> > .config files depending on the order of the config fragment files.
> >
> > So doing something like:
> > $ ./merge/kconfig/merge_config.sh selftest.config drm.config
> >
> > Where selftest.config defines DRM=y and drm.config defines DRM=m, the
> > result will be "DRM=m".
> >
> > Rework to add a switch to get builtin '=y' precedence over modules '=m',
> > this will result in "DRM=y". If we do something like this:
> >
> > $ ./merge/kconfig/merge_config.sh -y selftest.config drm.config
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  scripts/kconfig/merge_config.sh | 34 +++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> > index da66e7742282..fcd18f642fc7 100755
> > --- a/scripts/kconfig/merge_config.sh
> > +++ b/scripts/kconfig/merge_config.sh
> > @@ -22,6 +22,7 @@
> >
> >  clean_up() {
> >         rm -f $TMP_FILE
> > +       rm -f $MERGE_FILE
> >         exit
> >  }
> >  trap clean_up HUP INT TERM
> > @@ -32,6 +33,7 @@ usage() {
> >         echo "  -m    only merge the fragments, do not execute the make command"
> >         echo "  -n    use allnoconfig instead of alldefconfig"
> >         echo "  -r    list redundant entries when merging fragments"
> > +       echo "  -y    make builtin have precedence over modules"
> >         echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
> >         echo
> >         echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
> > @@ -40,6 +42,8 @@ usage() {
> >  RUNMAKE=true
> >  ALLTARGET=alldefconfig
> >  WARNREDUN=false
> > +BUILTIN=false
> > +BUILTIN_FLAG=false
>
>
> Could you move the initialization of BUILTIN_FLAG
> into the inner for-loop ?
>
>
>
> >  OUTPUT=.
> >  CONFIG_PREFIX=${CONFIG_-CONFIG_}
> >
> > @@ -64,6 +68,11 @@ while true; do
> >                 shift
> >                 continue
> >                 ;;
> > +       "-y")
> > +               BUILTIN=true
> > +               shift
> > +               continue
> > +               ;;
> >         "-O")
> >                 if [ -d $2 ];then
> >                         OUTPUT=$(echo $2 | sed 's/\/*$//')
> > @@ -105,13 +114,15 @@ MERGE_LIST=$*
> >  SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
> >
> >  TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
> > +MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
> >
> >  echo "Using $INITFILE as base"
> >  cat $INITFILE > $TMP_FILE
> >
> >  # Merge files, printing warnings on overridden values
> > -for MERGE_FILE in $MERGE_LIST ; do
> > -       echo "Merging $MERGE_FILE"
> > +for ORIG_MERGE_FILE in $MERGE_LIST ; do
> > +       cat $ORIG_MERGE_FILE > $MERGE_FILE
>
>
> This 'cat' should be moved after the check
> of the presence of '$ORIG_MERGE_FILE'.
>
>
> > +       echo "Merging $ORIG_MERGE_FILE"
> >         if [ ! -r "$MERGE_FILE" ]; then
>
> This check always returns false now.
>
>
> >                 echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
> >                 exit 1
> > @@ -122,15 +133,26 @@ for MERGE_FILE in $MERGE_LIST ; do
> >                 grep -q -w $CFG $TMP_FILE || continue
> >                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
> >                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>
> Could you add 'BUILTIN_FLAG=false' here?
>
>
>
> > -               if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> > -                       echo Value of $CFG is redefined by fragment $MERGE_FILE:
> > +               if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
> > +                       echo Previous  value: $PREV_VAL
> > +                       echo New value:       $NEW_VAL
> > +                       echo -y passed, will not demote y to m
> > +                       echo
> > +                       BUILTIN_FLAG=true
> > +               elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> > +                       echo Value of $CFG is redefined by fragment $ORIG_MERGE_FILE:
> >                         echo Previous  value: $PREV_VAL
> >                         echo New value:       $NEW_VAL
> >                         echo
> >                 elif [ "$WARNREDUN" = "true" ]; then
> > -                       echo Value of $CFG is redundant by fragment $MERGE_FILE:
> > +                       echo Value of $CFG is redundant by fragment $ORIG_MERGE_FILE:
> > +               fi
> > +               if [ "$BUILTIN_FLAG" = "false" ]; then
> > +                       sed -i "/$CFG[ =]/d" $TMP_FILE
> > +               else
> > +                       sed -i "/$CFG[ =]/d" $MERGE_FILE
> > +                       BUILTIN_FLAG=false
>
>
> Then this 'BUILTIN_FLAG=false' can go away.

Thank you Masahiro, will send out an update shortly where I address
all your comments.

Cheers,
Anders

>
> Thanks.
>
>
> >                 fi
> > -               sed -i "/$CFG[ =]/d" $TMP_FILE
> >         done
> >         cat $MERGE_FILE >> $TMP_FILE
> >  done
> > --
> > 2.19.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada
