Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E19C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0182E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="smXnAKJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeLEPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbeLEPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:22:38 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9E320989;
        Wed,  5 Dec 2018 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544023357;
        bh=GzznUPgfk5LUI7gjpKiMHDtNRJypjB60JNdOnM0r65o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=smXnAKJ6C78ol9KdicNRWRfvjaBZ93+0poTJac44VMqA0X/rqnK8GyUFe08/rEUiy
         7hb+KoyjqGjm/LGfrFbA4eBhKdw2KwelVZhHqn/KAUKlpnddzd36Pqj47OH8ZBCMCV
         vXEictrQ11//Ocjm5IIkJ0lEXjnlmLNl15VFsGrI=
Received: by mail-qt1-f178.google.com with SMTP id t13so22661782qtn.3;
        Wed, 05 Dec 2018 07:22:37 -0800 (PST)
X-Gm-Message-State: AA+aEWbR84S35R2f/4ypbFWk/T8cw4cNpZnolu9K34bJPCD9K3e6gbiD
        eUex7BPcRhIEVdmdylro83QmrMk1fOIQ8RVp9Q==
X-Google-Smtp-Source: AFSGD/XqTiHR8v07hdgSXcjHuD0Sr4IKpMY5JfCJi2mesvvNkpUttFYRO8sxs2Tzw6ocxWRYMwVeUwuKxLUcC6op2EI=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr24530945qvk.106.1544023356597;
 Wed, 05 Dec 2018 07:22:36 -0800 (PST)
MIME-Version: 1.0
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
 <20181204232237.GA16883@bogus> <2600b55c-f8fd-ab82-6372-a75f22e382f8@microchip.com>
In-Reply-To: <2600b55c-f8fd-ab82-6372-a75f22e382f8@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Dec 2018 09:22:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnw8qL2wJVCFe35bzCazoSv4j6A=o2MPdqXzV7TmvpEg@mail.gmail.com>
Message-ID: <CAL_JsqKnw8qL2wJVCFe35bzCazoSv4j6A=o2MPdqXzV7TmvpEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
To:     Andrei.Stefanescu@microchip.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 5:06 AM <Andrei.Stefanescu@microchip.com> wrote:
>
> Hello Rob,
>
> Thank you for your feedback.
>
> I will add a bit of context regarding the secumod. The
> "atmel,sama5d2-secumod"
> compatible string is not used for loading a driver. It is used by atmel
> securam
> driver (drivers/misc/sram.c) which has access to secumod's registers via:
>
>      syscon_regmap_lookup_by_compatible("atmel,sama5d2-secumod")
>
> So the secumod exports multiple hardware functions, eg: the securam, the
> PIOBU
> pins which can be used as GPIO pins.

Yes, I understand why you want to design it this way, but don't design
your bindings around how 1 OS happens to currently work.

>
> My initial patch had the "microchip,sama5d2-piobu" compatible appended
> to the
> secumod's compatible e.g.:
>
> secumod@fc040000 {
>      compatible = "syscon", "microchip,sama5d2-piobu";

That doesn't look appended to me. The documentation says it should
look like this:

compatible = "atmel,sama5d2-secumod", "syscon";

> ...
>
> Taking into consideration Linus Walleij's advice I arrived to the current
> version. I thought this was a good idea because it separates the secumod
> node
> from the GPIO controller node. Please notice that securam node is already
> separated from secumod node (it is a separate node in the device tree).
>
> I have a few questions because I am not sure of the best approach:
>
> 1. Is it ok to have the GPIO controller as a child node?

Is it a separate h/w block and do you have other child nodes that need
their own resources in DT (interrupts, clocks, etc.)? If these aren't
the case, then no you shouldn't. As it stands, you don't have any
other child nodes, so no you shouldn't have a child node here. Just
add to properties to the existing binding:

secumod@fc040000 {
        compatible = "atmel,sama5d2-secumod", "syscon";
        reg = <0xfc040000 0x100>;
        #gpio-cells = <2>;
        gpio-controller;
};

Now perhaps you have 10 other functions in this block like pinctrl,
clocks, phys, power domains, etc. Then child nodes would be warranted.
But if that's the case, then please write a complete binding for the
secumod block.

> 2. I used simple-mfd because it was the only way I could think of in
> order to
>     get the driver probed.

Sounds like an OS problem that has little to do with the binding. In
any case, if you change a binding which you have, then it needs to be
documented.

> 3. Should I add a register range? I thought that because the driver uses
> syscon
>     it is not necessary to add the register range. Also, the register
> range would
>     have been a subset of the secumod's register range.

If it has one, then yes you should. If it doesn't then it is probably
not a separate h/w block and shouldn't have a child node to begin
with.

Rob
