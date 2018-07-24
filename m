Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0113C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:31:43 -0400
Received: from sauhun.de ([88.99.104.3]:54538 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388394AbeGXIbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:31:43 -0400
Received: from localhost (p54B3332A.dip0.t-ipconnect.de [84.179.51.42])
        by pokefinder.org (Postfix) with ESMTPSA id D9CF3634593;
        Tue, 24 Jul 2018 09:26:37 +0200 (CEST)
Date:   Tue, 24 Jul 2018 09:26:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel@pengutronix.de,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Message-ID: <20180724072637.smhlrx4kpyh6hvwa@ninjato>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
 <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
 <20180717090920.zy6lkeqlcewhrfs5@ninjato>
 <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofht27vhe5ktigiu"
Content-Disposition: inline
In-Reply-To: <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofht27vhe5ktigiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

> > So, it is not possible to read SCL status then? Hmm, currently a working
> > get_scl is required...
=2E..
> > Well, I don't know much about this IP core and how/where it is used. I
> > just wonder what happens if another user comes along using an
> > open-drain GPIO. Is that possible?
> >=20
> > I assume it is the same with SDA? Non open-drain? Output only?
> >=20
>=20
> Just had a closer look at how it's setup here.
> Maybe the following helps.

Thanks for the detailed explanation. I am just afraid it is a litle too
detailed for me. I am not sure if I can read it correctly:

When you read the SCL/SDA GPIO, does it return the true state of the
SCL/SDA line or does it just reflect the value it was set to output?

> There's no concept of HiZ internally in the FPGA.

Which probably means SDA is to be treated the same as SCL -> push/pull.

> If there was some kinda of OpenDrain gpio driver that modelled a FET
> driven by a push pull GPIO I guess it could be made to work.

Still, that sounds quite unlikely to me, so we can for now assume that
all designware users will have push/pull?

Disclaimer: I have zero experience with this core, I don't know how hard
it is to modify or which versions are out there.

Thanks for your help,

   Wolfram


--ofht27vhe5ktigiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltW1KkACgkQFA3kzBSg
KbYqQA/7BLzkFJlpp83m/0LTH8LUFT1nWqSkrPjWGUw5PF91E91L4NNfHUHQLazy
jDKPrnTqnCz3WPMHrPHeRWRXZXCdv6s172wI2ubd8Xt1mH1T2fwu4X1g4yvVfDZj
xnF+Y0v9A/KVFTaM29rJo9pq6PAvJOip8haW3yC29+kF9tIJjBxkcJim0cZ4m7Yr
WVK37EzDI6x2FRfGWG2cy5bxUCRldCnDEmrkXS37X2PPjB4I81gZKh2T1bTfP4ac
VWwYMcNXfGpnNNBBB7ZftSdAq16hXCxIg/xyoM/xzfOxCMLWaEGeOJTQvzYyUkN1
PkZ1TO2fTa2GyB1zfCvIIRFZxNiUmuNvIWFG7a81q1pkIpfd45GznplnyW95elji
LkkcwBu0UL7vdEKXWsnF0qjqArKy/NtbSIMTRQHXc7Pazu1hlQkVhwVhFKBsrIFS
0ylIQg4+eK5WMLGSuZgpfLw3GQascmbPb53Cny18O9lV20Cx4d3qrXdCefMFH3Df
AF8XbcWELKzvVtrMrg1p9QtflCBYOx+Dq/tUzrDKU1Ufumamf9YBTPGkv4LMXJ0Y
L7mqscD9RYZYn1RKAS5QB6cagz5i7dPrivreTyDPG4SdLHCqU4F4LAuhI/g/Aaxa
muLCmtzU6y1vKOdgF3odUucqZeFKP2Nla0KzIJc3ubpnlfvwKTc=
=1srA
-----END PGP SIGNATURE-----

--ofht27vhe5ktigiu--
