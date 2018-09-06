Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A04C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB13520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB13520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeIFX2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:28:53 -0400
Received: from sauhun.de ([88.99.104.3]:48286 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbeIFX2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:28:52 -0400
Received: from localhost (i577A6E95.versanet.de [87.122.110.149])
        by pokefinder.org (Postfix) with ESMTPSA id A3A612C058F;
        Thu,  6 Sep 2018 20:52:03 +0200 (CEST)
Date:   Thu, 6 Sep 2018 20:52:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-i2c@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Message-ID: <20180906185201.GG8607@kunai>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Disable interrupts while configuring the transfer and enable them back.
>=20
> We have below as the programming sequence
> 1. start and slave address
> 2. byte count and stop
>=20
> In some customer platform there was a lot of interrupts between 1 and 2
> and after slave address (around 7 clock cyles) if 2 is not executed
> then the transaction is nacked.
>=20
> To fix this case make the 2 writes atomic.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Added a newline for better readability, added the stable tag and applied
to for-current, thanks!

BTW we have no maintainer for this driver. Would you or Michal be
interested in doing that? I don't maintain the whole driver directory
anymore.


--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRd1EACgkQFA3kzBSg
KbaGUA//Y1TH+XzL0PJFUgv/9hLCeDYMrhwdpW1ah6Vx6hwCMkMLEX11xtIMQvQe
Q7+Iyj5s7wuWXX3bDrtzMRT4OnSuvu9MYNsHlsCMM2I9SQD+EOC7WudXw1DJu7WA
EL++/74DmSWhCRTCBkBgOtWgTzM+a/bUPkg2d8qFna6/DC8J9I3dTQf/vhtH4jXB
6GIV4ePOrj7p3GqI46fI5bwOUbEoJHahOBfXBmvaQ5RQomdSmT6LKjsJyrZXNXtK
EE+YbLIg16KcDDTZ9aw0/kDhmMlHNs6LDv6LfLuz+piFDQdE2GhPIJDmf5erj5js
mHhSuzXiXh6NFY3fsbG65nZ1Rk3Mm167NBr1RiZ8bZ60yqMHbC4gFg/J04KJghzg
N/TvRzpCXQHNo5eNQCsaW+IA5n6dtP9OyoXZusP9XPuzpHzrc/0tHrf26vVS7s1q
vtiTNfdqmfyXVFZzuFvvo4EwJnC1qRlE96eoHEC/1i+BQnWGacyrouFRBRO3H0eq
ZJAsG6+lc77pmrspFbDlFB5fAu4/jFdYhpWKE7+pCqoePDZoe6mFxuLe8vEGaREC
fLz/uEdy4nz3QIjuvew9WqUskwzKgP+6D8M8wZKOV/bduy5FOn08Pl5A73uZzG9J
CNXVvcjmCz31mJUgFqUTdk97EkbsUFcK06OnJx91fCMOLlfI1wc=
=XF2e
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
