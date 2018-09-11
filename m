Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F6720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG0EBeKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F6720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIKSXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKSXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:23:13 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7969C20839;
        Tue, 11 Sep 2018 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536672234;
        bh=ZSfdyOpKrLF+6zkO6DA2QBDK+CEVBlS0FBvLMjZoyiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IG0EBeKz/S9z0LB17EkMv0rcxlQhyH4mOW1og7gmc1h3e/zQv2/LD96O1keEXbH8D
         rnN0llAgZ7rYWkVGr/yhlnMoIO+JHk6hYK3NkHCIvdVHSG7lEXBIe1omDS0sR3Sznl
         cROWjVyGExmWMcOInyWRBoArspijaKmwmodqvHP0=
Received: by mail-qk1-f176.google.com with SMTP id 93-v6so16687905qks.3;
        Tue, 11 Sep 2018 06:23:54 -0700 (PDT)
X-Gm-Message-State: APzg51CUAkeiQJMBitYra18L7QgML7Rw/EDdNAUB6IESiqh2S4fMSIfs
        S+PIjee6UxiusWJfFp6hX0j+UR/9XkpEFkfZKQ==
X-Google-Smtp-Source: ANB0VdYUivK6+WK6ppC1+LcoAk82m8RN9LEfgBTKbFnNDTKepEFeprs5uK7/J7X0bXO0YKCN7SJDCCzLxEGFYqyeUPQ=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr18381819qkw.184.1536672233664;
 Tue, 11 Sep 2018 06:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180910120243.163979-1-lkundrak@v3.sk> <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
 <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
In-Reply-To: <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Sep 2018 08:23:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmfuc7V2J0pzonj+uKfgpvc_DwnpGYQJ1iJ5SpGSpo9A@mail.gmail.com>
Message-ID: <CAL_JsqKmfuc7V2J0pzonj+uKfgpvc_DwnpGYQJ1iJ5SpGSpo9A@mail.gmail.com>
Subject: Re: [PATCH] DT: marvell,mmp2: add MMC controllers
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 7:55 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Mon, 2018-09-10 at 10:14 -0500, Rob Herring wrote:
> > On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk>
> > wrote:
> > >
> > > There's apparently four of them on a MMP2.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  arch/arm/boot/dts/mmp2.dtsi | 40
> > > +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/mmp2.dtsi
> > > b/arch/arm/boot/dts/mmp2.dtsi
> > > index 766bbb8495b6..51d4a2d70db9 100644
> > > --- a/arch/arm/boot/dts/mmp2.dtsi
> > > +++ b/arch/arm/boot/dts/mmp2.dtsi
> > > @@ -18,6 +18,10 @@
> > >                 serial3 = &uart4;
> > >                 i2c0 = &twsi1;
> > >                 i2c1 = &twsi2;
> > > +               sdhci0 = &mmc1;
> > > +               sdhci1 = &mmc2;
> > > +               sdhci2 = &mmc3;
> > > +               sdhci3 = &mmc4;
> >
> > Please drop this. MMC nodes don't need an alias and if they did,
> > "sdhci" wouldn't be the name.
>
> Will do. I essentially just cargo-culted this, because I had no idea
> which devices need aliases. How do I decide whether an alias is needed?

Add them when you find that you actually need them.

Serial to get stable tty names. It used to be for the console too, but
stdout-path property should be used instead.
ethernet for u-boot to determine which interface to net boot from (IIRC).
i2c and spi are also for stable /dev names, but that should be handled
another way IMO. You can find discussions about it in the archives.

Anything else is probably questionable.

Rob
