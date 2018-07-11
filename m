Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB71C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED23A20C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDgYN53Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED23A20C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbeGKSla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:41:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46273 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbeGKSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:41:28 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so9368976ioj.13;
        Wed, 11 Jul 2018 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pyfjpdoEyWs5DQhe5HkXNn79TyAvb0ZQZN59u01Yzo=;
        b=RDgYN53ZqEVoqyT5zEDyG5RYvoPKJS1XglmlKyUmeMfeAnnWwQBaacqt5nt66CPqFC
         zeGMo7Y6eXBMvblUmpGIYUZhJaSzOLAzyYFaoeLwGaT/lTszXp2JPkr/EYNh8ZJv+xbo
         Yqls38jtETB8y2gkfAsUsOQrVo0ZYjxPE0yb/q1SKNaBc8voP7yYDwhV5NS2FFLQyUcN
         PjTeVdObWwaz+jHn6ogHCwB0IduzCPppTg7eHBIQ3MBkgvU1/nhzYzy50RLSF4Wq4Yhi
         eGy0zK6IMuwCpj5vIXNjP+mYOgjTM8Onl+KKRyXJNg2zI/ONHWIHYoH+VEJqCICwKj0m
         0pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pyfjpdoEyWs5DQhe5HkXNn79TyAvb0ZQZN59u01Yzo=;
        b=r+oW9x3VBnTGT6M39Yp976bDmXi5/Mzm3TUqx7w/ybxge7bwi+odMjX++ocTKVSEug
         N+ZEXUPpqEJpm9assZg7BeZzIZNk75hKwXdHfIeHgeeagPlZpJ7km3mW6LYIntaB8Kgg
         S0rla8/P3+MlsjOb6n+d2LWYTwJ9uTJR3V7eUC/HJ2Mf/odz87/Szobzbrs9nU/VCmay
         fRhYde12K9EHsS5VLDV8O+Dvh/2FMqTaJCp+SnHwIMR0ywgVHsOJRQNsa29socKXJl0k
         yisM7fiKq2hDgI90DtnsJfH701QFjdj0YNfLt193JWIXQq0+YdH/UKkH/3jr0W+5Dbsn
         Vl9w==
X-Gm-Message-State: AOUpUlG+e98vzqGHemFUPnd3bDZIC4mwujclLGHKwcMSvVI2u+kXxqSZ
        /gxbKk2SSL8eCKXV13ffTBwjwDIXs8zA1YEOecE=
X-Google-Smtp-Source: AAOMgpeE/asR0WjTm50QR6tG11NfSBpK00ZNr1oCIdPnBsOMd3zQVfNadWHRVpkBhXmoVvzorelQ+e+zgs0hKnvZoLk=
X-Received: by 2002:a6b:5112:: with SMTP id f18-v6mr5382131iob.107.1531334153382;
 Wed, 11 Jul 2018 11:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180711050704.11492-1-andrew.smirnov@gmail.com> <20180711145713.GB14155@lunn.ch>
In-Reply-To: <20180711145713.GB14155@lunn.ch>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 11 Jul 2018 11:35:41 -0700
Message-ID: <CAHQ1cqF_=S1hHkLdenuByi0e=71DdkjPWcHBrm-rSMYpE_k3ZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:57 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 10, 2018 at 10:07:04PM -0700, Andrey Smirnov wrote:
> > +             switch@0 {
> > +                     compatible = "marvell,mv88e6085";
> > +                     reg = <0>;
> > +                     dsa,member = <0 0>;
> > +                     eeprom-length = <512>;
> > +                     interrupt-parent = <&gpio4>;
> > +                     interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-controller;
> > +                     #interrupt-cells = <2>;
>
> Hi Andrey
>
> I don't see a pinmux for this GPIO. Is one needed?

I got lucky and this pin is configured in GPIO mode out of reset. But
strictly speaking, yeah, I think there should be a pinmux entry for
this. Since things are working as is, I'll send a separate patch
adding that instead of re-spinning this one.

Thanks
Andrey Smirnov
