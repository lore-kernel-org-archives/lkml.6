Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7752133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QLN8H6wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfB0MdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:33:10 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30419 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbfB0MdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:33:09 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1RCWjix013863;
        Wed, 27 Feb 2019 21:32:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1RCWjix013863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551270766;
        bh=uPI57JCwxYuuy6+IDDYCSlExpT6Xshlch+VQcNQKq4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QLN8H6wXl2AkIwHFm8ue0YxukKCg+fbNVUSrg/KDqpLdxoeWPzFvtlQ7wd50gLInE
         +Fhi5BXo9Y5+4O2MCbLt+/fxZPvqhsV4AOsJzYQlD/6ebJhHlVn+kWj6GbAY6bmtyA
         gqW2aT5rxTbfR26E/OQx4o/GRstXPZOomPxaCHNK+xzDwt/OBmBgkxxFo9VidhAF1H
         LnxXN2OfdF9jxOKf/4j1akg9ccWgTB5mAvf1shO60kl2o4JSCeKFdtaHNYVQZuhj5U
         vW9ZGmw0TwVWn5NZDE2CbTcmspmyTSo/hoSP705XUlWdLG45iAjTTINAxgET0WX1Ff
         Axh/lLElNyLMw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id q17so15158699uam.0;
        Wed, 27 Feb 2019 04:32:45 -0800 (PST)
X-Gm-Message-State: APjAAAVMUklO0sFhXB91lpp9nJq3maGKeQPqQg/uSa7ev4pmJvwQwwaY
        bZSrPxQqRcF2gw+c+bKj+rTSF89B1QjS2Ya7jds=
X-Google-Smtp-Source: APXvYqzyiIZmFnvhLyqSp8H4siWFQoecjwAJqpdeZGsVLPGOxh3HN4HVEtjXd9/Z1lTg5rqgywMVPhv91J5mAvyx3mE=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr1874315uam.93.1551270764533;
 Wed, 27 Feb 2019 04:32:44 -0800 (PST)
MIME-Version: 1.0
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
 <1550568787-18710-5-git-send-email-yamada.masahiro@socionext.com> <acfea6b8-0986-3fc2-86a6-2553c9ef11e0@ideasonboard.com>
In-Reply-To: <acfea6b8-0986-3fc2-86a6-2553c9ef11e0@ideasonboard.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 21:32:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtUnSV-OKnrH+xvmWU1scJCCFr-EH-qJ_5djhgwf8BpA@mail.gmail.com>
Message-ID: <CAK7LNATtUnSV-OKnrH+xvmWU1scJCCFr-EH-qJ_5djhgwf8BpA@mail.gmail.com>
Subject: Re: [PATCH 5/5] scripts/gdb: refactor rules for symlink creation
To:     kieran.bingham@ideasonboard.com
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,


On Wed, Feb 27, 2019 at 8:56 PM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Yamada-san,
>
> On 19/02/2019 09:33, Masahiro Yamada wrote:
> > gdb-scripts is not a real object, but (ab)used like a phony target.
> >
> > Rewrite the code in a more Kbuild-ish way. Add symlinks to extra-y
> > and use if_changed.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  scripts/gdb/linux/Makefile | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
> > index 7545806..3df395a 100644
> > --- a/scripts/gdb/linux/Makefile
> > +++ b/scripts/gdb/linux/Makefile
> > @@ -1,13 +1,17 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -always := gdb-scripts
> >
> > -SRCTREE := $(abspath $(srctree))
> > -
> > -$(obj)/gdb-scripts:
> >  ifneq ($(KBUILD_SRC),)
> > -     $(Q)ln -fsn $(SRCTREE)/$(obj)/*.py $(objtree)/$(obj)
> > +
> > +symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
> > +
> > +quiet_cmd_symlink = SYMLINK $@
> > +      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
> > +
> > +extra-y += $(symlinks)
> > +$(addprefix $(obj)/, $(symlinks)): FORCE
> > +     $(call if_changed,symlink)
> > +
> >  endif
> > -     @:
> >
> >  quiet_cmd_gen_constants_py = GEN     $@
> >        cmd_gen_constants_py = \
> > @@ -18,4 +22,4 @@ extra-y += constants.py
> >  $(obj)/constants.py: $(src)/constants.py.in FORCE
> >       $(call if_changed_dep,gen_constants_py)
> >
> > -clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py)
> > +clean-files := *.pyc *.pyo
>
> Perhaps this answers my earlier question.
> I guess the extra-y hook is somehow handling the clean up of these files?
>
> Aha - yes, I've just found it in
>
> Documentation/kbuild/makefiles.txt:
> > === 5 Kbuild clean infrastructure
> > ...
> > Kbuild knows targets listed in $(hostprogs-y), $(hostprogs-m), $(always), $(extra-y) and $(targets). They are all deleted during "make clean".
>
> Perfect, so this is much better.

Exactly.

If you are interested in the real code,
see scripts/Makefile.clean


__clean-files   := $(extra-y) $(extra-m) $(extra-)       \
                   $(always) $(targets) $(clean-files)   \
                   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
                   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
                   $(hostcxxlibs-y) $(hostcxxlibs-m)





> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
> --
> Regards
> --
> Kieran



-- 
Best Regards
Masahiro Yamada
