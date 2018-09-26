Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ADC20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxnRb8vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ADC20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIZMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:45:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40812 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:45:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so6052573ljr.7;
        Tue, 25 Sep 2018 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8R4Olvm/xbakhubOHCF+6Gb16T1LNweznEtfKmGecg=;
        b=WxnRb8vmXtIWheJZP1u05EizC3wh6Psf5KTp9YDZ1oyUJMwPLfjLUZboO14MLkfOTW
         t1qnHY3V9WV7eoMpRvxTK8WoPB6yIFwX0THpclEKZL0mfPTuXozcnCftyewncjsShA0s
         XqZmwD+EibGb28mDotP3XtnYbBwEZoQXCZ17xb3gzdd/16aObJo94sCbWdjqxngCnpAS
         8HHEpKc21voapzzj+unoClEBcNeBaUb426yizsQcrQpyn5P6s2RKAxz4u8/nb1rx0IU4
         sr4vMq7bXiLmJ957hJZKNDSnWLMrgShfpxmO5OAU1rU5ShyBc+n0iYsAzJk5gn+p4Tk+
         w9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8R4Olvm/xbakhubOHCF+6Gb16T1LNweznEtfKmGecg=;
        b=RO5HlWdizUwWfOfaOpuQunwbXfeRBgfGORIGvhTZDsqSRwHXi70dhyE2pV1C2y4SJA
         ZhSgBryCtIfGdBvlcpz1RlVqwmBjsRZQ3dxhcKD8z/oKxzAekl2Q048fq4SrJC0/Q2f1
         Fi/q0E3rNipLrDa/XZWyk8TTr9pnxDcl74uFwo5UQDE30MdhD6l7n6VWVjX2YtLJVzC4
         CyJIH7fC45uwQB5mUEhfSDVobIs4lym51QH14920hoT3WQ9JDOZuSi3tdV11YCYfVsCp
         f1/sISMcp3vim4qiBqZ9xpmyJmH3uHPvzA3FaEbiZD4Cl1taHH1wb+zrOiJuX7Zc8I+A
         yI1g==
X-Gm-Message-State: ABuFfoiadGUVOvT18jQDwVPv5HSo0q3r8IYjK0H7qn7Wjzh441jSH4ca
        5bKI1pT1yVrVVvvmzu+IHqpCGF54OXRmKkWIJKULgbm/
X-Google-Smtp-Source: ACcGV60GRY0KPy+UDgaKXNXYk8KnJFzuLdgvHkX/8q5/Fjj2MSM8E+1t4qZ7RhZPxSarSKp+bw/IW1A6Qh2sM1Vh3HE=
X-Received: by 2002:a2e:9a93:: with SMTP id p19-v6mr3093138lji.87.1537943655500;
 Tue, 25 Sep 2018 23:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
 <20180905143643.9871-9-ricardo.ribalda@gmail.com> <20180925204813.GA6450@bogus>
In-Reply-To: <20180925204813.GA6450@bogus>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 26 Sep 2018 08:33:58 +0200
Message-ID: <CAPybu_3ZpE43X9W919k1KD-F3waBkwBdUFFamwZnHcRLWo-_5w@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] dt-binding: mtd: Document gpio-addr-flash
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

Hi Rob
On Tue, Sep 25, 2018 at 10:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 05, 2018 at 04:36:43PM +0200, Ricardo Ribalda Delgado wrote:
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
> > + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> > +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
>
> Why not just a bool prop for jedec mode? As-is, the '_probe' part is
> redundant.

I wanted to mimic gpio-addr-flash. Which btw does not document this
property. Shall I send a patch adding it?

>
> > + - #address-cells, #size-cells : Must be present if the device has
> > +   sub-nodes representing partitions (see below).  In this case
> > +   both #address-cells and #size-cells must be equal to 1.
>
> Perhaps most importantly, where's 'gpios' property?
>
> > +
> > +The device tree may optionally contain sub-nodes describing partitions of the
> > +address space. See partition.txt for more detail.
> > +
> > +Example:
> > +
> > +     cfi_flash_0: cfi_flash {
>
> flash@300000
>
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             compatible = "cfi-gpio-addr-flash";
> > +             bank-width = <2>;
> > +             reg = < 0x00300000 0x00200000 >;
> > +             gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> > +             partition@0 {
>
> All these under a partitions node is now recommended.
>
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
