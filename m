Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24DC2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDgaLYpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24DC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeKBEgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeKBEgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:36:48 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEE92084C;
        Thu,  1 Nov 2018 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541100748;
        bh=/x7S6wOFLQr8W3UDRcyWSs0Pz9v1coUTlDM/AkRrcxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aDgaLYpIBaFFLpQpRfHzTttNxmSf76DT07+GB1LRCOJ7QosM1oP+h0/VKEjHr8HsQ
         9pgLlxbnWI/yk14E0rGvb1mDQY2oLU6CMSmVuXA0i+DLgttmQK7a8Fc4JTIkSjGX8Y
         73wHVUfEknan10S9vXrb3ToiUGg67F2OglIOh3mw=
Received: by mail-qk1-f178.google.com with SMTP id 189so11713104qkj.8;
        Thu, 01 Nov 2018 12:32:28 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL3tcoaUHr7RdKgAqe6WI/2nSCnwIJmgpezUxa/+NpXoct0N09d
        6T61cyzPWvw3Svau6w6V3hwzDSvhC5llbba6pg==
X-Google-Smtp-Source: AJdET5fZTGJGL+FIAeOcyrSMk/63EwuYM5K3XvuDEugOn3TDRJWlPs+FR3PYDr/iUceerCdQiWwU851OBn49EgkjnZI=
X-Received: by 2002:aed:29a5:: with SMTP id o34mr1170272qtd.257.1541100747137;
 Thu, 01 Nov 2018 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
In-Reply-To: <20181009115713.GE6248@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Nov 2018 14:32:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
Message-ID: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To:     Will Deacon <will.deacon@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

In regards to no support for the single combined interrupt, it looks
like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
have only a single interrupt. Though the interrupt gets routed to MPIC
which then has a GIC PPI. So it isn't supported or happens to work
still since it is a PPI?

Rob
