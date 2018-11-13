Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF6622419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFpzZX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF6622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbeKMKV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeKMKV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:21:59 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8613122511;
        Tue, 13 Nov 2018 00:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542068786;
        bh=6TIJj5L+YmQ9KGgdPoE7eeq623ekJyCudLtDzPB/gkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvFpzZX2RqncW9Kk5ARAsdhsmqeXIEYZo74fxP9psXHMJY1CBry/8wVr/PwQhABgg
         MrfDW1jiNmmUaYV1VWDelecd9JdbbU/00kdqVFp+mvCHOFtBrqWx1kHXbgka1TsqIR
         l9xqqLximIiSl232mwU+uY5idbClUCI0f8UDqyJA=
Received: by mail-qk1-f174.google.com with SMTP id r71so16624413qkr.10;
        Mon, 12 Nov 2018 16:26:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gJz1fSUuRpRbqoH+wugSkCe6RZToe5OR6FjL3nn8Xh7unjtS3VN
        Wi709ZtTxPZVVfj0KOmK88r01RdSJoIWlzAEMg==
X-Google-Smtp-Source: AJdET5fhZRo1AMFLnZVxZEkFseXpZ5bRpH32BUSZkZo77vNJNZYNmYDcE0xE0uMRAIq4XPMZ8C7hEy3a09o2J60U/Bs=
X-Received: by 2002:ae9:c306:: with SMTP id n6mr2797721qkg.79.1542068785713;
 Mon, 12 Nov 2018 16:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20181029231447.3690-1-alex.williams@ettus.com>
 <20181029231447.3690-2-alex.williams@ettus.com> <5bea0e95.1c69fb81.88799.a282@mx.google.com>
 <CAJZzcDhTKAXW4vomD2xazfDU=NWH6eAAbLubEhAo-SWuq5+EKQ@mail.gmail.com>
In-Reply-To: <CAJZzcDhTKAXW4vomD2xazfDU=NWH6eAAbLubEhAo-SWuq5+EKQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Nov 2018 18:26:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRNBmJgVcAynLtsYkSUJAyT2_eSTQcens6fa1j52+dNw@mail.gmail.com>
Message-ID: <CAL_JsqLRNBmJgVcAynLtsYkSUJAyT2_eSTQcens6fa1j52+dNw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: nixge: Update device-tree bindings with v3.00
To:     alex.williams@ettus.com
Cc:     netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Moritz Fischer <mdf@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Williams <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:41 PM Alex Williams <alex.williams@ettus.com> wrote:
>
> On Mon, Nov 12, 2018 at 3:36 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Oct 29, 2018 at 04:14:47PM -0700, alex.williams@ettus.com wrote:
> > > From: Alex Williams <alex.williams@ni.com>
> > >
> > > Now the DMA engine is free to float elsewhere in the system map.
> > >
> > > Signed-off-by: Alex Williams <alex.williams@ni.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/nixge.txt | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
> > > index e55af7f0881a..d0f9fb520578 100644
> > > --- a/Documentation/devicetree/bindings/net/nixge.txt
> > > +++ b/Documentation/devicetree/bindings/net/nixge.txt
> > > @@ -1,8 +1,14 @@
> > >  * NI XGE Ethernet controller
> > >
> > >  Required properties:
> > > -- compatible: Should be "ni,xge-enet-2.00"
> > > -- reg: Address and length of the register set for the device
> > > +- compatible: Should be "ni,xge-enet-3.00", but can be "ni,xge-enet-2.00" for
> > > +              older device trees with DMA engines co-located in the address map,
> > > +              with the one reg entry to describe the whole device.
> > > +- reg: Address and length of the register set for the device. It contains the
> > > +       information of registers in the same order as described by reg-names.
> > > +- reg-names: Should contain the reg names
> > > +     "dma":  DMA engine control and status region
> > > +        "ctrl": MDIO and PHY control and status region
> > >  - interrupts: Should contain tx and rx interrupt
> > >  - interrupt-names: Should be "rx" and "tx"
> > >  - phy-mode: See ethernet.txt file in the same directory.
> > > @@ -13,7 +19,9 @@ Required properties:
> > >  Examples (10G generic PHY):
> > >       nixge0: ethernet@40000000 {
> > >               compatible = "ni,xge-enet-2.00";
> >
> > Shouldn't the compatible change here?
> >
> That's an oops... Will fix.
>
> Should I leave the old example for the version 2.00 format and create
> another for 3.00?

No, we don't need every permutation for examples.

Rob
