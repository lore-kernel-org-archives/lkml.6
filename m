Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933063AbeCJNPm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:15:42 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52407 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932854AbeCJNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:15:40 -0500
X-Google-Smtp-Source: AG47ELsoQug4PHhgQFD7qg25zPWzFQWkjMn1ccsQbiJQoHjDNntUlUpKNVv5NkKnUPWWzyL6sAc2Hg==
Reply-To: monstr@monstr.eu
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
To: Rob Herring <robh@kernel.org>,
        "Alvaro G. M." <alvaro.gamez@hazent.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <ac91e42c-87fa-bdee-5dd1-640802a06e91@monstr.eu>
Date: Sat, 10 Mar 2018 14:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mblUGwnFd7TPUqHJntuZuAgBqiCBjBIst"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mblUGwnFd7TPUqHJntuZuAgBqiCBjBIst
Content-Type: multipart/mixed; boundary="tqB2F5M1vcoa0FG2A4OYvDOXdDyF4bNS6";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>, "Alvaro G. M." <alvaro.gamez@hazent.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <ac91e42c-87fa-bdee-5dd1-640802a06e91@monstr.eu>
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
In-Reply-To: <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>

--tqB2F5M1vcoa0FG2A4OYvDOXdDyF4bNS6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9.3.2018 20:05, Rob Herring wrote:
> On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.com> =
wrote:
>> Hi,
>>
>> I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d38=
b
>> makes microblaze unbootable.
>>
>> I'm sorry I can't provide any console output, as nothing appears at al=
l,
>> even when setting earlyprintk (or at least I wasn't able to get anythi=
ng
>> back!).
>=20
> Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
> memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
> !CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem and
> it can be removed, but I'm still investigating. Can you try out this
> branch[1].
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> microblaze-fixes
>=20

Let me take a look at it on Monday with the rest of patches sent by you.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--tqB2F5M1vcoa0FG2A4OYvDOXdDyF4bNS6--

--mblUGwnFd7TPUqHJntuZuAgBqiCBjBIst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqj2nUACgkQykllyylKDCGbVwCgj9qGosojfZnw46xvHr/phNxa
uL8An0/fXnWk5cdyc860tLw0ij7hCJg3
=LhRy
-----END PGP SIGNATURE-----

--mblUGwnFd7TPUqHJntuZuAgBqiCBjBIst--
