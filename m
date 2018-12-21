Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1431C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DD1218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0ILiDIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbeLUKNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:13:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35075 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbeLUKNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:13:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so3526103lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQamXTi8TKe69PR+OLukRfp4Ug/WtFDmzXseVj8IQ/U=;
        b=g0ILiDIvj6BNBwfbU+3eSix+MwnTmuYguxHyVFbwu82lLlupKvdsw26I9t9lnEqOTD
         uagMIvZVlHEToSEuDhWwGypijntUOCpWsqCJaABImR/u/kc0A8dQk9KDbk6NsD15KYB2
         TiX0rBmthcv0yyhnlXaYibRwtUB0oBjL3E8Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQamXTi8TKe69PR+OLukRfp4Ug/WtFDmzXseVj8IQ/U=;
        b=RxdXseM3b673XL7uEi5MklQSmi+9eXqVm4qZS2PnTVPvIEgEt+uQzVoXJ7uZ1SWyyH
         Ot4BebkpXzxJNfGlOd5X47DUV0F4VROmxWywU1Ll0vyQS0y2dpaO/ZjB3BvdTY4oHDOn
         eSiF7/jlQ0CZt0YpiP2J8rSjGvDt0icQPo31MYZtGwpzymdjHPiMyw7d9iAstMmkGd9r
         qbi3GW60Fj0A5xIS2gQ8fjTDQcC9KNylxoGJsigsfOtcPofhYJ/urQQrOHjkNlWL3JvS
         zecA8RRP03t8AB17kWXFr87XOiNYrm+eDPlafXEfVTDzkOvZRcDkRyaT9HvlwSbiVjry
         kCKQ==
X-Gm-Message-State: AA+aEWaBdLi7CRuco3C7NIABuJjyy5ITXKopZYeoB1GqRW+UZTinnfPz
        3HnW3yUYno/lKvCm6iwwHtB8zRoXFM5V6Fn+ajMjHg==
X-Google-Smtp-Source: AFSGD/WhtxTsrQiAdAULtVP4Sgshz/Rq6ng9QRx0DWfpEuZXzzoUioYlwXoKXjbHI0jDj0KTpkrYU8xu0JFoP0KTALs=
X-Received: by 2002:a19:c801:: with SMTP id y1mr994764lff.53.1545387185727;
 Fri, 21 Dec 2018 02:13:05 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com> <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com> <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181130210814.GA5756@amd> <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
 <fa5add90-e1b7-d527-374f-175abdf88455@gmail.com> <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:12:53 +0100
Message-ID: <CACRpkdakp666YykdTqt=CGiqzkz-jBLbh=sSDuS7_M8Rw_8Y3w@mail.gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color properties
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 6:27 PM Rob Herring <robh@kernel.org> wrote:
> On Sat, Dec 1, 2018 at 3:17 PM Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:

> > This is not true in case of associations where LED controller is
> > an independent device, as in Pavel's example [0].
>
> I'm not really following how the HDD example is different. The parent
> of an LED would be the controller. The link to the led node would be
> in the disk controller node. Though maybe if things get complicated
> enough, we'd want to describe the drives or drive bays in DT.

Not talking about this in specific, but I will need to add DT bindings
for ATA master/slave, in order to add a temperature zone
for each drive (one sensor in each drive) in my in-progress
hwmon-over-SCSI-emulation-ATA-sensors such that:

ata-controller {
      ata-master {
      };
      ata-slave {
      };
};

I haven't looked closer at this topology yet, but we definatelt
need nodes for each physical connector out of an ATA
master, somehow, so they can act as a sensor/temperature
zone.

Yours,
Linus Walleij
