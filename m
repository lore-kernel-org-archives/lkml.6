Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C98C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0893208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ln3tHto3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0893208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHHMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:44:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52778 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:44:14 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9E3757;
        Wed,  8 Aug 2018 12:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533723909;
        bh=KM2mEHXm8a0+NPwW6IGoVbhF4VJy35aIEDrFBua5vyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ln3tHto3EKlKPl0DGBAoC0GiqVM6hay4Ak2gDGF8c80ze57+xrsdi4sfj5Us3wlyv
         fKL4jKJYkJ5KVp3mdaMKi4dJFUHfJCbJky0wA/2UPED2O4K9lyFQIgA7LCgasmne0r
         CNLI4atqDSdIwhTMcRmzrts/edI5a2OKiEYVkq4k=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     kieran.bingham@ideasonboard.com
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt: adv7604: Fix slave map documentation
Date:   Wed, 08 Aug 2018 13:25:53 +0300
Message-ID: <5273911.bCJl0SVgzf@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <b5b25641-f898-577b-7762-d72dd64272cf@ideasonboard.com>
References: <20180807155452.797-1-kieran.bingham@ideasonboard.com> <505904fb-7bfc-c455-740e-b72a14731eb9@ysoft.com> <b5b25641-f898-577b-7762-d72dd64272cf@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wednesday, 8 August 2018 13:23:32 EEST Kieran Bingham wrote:
> Hi Michal,
>=20
> Thank you for your review.
>=20
> +Rob, +Mark, +Laurent asking for opinions if anyone has any on prefixes
> through media tree.
>=20
> On 08/08/18 08:48, Michal Vok=C3=A1=C4=8D wrote:
> > On 7.8.2018 17:54, Kieran Bingham wrote:
> > Hi Kieran,
> >=20
> >> The reg-names property in the documentation is missing an '=3D'. Add i=
t.
> >>=20
> >> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
> >> bindings to allow specifying slave map addresses")
> >=20
> > "dt-bindings: media: " is preferred for the subject.
>=20
> This patch will go through the media-tree as far as I am aware, and
> Mauro prefixes all commits through the media tree with "media:" if they
> are not already prefixed.
>=20
> Thus this would then become "media: dt-bindings: media: adv7604: ...."
> as per my commit: 9feb786876c7 which seems a bit redundant.
>=20
> Is it still desired ? If so I'll send a V2. (perhaps needed anyway, as I
> seem to have erroneously shortened dt-bindings: to just dt: which wasn't
> intentional.
>=20
> > I think you should also add device tree maintainers to the recipients.
>=20
> Added to this mail to ask opinions on patch prefixes above.
>=20
> Originally, I believed the list was sufficient as this is a trivial
> patch, and it goes through the media tree.
>=20
> But, it turned out to be more controversial :)
>=20
> Rob, Mark, should I add you to all patches affecting DT? Or is the list
> sufficient?

Given the insane amount of patches received by DT maintainers, I personally=
=20
try to use common sense and only disturb them when needed. Such a typo fix=
=20
doesn't qualify for a full CC list in my opinion.

> >> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >> ---
> >>   Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> index dcf57e7c60eb..b3e688b77a38 100644
> >> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> >> @@ -66,7 +66,7 @@ Example:
> >>            * other maps will retain their default addresses.
> >>            */
> >>           reg =3D <0x4c>, <0x66>;
> >> -        reg-names "main", "edid";
> >> +        reg-names =3D "main", "edid";
> >>             reset-gpios =3D <&ioexp 0 GPIO_ACTIVE_LOW>;
> >>           hpd-gpios =3D <&ioexp 2 GPIO_ACTIVE_HIGH>;

=2D-=20
Regards,

Laurent Pinchart



