Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F270C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4947E208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="cjsSa0z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4947E208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbeFRQh0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:37:26 -0400
Received: from mail.blih.net ([212.83.177.182]:15154 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934644AbeFRQhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:37:20 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2018 12:37:19 EDT
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id e14c3cbe;
        Mon, 18 Jun 2018 18:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=SBi4ZACnxb4J0qfwjsbnq1cfM7w=; b=cjsSa0z3dsohVJAp+hedJ1J2U2ra
        BGiz6pP7B+53gjejT0d/hdq9fj9bce1x66rZiM+v3Lg7y01UJYMCKPZKO7jIMY5f
        4ePU4IG1Dz+dXqcMEJsrnoAsjZKe6vTXGZaA+Bpk6cB8cjr9oGPMPo/Xt3O1kpyp
        l/Hw8vrIs4DQGmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=g5KRzeQe3q7TkuNSpN2gdG3ryVnitoMgqsnqTxNJssqKfW7vT5Ap3CNF
        c08Sb6jZS0sANm5H0aFXAwjYrQga8FJsfhzcT4mtnkx29QllbzXgZ6fPyeolihyz
        hvBaf+Wuk5ccDCnzZyEePq+MQFcf97eMgX9QqfCG5pbVdSLUjUU=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id 14c7cb9b
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Mon, 18 Jun 2018 18:30:38 +0200 (CEST)
Date:   Mon, 18 Jun 2018 18:30:38 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Emmanuel Vadot <manu@freebsd.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path
 property
Message-Id: <20180618183038.c8ee3164ff62ab5e27535c5c@bidouilliste.com>
In-Reply-To: <1529337797.7211.4.camel@pengutronix.de>
References: <20180618154257.16919-1-manu@freebsd.org>
        <1529337797.7211.4.camel@pengutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 18:03:17 +0200
Lucas Stach <l.stach@pengutronix.de> wrote:

> Am Montag, den 18.06.2018, 17:42 +0200 schrieb Emmanuel Vadot:
> > The RIoTboard debug uart is connected to serial1.
> > Add a chosen property in the DTS so OS knows what serial port to use for
> > the console.
> >=20
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > ---
> > =A0arch/arm/boot/dts/imx6dl-riotboard.dts | 4 ++++
> > =A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts=
/imx6dl-riotboard.dts
> > index 2e98c92adff7..315d2ae6fa45 100644
> > --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
> > +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
> > @@ -19,6 +19,10 @@
> > > =A0		reg =3D <0x10000000 0x40000000>;
> > > =A0	};
> > =A0
> > > +	chosen {
> > +		stdout-path =3D "serial1:115200n8";
>=20
> If there a reason to deviate from the "stdout-path =3D &uart1;" notation
> used by other i.MX boards?
>=20
> Regards,
> Lucas

 This is, AFAIK, the proper way to specify the stdout-path.
 See
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/chosen.txt#L31

 Cheers,

> > +	};
> > +
> > > =A0	regulators {
> > > =A0		compatible =3D "simple-bus";
> > > =A0		#address-cells =3D <1>;
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=20
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
