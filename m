Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A02084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkot1Lqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7A02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJDV0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:26:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34705 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:26:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so8606129ljk.1;
        Thu, 04 Oct 2018 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFh4/z6kc+w/tczrmSajZkNfvZfWYf64ehKmrvnAHkQ=;
        b=Zkot1LqePJDh9we2MfQXd39JYj7D9Zi5tX1BBn0+mRj/Or/hjGFDZH3zoycHNJQYTy
         fjCOfafbTzVjzSRDxycYAiPgaEV7OnjHA9ERJnQRgRWYg/MwQrbF3dLTMCUBpyQg/wDR
         DiKnetha155el77TCr0G55YsfxetPUYfu3EvMKzuCC4+jX8+FLpVTyYmSgwRvp7Jz6Up
         jGNDMCmfR8HOThNKYtuzcqmrbTZaM2SW0fcl1v9+0x7FJWPtnGC336i7WLRYZyjM1fJ+
         BWyD66vBxxwamUtsU1BSTgL0a1wqiTGT5m23sXv0J0J7Zi3/HZH6WUgiTGabnswjZPo+
         vZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFh4/z6kc+w/tczrmSajZkNfvZfWYf64ehKmrvnAHkQ=;
        b=LVLZlEQfE9VL3Yra/mHJXX6NsCQ5BU2nyqk/KYU6sbHI5/nS6iBwfAapVOIzoGm1y7
         Y76VlYmMfAYqz+1ak8afyPGMMzDx+Tfc+tGbmm/+M7Rw/EDgNhXdy2uDMcADy+tIfPFb
         izVrtkd0s0vr7q6Lpba7Z8niLj8HW4DVcrPRsjGJq9AtSYZPaHX/jpRZ1IbzfVvQdtER
         XHHhbaSTnl8fE9OHPkCTBcDeKAaeBIzWTWsC9oczL+AEqc4eV6/0Vyxm6ryLr0eyYALl
         Lvb5Nux+cioMY8v/ql0Aoup3xZPLBUHdDDlVqyvbhFmpJL6OxcP98HcNOMyIataOjOUT
         DlbQ==
X-Gm-Message-State: ABuFfohDeRydA+5S0wYYqVuFznkRhuJwBT/787Ihf4BVX9z/+vKQPo9h
        cyDy74CTHXEg7DbxK7GN1V+UsXj8aOxGgrsYEiI=
X-Google-Smtp-Source: ACcGV62YIlGkJkawPnBnMQqLzaYBjxTG5Od63gn0TkyVti8o8jTkUy4uIhHTTmXOejGCEhaSJAbtGE/zE8qGgL1oCE4=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr4396882lji.140.1538663580049;
 Thu, 04 Oct 2018 07:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
 <20181004130110.8496-9-ricardo.ribalda@gmail.com> <20181004160207.3b0403d7@bbrezillon>
In-Reply-To: <20181004160207.3b0403d7@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 4 Oct 2018 16:32:43 +0200
Message-ID: <CAPybu_02nJf3JusnBrBZhEU4QvsDFWidEgZ_Teuv9ZqedCek1Q@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] dt-binding: mtd: Document gpio-addr-flash
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
On Thu, Oct 4, 2018 at 4:02 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu,  4 Oct 2018 15:01:09 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Add documentation for gpio-addr-flash. This binding allow creating
> > flash devices that are paged using GPIOs.
> >
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  .../bindings/mtd/mtd,gpio-addr-flash.txt      | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> > new file mode 100644
> > index 000000000000..304a33880f9e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> > @@ -0,0 +1,25 @@
> > +Memory Mapped flash with some address lines addressed using GPIOs
> > +
> > +Handle the case where a flash device is mostly addressed using physical
> > +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> > +to a 2MiB memory range and use the GPIOs to select a particular range.
> > +
> > + - compatible :  must be "mtd,gpio-addr-flash", "cfi-flash";
>
> I keep thinking you don't need a specific binding, just add an optional
> addr-gpios property to the generic physmap binding and that should do
> the trick. Plus, "*mtd*,gpio-addr-flash" is a linux-ism, and DT
> bindings should be OS-agnostic.
>

That is a very good point. Please take a look to v10, and tell me what
do you think.

It does not require a specific binding and also it can be build optionally.

Regards!

> > + - reg : Address range of the mtd chip that is memory mapped, this is,
> > +   on the previous example 2MiB.
> > + - addr-gpios: List of GPIO specifiers that will be used to address the MSBs
> > +   address lines. The order goes from LSB to MSB.
> > +
> > +For the rest of the properties, see mtd-physmap.txt.
> > +
> > +The device tree may optionally contain sub-nodes describing partitions of the
> > +address space. Check partition.txt for more details.
> > +
> > +Example:
> > +
> > +     flash@300000 {
> > +             compatible = "mtd,gpio-addr-flash", "cfi-flash";
> > +             bank-width = <2>;
> > +             reg = < 0x00300000 0x00200000 >;
> > +             addr-gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> > +     } ;
>


-- 
Ricardo Ribalda
