Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA1ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2920862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IrehAtPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC2920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeKERxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:53:35 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29632 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKERxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:53:35 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wA58YvDu009317;
        Mon, 5 Nov 2018 17:34:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wA58YvDu009317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541406898;
        bh=ky9IcwVbd4pvge/sURUwm2hea57/L+O9ucQjmbRGS5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IrehAtPtEuy8PV7gtV/jomcpy74hx1W/3N1RNnABjWRvhnhqOFX+I1fKI2CSvNGvZ
         41fwWtfxesf4Ysa0saLs6kL9Ap1PtCCHAY4EkLJZkwXsV6pS1YcndMmzPJZSx6i/ZJ
         84LIXVSmEydfKVOdusu85t/84JjFP7WRBhFubAhutRx+5tVtUFwWTqCoicaA7ThFZb
         mHXphfN+tlu99NfV5FXa9llf2MdaM4i4GUv1buVolAHsAfb+C4IWdPpVDFaLuuBqg1
         fPWOOkmn1A4+3m//vX86gIjg2vmCADUkQuBm5V4oXd3o0Cz++TkjtOb1f9LfpttuWm
         4f+hg5Prj6JyA==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id y14so1526643vky.9;
        Mon, 05 Nov 2018 00:34:58 -0800 (PST)
X-Gm-Message-State: AGRZ1gL14Vp+C8HUI6vGUoN3Q/KX52q8vT3vj+W/luFp9CvKL9f82eu+
        LCbgv/wCVxVqW5LAnSzz7oYMyBIvBz1SOzBg3Vw=
X-Google-Smtp-Source: AJdET5fxw6ATCsM5lgFOyIvfWrOPaco+q3rZzriFjgZj9EFqX1w52yVOSW2hQq2fftML/CLi9caZqZsmyOgMORwtlJI=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr468257vki.84.1541406897136;
 Mon, 05 Nov 2018 00:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20181102114119.23859-1-anders.roxell@linaro.org>
In-Reply-To: <20181102114119.23859-1-anders.roxell@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 17:34:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARda14b9_8Yh7vC2PFa_w=yw+qD0YTriAVQ_Aw5PoXkNw@mail.gmail.com>
Message-ID: <CAK7LNARda14b9_8Yh7vC2PFa_w=yw+qD0YTriAVQ_Aw5PoXkNw@mail.gmail.com>
Subject: Re: [PATCH] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvhart@infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Fri, Nov 2, 2018 at 8:41 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> In today's merge_config.sh the order of the config fragment files dictates
> the output of a config option. With this approach we will get different
> .config files depending on the order of the config fragment files.
> Adding a switch to add precedence for builtin over modules, this will
> make the .config file the same
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

I think this patch makes sense.

Just in case, could you please provide me the context of the discussion?

Does the real problem exist in the kernel tree,
or for local fragment files?


Thanks.



>  scripts/kconfig/merge_config.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index da66e7742282..902a60b45614 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -32,6 +32,7 @@ usage() {
>         echo "  -m    only merge the fragments, do not execute the make command"
>         echo "  -n    use allnoconfig instead of alldefconfig"
>         echo "  -r    list redundant entries when merging fragments"
> +       echo "  -y    make builtin have precedence over modules"
>         echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
>         echo
>         echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
> @@ -40,6 +41,7 @@ usage() {
>  RUNMAKE=true
>  ALLTARGET=alldefconfig
>  WARNREDUN=false
> +BUILTIN=false
>  OUTPUT=.
>  CONFIG_PREFIX=${CONFIG_-CONFIG_}
>
> @@ -64,6 +66,11 @@ while true; do
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
> @@ -122,7 +129,13 @@ for MERGE_FILE in $MERGE_LIST ; do
>                 grep -q -w $CFG $TMP_FILE || continue
>                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
>                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
> -               if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> +               if test "$BUILTIN" = "true" && echo $PREV_VAL |grep -Eq '^\w+=y' && echo $NEW_VAL |grep -Eq '^\w+=m' ; then
> +                       echo Value of $CFG is \'y\' and we don\'t want to redefine the fragment $MERGE_FILE:
> +                       echo Previous  value: $PREV_VAL
> +                       echo New value:       $NEW_VAL
> +                       echo Will use previous value.
> +                       echo
> +               elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
>                         echo Value of $CFG is redefined by fragment $MERGE_FILE:
>                         echo Previous  value: $PREV_VAL
>                         echo New value:       $NEW_VAL
> --
> 2.11.0
>


-- 
Best Regards
Masahiro Yamada
