Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeC1EBE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 00:01:04 -0400
Received: from mail.crc.id.au ([203.56.246.92]:60598 "EHLO mail.crc.id.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeC1EBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 00:01:03 -0400
From: Steven Haigh <netwiz@crc.id.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Regression: 4.14.x x86/mm: Encrypt the initrd earlier for BSP microcode update
Date: Wed, 28 Mar 2018 14:54:08 +1100
Message-ID: <13354833.vZGJLXuz6d@wopr.lan.crc.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8142277.D7R0nplBXb"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8142277.D7R0nplBXb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi all,

After the following patch, we are unable to build the 4.14 tree with EL6 -=
=20
which uses gcc 4.4.7

The failure logs are as follows:
BUILDSTDERR: arch/x86/kernel/head64.c: In function 'copy_bootdata':
BUILDSTDERR: ./arch/x86/include/asm/mem_encrypt.h:59: sorry, unimplemented:=
=20
inlining failed in call to 'sme_map_bootdata': function not inlinable
BUILDSTDERR: arch/x86/kernel/head64.c:294: sorry, unimplemented: called fro=
m=20
here
BUILDSTDERR: ./arch/x86/include/asm/mem_encrypt.h:60: sorry, unimplemented:=
=20
inlining failed in call to 'sme_unmap_bootdata': function not inlinable
BUILDSTDERR: arch/x86/kernel/head64.c:310: sorry, unimplemented: called fro=
m=20
here

Patch in question:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/
commit/arch/x86/include/asm/mem_encrypt.h?
h=3Dlinux-4.14.y&id=3De0f82cbde41353ddf63935175583ceb5580cce87

I can confirm that this builds fine with EL7.

=2D-=20
Steven Haigh

=F0=9F=93=A7 netwiz@crc.id.au       =F0=9F=92=BB https://www.crc.id.au
=F0=9F=93=9E +61 (3) 9001 6090    =F0=9F=93=B1 0412 935 897
--nextPart8142277.D7R0nplBXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFHf0gfgNrH6ofcYGQa811Xp9MdwFAlq7EeAACgkQQa811Xp9
MdxlFA//dvFSZTHNxO5DMrnyXYVdFPxjlupiM6q0zZL00QFgi6KVWOU4rh3WfTJl
qOPYRJ0xDqS9n8GJ8ahSkZqCoA3NZfAPzICay5rrPFSp6f5i/XDuJYx12gys3EBh
gnrqLkH2vqB4iWJih2aF/duJxaOZjrywc62cCsCTXSFJ3dtAzqSRG/bTbAH7uw3D
H0t9TFqGU6afHwI6WtoxFVbtrrHbAdYYES2Ov1JsVDEY/ffJ/oU0SFUzPZxCxZDi
R2ktaBppuemwhanggeleVv8nYYoOozUgkOcsWPrdPjOxH+IaY3cskmeQzJbJo1HX
Qa/Ize9yqpBh0mqoHpckOxz6pFkLU9+gQ4cE5RBbh8VnCBE34t+UTtGdvfq8ntKj
u15VbSuIZ++Xw/RWhRgBGGOPMU+g2KZ6xeD01iumHYBn3AFJ4+DwpU/VKyJoUWka
rJ/k8r+4aS23sS6m9/JQgH4ExrKPCpP0Z5d5VRK/7Oh/WBoX0AtsF9sRjkPn7vAk
fTqyZqlqecuNq7Hhx4xRE91u7Jg+9vJ8HAKtZV1I7rKAGOAq9GaMOhBRqzMcsruX
3taMw2woFvHIyi6aywnruHbVxYvbN7rk6uc0R4ZVU2YeSVpZ5+9ZYeOVnK07Q6fT
BEvcRGhjVSxjr32YVaK88dectgfaJXEjekgZNl8aUsafd4/TNCg=
=oDVo
-----END PGP SIGNATURE-----

--nextPart8142277.D7R0nplBXb--
