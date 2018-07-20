Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C9620854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A++WD4JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C9620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbeGTSbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:31:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46868 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:31:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so7447546pgv.13;
        Fri, 20 Jul 2018 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ebGDfZaJ6A5otDc0AS941+jfWKYGER9G0EGKo1WDLjc=;
        b=A++WD4JL/Ol/70h2qZp1c9Bw94b9DN5g3el+B1Um7iEz8rFhJOX1fx99GDC1y4awXS
         c4O9DqcVoZlB75zhDr12zur0kZzl0AC4bXVmtt6eIOFwJctyK7ftAcy3wR2MeS0FAQVF
         JKy/kyd6xuapBodiliq1B3i9s47Ja1shXAOBPxSH8RPAXLWdTrwnJAlhKMEPv547TtlK
         jwcl4jkKLZZP1sFKKraHjDIFkn6Ziah2beCkgPt4TRZ8U2W+P3NXSb5qlwSZfWYrT/96
         A3H0iak/5LIw8+9xIm9CaMR/K3IpvXqCKbtVu08op+pdP8wEKI7eKZy5L8Bm5enzMxVF
         hIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ebGDfZaJ6A5otDc0AS941+jfWKYGER9G0EGKo1WDLjc=;
        b=kNei5vZTBeGjFGsvLCC//bnJgylsvRRzEIvq/AkKeaNDAfDeJFHyCoGMov0SOIp0Bd
         LmG/yrq+Pi+nDNvC56B8MvBA9S4AKyXyw3B6oQ+w//ejRxV4bekUoKUAntARHG2UugYS
         6dpIaOcMvMDaZGyyn3P388YWP1+ajzXrTu3ckLPqbziknCpjffEOTZK7rL/cDYcGuYGX
         1V4DsC+l4eyTZ9cGGylp3SJfwMLUYGmcK43g4bvTLGquzmB5CdN0uWhR/ScDTP3xz+x0
         a8rZHtYkdAzpC8XL4VyypqOVgLofOowuC8edT3PH02vkBTpgOnNXTQzivs+V87Qv4uTg
         Nf1g==
X-Gm-Message-State: AOUpUlHzrTBaCZULQeUsTGLF03B8PzUac+A/B1bP5PP2u8KpzZZ4sPxs
        2Y7Pa0PPlxb3kB9dQA7Uw8tR+ghTPcWOXMWNbHY=
X-Google-Smtp-Source: AAOMgpcQv9ekJMVPRXr3kiTrEndnimCjCntUoJrFBOws78IcXUEAFDENoQa3ZlRhTWDyDAi2O36wTxQ5vc9Sja06GHA=
X-Received: by 2002:a63:941a:: with SMTP id m26-v6mr2909846pge.82.1532108508443;
 Fri, 20 Jul 2018 10:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <1531756070-8560-1-git-send-email-akinobu.mita@gmail.com>
 <1531756070-8560-2-git-send-email-akinobu.mita@gmail.com> <20180718152832.ylu6rlcsaom2q4xm@ninjato>
In-Reply-To: <20180718152832.ylu6rlcsaom2q4xm@ninjato>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 21 Jul 2018 02:41:37 +0900
Message-ID: <CAC5umyig9ZTddEu7HLwnspcPqEEmRS7ac=Oszd=6dPdN1vSkfA@mail.gmail.com>
Subject: Re: [PATCH -next v4 1/3] regmap: add SCCB support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B47=E6=9C=8819=E6=97=A5(=E6=9C=A8) 0:28 Wolfram Sang <wsa@the-dr=
eams.de>:
>
> On Tue, Jul 17, 2018 at 12:47:48AM +0900, Akinobu Mita wrote:
> > This adds Serial Camera Control Bus (SCCB) support for regmap API that
> > is intended to be used by some of Omnivision sensor drivers.
> >
> > The ov772x and ov9650 drivers are going to use this SCCB regmap API.
> >
> > The ov772x driver was previously only worked with the i2c controller
> > drivers that support I2C_FUNC_PROTOCOL_MANGLING, because the ov772x
> > device doesn't support repeated starts.  After commit 0b964d183cbf
> > ("media: ov772x: allow i2c controllers without
> > I2C_FUNC_PROTOCOL_MANGLING"), reading ov772x register is replaced with
> > issuing two separated i2c messages in order to avoid repeated start.
> > Using this SCCB regmap hides the implementation detail.
> >
> > The ov9650 driver also issues two separated i2c messages to read the
> > registers as the device doesn't support repeated start.  So it can
> > make use of this SCCB regmap.
>
> Cool, this series really gets better and better each time. Thank you for
> keeping at it! And thanks to everyone for their suggestions. I really
> like how we do not introduce a couple of i2c_sccb_* functions with a
> need to export them. And given the nature of regmap, I'd think it should
> be fairly easy to add support for ov2659 somewhen which has 16 bit
> registers? Only minor nits:

I have an ov2659 sensor.  The ov2659 driver works with i2c adapter that
doesn't know I2C_FUNC_PROTOCOL_MANGLING, so it actually supports repeated
start.

But ov5645, ov5647, ov7251 drivers may want to use SCCB regmap API for
16-bit register.  Because they use i2c_master_send + i2c_master_recv
for reading register value.

> > +#include <linux/regmap.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
>
> Sort these?
>
> > +/**
> > + * regmap_sccb_read - Read data from SCCB slave device
> > + * @context: Device that will be interacted wit
>
> "with"
>
> > +     ret =3D __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
> > +                            I2C_SMBUS_WRITE, reg, I2C_SMBUS_BYTE, NULL=
);
>
> Mark: __i2c_smbus_xfer is a dependency on i2c/for-next. Do you want an
> immutable branch for that?
>
> > +/**
> > + * regmap_sccb_write - Write data to SCCB slave device
> > + * @context: Device that will be interacted wit
>
> "with"
>
> But in general (especially for the I2C parts):
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for your reviewing.
