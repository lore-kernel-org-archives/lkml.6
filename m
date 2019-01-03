Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3268C21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iR8MQG7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfACBAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:00:51 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57376 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfACBAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:00:50 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x0310dmi018991
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 10:00:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x0310dmi018991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546477240;
        bh=X2sWuKEkNZ7gLbWG5LbdTXRuaic0LVSffH4BwabE+/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iR8MQG7YxPnsW8Kpok8Ksu10iP0s0X40+waqO1UwQ13TmD6g+W6fbUKiGzfhgEN9R
         UNN77nWmztsKww812iQ+UXycil2pJWFnkOTx8zgYIhbxnHM013uZ4xGWylcroMfGCN
         rJk7iQTpUei05TBNP87uqTL6EH65sllONdlNdQuldhhSjRQeo4h5q5VIafacsDywZC
         x85bvLimLLJqMLrd6+0mktcfxw970vRbdLxdKc/zAH9OI7oRtXTXV2F6MCMbu7O/lx
         n6PF8U8KDztoe1g7idhlAXeq3vEWpNeVQDi76ZSgXItjpLo57YOWoV2pgpzaEDq1vm
         kQM1dndA9OvXg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y27so19954666vsi.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 17:00:40 -0800 (PST)
X-Gm-Message-State: AA+aEWbi9pw92JkMo1H+wU942N6btiY4AMl3Jt7VmxJYDgPLc6VGJO9Q
        OyrKDEZcJm/8VzFsfBa1y8EWfQkDj9fBYcRAguU=
X-Google-Smtp-Source: AFSGD/UjyPMlg9f0e2ZcvBMDjk0BvFh+6xV6rLXAaM2Qy1h9eCnbSNr++FsHxoMS82SPAZw3UwusZFoD8gxth5y4z8c=
X-Received: by 2002:a67:a858:: with SMTP id r85mr18057872vse.215.1546477239055;
 Wed, 02 Jan 2019 17:00:39 -0800 (PST)
MIME-Version: 1.0
References: <1544976205-18762-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNATsp7Jez3eZxM8Zv642=YS0N8cWPN4XY9CRbD2dXDK3tg@mail.gmail.com>
In-Reply-To: <CAK7LNATsp7Jez3eZxM8Zv642=YS0N8cWPN4XY9CRbD2dXDK3tg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 10:00:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQN+vDAXv5=n38ozdko=-eB+efq=jsp9_f7VaHUDD0arA@mail.gmail.com>
Message-ID: <CAK7LNAQN+vDAXv5=n38ozdko=-eB+efq=jsp9_f7VaHUDD0arA@mail.gmail.com>
Subject: Re: [PATCH] csky: remove meaningless header-y
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:36 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Dec 17, 2018 at 1:07 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Since commit fcc8487d477a ("uapi: export all headers under uapi
> > directories"), header-y is meaningless because headers under uapi
> > are all exported.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Applied to linux-kbuild.


I take it back.

I found Guo Ren had already applied it.




>
> >  arch/csky/include/uapi/asm/Kbuild | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
> > index e02fd44e..7449fde 100644
> > --- a/arch/csky/include/uapi/asm/Kbuild
> > +++ b/arch/csky/include/uapi/asm/Kbuild
> > @@ -1,7 +1,5 @@
> >  include include/uapi/asm-generic/Kbuild.asm
> >
> > -header-y += cachectl.h
> > -
> >  generic-y += auxvec.h
> >  generic-y += param.h
> >  generic-y += bpf_perf_event.h
> > --
> > 2.7.4
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
