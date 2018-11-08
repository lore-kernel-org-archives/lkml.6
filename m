Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B74EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BF220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqS+xx4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BF220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeKIFUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:20:09 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45525 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIFUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:20:09 -0500
Received: by mail-yw1-f66.google.com with SMTP id p18-v6so6265021ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7WtjV6JelGpEqZ/PjCCgd9bMB4nCwZFA13lPhMOcas=;
        b=cqS+xx4gl6Ugu/0Y3+fP4a7pB2o/0P3oGcuFeBCLwC83lAfBb+LJR6A8O6w7NdNc+E
         hpneFvLuwt8tLzh48ZFy6LvhcBvUPg/32MZyDyYqI8scMtqLdY/SdUUZOwWmuYINuz2E
         pmAl/KA+U/J8LB0KJOk2Xt4l3GzJDnZZ5x8/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7WtjV6JelGpEqZ/PjCCgd9bMB4nCwZFA13lPhMOcas=;
        b=iNGo7DIEVNZNp/iS7o65ZzUiCRRpHiaYkpNc6TyaqATDRV19Dg7bcyKG//m+XgR0b1
         MZ4rq0V0EKGOwYwYlq0zwUEFa3HZ0Uom2Zpl2IQSy+RH5R2s3n3NV4DmgQAzpvww2QH5
         SYdwVZcnlYT/lr4/AsFBcRH0rK5m4MZ1EU1Ow5CBbupYKBlm7BFmc+YZDPMb+kxMnW2R
         glKLZ6iF+bqtYo7sQFXkxUCNoWd5NLg6cmY8BrFNjcuqd77DyRdD8mqyaiejDrL5gpve
         ATuun9ZoH8IzisjNfMN8hh6TidJA1RAawQQ8PK0iWRcj+QJ9GPIbKTT3Dnlxh25FhLdp
         vDRg==
X-Gm-Message-State: AGRZ1gJr01e7ZxD3wRf8dlTjSUDvcYZ6gApXQu9UJOk5hVbMZYGZkmjL
        6+EfceEFih8X5i4Gowx786XY+DrH4r50QSCU9q4w/Q==
X-Google-Smtp-Source: AJdET5cNB23D9aqhR174nnIgHlfFgGhChxDgxYStWNjX2m4QxyNxSZrq8m0M6C0Mjg/f71Wv56RiXolOBKVcjOpUJC0=
X-Received: by 2002:a81:8d7:: with SMTP id 206-v6mr1673566ywi.425.1541706192091;
 Thu, 08 Nov 2018 11:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20181102114119.23859-1-anders.roxell@linaro.org> <20181107193643.GB95239@fedora.eng.vmware.com>
In-Reply-To: <20181107193643.GB95239@fedora.eng.vmware.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 8 Nov 2018 20:43:00 +0100
Message-ID: <CADYN=9K8kfqMk3NL8BSecG=sAPOh26QffikMszV0H0ejSZrQkg@mail.gmail.com>
Subject: Re: [PATCH] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     dvhart@infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 at 20:36, Darren Hart <dvhart@infradead.org> wrote:
>
> On Fri, Nov 02, 2018 at 12:41:19PM +0100, Anders Roxell wrote:
> > In today's merge_config.sh the order of the config fragment files dictates
> > the output of a config option. With this approach we will get different
> > .config files depending on the order of the config fragment files.
> > Adding a switch to add precedence for builtin over modules, this will
> > make the .config file the same
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Thanks for the patch Anders!
>
> > ---
> >  scripts/kconfig/merge_config.sh | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> > index da66e7742282..902a60b45614 100755
> > --- a/scripts/kconfig/merge_config.sh
> > +++ b/scripts/kconfig/merge_config.sh
> > @@ -32,6 +32,7 @@ usage() {
> >       echo "  -m    only merge the fragments, do not execute the make command"
> >       echo "  -n    use allnoconfig instead of alldefconfig"
> >       echo "  -r    list redundant entries when merging fragments"
> > +     echo "  -y    make builtin have precedence over modules"
> >       echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
> >       echo
> >       echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
> > @@ -40,6 +41,7 @@ usage() {
> >  RUNMAKE=true
> >  ALLTARGET=alldefconfig
> >  WARNREDUN=false
> > +BUILTIN=false
> >  OUTPUT=.
> >  CONFIG_PREFIX=${CONFIG_-CONFIG_}
> >
> > @@ -64,6 +66,11 @@ while true; do
> >               shift
> >               continue
> >               ;;
> > +     "-y")
> > +             BUILTIN=true
> > +             shift
> > +             continue
> > +             ;;
> >       "-O")
> >               if [ -d $2 ];then
> >                       OUTPUT=$(echo $2 | sed 's/\/*$//')
> > @@ -122,7 +129,13 @@ for MERGE_FILE in $MERGE_LIST ; do
> >               grep -q -w $CFG $TMP_FILE || continue
> >               PREV_VAL=$(grep -w $CFG $TMP_FILE)
> >               NEW_VAL=$(grep -w $CFG $MERGE_FILE)
> > -             if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> > +             if test "$BUILTIN" = "true" && echo $PREV_VAL |grep -Eq '^\w+=y' && echo $NEW_VAL |grep -Eq '^\w+=m' ; then
>
> I think we can avoid the rather lengthy/forky "echo | grep" mechanism
> with POSIX substring parameter expansion (should work in bash, dash,
> etc.).
>
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_02
>
> We can also be more consistent with the other tests in the script, consider:
>
>                 if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
>
>
> > +                     echo Value of $CFG is \'y\' and we don\'t want to redefine the fragment $MERGE_FILE:
>
> I think we can drop the above and perhaps update the last line with...
>
> > +                     echo Previous  value: $PREV_VAL
> > +                     echo New value:       $NEW_VAL
> > +                     echo Will use previous value.
>
> echo "-y passed, will not demote y to m"
>
> Or something along those lines.

Thank you for your input, I'll update and send a v2 shortly.

Cheers,
Anders

>
> > +                     echo
> > +             elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> >                       echo Value of $CFG is redefined by fragment $MERGE_FILE:
> >                       echo Previous  value: $PREV_VAL
> >                       echo New value:       $NEW_VAL
> > --
> > 2.11.0
> >
> >
>
> --
> Darren Hart
> VMware Open Source Technology Center
