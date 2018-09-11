Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10844C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB232206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB232206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIKRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:54:49 -0400
Received: from shell.v3.sk ([90.176.6.54]:42149 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKRyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:54:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3B85EAFA96;
        Tue, 11 Sep 2018 14:55:33 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U7UTuDDiBQS6; Tue, 11 Sep 2018 14:55:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D1751AFAD7;
        Tue, 11 Sep 2018 14:55:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O7CY8V4ycJEF; Tue, 11 Sep 2018 14:55:29 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id F3BD0AFA96;
        Tue, 11 Sep 2018 14:55:28 +0200 (CEST)
Message-ID: <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
Subject: Re: [PATCH] DT: marvell,mmp2: add MMC controllers
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Tue, 11 Sep 2018 14:55:27 +0200
In-Reply-To: <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
References: <20180910120243.163979-1-lkundrak@v3.sk>
         <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 10:14 -0500, Rob Herring wrote:
> On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > 
> > There's apparently four of them on a MMP2.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  arch/arm/boot/dts/mmp2.dtsi | 40
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mmp2.dtsi
> > b/arch/arm/boot/dts/mmp2.dtsi
> > index 766bbb8495b6..51d4a2d70db9 100644
> > --- a/arch/arm/boot/dts/mmp2.dtsi
> > +++ b/arch/arm/boot/dts/mmp2.dtsi
> > @@ -18,6 +18,10 @@
> >                 serial3 = &uart4;
> >                 i2c0 = &twsi1;
> >                 i2c1 = &twsi2;
> > +               sdhci0 = &mmc1;
> > +               sdhci1 = &mmc2;
> > +               sdhci2 = &mmc3;
> > +               sdhci3 = &mmc4;
> 
> Please drop this. MMC nodes don't need an alias and if they did,
> "sdhci" wouldn't be the name.

Will do. I essentially just cargo-culted this, because I had no idea
which devices need aliases. How do I decide whether an alias is needed?

> 
> Rob

Thank you,
Lubo

