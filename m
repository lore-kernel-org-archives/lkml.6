Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF29ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2240020877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vNph7Xc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2240020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeIYPhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:37:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44450 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:37:02 -0400
Received: by mail-io1-f68.google.com with SMTP id u12-v6so14859486ioc.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xuzOBy0ebYexCOXoFZ074MpvDoivn3W2BOn8belaMzc=;
        b=vNph7Xc2RGFOf0EQ02dlMg7GycSm9SefVi+anl00J3Xp/9hGXUPiczlvPvlKfNpiPq
         mDJE++GNgaOtnBz9pTteWL2Ylo7gaTK0Ev2kt7DkngYzK0TVBMaYsBdaUHPKrd2/W10u
         vUz2k3LRYc12LDIDtTtgs/jPk51p3JTmkA6RccobcG7d8gJ4bc0HRcQbcWreGGafas6x
         sX91x7fXqJcmdDv7E73BxenMPg3ecYtlslaBJicdFDxuhN/NkdGP57tXVYBpymr8lsP+
         EaLbo32rSCg+IbTnw2eZj/oafcDjsGJmftqDuc2cU0HjMlTVra/9O2za44ZDRabTqYdL
         /l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xuzOBy0ebYexCOXoFZ074MpvDoivn3W2BOn8belaMzc=;
        b=HBWnXnRX+4lgwSUIJdalZxkFuyphUrjQW1ESjBOrmB3dUPX+hiRic2VMluiJNVw8oa
         IO6Nck3gQ1GZqW6egTEp9Xu2ZLABTkLNgo+m2sgdUBjrb03vST5h7rgxFwHgpa1NKNvv
         tUqu1A04WqCF+pS0JNIK1Yw+4XQke8h4PCPsFJCbVJJ/o5h4JaEK6dBRD4EPP49woGrG
         R5er8Ru0DU99yaiYUawv9dE0o87niKiKGjQnngxyf2t/2WAFdwWZAHVw/zFTCc8X5DMf
         HLqkr/KSUH+955IvsaAlFZk3/Dgt1xMgX2/a8SgoGFHoum89f9VYybpzjjSjVrPcHk76
         W5gg==
X-Gm-Message-State: ABuFfoi50gKMZxtGUctQjwKnMqThlo/5YJ/jpQyu7yJQvtUAa17FsWGK
        UenyufrKVzgHtyU8EdUhLuWG42NdsfDzOgZ8YFOEdRaC
X-Google-Smtp-Source: ACcGV62rwXOXrS9a6gFzz+BrNsAzItUOArU0iJwSrjYmuJ2mwJMrV0wmDZFfEXZd5+NAz7/6K590AaDy+B3KR5o0O1s=
X-Received: by 2002:a5e:aa02:: with SMTP id s2-v6mr65985ioe.187.1537867823156;
 Tue, 25 Sep 2018 02:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180923111727.10378-1-brgl@bgdev.pl> <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
 <CACRpkdb7zKfa_e6WWHncg+gxGncsC_Bx7gpkhJyutH4tqJRkew@mail.gmail.com>
 <20180925090321.GX2664@lahna.fi.intel.com> <CACRpkdb1BoD2bNfZx=CQvJjgdAYbqQ9556eGPXUawrm=OfKnYg@mail.gmail.com>
In-Reply-To: <CACRpkdb1BoD2bNfZx=CQvJjgdAYbqQ9556eGPXUawrm=OfKnYg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Sep 2018 11:30:12 +0200
Message-ID: <CAMRc=MeWs1LpO1Nab=0Tw18M5nZ7OkXMbfhanacF7e0Y+BGaUg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: use device properties instead of platform_data
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 25 wrz 2018 o 11:14 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Tue, Sep 25, 2018 at 11:03 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Tue, Sep 25, 2018 at 10:53:30AM +0200, Linus Walleij wrote:
> > > On Mon, Sep 24, 2018 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > > > niedz., 23 wrz 2018 o 13:17 Bartosz Golaszewski <brgl@bgdev.pl> nap=
isa=C5=82(a):
> > > > >
> > > > > Some users want to introduce device tree support to the mockup dr=
iver.
> > > > > Let's make it easier by switching to using generic device propert=
ies.
> > > > > The driver stays compatible with previous use cases and after thi=
s
> > > > > conversion there'll be no need to change the way probing of mocku=
p
> > > > > GPIO chips works.
> > > > >
> > > > > Tested with libgpiod test suite.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > > (...)
> > > > Linus, I just noticed that we either need to drop the check for
> > > > -ENOENT or add an else that returns on any other error. I'll need t=
o
> > > > send a v2
> > >
> > > OK business as usual.
> > >
> > > > but I'll let you first tell me if you like the general idea.
> > >
> > > I don't know, I'm a bit ignorant about the idea, scope and
> > > ambition with device properties.
> > >
> > > In my book this relates to the fwnode concept, but maybe
> > > I'm wrong?
> >
> > I think you are right.
> >
> > > Mika, please fill us in here. The device properties in gpiolib
> > > came in the patch
> > > "gpio: Rework of_gpiochip_set_names() to use device property accessor=
s"
> >
> > I'm not sure what to answer to be honest :) The idea behind that patch
> > was that we would be able to use the same properties (DT properties,
> > ACPI _DSD properties, or possibly built-in properties) to set names for
> > GPIOs.
>
> I guess it's a yes.
>
> If Vincent use this as a basis for this DT (etc) probing it means we
> can use the mockup GPIO driver for ACPI gpiochip prototyping as
> well, which is a win-win.
>
> Yours,
> Linus Walleij

I'll send a v2 later today.

Thanks,
Bartosz
