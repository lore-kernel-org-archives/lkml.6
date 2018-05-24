Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030409AbeEXORD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:17:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966100AbeEXORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:17:00 -0400
Date: Thu, 24 May 2018 15:16:51 +0100
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>, Wendy Wang <wendy.wang@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20180524141651.GV4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YwTTlJgQ7QoYB9ta"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YwTTlJgQ7QoYB9ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

After merging the pm tree, today's linux-next build (arm64 defconfig)
failed like this:

drivers/acpi/ec.o: In function `acpi_ec_dispatch_gpe':
/home/broonie/next/next/drivers/acpi/ec.c:1040: undefined reference to `acpi_dispatch_gpe'
/home/broonie/next/next/drivers/acpi/ec.c:1040:(.text+0x228c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `acpi_dispatch_gpe'

Probably caused by commit

  8f81c457105b5d4 ("ACPI: EC: Dispatch the EC GPE directly on s2idle wake")

(though the symbol appears to be there and like it should be built and
the relocation warning looks funky...).  I've used the PM tree from the
last -next.

--YwTTlJgQ7QoYB9ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGyVIACgkQJNaLcl1U
h9BPBAf+Lo9wQmffH4H2EV4dSINIApOkXivOXJ7jydPy3Srx6sXD0kbYPZdV/eA3
mPmSaaF631sgU0tgVIwyoP6zpjnY5JIDAEQVoqj/xm+trfnCqzXMa25peTMPR0kR
Lt4MDQzua0GqPFh8cQtOAQQcMRboZgcPPymu5JILIILoe1/t6JVxrOjl34KOlFOg
WmBJ4abBtcydtHEufjumZ4jzIA0uHSM6raWcEPrOqD7BlHD3PU2NZRJIFY45j+Ns
B3NHp+ICvuMTnqSJtDHmvNG3zmV0XSrkW7v/T0VgklyQd48Oq4aZNFW2r6opFb9L
pJ9Ap1khBoh/j1xfOAzwEyPqNBsR0Q==
=zbJe
-----END PGP SIGNATURE-----

--YwTTlJgQ7QoYB9ta--
