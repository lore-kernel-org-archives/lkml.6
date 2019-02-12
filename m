Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1138217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tfNWCIZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfBLN2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:28:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34981 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfBLN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:28:23 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so7509467itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WwjiN94X9bwpkY7kutX47Uu9gGqDE64QOmuMYCdWGRY=;
        b=tfNWCIZ8epkQ92/BaCVEZe5To210fqoMbomiWS5TRz7yWgR/uRopMmRNvpPYVVLvzw
         qhZeKqevSLS0Ghre852ii+lrQsMW5wbO7pc6lCxvxm3FGPN9JXK4XADgeLwPv1l+TaIs
         1+8pduoybdIxjdn4ZtRqzba9VOGF9AkxnJLhfO418b4quxExurKvoj5Wt0yml2pXGlTC
         LbAg3j3QFzyGj1b5ljPROgPSK8BZDNskR2eZalvCHzarRJD6JGYb+HGARr4a7lfWR8RR
         6DOpnZXv+diNHb6l72CRxAcsq1FBjiVjdmZauPmJgqsBe5mWZAkrIRS2QQK07p7thDwI
         rnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WwjiN94X9bwpkY7kutX47Uu9gGqDE64QOmuMYCdWGRY=;
        b=rik59/g5dCAV8QsTIVl7JxlVKSTCh5jk+xpXhLkPegxvyTsiKdBlA6rC4qfcrG8EFo
         DSbYXU6LNgE1TE6w49MiacvUU5RH3BbnzNYBygdzBE7H6reaCVig5SRLYrKAz4LazzfT
         G4eQQm27FMRd9pe9hrN+5TP7LI3HCFisiI4FIunryF9E1jojAkYnbW4PxLmgIAiVkt1U
         GLNkF9URpqjZpjQnx4xRSCrJUeYxCXB/+IaC1zrAQJ083lr6NiQE+QMG5TgYdD66Yq6d
         MX2L2Z+7t3X/czouakau/mkJRgEJbTY4wtdZVYcuZQlyC2MqVnrq3KA4UOFM7azRAYBK
         Gp/A==
X-Gm-Message-State: AHQUAuakxE8i43qsT9ZJiYTl0ddI52khiC82atKr5IFzpTy/q5iLXb36
        29J73aB1QbkoptYsSVTaRoOZfO/03ufwYOhQZVnHOg==
X-Google-Smtp-Source: AHgI3IY8HCiFLV1GnBHxikJdzIInGW15f9KH2taCkcdhNbMolqflgZk/wNVGMhR8TDa5NwMTze6bAHHo2EOL1zxJpdU=
X-Received: by 2002:a5e:de05:: with SMTP id e5mr2234251iok.111.1549978101774;
 Tue, 12 Feb 2019 05:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-3-brgl@bgdev.pl>
 <20190212115420.GA24296@amd>
In-Reply-To: <20190212115420.GA24296@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 14:28:10 +0100
Message-ID: <CAMRc=MdCXfPh6g4u-v4GkQJxNDA+v1dqRChcEHdauczrVywkDg@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 12:54 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..f3e00d41e299
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> > @@ -0,0 +1,27 @@
> > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +This module is part of the MAX77650 MFD device. For more details
> > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > +
> > +The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:                Must be "maxim,max77650-charger"
> > +
> > +Optional properties:
> > +--------------------
> > +- maxim,vchgin-min:  Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
> > +- maxim,ichgin-lim:  CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> We already have richtek,min-input-voltage-regulation and
> ti,minimum-sys-voltage and ti,in-dpm-voltage.
>
> This is not too consistent with with the rest.. and perhaps common
> name should be used for those?
>
> See also ti,current-limit. That seems to be direct match.
>

Well I can't really use a TI-specific property name on a maxim part, can I?

Bart

PS This version was superseded by v4.
