Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0621C218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbeLTTGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:06:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeLTTGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:06:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65B00B0B1;
        Thu, 20 Dec 2018 19:06:48 +0000 (UTC)
Message-ID: <3df5afdfe9fe709fad1a4ae565692028c437beed.camel@suse.de>
Subject: Re: [PATCH v2] drm/panel: rpi-touchscreen: Add backlight support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Gordon Hollingworth <gordon@raspberrypi.org>,
        Eric Anholt <eric@anholt.net>
Cc:     David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>, afaerber@suse.de,
        agraf@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        stefan.wahren@i2se.com
Date:   Thu, 20 Dec 2018 20:06:45 +0100
In-Reply-To: <CAPLZx4kd9RZtUKySDhk9RHOWPL2P=GG_g0GP3NweZ-UR-a3MSQ@mail.gmail.com>
References: <20181219112033.31064-1-nsaenzjulienne@suse.de>
         <87tvj8dp60.fsf@anholt.net>
         <CAPLZx4kd9RZtUKySDhk9RHOWPL2P=GG_g0GP3NweZ-UR-a3MSQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-B5ikKgrafLfFK2k6vz3c"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B5ikKgrafLfFK2k6vz3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-12-20 at 18:36 +0000, Gordon Hollingworth wrote:
> Assuming this is using the firmware interface then yes it's fine.  If
> it is using the i2c directly then it's possible to clash with the GPU
> driving the camera

Well we're already in such a situation without this patch, as the panel
enables the back-light though the I2C lines. This is only enabled by an
overlay, it's left to the user's discretion.

As commented previously by Alex Graf and given the constraints, I think
that it would make sense to start considering both options as good
(using FW & direct I2C access). We are defaulting to the FW based one,
but providing support/overlays for the direct access doesn't seem a bad
compromise to me.

I do understand Gordon's concerns. Maybe it would be nice for the
firmware to detect device tree nodes accessing I2C0 and disable the
camera. Or providing a FW configuration option.

Kind regards,
Nicolas

--=-B5ikKgrafLfFK2k6vz3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwb6EUACgkQlfZmHno8
x/5Hkwf/Q+Uam+zGriPGsJ6mIYD6ttPC1liJQE2TtQboC077phvwpVKikG26cNtX
riRdFVJpNNHg69c1OBR7OZ1Jhrm4ck32Xop13iO/fmr0rdaQARTpv6Jd6fDcqSqG
lfgQA4tWsudvGGWw/QpFKqxfRhUCw7ieB/bhYYjHWzajEYBzPQcpVhwF8CFQJKNY
QureELDGGj0OmuI3Xn4UUWRjq9lrqvehazz28ud8E4Ane0azAlNGeumrAHuXT3g5
Uc/hULeXl3pwaFa/y73jPWH80MK4/CPg3kBnwZPtC/7JCzfcruTFLnUhYoIGbJBI
Ksf2XguMb48R9Ri+aB4ekNxscgpGIQ==
=kwGm
-----END PGP SIGNATURE-----

--=-B5ikKgrafLfFK2k6vz3c--

