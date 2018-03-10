Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeCJKki (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 05:40:38 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50709 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeCJKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 05:40:36 -0500
X-Google-Smtp-Source: AG47ELtohmehSFJ/t/G634jqnEI6zOx/5tgLzIIvFSdWP/Jciny8FNmwgih0KuNG0UvZSkcH6lvYLQ==
Date: Sat, 10 Mar 2018 11:40:33 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, mjg59@srcf.ucam.org,
        dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180310104033.ndmlwt4evbs6xg5u@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <20180310065039.GA6633@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7lb3d2knnhwyrstn"
Content-Disposition: inline
In-Reply-To: <20180310065039.GA6633@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7lb3d2knnhwyrstn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 10 March 2018 07:50:39 Lukas Wunner wrote:
> Pretty much all modern Nvidia GPUs do have an integrated HDA
> controller, however it's possible to hide it by clearing a bit
> at offset 0x488 in the GPU's config space.  Some BIOSes hide
> the HDA if no external display is attached.
>=20
> I could imagine that the BIOS of the Dell machines in question
> hides the HDA if Switchable Graphics is enabled.  If that is the
> case, be aware that there's an ongoing discussion to always expose
> the HDA controller because the behavior of some BIOSes to only
> expose the HDA when a display is attached causes massive problems
> with Linux' HDA driver:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D75985
>=20
> If we decide to always expose the HDA controller on Nvidia cards,
> you may need to also match for the Nvidia vendor ID here.

This is probably the example of reason why current solution based on
vendor id is fragile and could be broken in future... if such changes to
unhide devices are going to be implemented.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7lb3d2knnhwyrstn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqO2HQAKCRCL8Mk9A+RD
UnA+AKCMayrsTj+qiYSGDWAb1DTH+TudoQCeOYtBDhTFqf8RbCuyprC4YVm/RVg=
=CueD
-----END PGP SIGNATURE-----

--7lb3d2knnhwyrstn--
