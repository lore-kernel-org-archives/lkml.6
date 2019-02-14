Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E711BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A02080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550153796;
	bh=yI1kE66VpuYQMMEK8/lcyOGgJ4h+beeo2bebLTahaEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WFpstqT+j/LQs9e+MeMmAmzVglxXuZLZCTkKyKCZBhPOeOYRmk2FD9r3oI9q3RAcK
	 hyOy9VNZT+eqMZeYD7t9+kJZdGHpelPts1SfMn4VPcb8QPsFAZ1O679FHYp+9d0thX
	 b05sFBwuVn6u55wTqvBBjIiQaj56XQ0Qjbusf3DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbfBNOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBNOQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:16:34 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570C0222D9;
        Thu, 14 Feb 2019 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550153793;
        bh=yI1kE66VpuYQMMEK8/lcyOGgJ4h+beeo2bebLTahaEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lWdUKpZ5b32vafVlM2ACyug91RHOEP61NQg/CmmJehD7ucGn9dPpQ+ElQXxTge8zj
         VzhEuVph7qY/Nbg+l2FsgLW2X4b+u4UVh0+7yRTOUCyWGdXiQ1GyKvqi6LPeU9MQOR
         Y4Mme7lN81ndam5Ak0ELEg8y2m1o+hJEC3Q9fDbQ=
Received: by mail-qt1-f180.google.com with SMTP id w4so7011328qtc.1;
        Thu, 14 Feb 2019 06:16:33 -0800 (PST)
X-Gm-Message-State: AHQUAubiEaSWAPm1ZuN1lHvEMJCWCNWfuPV5DDOXw3jMnRv5ZP1bmo4L
        TaCR5NALoF2fgV2rcXN3UR68pPOyrvEGjvjuVg==
X-Google-Smtp-Source: AHgI3IaY3wfg3Md+1Jr5MIMyVnKv0PcB1DKLA6qjTpequls8S4t1vV/LZF3iBSgJba/tP3oJC5hJw3YQ+h7efOS21HI=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr3043949qve.246.1550153792504;
 Thu, 14 Feb 2019 06:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20190204231554.87666-1-ray.jui@broadcom.com> <20190204231554.87666-4-ray.jui@broadcom.com>
 <20190213211651.GA10705@bogus> <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
In-Reply-To: <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Feb 2019 08:16:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Message-ID: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Hi Rob,
>
> On 2/13/2019 1:16 PM, Rob Herring wrote:
> > On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
> >> In prep for the introduction of polling mode into the driver, update the
> >> binding document to make the 'interrupts' property optional
> >>
> >> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >> ---
> >>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> index 81f982ccca31..d3a3620b1f06 100644
> >> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> @@ -9,9 +9,6 @@ Required properties:
> >>      Define the base and range of the I/O address space that contain the iProc
> >>      I2C controller registers
> >>
> >> -- interrupts:
> >> -    Should contain the I2C interrupt
> >> -
> >>  - clock-frequency:
> >>      This is the I2C bus clock. Need to be either 100000 or 400000
> >>
> >> @@ -21,6 +18,13 @@ Required properties:
> >>  - #size-cells:
> >>      Always 0
> >>
> >> +Optional properties:
> >> +
> >> +- interrupts:
> >> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
> >> +    polling mode
> >
> > What determines when you want to use polling mode? I'm not sure DT
> > is the best way to control this unless it's really a property of
> > the h/w. Driver behavior is really outside the scope of the DT. u-boot
> > would use polling even if an interrupt is specified, for example.
> >
> It's tied to the particular revision of the I2C controller, i.e., the
> iProc NIC i2c controller does not have interrupt line wired. In this
> case, the behavior is determined by the DT compatible string of the
> iProc I2C device. I thought that it makes sense to now move the
> 'interrupts' property to be under "Optional" than "Required" which is
> basically what this change is.

Okay, please put this detail into the commit msg.

Rob
