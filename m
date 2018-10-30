Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C97EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379C02082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379C02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ3Qhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:37:37 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33700 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeJ3Qhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:37:37 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id AAFEB3A2771;
        Tue, 30 Oct 2018 08:34:51 +0100 (CET)
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6ABA220011;
        Tue, 30 Oct 2018 07:34:46 +0000 (UTC)
Date:   Tue, 30 Oct 2018 08:34:44 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Ulrich Hecht <uli@fpond.eu>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, geert+renesas@glider.be,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au,
        linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: Introduce VIN_DATA_PIN_GROUP_VER
Message-ID: <20181030073444.GE15991@w540>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <1540836824-4636-2-git-send-email-jacopo+renesas@jmondi.org>
 <1822236810.335136.1540871186977@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <1822236810.335136.1540871186977@webmail.strato.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Uli,

On Tue, Oct 30, 2018 at 04:46:26AM +0100, Ulrich Hecht wrote:
>
> > On October 29, 2018 at 7:13 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >
> >
> > VIN data groups may appear on different sets of pins, usually named
> > "vinX_data_[a|b]". The existing VIN_DATA_PIN_GROUP() does not support appending
> > the 'a' or 'b' suffix, leading to the definition of groups names not consistent
> > with the ones defined using SH_PFC_PIN_GROUP() macro.
> >
> > Fix this by adding a macro that supports appending suffixes when required.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  drivers/pinctrl/sh-pfc/sh_pfc.h | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > index 458ae0a..2930e9a 100644
> > --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> > +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > @@ -54,17 +54,27 @@ struct sh_pfc_pin_group {
> >
> >  /*
> >   * Using union vin_data saves memory occupied by the VIN data pins.
> > - * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups
> > - * in this case.
> > + *
> > + * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups,
>
> Maybe fix the odd spacing, while you're at it?

Ups, I have missed it.

Thanks, I'll wait for more feedbacks and add your tag to the next
version.

Thanks
  j

>
> > + * while VIN_DATA_PIN_GROUP_VER() is used when the same pin group can appear
> > + * on different sets of pins.
> >   */
> > -#define VIN_DATA_PIN_GROUP(n, s)				\
> > -	{							\
> > -		.name = #n#s,					\
> > +#define __VIN_DATA_PIN_GROUP(n, s)				\
> >  		.pins = n##_pins.data##s,			\
> >  		.mux = n##_mux.data##s,				\
> >  		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
> >  	}
> >
> > +#define VIN_DATA_PIN_GROUP(n, s)				\
> > +	{							\
> > +		.name = #n#s,					\
> > +		__VIN_DATA_PIN_GROUP(n, s)
> > +
> > +#define VIN_DATA_PIN_GROUP_VER(n, v, s)				\
> > +	{							\
> > +		.name = #n#s"_"#v,				\
> > +		__VIN_DATA_PIN_GROUP(n##_##v, s)
> > +
> >  union vin_data {
> >  	unsigned int data24[24];
> >  	unsigned int data20[20];
> > --
> > 2.7.4
> >
>
> With or without the whitespace fix:
>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
>
> CU
> Uli

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb2AmUAAoJEHI0Bo8WoVY8TFQQAIsZnPDnlNBvl+MeaWF+O0QP
85Ej7Az3Evfmz/ZMQTrNUyLbdhRMmmrYxnnURldaJA2WVZgvmQbWWGDjRLdppg2E
tMoAXnbyBqVOsb26aQjIlHil+J2Qh95fFqv/u3gXQm9k2GRDG4/eUVsvFMSHbev3
T3FXOpLIPdx6C6XHdAy1tMgnkzlGzIDKFoDRvUt/2s0MIdcTO9UNyIAmFUjlc+gq
YIKDJK8JjJxKuSZY2o9SeHk6Fh5F9FQv2JLl8xIZzFbV6yoYUPoB5qht+0NAObot
HD+NxlMlFCFP/lvBgPRgAzREhwvzKrvRhD8UMydGPy9R4Y+AQ2Qf32Bgw+VnZnho
9uceAQ6yYzA477/7llFKfnO/429DmiPhjuiT/POBEyXtAPGOwV7RkzYBQdDVyjPi
gjEEk4LDwpxAuHhG0MMgW3xLDCbl9G8R0lZTuoDZMX6LJOycZuHn+6yb4hFDr3/X
2mGtXp2Y6cX9nsMSTEZMM6YJ5iNBdkNza0r7Jc/IuL+fLh88ihfnUdGcP7kEOArO
EhO9r4vVydMGofYV1bGs36oTkjWzvhovxjLz8wR55TiWIX+Ipk/ZhywKXtstdgKk
Rc49j4jwzK3gPqtct8K6Nw4+bKWpyUiNsH50MrYKO6GRc63Gpk2mzuFUlxVzNCpr
78LjLBmbMlfvtXs/JC9u
=/rtT
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
