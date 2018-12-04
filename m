Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD908C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D79D223D8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w29ShF+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D79D223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLDWtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeLDWtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:49:12 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C03A223D0;
        Tue,  4 Dec 2018 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543963751;
        bh=nAJYNF5exn/7MIzDf+gyUHqeEcWC+Frr1x7qmSLYhyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w29ShF+bdXzVUKOyWvM4TIxOwLG8xXP4CAen4rtuCdJcFedVIUULLN7NU5HV/y5zd
         w5mcA2Ayx6Q3IQYPL4sfET8nG0VH4LeorZR5k4hTtjLUPDA3sVYSgMPDdtDByiHE2n
         QNO7K2fx5b81rE2nLaTfiiyR/QaC2i10vmzx8I4E=
Received: by mail-qt1-f175.google.com with SMTP id e5so20110981qtr.12;
        Tue, 04 Dec 2018 14:49:11 -0800 (PST)
X-Gm-Message-State: AA+aEWZlcfCv38i+/vvamxl2sJc9WjBifeUySqkOU4H4mnlHfAiAOMie
        vCSnZmYNnuwl0xOYaj9HDypNfrG7DU0qJT78Qg==
X-Google-Smtp-Source: AFSGD/V5FXSz3M1XMujzv3vfX6JjiuiUVj0szW8v6ILDUDw7ehQqjaWH5Tw2r1t6XJQTmzZ0rlxzOodM3Mh8u9BQL08=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr21366933qve.246.1543963750624;
 Tue, 04 Dec 2018 14:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-16-robh@kernel.org>
 <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
In-Reply-To: <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 16:48:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Subject: Re: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:12 AM <Nicolas.Ferre@microchip.com> wrote:
>
> On 03/12/2018 at 22:32, Rob Herring wrote:
> > Convert Atmel SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>
> I'm listed here...
>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Proper email address here...
>
>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
> >   .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
> >   2 files changed, 133 insertions(+), 72 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
> >   create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > deleted file mode 100644
> > index 4bf1b4da7659..000000000000
> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -Atmel AT91 device tree bindings.
> > -================================
>
> [..]
>
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > new file mode 100644
> > index 000000000000..19431f58b906
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel AT91 device tree bindings.
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Ludovic Desroches <ludovic.desroches@atmel.com>
>
> ... and sorry but it's not correct just above ^^^
> - wrong Ludovic's email address
> - wrong Alexander's email address
> - and I'm not part of the game anymore...

Humm, I think get_maintainers.pl says you are as that's where the Cc
list came from. But it could be stale if that changed recently.

>
> So actually our MAINTAINER's entry is up-to-date: please use it.

Sorry, it was generated from git history. Many of cases with
get_maintainers.pl was not correct and ended with me being listed.
Probably should have made the git history a fallback.

Rob
