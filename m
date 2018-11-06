Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F39206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BChQs9or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F39206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeKFXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:23:15 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32837 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388509AbeKFXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:23:15 -0500
Received: by mail-yb1-f196.google.com with SMTP id i78-v6so5338735ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebaVB+y5abTK19HvX2rCNWE4KN4fe1zXURPiibjaJ9E=;
        b=BChQs9orPyx2PeUq1U0FMk5aka/tQaGiBzhN2Br/cBfE96BIqZC8xr2bnb9Xkbjfd+
         3Yihpyz+5twx9G5J9yy10VzJH0fWc3DsJbJV+QvO/ftUrkAPGjIi0CLEBIkxDJnvNOey
         ACzm5TxIAJzU3kmnrS+JjFumAqK30SP6FhZRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebaVB+y5abTK19HvX2rCNWE4KN4fe1zXURPiibjaJ9E=;
        b=S2/Fa5EZJZM8wI+8DgaM/KDixGL8XfGQeoPkxn3n+Xxkutg10/m6VhaLfSPoH55GTi
         YNGSFb0RflrrPpGh6MRJQR/DJFQ5SsxVubfqjWtrzWATuLimemAPc/sSa/r8OgGx/BwL
         3IgQ4OiGWNh+E/hsKcg/wzFHOpBs0SIQFd6g7lfdHXCpwgLEo7r8NDMXAuIqQJ+95ED3
         iIDQ0cyl6LPidbftEMqWp0Nj1jTvGbqMUeXF8sgw9xMLYtQq4uLhL3yFHNFXZ4JgrAJZ
         1XnZQvDTYdKwIqfKC+XFqemGdW8iKmEv6/QhvwkfdMW0/MVXCVoz12ZalqrPK479/Yjb
         Rd0A==
X-Gm-Message-State: AGRZ1gLtdaGYzmFohy53qrRFV4aTJS4hEjDT9o9XM6cWC3rW+/R+67B5
        0UcAM4k1R/UfPk1qtlO2gDory5ZgvGtks69Llc2AzQ==
X-Google-Smtp-Source: AJdET5ct/ZpbHY5kVwDjg2WiEngrBry5hr2VILNbU5yXgUkYbjywzQr2KtDfvjeaUnnm1zSfhD6dbB9JdVVt2y/KBeo=
X-Received: by 2002:a25:6046:: with SMTP id u67-v6mr24733225ybb.198.1541512672241;
 Tue, 06 Nov 2018 05:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20181102114119.23859-1-anders.roxell@linaro.org> <CAK7LNARda14b9_8Yh7vC2PFa_w=yw+qD0YTriAVQ_Aw5PoXkNw@mail.gmail.com>
In-Reply-To: <CAK7LNARda14b9_8Yh7vC2PFa_w=yw+qD0YTriAVQ_Aw5PoXkNw@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 6 Nov 2018 14:57:40 +0100
Message-ID: <CADYN=9L2kEVJMiVRBUBU7z4B4_YrvkNefCE5FO3qjACgm=FugA@mail.gmail.com>
Subject: Re: [PATCH] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvhart@infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 at 09:35, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Anders,
>
> On Fri, Nov 2, 2018 at 8:41 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > In today's merge_config.sh the order of the config fragment files dictates
> > the output of a config option. With this approach we will get different
> > .config files depending on the order of the config fragment files.
> > Adding a switch to add precedence for builtin over modules, this will
> > make the .config file the same
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
>
> I think this patch makes sense.
>
> Just in case, could you please provide me the context of the discussion?

For instance we don't want to force X86 from DRM=y to DRM=m, when
enabling selftest, that would surely break somebody's setup and you also
don't want to force ARM64 from DRM=m to DRM=y, that seems
unnecessary for a big subsystem like DRM.

>
> Does the real problem exist in the kernel tree,

Not that I'm aware about.

Cheers,
Anders

> or for local fragment files?
>
>
> Thanks.
>
>
>
> >  scripts/kconfig/merge_config.sh | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> > index da66e7742282..902a60b45614 100755
> > --- a/scripts/kconfig/merge_config.sh
> > +++ b/scripts/kconfig/merge_config.sh
> > @@ -32,6 +32,7 @@ usage() {
> >         echo "  -m    only merge the fragments, do not execute the make command"
> >         echo "  -n    use allnoconfig instead of alldefconfig"
> >         echo "  -r    list redundant entries when merging fragments"
> > +       echo "  -y    make builtin have precedence over modules"
> >         echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
> >         echo
> >         echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
> > @@ -40,6 +41,7 @@ usage() {
> >  RUNMAKE=true
> >  ALLTARGET=alldefconfig
> >  WARNREDUN=false
> > +BUILTIN=false
> >  OUTPUT=.
> >  CONFIG_PREFIX=${CONFIG_-CONFIG_}
> >
> > @@ -64,6 +66,11 @@ while true; do
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
> > @@ -122,7 +129,13 @@ for MERGE_FILE in $MERGE_LIST ; do
> >                 grep -q -w $CFG $TMP_FILE || continue
> >                 PREV_VAL=$(grep -w $CFG $TMP_FILE)
> >                 NEW_VAL=$(grep -w $CFG $MERGE_FILE)
> > -               if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> > +               if test "$BUILTIN" = "true" && echo $PREV_VAL |grep -Eq '^\w+=y' && echo $NEW_VAL |grep -Eq '^\w+=m' ; then
> > +                       echo Value of $CFG is \'y\' and we don\'t want to redefine the fragment $MERGE_FILE:
> > +                       echo Previous  value: $PREV_VAL
> > +                       echo New value:       $NEW_VAL
> > +                       echo Will use previous value.
> > +                       echo
> > +               elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
> >                         echo Value of $CFG is redefined by fragment $MERGE_FILE:
> >                         echo Previous  value: $PREV_VAL
> >                         echo New value:       $NEW_VAL
> > --
> > 2.11.0
> >
>
>
> --
> Best Regards
> Masahiro Yamada
