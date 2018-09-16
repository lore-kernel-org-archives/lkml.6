Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459DECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C889B2086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C889B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeIQCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 22:07:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbeIQCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 22:07:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B74D627DAB6
Received: by earth.universe (Postfix, from userid 1000)
        id 4AF343C0C2B; Sun, 16 Sep 2018 22:43:23 +0200 (CEST)
Date:   Sun, 16 Sep 2018 22:43:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] shutdown procedure verification for SAMA5D2
Message-ID: <20180916204323.ysvt4axagxyx7hsc@earth.universe>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
 <20180916104301.dcrm333ydo5kh5bj@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wvwad2occsvd2eok"
Content-Disposition: inline
In-Reply-To: <20180916104301.dcrm333ydo5kh5bj@earth.universe>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wvwad2occsvd2eok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Sun, Sep 16, 2018 at 12:43:01PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Aug 30, 2018 at 02:50:05PM +0300, Claudiu Beznea wrote:
> > Hi,
> >=20
> > Patch 1 from this series implement a fix for shutdown procedure
> > for SAMA5D2.
> >=20
> > The rest of the patch are improvements as follows:
> > patch 2 - use only one function for poweroff
> > patches 3-6 - cosmetic improvements
> >=20
> > The patches are based on latest sys-reset/for-next [1].
> >=20
> > Thank you,
> > Claudiu Beznea
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-sup=
ply.git
>=20
> Thanks, queued.

I merged this via a immutable branch, that you can pull into at91 or
ignore:

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/psy-at91-poweroff-immutable-for-v4.20-signed

for you to fetch changes up to 9f1e44774be578fb92776add95f1fcaf8284d692:

  power: reset: at91-poweroff: do not procede if at91_shdwc is allocated (2=
018-09-16 12:32:17 +0200)

----------------------------------------------------------------
Immutable branch for mach-at91 and power-supply for v4.20

Immutable branch between mach-at91 and power-supply for driver
changes in at91-poweroff.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Claudiu Beznea (6):
      power: reset: at91-poweroff: switch to slow clock before shutdown
      power: reset: at91-poweroff: use only one poweroff function
      power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
      power: reset: at91-poweroff: make sclk part of struct shdwc
      power: reset: at91-poweroff: rename at91_shdwc_base member of struct =
shdwc
      power: reset: at91-poweroff: do not procede if at91_shdwc is allocated

 arch/arm/mach-at91/pm_suspend.S          |   8 +++
 drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++------=
----
 2 files changed, 88 insertions(+), 39 deletions(-)

-- Sebastian

--wvwad2occsvd2eok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluewGsACgkQ2O7X88g7
+poy0Q/+IQkeg0hB5xLAtbJ2e6VsZwxmeHENsdY+CYifVhEBol5xIU/WpF/KzBF3
YsvI2aXK2/d0Ej2k96NHOJ2wUrrwfW/9CJcxpIom4AW5k2GugBpYNtoz+Hf+zPPr
dnQGyuYjAkm9/wyQGpA/wTz908rB6tla0PIbRJ/pz9fMsA9cz6+ygrAEePpCKWdW
RhO5HQwaGhlSFQ1tF32WxTSD8myxhBrRqQ08bu4VKZxWxZkHjRSMROWygjgnnRAA
35uJvHTpBPMrbWw3VBxBFWeQl2JyrB+s07moQuKHjhKlbAToWqdHLn5WzOsRhic5
N1bdYzfCI0OfbfGckLgxHt76HxNzXMbKImS+cH1a2ppbWR21mIUYvv5tw+YUgQqz
CWPfciJlyuqfJxwnNChae5+VV6s94WBgHyaBaFTv2iKoDL1PC8waozwFNWkoK70+
/LuMXHIxbbnyMbZ/tz1agsDvBPqhS9H06K7yobK3gfbJA7ywiKit+7FEu86kv7zd
izzlR1eXHQR18lzkAw+bbYlO7lKDuG/YiZE7w7RNosaAqUQJFjMkFrgPj3d47DeI
4fuvzI60GAQwPnIMOBElEtE6jV19bO6tnSKWm7CIzxEmpUooHq0Z6CxLI7wBuizU
2T0suKk4gDPqYfkZOuJP3cuzotwuTuxHmXEJfYCvBetBzUlUjXA=
=3Ybp
-----END PGP SIGNATURE-----

--wvwad2occsvd2eok--
