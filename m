Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A088248F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A088248F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeGBSQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:16:46 -0400
Received: from sauhun.de ([88.99.104.3]:43920 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbeGBSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:16:44 -0400
Received: from localhost (p54B33579.dip0.t-ipconnect.de [84.179.53.121])
        by pokefinder.org (Postfix) with ESMTPSA id C0C2456A485;
        Mon,  2 Jul 2018 20:16:42 +0200 (CEST)
Date:   Mon, 2 Jul 2018 20:16:42 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 7/7] i2c: fsi: Add bus recovery
Message-ID: <20180702181642.aa6yjecsavv47zd6@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
 <c9d0b0c8-268f-04af-7c43-6fec0e272a9d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u2q4ccg7tyhlb6wv"
Content-Disposition: inline
In-Reply-To: <c9d0b0c8-268f-04af-7c43-6fec0e272a9d@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u2q4ccg7tyhlb6wv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This all won't have any effect since you never call i2c_recover_bus
> > which calls back into i2c_bus_recovery_info callbacks.
>=20
> Ah, I thought there would be some use of this in the core or in client
> drivers, or some ioctl interface. Would there be any outside users of the=
se
> callbacks in the future?

No. i2c_recover_bus() is only to recover from stalled SDA and the only
place where this can be detected is inside the I2C master driver. It is
not an event which can be controlled by a user.


--u2q4ccg7tyhlb6wv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls6bAoACgkQFA3kzBSg
KbbXnA//eo8DSb11K6+Z925m4DH1eqinQ+inYTF94j3RBKFDHHFqB4AEvrSKzPzP
PIE2v6AnNs02djJE54McVadbWHF65ya9Esbi5t9JgniaXbIPZOQyIV25JNfOfZTG
AGLY/NKWV96RmQKTXCmDM+YY1C5GdSgeGIlVsBcfovu0QXMMAXMQsYQpAmP7FbG4
AJwQKyGSJJO4fSIf32MJ/iSo7PwshHe2zD0X8zrsQa2EQeZT9k2Y/jtyNAZJ4ale
Zzjrx5WyRaItUw/MKtaBMGNY0HlTrY3DX3dWuMSQZPnSFiTzjCQnJ8q/4w7N+xTM
1dfQoFkLqm36TNvco8nJ4cLQv/zOdwYyVf2D9+VveMiXkmNp2XBYGnyo5x5rRRON
m6p1FG86wGD9V/sQqREcDwbzr5El5UWGYnULVR45GnC/+VcLtGKGfoliQy+obBJ7
ZjKdMUiPPVuWhaUJ7Ms+dtbZKeLLjEmEc+eUmKVYXXnj2KIxWbsbOnEN5Cly1giv
pMqVoeQAT3HQshcuMlIJ3g8BKfX8GsQ+O85nR1oBQyAkafQtXJKkmoi4nw9BfGjF
TiNVz0KIsRypYoNzu79BNx6t44rmo+e+ZNrKn7+ReSFaZjQwpkhz9ATFAzBmBOUC
siQVAq3S3chZ7ATsGkAgLW0XN9znYZKVuUix8Snm5++xv//u/eY=
=llkO
-----END PGP SIGNATURE-----

--u2q4ccg7tyhlb6wv--
