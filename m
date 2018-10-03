Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3987C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A793206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG8FKqVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A793206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJDEn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:43:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37193 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDEn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:43:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id 63-v6so6542444ljs.4;
        Wed, 03 Oct 2018 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHXzlX7JqZoWkOs83Z8eqDiRlfjlpaRldWOBCio/AXM=;
        b=fG8FKqVLyVwGOoFu7qELNquP/FrmauXiipRUhV++NgYkiOpXM4ExTARiimfxRxOv9j
         alqpbQZzauwgEdCAtyWkBZVG5VxS2nh/Cry2F5i1uT+bKnPdhycrPRj2S+MhCjWcrS8b
         DLlLq9UcJy+/b9NWRagieKQ1FEg6vEJvRg73G2pbBtt7Gs9yzhO1wehATBeOkPnPzsdy
         WLTGJ7V5tIn30VNDgItjTJ378G57JmXxIqYk1QFvJ3N/3NlvtsudU6yYDzwq/Jb4kN+3
         6zVIGnGPfAOiaTPjfbnwd7Ogf2ce8PEWhWRwYwbkfAnHoHo2Y7BhY0m/z19SDswk/nw3
         S48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHXzlX7JqZoWkOs83Z8eqDiRlfjlpaRldWOBCio/AXM=;
        b=p2o7QVEwXX/S/qpetS+F7OKET9r7Z3HEIVnnlzybXtZOLn1VXQRneo1nlfjd3kGcHi
         FLpkcrmgOf3BrrUSWkRgtJ7nOKHLoI0kZNb8GPMwe03mmw6af96NU9bKjyHoObIwGJLY
         2Q9wEoCPVIkcN4h9yWONR68Wtx0EVAfVfAtaPfIK9BcuUTmd39C/OxqlRUbMD2RrZniM
         u3YbVy+brOqNxkI4IvoSgvGMZqEY9yFz+0ktyRjj9LqSXvdePfSwllGEWWQ0bNkJLcjO
         kMX3qVCFoHXYty5DZeSTs0BtjB93UGF8gOFWQrOpEpfOSiyhqHSAngJuOKx/GuderLdu
         jyEg==
X-Gm-Message-State: ABuFfoiJwRPa7HLKTduTPJL2IGznys9OXfYT7KFnC3GMM6x1OwiSbrpt
        UI9tqBdozU4r88cltrz4QGJEHXesnGYaG1wcOIY=
X-Google-Smtp-Source: ACcGV62c1YO7kOREjIZRAtzEHwR8ejAlpe7cXUwHwoKKg9hoesuuUXdvQ8FppW6jgfXRlqtRvnm2voWqgBsu1NzRBgE=
X-Received: by 2002:a2e:8919:: with SMTP id d25-v6mr2491047lji.69.1538603623912;
 Wed, 03 Oct 2018 14:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
 <20181003193859.23928-7-ricardo.ribalda@gmail.com> <20181003232702.4c18e725@bbrezillon>
In-Reply-To: <20181003232702.4c18e725@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 3 Oct 2018 23:53:27 +0200
Message-ID: <CAPybu_3M75E9c+JmR7MVKsyv3vYPOrZ6qBABtvEF317KA+roBg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] dt-binding: mtd: Document gpio-addr-flash
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
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

Hi Boris
On Wed, Oct 3, 2018 at 11:27 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Wed,  3 Oct 2018 21:38:58 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Add documentation for gpio-addr-flash. This binding allow creating
> > flash devices that are paged using GPIOs.
> >
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > new file mode 100644
> > index 000000000000..5006a26e1753
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > @@ -0,0 +1,54 @@
> > +Memory Mapped flash with some address lines addressed using GPIOs
> > +
> > +Handle the case where a flash device is mostly addressed using physical
> > +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> > +to a 2MiB memory range and use the GPIOs to select a particular range.
> > +
> > + - compatible : "cfi-gpio-addr-flash"
> > + - reg : Address range of the mtd chip that is memory mapped, this is,
> > +   on the previous example 2MiB.
> > + - bank-width : Width (in bytes) of the bank.  Equal to the
> > +   device width times the number of interleaved chips.
> > + - gpios: List of GPIO specifiers that will be used to address the MSBs address
> > +   lines. The order goes from LSB to MSB.
> > + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> > +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
>
> Looks like other bindings are encoding the probe type in the
> compatible [1][2], and we should probably follow what's been done by
> others.

If I understood it right, they are special cases of physmap_of_core.c
https://elixir.bootlin.com/linux/v4.18.11/source/drivers/mtd/maps/physmap_of_core.c#L242

The driver that handles the compatible is physmap_of_core.c, and afaik
multiple drivers with the same
compatible string is a very bad idea.

We can convert the driver to something like Versatile or gemini, but
then we will not support platform devices

btw, the binding that I am used is used by:
https://elixir.bootlin.com/linux/v4.18.11/source/drivers/mtd/maps/physmap_of_core.c#L91

Yes, I know is obsolete

Tomorrow morning I will try to address your comments, test in hw and resend

Thanks




>
> > + - #address-cells, #size-cells : Must be present if the device has
> > +   sub-nodes representing partitions (see below).  In this case
> > +   both #address-cells and #size-cells must be equal to 1.
> > +
> > +The device tree may optionally contain sub-nodes describing partitions of the
> > +address space. Check partition.txt for more details.
> > +
> > +Example:
> > +
> > +     flash@300000 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
>
> You should not have the #address-cells and #size-cells props defined at
> this level, it's done in the partitions node already.
>
> > +             compatible = "cfi-gpio-addr-flash";
> > +             bank-width = <2>;
> > +             reg = < 0x00300000 0x00200000 >;
> > +             gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> > +             partitions {
> > +                     compatible = "fixed-partitions";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +
> > +                     partition@0 {
> > +                             reg = < 0x0 0x200000 >;
> > +                             label = "Golden Bitstream";
> > +                     };
> > +                     partition@200000 {
> > +                             reg = < 0x200000 0x200000 >;
> > +                             label = "User Bitstream";
> > +                     };
> > +                     partition@400000 {
> > +                             reg = < 0x400000 0x200000 >;
> > +                             label = "V4L Controls";
> > +                     };
> > +                     partition@600000 {
> > +                             reg = < 0x600000 0x200000 >;
> > +                             label = "Production Data";
> > +                     };
> > +             }
> > +     } ;
>
> [1]https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> [2]https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mtd/arm-versatile.txt



-- 
Ricardo Ribalda
