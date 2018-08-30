Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB97C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5A62083A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxJ6PQ61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5A62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeHaBbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeHaBbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:31:22 -0400
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D72920652;
        Thu, 30 Aug 2018 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535664434;
        bh=aIDW06qS1A5ch4KhqrJPSATmQe3oIV3AmpFOr7tPuFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxJ6PQ61D0RFNANz9USKzBChQZr7E1GxqwQDpMAAgzP9LxTkXFfZktRZ9OqPvf+r+
         mhhlka6ZOPX3D5Hva6z8JbfQfYe/xlVvmVIVjEkQp9K2jG3LyT+EdEh2f1UAzXRiGE
         eM4fieRbvGsR8mj4eJm5gv7kVE3oKM+WIkcZUYU0=
Date:   Thu, 30 Aug 2018 23:27:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC2731 charger support
Message-ID: <20180830212710.jhpxjdyuifjxr6t6@earth.universe>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
 <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
 <CAMz4kuJGbvKKVvXmGKaEMbu87bY1nQqB+Zvo5UTpv1gwCG41mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="257puiedckvm2awp"
Content-Disposition: inline
In-Reply-To: <CAMz4kuJGbvKKVvXmGKaEMbu87bY1nQqB+Zvo5UTpv1gwCG41mQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--257puiedckvm2awp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 30, 2018 at 11:08:59AM +0800, Baolin Wang wrote:
> >> +static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
> >> +{
> >> +       int ret;
> >> +
> >> +       /* Enable charger module */
> >> +       ret =3D regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
> >> +                                SC2731_CHARGE_EN, SC2731_CHARGE_EN);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Set default charge termination current to 120 mA */
> >> +       ret =3D regmap_update_bits(info->regmap, info->base + SC2731_C=
HG_CFG2,
> >> +                                SC2731_TERMINATION_CUR_MASK, 0x2);
> >
> > Looks like DeviceTree property.
>=20
> OK.
>=20
> >
> >> +       if (ret)
> >> +               goto error;
> >> +
> >> +       /* Set default charge termination voltage to 4.35V */
> >
> > Looks like DeviceTree property.
>=20
> OK. Thanks for your comments.

I did not review this in detail, but had quick look at this.
Please make sure to derive battery specific DT values using
this:

Documentation/devicetree/bindings/power/supply/battery.txt

-- Sebastian

--257puiedckvm2awp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluIYSsACgkQ2O7X88g7
+prmbw//VIFs3zlPNH/DpBgYUcd+so+q2u6CvWTnNflbK85M3ywIFczku1VaM6+s
M2Tm2+tl7FXKU+gVA+F+OT+TNnsHfa11VAwLTZhDdRX+MMq9rBb2Gk+cCMOF2h9E
V+63QURkEnT7tOoTXZtAic51F0nRfxH6igVz7WKccfMzXNf8sDGST3ZCvr6bgH6d
VykPh5+TTtVfKnzS3YGbujr34q2VpCjoeZ6J5aK4rY2E40YG4c5cFsnyyEsd54Qa
CliCkkTHU3h56sH68/LSmwMdCcIFU5i7GRBqIOrJV0wtnPos+9obPn5C2bxlNho5
5D8c1WI5u1dVWc5VNOLCuS4d/WJdGu4bm46yHuG+nGiVbKXwwPhgzdjdo8mBw+3V
PvX5eWyX1HODZ7CIrdU96khzW6HEKNfctD6utNfh1tqK4iMoj9hSU76iyGUVQwrQ
YcTdE5cEwsBY+dDylE0ws47s3MqWYMnuK+zcra016W5I6x8dTvIk2JgIdfTXj96H
nMiVqa2TSFDJiQQrttlif7ILc56odKsKlC4qmx48FZd6Q37kSgULNF2mA20JU9Tk
TlMY8f5vJWxAqHfhEZo7YiqHcaipCCpbADob0iqMgBw+3QAl1wjZWEh/hqwxNtSh
BLK0l61DZb1O5zaEdEorF/i7iQoOJm8Q+6s3dEleLJ5eg3TFI4Y=
=dCm9
-----END PGP SIGNATURE-----

--257puiedckvm2awp--
