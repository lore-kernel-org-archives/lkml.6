Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32AAECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A705B2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD6YUJAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A705B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJJBc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJJBc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:32:29 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D656C2086D;
        Tue,  9 Oct 2018 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539108856;
        bh=Xnz7e4MieeINIK73Bkz1Fsgawc7pp5RWEpRSK2chvLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dD6YUJArmw6Qk+jTL5DI2B4ztWD3u/RkiN+pP56TPHoMHZCnKaRegfQ6gCeLeM5n3
         +XIMoYc+NOveyOooBb3UMUzxlV0Wxy3fgjhG1kC3eg43thbBXfRoyVipgoTQqy8M7F
         Q1ixww/3OjpRxDXNQTxi1jk3/6oRrJmbtcbkGOIE=
Received: by mail-qt1-f169.google.com with SMTP id q40-v6so2744505qte.0;
        Tue, 09 Oct 2018 11:14:15 -0700 (PDT)
X-Gm-Message-State: ABuFfoiFRKi9qs936aNO481MrQHJjzw87VvuAK66rWUdKstoITOZOsDn
        qVbEP9Ib8A0KpT5aOP82CWQpO6eO953W5zoADA==
X-Google-Smtp-Source: ACcGV6169OZaMd9MjGa1efH0Jmg7K/FjvYSeMEs3LV87liAWkxj/R19oCxCzHLXEmce7ZChgWmO+4sN2h6qM2cbj1+4=
X-Received: by 2002:a0c:bc03:: with SMTP id j3-v6mr24770926qvg.77.1539108855092;
 Tue, 09 Oct 2018 11:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
In-Reply-To: <20181009115713.GE6248@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Oct 2018 13:14:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
Message-ID: <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To:     Will Deacon <will.deacon@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Rob,
>
> On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
> > Convert ARM PMU binding to DT schema format using json-schema.
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
> >  .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
> >  2 files changed, 96 insertions(+), 70 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
>
> [...]
>
> > -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > -               interrupt (PPI) then 1 interrupt should be specified.
>
> [...]
>
> > +  interrupts:
> > +    oneOf:
> > +      - maxItems: 1
> > +      - minItems: 2
> > +        maxItems: 8
> > +        description: 1 interrupt per core.
> > +
> > +  interrupts-extended:
> > +    $ref: '#/properties/interrupts'
>
> This seems like a semantic different between the two representations, or am
> I missing something here? Specifically, both the introduction of
> interrupts-extended and also dropping any mention of using a single per-cpu
> interrupt (the single combined case is no longer support by Linux; not sure
> if you want to keep it in the binding).

'interrupts-extended' was implied before as it is always supported and
outside the scope of the binding. But now it is needed to validate
bindings. There must be some use of it and that's why I added it.
However, thinking some more about this, I think it may be better to
have the tools add this in automatically whenever we have an
interrupts property.

I guess the single interrupt case is less obvious now with no
description (it's the first list item of 'oneOf'). The schema If the
single interrupt is not supported, then we can drop it here.

Rob
