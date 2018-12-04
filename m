Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7769D2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV0vsPgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7769D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeLDOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:05:07 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB302087F;
        Tue,  4 Dec 2018 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543932306;
        bh=yTr+UbBFW+eS6HM3fzcLbxczAbrxW4SyfnuUXDeA/9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GV0vsPguRlbVwUdqPqdotp9D2RX4uJcvLoeZB4aoigLRi8c7ofsrLfJ3hTvEy12nT
         3oDb2slvH5a27cyVmVC2m6BQspIoq8Cfy2ZmpH2LSslhjD9ORiJJdd8STMH9ZsBG+O
         U9Uh+jBysPhtu0bVYSATY+Qpb2tiZwvhrxeihfeg=
Received: by mail-qt1-f169.google.com with SMTP id y20so18065933qtm.13;
        Tue, 04 Dec 2018 06:05:06 -0800 (PST)
X-Gm-Message-State: AA+aEWZCFW29VUfREm3JJWmlnRVl1OJJCxhwaTpIFZpeLHh/gpis1B5J
        BBozvH4KjtZeF+3GLVuX29soJ1GippnDd9Kq2A==
X-Google-Smtp-Source: AFSGD/Wa9LYCKIlO2I4w34Owie/nbFY2YYmEhKbJJCOx75JQlW9JLL4Y1Zli1NJqi2tnJfrE9cHPFZaPN3+nzSMsdBg=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr19809237qts.144.1543932305591;
 Tue, 04 Dec 2018 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-22-robh@kernel.org>
 <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
In-Reply-To: <be37bd18-a573-307e-3a9e-e879010cfc89@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 08:04:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3oL4FWSQKVLRtmg5Bma5q6-QgicfATcOEo3nQY-TdPw@mail.gmail.com>
Message-ID: <CAL_JsqJ3oL4FWSQKVLRtmg5Bma5q6-QgicfATcOEo3nQY-TdPw@mail.gmail.com>
Subject: Re: [PATCH v2 21/34] dt-bindings: arm: Convert Oxford Semi board/soc
 bindings to json-schema
To:     Neil Armstrong <narmstrong@baylibre.com>
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
        Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Oxford Semi SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-oxnas@groups.io
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
> >  .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
> >  2 files changed, 25 insertions(+), 14 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> > deleted file mode 100644
> > index ac64e60f99f1..000000000000
> > --- a/Documentation/devicetree/bindings/arm/oxnas.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > --------------------------------------------
> > -
> > -Boards with the OX810SE SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox810se"
> > -
> > -Boards with the OX820 SoC shall have the following properties:
> > -  Required root node property:
> > -    compatible: "oxsemi,ox820"
> > -
> > -Board compatible values:
> > -  - "wd,mbwe" (OX810SE)
> > -  - "cloudengines,pogoplugv3" (OX820)
> > diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > new file mode 100644
> > index 000000000000..6ae51ef513be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/oxnas.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
> > +
> > +maintainers:
> > +  - Neil Armstrong <narmstrong@baylibre.com>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +            - wd,mbwe
> > +        - const: oxsemi,ox810se
> > +
> > +      - items:
> > +        - enum:
> > +            - cloudengines,pogoplugv3
> > +        - const: oxsemi,ox820
> >
>
> We also loose all the "human friendly" description of board/SoC relationship here,
> and I think it's a shame.

You can have whatever comments or description properties you like, so
how would you like it to look?

Rob
