Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547CCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0A20845
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6/trRfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE0A20845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeHaQ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36663 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id x207-v6so4129737lff.3;
        Fri, 31 Aug 2018 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCtW2yKoQdTtuhViJ7t3FusZKSquGxusuTTElmWLtQI=;
        b=q6/trRfXhLxEYj5cEjhIJbuGHJBlWoQw1rTGX881ftDlzTNmrEDWKXhPrPzIeQTX4d
         Om2RsdlgXQIOuvGZ89f1c5uF49ZFsb7IpXXdWbsL7zOscmcbr7bEMTvjL0pETXX4Nt53
         Udr/cEKnA5C4u570nEiRHDH+RqM8wsTBFVPTaYdr18s476aRUMbozOFXwmGHd5OdAeqa
         qz2Vv7mCCQ4GfMywOnwM+ydytgYUwfT2kMG0W40atQjDpMCzIn2VSqFF6Q/d+7y5F+Zl
         IM7rMpw3Ttd88Fp5oXmboSzVbsD0C0VgAGgre11yoZaWuhJ/084ohqVBJq1QwUzJHzKL
         L76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCtW2yKoQdTtuhViJ7t3FusZKSquGxusuTTElmWLtQI=;
        b=aPE5Vxmbf2Fy1otnCFbRkqGN1bXoypLrW2r4V2UaFP5FhYo9PK+9/jusDbXq7gO6k0
         OLR9Ec3ekhPpAeA0RZC6W7eqSalHTcrTdv8pkzD3TrHCSRAvbAs/5ryM9iLJlywA5VzL
         umiqGoxW8j6O8Gh47YybV8h+yLIPts2mB+RQOZPsQzhoiL6S95h5ZSI9SVc36ihKclh3
         XVMbLm/4qESULOF7pX/zsI94ytrVHr55wN+BgYkluw5JsHkLTvVscok9htKhuDnAGoG8
         wGBegfKbNXbjwgM4R04oDcsh09HP2eHHiFcpfpMst4dZOf6Mb24xii7W0r54E/62bsE5
         xJUA==
X-Gm-Message-State: APzg51Cdx+yxZ1w6fX9ZXETMxG/O9OUnKK09c1vFZr9BjVxBMey3sqqN
        r8/uwnXv0/r7Sot93MherCRnfevS7v/tnVbYLP0=
X-Google-Smtp-Source: ANB0VdYXkJuFWuz+wlNJ97yA8X41jic2jY0k2CxSFEBgaqnbvjDiOZ9aD2typcKDD4xypbyTK68EvF0KEv5D1prCyCo=
X-Received: by 2002:a19:2c8e:: with SMTP id s136-v6mr4341436lfs.78.1535718017317;
 Fri, 31 Aug 2018 05:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
 <20180821143152.32293-9-ricardo.ribalda@gmail.com> <20180831121751.GA22256@bogus>
In-Reply-To: <20180831121751.GA22256@bogus>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 31 Aug 2018 14:20:00 +0200
Message-ID: <CAPybu_2cqyLXiQ9pdLBDbz8zFPM1u6B4jnKJqLXWzW+gXHbwRA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dt-binding: mtd: Document gpio-addr-flash
To:     Rob Herring <robh@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 aHi Robb
On Fri, Aug 31, 2018 at 2:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 21, 2018 at 04:31:52PM +0200, Ricardo Ribalda Delgado wrote:
> > Add documentation for gpio-addr-flash. This binding allow creating
> > flash devices that are paged using GPIOs.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  .../bindings/mtd/gpio-addr-flash.txt          | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > new file mode 100644
> > index 000000000000..4279e8cad09b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > @@ -0,0 +1,46 @@
> > +Memory Mapped flash with some address lines addressed using GPIOs
>
> That's ugly...
>
If hw was perfect there would be no firmware engineers in the world :P

> > +
> > +Handle the case where a flash device is mostly addressed using physical
> > +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> > +to a 2MiB memory range and use the GPIOs to select a particular range.
> > +
> > + - compatible : "cfi-gpio-addr-flash"
>
> Why a new compatible? Shouldn't just adding some address gpios to an
> existing flash device binding be sufficient?

Because today there are handled by two different drivers

Thanks!

>
> > + - reg : Address range of the mtd chip that is memory mapped, this is,
> > +   on the previous example 2MiB.
> > + - bank-width : Width (in bytes) of the bank.  Equal to the
> > +   device width times the number of interleaved chips.
> > + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> > +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
> > + - #address-cells, #size-cells : Must be present if the device has
> > +   sub-nodes representing partitions (see below).  In this case
> > +   both #address-cells and #size-cells must be equal to 1.
> > +
> > +The device tree may optionally contain sub-nodes describing partitions of the
> > +address space. See partition.txt for more detail.
> > +
> > +Example:
> > +
> > +     cfi_flash_0: cfi_flash {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             compatible = "cfi-gpio-addr-flash";
> > +             bank-width = <2>;
> > +             reg = < 0x00300000 0x00200000 >;
> > +             gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> > +             partition@0 {
> > +                     reg = < 0x0 0x200000 >;
> > +                     label = "Golden Bitstream";
> > +             };
> > +             partition@200000 {
> > +                     reg = < 0x200000 0x200000 >;
> > +                     label = "User Bitstream";
> > +             };
> > +             partition@400000 {
> > +                     reg = < 0x400000 0x200000 >;
> > +                     label = "V4L Controls";
> > +             };
> > +             partition@600000 {
> > +                     reg = < 0x600000 0x200000 >;
> > +                     label = "Production Data";
> > +             };
> > +     } ;
> > --
> > 2.18.0
> >



-- 
Ricardo Ribalda
