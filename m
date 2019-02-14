Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24052229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550152941;
	bh=hX9pWkxgVzMfutIVf1friNZvd9QbP9PurqC/eXn/pTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K4jhW+Flsdmi541ZXFrqv6ulOqMedDBZanDin0V/IyXAu5o4vLieSxR7RL0QmCIXZ
	 SoYfHzv8+7pai9B4Fk7BJuQqJJqd69yjgK70juVK+E3qMpE5EiLnOv1A1XsuOsiadR
	 7FjEvLvjkAnw0y4rNBxTc8V5Gd+XIGEG6jvTdj/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439148AbfBNOCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389393AbfBNOCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:02:19 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69082222D7;
        Thu, 14 Feb 2019 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550152938;
        bh=hX9pWkxgVzMfutIVf1friNZvd9QbP9PurqC/eXn/pTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pV7SIqXwcq7UBg7gwWpdmTFkPN7h8GVcZ7gEVgLg3MrhQ9kQNRPQug6L7kjAeWfiO
         liFchfzwF9NFGkkW7nGkQ7MyPCg99vO+zpLD2Gh4LYwKD2ZCMKbHeP6h9rguuFeqdC
         kEzIPgALWyXpHLUH8gzC9QgPU3mYRsKtGvSVFC/0=
Received: by mail-qt1-f175.google.com with SMTP id y20so6841885qtm.13;
        Thu, 14 Feb 2019 06:02:18 -0800 (PST)
X-Gm-Message-State: AHQUAuaLrgMMTcCMwFm2wCoDGhQKw+t3MqEvhdEUdq6sJpwNTkQWEsxL
        SzFGgLhtBm+Oq4SHsx07g8FFGv6PIpim/lVoJA==
X-Google-Smtp-Source: AHgI3IYx+ALS17jgxLkv693q9nJ0Uc8AvrIdj0TNhfDOfUSAO+Ybt4k4QiVhipWDHP+klWPCEOCV+S1UtbL3GIiT12Q=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr3106313qta.76.1550152937642;
 Thu, 14 Feb 2019 06:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20190204231554.87666-1-ray.jui@broadcom.com> <20190204231554.87666-7-ray.jui@broadcom.com>
 <20190213211807.GA20560@bogus> <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
In-Reply-To: <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Feb 2019 08:02:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Message-ID: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
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

On Wed, Feb 13, 2019 at 4:09 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 2/13/2019 1:18 PM, Rob Herring wrote:
> > On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
> >> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >>
> >> Update iProc I2C binding document to add new compatible string
> >> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> >> also added that allows configuration of the host view into the APE's
> >> address for "brcm,iproc-nic-i2c"
> >>
> >> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >> ---
> >>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> index d3a3620b1f06..02e82d20239e 100644
> >> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
> >>  Required properties:
> >>
> >>  - compatible:
> >> -    Must be "brcm,iproc-i2c"
> >> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
> >>
> >>  - reg:
> >>      Define the base and range of the I/O address space that contain the iProc
> >> @@ -24,6 +24,9 @@ Optional properties:
> >>      Should contain the I2C interrupt. If unspecified, driver will fall back to
> >>      polling mode
> >>
> >> +- brcm,ape-hsls-addr-mask:
> >> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
> >> +    'APE' co-processor
> >
> > What's the data type and size? What are valid values?
>
> It's an unsigned u32 mask value. An example of a valid value is for
> example 0x03400000. Do you want any of these added to the paragraph above?

Yes. Bindings should define constraints.

Rob
