Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8D218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546618224;
	bh=nTaQpQiBruavmbR2hIkJLXAjgq+PPgj4FZEDF94KIlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gWkge2IUMvdSOJ7cKqPMERg0xL4eWZpxd2zrykPHn72XY4LaCOEDNCJfyHvhxo2sQ
	 7XXeMlTvbpUWo5uWsIIOImS3nqEkTjxp6ayQV20fbz6vNiuX1KVj1nX6PS6fRGF5lc
	 qAtwudrnn+LdHO1+gPRbqZLKVAMkpy4cQj9UN+q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfADQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:10:22 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C808B218DE;
        Fri,  4 Jan 2019 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546618221;
        bh=nTaQpQiBruavmbR2hIkJLXAjgq+PPgj4FZEDF94KIlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0tv2VeBhlHZB/BbkHehKV0Y7n42458FeIXLdR6tX+jzAn4S3FBCCjXqqUGai95NnV
         sILVNdHRdUa1jwzJ2cn9YxOZiuS2Eriyyv4Cnhh6qLsNwGkRd3oz/DiQCnpZNf+SgX
         CIx89nWQVJuKLqy7vgMxr079AT+qkiOk3l7wmq4k=
Received: by mail-qt1-f178.google.com with SMTP id n32so40775464qte.11;
        Fri, 04 Jan 2019 08:10:21 -0800 (PST)
X-Gm-Message-State: AJcUukeM020lUNeBy+BOAV4IazhOQ3q8k3t63+O0JnRerSeNuqiHb5CA
        gNkAqSwcTbJasd4HrIUPFmDHwxBsg5ykneFSCA==
X-Google-Smtp-Source: ALg8bN7FQZhVmdiK/UO10+dik3k6PM7Pw9UzxPOGWYBkjuzr/JOTDnai0t523prqpoz9264Q4x8sKdQAd/wfYWSCGiQ=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr50455640qve.246.1546618220971;
 Fri, 04 Jan 2019 08:10:20 -0800 (PST)
MIME-Version: 1.0
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com> <20190103221414.GA14639@bogus>
 <1546570807.585.31.camel@mhfsdcap03>
In-Reply-To: <1546570807.585.31.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Jan 2019 10:10:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
Message-ID: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek musb controller
To:     Min Guo <min.guo@mediatek.com>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:00 PM Min Guo <min.guo@mediatek.com> wrote:
>
> On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> > On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > > From: Min Guo <min.guo@mediatek.com>
> > >
> > > This adds support for MediaTek musb controller in
> > > host, peripheral and otg mode

[...]

> > > + - interrupts      : interrupt used by musb controller
> > > + - interrupt-names : must be "mc"
> >
> > -names is pointless when there is only one.
> The MUSB core driver has two interrupts, one is for MAC, another for DMA,
> but on MTK platform, there is only a MAC interrupt, here following the binding
> of MUSB core driver.

You should probably be listing the same interrupt number twice if 2
interrupts are combined.

> > > +Optional properties:
> > > + - extcon : external connector for VBUS and IDPIN changes detection,
> > > +   needed when supports dual-role mode.
> >
> > Don't use extcon for new bindings. The usb-connector binding should be
> > used instead.
> This is used to detect the changes of the IDPIN and VBUS, the change
> events are provided by other drivers, such as extcon-usb-gpio.c, and
> then switch MUSB controller to host or device mode, but the
> usb-connector can't detect these changes.

To repeat, do not use extcon binding for new bindings. It is poorly
designed as it reflects extcon driver needs, not a description of the
hardware. If you have ID on GPIO, then that belongs in a usb-connector
node because that GPIO goes to the connector. For Vbus, you should
have a vbus-supply in the connector and use a gpio-regulator if it is
GPIO controlled.

> > > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > > +   dual-role mode.
> >
> > The controller is powered from Vbus? Probably not. This belongs in the
> > connector or maybe the phy (if the phy is powered from Vbus).
> The Vbus is used to provide 5V voltage to the connected device when the
> controller works as host mode.

I know what Vbus is. Unless Vbus is providing power to the host
controller, putting the Vbus supply in the controller node is not a
accurate representation of the hardware.

Rob
