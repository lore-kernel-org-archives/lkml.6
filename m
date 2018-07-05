Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F48A223B6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdRAG0Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F48A223B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeGEQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753874AbeGEQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:08:29 -0400
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2872723F8B;
        Thu,  5 Jul 2018 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530806909;
        bh=U+S4KVq7SFUN+KFU1BeV5Vv/LW3j3Qxmu5sOdrqFpp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YdRAG0Hq/M16aoxMpn301I2/JF5L5o/HEMcgp0Qlw/ErMySrvlNNWwlgPKs1Gy5Xz
         0vwrM1Xb1IJDao8s76NqTDXDI251WWp3sTUChtgngDYCgf3X5+be1zBmfXoqjeC0Nv
         adavIXW7Ym5hYaYmciJVFWqtKwh6R9r/ltLIhqNM=
Received: by mail-it0-f45.google.com with SMTP id l16-v6so13134275ita.0;
        Thu, 05 Jul 2018 09:08:29 -0700 (PDT)
X-Gm-Message-State: APt69E2z2/8pqGblG1alCuYGd2yb7yHIU405EJh+ovhxc47bpoftEgzn
        bSHTnxawBO2QqeYotoJf9AWt/cD5xxUefd7/qg==
X-Google-Smtp-Source: AAOMgpcDDRPvGh5lgHAlDW+PDq5WJz4X9cCACeAYyJbdIMp1BCO/7e1C8pfK5rY5PpzaLfipbCxJioJXQmaKMsEyD5c=
X-Received: by 2002:a02:8509:: with SMTP id g9-v6mr5582158jai.54.1530806908574;
 Thu, 05 Jul 2018 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org> <20180703223046.GA20184@rob-hp-laptop>
 <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
In-Reply-To: <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Jul 2018 10:08:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
Message-ID: <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
Subject: Re: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 7:16 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2018-07-03 at 16:30 -0600, Rob Herring wrote:
> > On Wed, Jun 27, 2018 at 09:26:02AM +1000, Benjamin Herrenschmidt wrote:
> > > This isn't per-se a real device, it's a pseudo-device that
> > > represents the use of the Aspeed built-in ColdFire to
> > > implement the FSI protocol by bitbanging the GPIOs instead
> > > of doing it from the ARM core.
> > >
> > > Thus it's a drop-in replacement for the existing
> > > fsi-master-gpio pseudo-device for use on systems for which
> > > a corresponding firmware file exists. It has most of the
> > > same properties, plus some more needed to operate the
> > > coprocessor.
> > >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > >  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > > new file mode 100644
> > > index 000000000000..50913ae685cc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > > @@ -0,0 +1,36 @@
> > > +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> > > +------------------------------------------------------------------------
> > > +
> > > +Required properties:
> > > + - compatible =
> > > +                 "fsi-master-ast-2400-cf" for an AST2400 based system
> > > +       or
> > > +         "fsi-master-ast-2500-cf" for an AST2500 based system
> >
> > <vendor>,<soc>-<block>
>
> It's not really a SOC block from a vendor, it's a pseudo-device in a
> way. The current one that doesn't use the coldfire offload is just
> compatible "fsi-master-gpio".
>
> I can add a vendor but what should it be ? aspeed because it runs on
> the aspeed SoCs only ? ibm because we wrote it and FSI is an IBM
> protocol ?

I would say aspeed as it is tied to their chip.

>
> <soc>-<block> doesn't make sense here though.

But you do already have <soc> in the compatible, but in a slightly
different form and position. And "cf" is the block.

So I'd propose: aspeed,ast2500-cf-fsi-master

>
> > > +
> > > + - clock-gpios = <gpio-descriptor>;        : GPIO for FSI clock
> > > + - data-gpios = <gpio-descriptor>; : GPIO for FSI data signal
> > > + - enable-gpios = <gpio-descriptor>;       : GPIO for enable signal
> > > + - trans-gpios = <gpio-descriptor>;        : GPIO for voltage translator enable
> > > + - mux-gpios = <gpio-descriptor>;  : GPIO for pin multiplexing with other
> >
> > So the gpio info is pased to the CF? Otherwise, what's the point of
> > having these in DT?
>
> In the original version you are looking at, they are not passed to the
> CF per-se but the driver does use aspeed GPIO specific APIs to
> configure them to be owned by the CF, so we need the references.

Okay.

> However, I've just reworked the ucode with a few tricks to avoid losing
> singificant performance, so that we can indeed pass them to the CF,
> thus avoiding the need for a per-system image, so the above are here to
> stay.
>
> > > +                                          functions (eg, external FSI masters)
> > > + - memory-region = <phandle>;              : Reference to the reserved memory for
> > > +                                          the ColdFire. Must be 2M aligned on
> > > +                                     AST2400 and 1M aligned on AST2500
> > > + - sram = <phandle>;                       : Reference to the SRAM node.
> > > + - cvic = <phandle>;                       : Reference to the CVIC node.
> >
> > Vendor prefixes.
>
> On what ? Why would an "sram" pointer have a vendor prefix ? Or a
> memory region pointer ?

memory-region is a standard property. sram and cvic are not, so should
have vendor prefixes. However, perhaps we should add a common "sram"
property to sram/sram.txt.

Rob
