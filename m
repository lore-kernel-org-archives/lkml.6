Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29637ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E467E2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E467E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeIRTGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:06:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58797 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeIRTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:06:36 -0400
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2435A240003;
        Tue, 18 Sep 2018 13:33:54 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:33:53 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] pinctrl: renesas: Renesas RZ/N1 pinctrl driver
Message-ID: <20180918133353.GT16851@w540>
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-3-phil.edworthy@renesas.com>
 <20180918104330.GO16851@w540>
 <TY1PR01MB17695F174D9083C0E625494FF51D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XSEVMyPRvc8xgDhM"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB17695F174D9083C0E625494FF51D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XSEVMyPRvc8xgDhM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Phil,

On Tue, Sep 18, 2018 at 11:55:16AM +0000, Phil Edworthy wrote:
> Hi Jacopo,
>

[snip]

> > > +
> > > +/*
> > > + * Structure detailing the HW registers on the RZ/N1 devices.
> > > + * Both the Level 1 mux registers and Level 2 mux registers have the
> > > +same
> > > + * structure. The only difference is that Level 2 has additional MDIO
> > > +registers
> > > + * at the end.
> > > + */
> > > +struct rzn1_pinctrl_regs {
> > > +	union {
> > > +		u32	conf[170];
> > > +		u8	pad0[0x400];
> >
> > Is pad0 actually used?
> No, it's just to implement the padding. Would you prefer not using a union
> here?

Oh, I did the math wrong, to me it was (32*170 > 8*400) but it's
actually (32*170 < 8*1024).

Also using a struct to define the memory region layout confused me and
I was about to ask "WHY ARE YOU RESERVING MEMORY HERE???" but this
type is just used for pointers, and it makes accessing HW locations
nicer actually (thanks Geert for having saved me a silly comment on this).

Cheers
   j


--XSEVMyPRvc8xgDhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJboP7BAAoJEHI0Bo8WoVY8v6QP/0FfpEDFS4ePrHBtSd0qDdhH
NSVFPt/fcmYXLyQRbLeA/W143cahf9ITSE1TfKGYJXqVGlVccwlSiud+7FKjTYMO
tYFKraEhodmAew7jlf+Bnx5Yrhh6UOPgBq8kOXG8mAFlMitmOKWkc2O9R18Z7THS
PeBtPzltIr6/0eZioxCuo+NbRxwtG9EA0bbcWTeymzGPebsDoOz+0uD7UER/fA5o
kAxmb0cnIoSYh3c8DYBMt5awontuldtLH2sjMva4AEPf1C/kRVZopTKHC9HclCJe
gtnQ0IwjGlyeWeR6R8pWFL6h4LlpE5G9l9mReLR2NaWJo/m0wP2SSN57Tyk1MS28
SErxHu2SJurK9aoWaMPlpqlNXk96FBRfRhqpbvxoNM4xwczWINojYMMd+Nz4N1Rn
RHhJCq1KVY6nk80E7KkR/8hM0WPL0/G37u8X06L+DwFD4zygzVmjdk9wJuPLeWdf
l/mGWX3pFYVRPcOHORHLl3uREmAcbxXcW3Gj7hz16CphnlEnSqVfpf55Mji8oHNg
H4LCNqvmwXo2CUU4yEiXmJhxC0ulGC+ihqnI1CSg6qTq43CrP/u3CX9EHjMJEb7k
3HdFQhdD14Uo6uNyfd9gkJL9ao+s9wiyNt3fQXpnwjo9AWhObQLiPeYv4NTnTuzV
vY2NGzZnoNTHZfQpHuXx
=oeFZ
-----END PGP SIGNATURE-----

--XSEVMyPRvc8xgDhM--
