Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1DE2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182946;
	bh=Jtz9B9hz7hchiClRws1OJLmBy0wplegWUTIbVzgbzfM=;
	h=To:In-Reply-To:References:Subject:From:Cc:Date:List-ID:From;
	b=wsQfCeOtdlOsVp03fLbBV3Jemu9s7AwdCMqyo8gT9yfn3ByUyrLUbak7psT0F//rn
	 BXIJe+fcJRcHYmByv9X5YJsphLfroIM7Ztyeqs9+lP1MyTAf2JYHBy7L2rTjsawvst
	 UxAAI/OfJ695NTFIJSsupR5e6QNWTqL8dBco5Pa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAVStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVStD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:49:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5612085A;
        Tue, 22 Jan 2019 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182942;
        bh=Jtz9B9hz7hchiClRws1OJLmBy0wplegWUTIbVzgbzfM=;
        h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
        b=k3VEAA7MKecXNmzRi9N9O7EVBPACAYOSjCV+QNWYVqFXgLc9CMnXHb6ssxeJjXcxP
         kc6wYjifJszRGEAXJYyKvVUEGYnFAdRdHt2FnWoTJyl8ykU3tiN5c6fcjxlT5fAgWy
         D+i+3odrva8D5Qrx6aiK62pGZx6CFNbTo/5gM9eg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20190117063804.GJ25498@builder>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org> <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com> <20190117063804.GJ25498@builder>
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818294180.20280.13967884067917226851@swboyd.mtv.corp.google.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, vkoul@kernel.org, niklas.cassel@linaro.org,
        sibis@codeaurora.org, georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Tue, 22 Jan 2019 10:49:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-16 22:38:04)
> On Mon 17 Dec 11:39 PST 2018, Stephen Boyd wrote:
>=20
> > Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> > > The high frequency pll functionality is required to enable CPU
> > > frequency scaling operation.
> > >=20
> > > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/d=
ts/qcom/qcs404.dtsi
> > > index 4594fea7..ec3f6c7 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > @@ -375,6 +375,15 @@
> > >                         #mbox-cells =3D <1>;
> > >                 };
> > > =20
> > > +               apcs_hfpll: clock-controller@0b016000 {
> >=20
> > Drop leading 0 on unit address please.
> >=20
> > > +                       compatible =3D "qcom,hfpll";
> > > +                       reg =3D <0x0b016000 0x30>;
> >=20
> > Wow that is small!
> >=20
>=20
> I double checked and it's actually 0x34, but the last register is
> protected.
>=20

Ok, so then it should be 0x34? I don't think we've left out protected
registers from the size before.

