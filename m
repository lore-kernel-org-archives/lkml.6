Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2926730-1524570756-2-5552749267092632323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524570755; b=r3GyRgpd7WECfRWQ1sfmYJ+nvtikZt5mud7rpyH8bORrvxQX1O
    9ma1qPcHZeLpGv+OxlCmcz+kiXBffXkTmkUm9i5gdgCGsidwxZ2R4EgtWVb1f7/k
    3lmRuQqFmtuw44qvL8FyytSa7FwVCXcpYVLTbVH0MnaIkPejWo7wtmZTwzfJqcUV
    spVMK0B2YdXHvOEFBbtpZA3jVLykqgF8pDldElpmeUYuwQs6/+aGTfej1+zJGNWr
    GiV/N1sK+kQLLfF1FUv4OG9GhJeK0E9sGYFq5/uycM43P//bQU5+/jm3riI+VQRa
    4P8AjWncP0aYVCbpo6cFbUODJCxOo4bu1cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524570755; bh=qf2YKU2/fSxGZ3xXP5RfGFXNOz2dcW
    5pnsdIAD47XE8=; b=ltBA7f9H1d+/fu7Y/pca9N5aPJiFRGBxNEjf2dLMqaTmIN
    MotS1OI/xlGp64c0qkmbjUoOj1iAk30cpuphO3a5FT8rBEpgIN+9vNZXZSHKCcSG
    ByTxGdz1qBjPOG3XiiH5ps6VgIgWDdEn7oS3Kw9OztdmNOjUNIQGvZZ49aV2gkXu
    QPzOdwsGW+cTgVZgseK04V/E4Qm/Kecw9q7jyil88ZNepkZvzSo8OmxxzxFbzYU5
    zUvbRanh/ZOsVWWHE2wOU9b3BrDOmcxnISsYw+lszO8W/t+3VbVmCAOcXZ5NWYfT
    p7Ecs61pw9H8El0XztO6tO0bl71imdHnCBm/KJLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCMNsUin9axp0C00+xx+p5kwc9gtrZ6Oc78Z9Yuknv9AtEZ2aSvfUhPyLpXMweb/AHT02GA1tM1xWZckZlL1kecMNTA6fkVatgAYDfXVy9ZMwtIBIRfq
    oAGW0EVayyFGwP3RC/hIaYWH0hIoFTTjK2STaOcRy14xPAf6rYtAeujLfupWHECofGtATLPpEjA1oMh3uVEj5vQH6w6FCu2KSVZFWMG+rrGRMgPcNSaISH2n
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=zu6OG0ZhAAAA:8 a=P-IC7800AAAA:8 a=BI7-smHU6VabblHp8_sA:9 a=CjuIK1q_8ugA:10
    a=14KEWizoL1fqEuARi7UA:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=pAN39diAhXWuPx0-Vjn3:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756483AbeDXLwe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 07:52:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44619 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756235AbeDXLwd (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 07:52:33 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 24 Apr 2018 13:52:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/7] ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2
 regulator voltage
Message-ID: <20180424115221.tlb6r44u2drz7hnn@flea>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="li5y6zrle3355vak"
Content-Disposition: inline
In-Reply-To: <20180424113424.13196-2-wens@csie.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--li5y6zrle3355vak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 07:34:18PM +0800, Chen-Yu Tsai wrote:
> The voltage of the VCC-1V2 regulator on the ALL-H3-CC H3 ver. should be
> 1.2V, not the 3.3V currently defined in the device tree.
>=20
> Fix the voltage in the device tree.
>=20
> Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
> 		      Computer Board ALL-H3-CC H3 ver.")
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--li5y6zrle3355vak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfGnQACgkQ0rTAlCFN
r3SaJxAAimCkIOtOoantuy10iemRZuYJSYGEEpMbY/B+2mnt2SjbFMTOtQWDVR3W
xxJtIScAVd5NrvZevgoovo7LKoSHQwPKWy6gNuKmplZmA9OCYb4q7xR3knObH+vQ
28b7iecf5ZsxoDhop+TwpB0Dscs8MFB/gyriWglLqtGgrQwBHT1pOn9ttuOhase1
VbaIkIiuA8L9DsPubgp7l2xvhr6kDXscog/JSj/MiBK/MMiof8m3CteS0THh6dUG
xRhfxCFiwwZJZkK/Ynmw2Bx3PS1CpDJCZGcVHgJG+TbKBaXtn69Sn3/eSEhHXsUD
+tp7tzlZZZhaY++wkYVkQllY1n2zzxGYYK/tCmEC+JNMj2MBkzaMfmVLA4IN9KtT
UTYtLbnbi8rploxtgQqNRLmBENWS//yID29UC3IULQ9GPQmhSsmbkrCZtN5Ph5P8
n9SFODx5fD1fZxTx/NWZd379O8Jr1WAtDmbKSdgOAJqxC1exndhqiTi7T2+jGURT
8t37+tbP6PiXWrusguhn1zFqEXqOjCi6XabW+unXuPgFXjpjgN/XqoCDEp6rhbd+
fDAMC7H7eOi3OZp5fyZA6acKt2by6dg53ivAOh6vhvH1ir7FBCAD7n1wuq4FLRxC
TLw3LH+yDZYVSpX9i0qER97UDT/xJ1Em5sqeGukQpMxzz5CvdgM=
=Hmfo
-----END PGP SIGNATURE-----

--li5y6zrle3355vak--
