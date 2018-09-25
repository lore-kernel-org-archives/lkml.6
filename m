Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805EAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CD21508
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhrZzyOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371CD21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeIYWbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:31:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33183 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbeIYWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:31:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so8628749pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owewT7VudoFRLY73ChYZfXnybFnLgs14gmnz+V8QJ58=;
        b=DhrZzyOgxsMaFAk0XVbvy1hZYkdQb1Q7wnyOL8M3OQMGmfzsKfrw5qWCPyJSzBcKVk
         mtHXPBjpb0XzIaps7TTsUfqYejeVm6rmF4qAXHX/9L4/hvnfuCy6rHjD1ZGTuaHC+3Rs
         RwmpsW5xLMiEcwZ0yVOHpT5AtGB415YeKmS0+XTNuNoJHD+SWRQTxPn82Q+7Gvnq/fZV
         Zy8pza4vGcG19gd+TZBy/i1Ts9/6uaMseFLbGZ2ChmVYcNaxzcFUnbI0w7YgW71M5mfL
         MZKtn2GPC55pn+a29rd/qu8MeQ2fmA3ga2RvgcRUMjC5Y+ma4IG5LoE96A4rftqlg0/F
         NcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owewT7VudoFRLY73ChYZfXnybFnLgs14gmnz+V8QJ58=;
        b=t1Ch2hkdo0bnx3jdY7cEyoCumdK7drw8MiJnCtLy26swVbV1fesGi2g/Og1EbF1F0v
         +Pt3eUxBOsLLXvM4P2gJZneTsXj6bHblhvvVlrHNvjwTu8AIGJF8CTSgeM4IChXiV1tM
         iXGev9f185coXE6fs947YSkXP6IXcX2Pd82w6IxFGQ8BFoRkqRuq+u2xOMDbC2BRMcvH
         XDzZ3aDT7kdA0oRKr9updr0YonGJrgJaDG9JqijPdDaZeRdpxU9QjbauVLVufk99YSxt
         POQc3S/Wr/JPXmiu9kYOVIzyrcg9IUlpf7+pt0VpC6n9ti5TuXIfUnvi1d3DelhhxQLm
         ourg==
X-Gm-Message-State: ABuFfojcHJYc/4uz8uVYGbgblV8NQ3mS9Ku0HrhTN9TS+YZCKVhhQmZ5
        mHnFiKVA02hE/9rTwe1gF7wTkytCIOBYBllMaxUU2Q==
X-Google-Smtp-Source: ACcGV635GrgkSAMBtiboPb3TSUuaN+tpB4qEmS46FfPGdypchu5h8QDwCvrO66/PrBv8gFPe8r6ONjWGNG2JqVT4Zno=
X-Received: by 2002:a62:1895:: with SMTP id 143-v6mr1859453pfy.227.1537892600436;
 Tue, 25 Sep 2018 09:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com> <20180925161459.GA15840@flashbox>
In-Reply-To: <20180925161459.GA15840@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 09:23:09 -0700
Message-ID: <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 9:15 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:58:16PM +0200, Linus Walleij wrote:
> > On Tue, Sep 25, 2018 at 8:19 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> >
> > > Clang warns when one enumerated type is implicitly converted to another,
> > > which happens several times in the pinctrl drivers for a few reasons:
> > >
> > > * The PCONFDUMP macro, which sets the param member in pin_config_item.
> > > * The pinconf_generic_params structure, which is used by drivers to
> > >   configure their bindings, which has a param member like pin_config_item.
> > > * The pinconf_to_config_packed, which takes either the generic enum
> > >   pin_config_param or a specialized one.
> > >
> > > Drivers are allowed to extend this enumerated type because of the gap
> > > betweem PIN_CONFIG_END and PIN_CONFIG_MAX. Make it clear to Clang that
> > > this is allowed by changing param's type in all of these instances to
> > > int so no conversion needs to happen.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/138
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > I'm not superhappy about this because that enum is great for readability,
> > even if the static syntax checker is unhappy.
> >
> > If we can't have an enum here I would argue that we can just as well
> > remove the enum altogether and just use #define for the config
> > parameters, would you agree?
> >
> > Yours,
> > Linus Walleij
>
> Hi Linus,
>
> I see no reason to get rid of the enums. All this patch should do is
> silence Clang's warnings because there is no other way to tell it that
> this construct is okay except for changing the parameter/member type to
> int (so no conversion needs to happen) or an explicit cast, which will
> result in more noise in my opinion since this warning happens at least
> 10-15 times in the pinctrl drivers. There's no fundamental change to
> how the enums are used.
>
> See these other commits for similar fixes:
>
> 3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to int")
> 04fecbf51b3c ("mm: memcontrol: use int for event/state parameter in several functions")
>
> Cheers!
> Nathan

That or all of the call sites should have explicit casts to the base enum.

-- 
Thanks,
~Nick Desaulniers
