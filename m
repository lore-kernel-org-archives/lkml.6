Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FB021904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBGPx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:53:29 -0500
Received: from sauhun.de ([88.99.104.3]:48758 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBGPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:53:29 -0500
Received: from localhost (p54B33308.dip0.t-ipconnect.de [84.179.51.8])
        by pokefinder.org (Postfix) with ESMTPSA id 68ED84A16EA;
        Thu,  7 Feb 2019 16:53:27 +0100 (CET)
Date:   Thu, 7 Feb 2019 16:53:27 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Elie Morisse <syniurge@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20190207155326.GC4796@kunai>
References: <20181226232258.GA23526@syn-yoga530>
 <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bjorn,

thanks a lot for your additional information!

> IMHO the split into two drivers is a bit of a mess and doesn't really
> correspond with the hardware, as I mentioned at [1].  The PCI device
> is the real hardware and the driver should claim that.  AFAICT the
> ACPI device exists only to pass some config information to the PCI
> driver.  I think the natural approach would be for the PCI driver to
> directly search the ACPI namespace for that config information.

AFAIR the AMD folks insisted on the two driver setup because they need
it in the future? Maybe they can explain again here?

> The fact that driver_find_device() is essentially unused except for a
> few very special cases is a good clue that there's probably a better
> way.

Excactly this thinking made me recommend something else, too. Let's see
what we can come up with.

Thanks,

   Wolfram


--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxcVHYACgkQFA3kzBSg
KbbKUg/+PJomClPceiLS2KRwNbNrlsyyrzpU/NmDQhCRtTVswOm0z/li4Mb0kj4X
TwcLUFjZAYe8tyX/8K6QeTEsG+5iPPWKmlA1AoEy+sX7vl/OX8kRdVAcSoGOx5/8
0jNc+1m3mTF/woaiDHEwMPHo178SQpaYC5kyvvnvyoH3PZY1uMVMOwCUzTMsfuWu
imW08ROvQoW/T0zSiW9v3OSsaaapCdQuBzq+qXBeEpaGyYCqaDZIj++ZMS7QIpoI
+YBEtiHDRzSNyBo2Qr7rOsDwD38BvHBd1QI1mYzifaf26P2YbDB97IceTMVBS4Ru
Vp9Fp6gVgcPZWjv47ilsgz8YFyXCPiPVICJyMLsadAOYcwz/Mu1sE4vruweq8j6c
ahAgtlXvA083CXe8aXxuQUp50gSvo1AMyFGmZLxhUXrdz/ci67jnupU0RxqiLmkC
EFPyMeELKfOy5ubWij9MPb+gA6j5vMuqhvsCuuzJArdcMVsBxPbU9KvfnIf6dKT/
rcH76sULNbv5Ygr4z5EUTAXJSRS0LWy9lu2YfzKg+WFRh4PrpQazmwjEmE36cB6E
E9m5dhkCuyWjAtCPmM0k0Dki8jTS9K47EtQOXTkXcFgD+lnl7ffkQrc5bcismsKv
47u2jjhCEHFG3XiVkhaZmeXgydqlZ8O2YKImmTSZ5RrSfjqSEII=
=ib+6
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
