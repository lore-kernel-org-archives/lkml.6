Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeDCTUm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:20:42 -0400
Received: from orion.archlinux.org ([88.198.91.70]:39318 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDCTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:20:41 -0400
X-Spam-BL-Results: 
Date: Tue, 3 Apr 2018 21:13:26 +0200
From: Andreas Radke <andyrtr@archlinux.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        benjamin.tissoires@redhat.com, aduggan@synaptics.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Message-ID: <20180403211326.4907f1bc@laptop64.home>
In-Reply-To: <20180402123435.5587-1-jandryuk@gmail.com>
References: <20180402122536.5083-1-jandryuk@gmail.com>
        <20180402123435.5587-1-jandryuk@gmail.com>
Organization: ArchLinux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XkH6mZ7UDh1Kx7tGm5D5AYv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XkH6mZ7UDh1Kx7tGm5D5AYv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon,  2 Apr 2018 08:34:35 -0400
schrieb Jason Andryuk <jandryuk@gmail.com>:

> The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
> hangs while plugged in if Linux enables the Host Notify features of
> i2c-i801.  The cold boot hang depends on how the system boots.  It
> does not hang on UEFI Grub text boot or legacy Grub text boot.  But
> it does hang on legacy Grub graphical boot and Intel Boot Agent PXE
> text boot. Booting unplugged is not affected.
>=20
> Disabling the Host Notify feature with disable_feature=3D0x20 works
> around the bug, so automatically do so based on DMI information.
>=20
> More information can be found here:
> https://www.spinics.net/lists/linux-i2c/msg33938.html

I'm faced with similar cold boot issues on my HP ProBook 430 G4 model.
Trying your hint with adding=20
"options i2c_i801 disable_features=3D0x20"
to /etc/modprobe.d/i2c_i801.conf doesn't seem to solve it for me.

root@laptop64:/root # systool -v -m
i2c_i801 Module =3D "i2c_i801"

  Attributes:
    coresize            =3D "28672"
    initsize            =3D "0"
    initstate           =3D "live"
    refcnt              =3D "0"
    srcversion          =3D "A40BF457CFB8C7887EB2045"
    taint               =3D ""
    uevent              =3D <store method only>

  Parameters:
    disable_features    =3D "32"

  Sections:
    .bss                =3D "0xffffffffc0801800"
    .data               =3D "0xffffffffc0801120"
    .exit.text          =3D "0xffffffffc07fe463"
    .gnu.linkonce.this_module=3D "0xffffffffc08014c0"
    .init.text          =3D "0xffffffffc070b000"
    .note.gnu.build-id  =3D "0xffffffffc07ff000"
    .orc_unwind         =3D "0xffffffffc0800140"
    .orc_unwind_ip      =3D "0xffffffffc07ffe38"
    .parainstructions   =3D "0xffffffffc07ff548"
    .rodata.str1.1      =3D "0xffffffffc07ff284"
    .rodata.str1.8      =3D "0xffffffffc07ff028"
    .rodata             =3D "0xffffffffc07ff560"
    .smp_locks          =3D "0xffffffffc07ff280"
    .strtab             =3D "0xffffffffc070d350"
    .symtab             =3D "0xffffffffc070c000"
    .text               =3D "0xffffffffc07fc000"
    __jump_table        =3D "0xffffffffc0801000"
    __mcount_loc        =3D "0xffffffffc08005d0"
    __param             =3D "0xffffffffc07ffe10"
    __verbose           =3D "0xffffffffc0801220"

My system boots legacy grub in text mode (KMS) and seems to keep hanging
even with that option set.

Do you have any further idea?

-Andy
Arch linux

--Sig_/XkH6mZ7UDh1Kx7tGm5D5AYv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAlrD0lYACgkQlGV6sg8q
CSunBgf9G0ZF5xVjIXBZjMfIMKUqK+VLld0BTZno+Jzap92K2pKItGP6iuXi1u//
zTtFGUIF4NckPL3ZeumR9DPtash1O2LC+h13BEPnN/8lH7kNfqWSYvysKeUiOMeY
FQn+fu/SktwxRK9SCE+5hY1a6lb1/qc+paSLTKs82dBRBz0ObvFPWpO/P2rU9rYD
W9hZpa8w2E6nsXeADHepk4PtW4Tl4rnje8qdKScxChUBH7tGDNCmUDjSaI+93pZw
8gaddKvh9y17R8bHWmIM2RLLaA0aGY+HUK/bVwgJBy34kGbp2gELLsQVyXn/KDaG
RLfRpqw8SdXMUCJHxZRAp8wUkwmN1g==
=v6cn
-----END PGP SIGNATURE-----

--Sig_/XkH6mZ7UDh1Kx7tGm5D5AYv--
