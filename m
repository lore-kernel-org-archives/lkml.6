Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3595AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BCC21476
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKCM8tqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BCC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeGQOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbeGQOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:55:15 -0400
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13C921476;
        Tue, 17 Jul 2018 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531837340;
        bh=tH1TrPtS9VLFrWAvJbTOk+nHJahZHNs/5EH8WN/2NJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tKCM8tqoObmICYnc+kiWX1udWizv++/BYLQcnuJkKS9B+ieKV/npJ2F3az+ISz4Xp
         BTwRy+79Y7cbH9JFQd4L7DGttui/rcg+Aa0Lw8VuG5Ju+CxRo2aSKXYhlk9YDbquvJ
         QMY6+MAyjp1UgR2kZtgMhZEuv+LQdbaX0qfUtNB8=
Received: by mail-it0-f50.google.com with SMTP id 72-v6so2043137itw.3;
        Tue, 17 Jul 2018 07:22:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlE6Zi6dgKMefkPVA7QaDMf3tVB0X2QMkUTRHWCBxLdsHyNPwYRw
        WnBgY6be7xS+nzoHSHViNouJZDbRLgYmYuI6bg==
X-Google-Smtp-Source: AAOMgpeRau3cPJBlvirVG3v/gnDGb2/qaV8IRxV83iY669CXEkZ7YE9lR2xN9AIVzYOfbZx+k2y2oqeD8w0qHIP5S3g=
X-Received: by 2002:a02:9936:: with SMTP id r51-v6mr1696009jaj.46.1531837340200;
 Tue, 17 Jul 2018 07:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
 <1531396813-6581-6-git-send-email-avienamo@nvidia.com> <20180716154309.GA16477@rob-hp-laptop>
 <20180717152318.3608e3f9@dhcp-10-21-25-168>
In-Reply-To: <20180717152318.3608e3f9@dhcp-10-21-25-168>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 Jul 2018 08:22:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
Message-ID: <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration bindings
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:23 AM Aapo Vienamo <avienamo@nvidia.com> wrote:
>
> On Mon, 16 Jul 2018 09:43:09 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Thu, Jul 12, 2018 at 03:00:11PM +0300, Aapo Vienamo wrote:
> > > Document the pinctrl bindings used by the PMC driver for performing pad
> > > configuration. Both nvidia,tegra186-pmc.txt and nvidia,tegra20-pmc.txt
> > > are modified as they both cover SoC generations for which these bindings
> > > apply.
> > >
> > > Add a header defining Tegra PMC pad voltage configurations.
> > >
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 84 +++++++++++++++++++
> > >  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 95 ++++++++++++++++++++++
> > >  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h | 18 ++++
> > >  3 files changed, 197 insertions(+)
> > >  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > index 5a3bf7c..9528f41 100644
> > > --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > @@ -34,3 +34,87 @@ Board DTS:
> > >     pmc@c360000 {
> > >             nvidia,invert-interrupt;
> > >     };
> > > +
> > > +== Pad Control Nodes ==
> > > +
> > > +The PMC can be used to set pad power state and voltage configuration.
> > > +The pad configuration is done via the pinctrl framework. The driver
> > > +implements power-source, low-power-enable, and low-power-disable pinconf
> > > +pin configuration node properties. Each pinctrl pin corresponds to a
> > > +single Tegra PMC pad. Thus, in the following sections of this document
> > > +pin refers to the pinctrl frameworks notion of a Tegra PMC pad.
> >
> > "pinctrl framework" is Linux specific and doesn't belong in the binding.
> > Neither does what a driver supports. Describe what the h/w supports.
> >
> > > +
> > > +The pad configuration state nodes are placed under the pmc node and they
> > > +are referred to by the pinctrl client device properties. For more
> >
> > Another driver detail not relevant.
> >
> > > +information see the examples presented later and
> >
> > examples don't document bindings. The documentation should be complete
> > without examples.
> >
> > > +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> > > +
> > > +The values accepted by power-source property are
> > > +TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
> > > +in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
> >
> > You need to list out what properties the child nodes can have.
> >
> > power-source needs a vendor prefix.
>
> Isn't it a generic pinctrl property?

I don't know offhand. Doesn't look like it if you have custom values.

Rob
