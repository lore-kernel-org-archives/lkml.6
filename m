Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeBDN60 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 08:58:26 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45450 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 08:58:16 -0500
X-Google-Smtp-Source: AH8x225jyuD/hg3ztWDzsMjj9VrCKQc7oa3xfZqBMi/OVwUtQrzO9d+Va6HMMS39PUcDZNZfAhDGtQ==
Date: Sun, 4 Feb 2018 14:58:12 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Cirque/ALPS touchpad documentation
Message-ID: <20180204135812.5qnwgimcqsdhnkc7@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xkn7ajb7dqqv5jz7"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkn7ajb7dqqv5jz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Now I find on cirque website that there is some documentation for
GlidePoint/ALPS touchpads/trackpads. The most interesting part is
"GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF)" on website:
http://www.cirque.com/gen4-dev-resources

There is basic I2C and HID protocol information with Memory Table
registers in section 7.

Looking at mouse/alps.c and hid/hid-alps.c source code, it seems that
those 0xC2C0 and other "random" numbers have real meaning. And it should
be possible to set more configuration options for ALPS touchpads. There
are some coordinate algorithms or configuration for sample rate, etc.

PS/2 protocol description is completely missing in that documentation,
but e.g. addresses passed to PS/2 function alps_command_mode_read_reg()
perfectly matches addresses in above memory table (e.g. AuxDevicePresent
=3D enable/disable trackstick, etc...).

I have not know that there is released such documentation for ALPS
devices, so I'm sending this email... maybe it can be useful for you
too.

On that page is also documentation with source code examples how to
update firmware in touchpads.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xkn7ajb7dqqv5jz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWncRbAAKCRCL8Mk9A+RD
UtOqAJ9kAsuVIp3bq+qBF0NZWfzPM3IdnQCgtggUD0jNB9Q38l1viqMvbmcQ/1k=
=Rrok
-----END PGP SIGNATURE-----

--xkn7ajb7dqqv5jz7--
