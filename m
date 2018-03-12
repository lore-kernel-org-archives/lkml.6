Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeCLKWE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:22:04 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35417 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeCLKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:22:02 -0400
X-Google-Smtp-Source: AG47ELs/v9NN2As5364JxTqzQz9McWlMIQ02ZE+BH4oIvbzjQeAv5ymNPx1hoCVWJ4NwUBbJs/JodA==
Reply-To: monstr@monstr.eu
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
To: "Alvaro G. M." <alvaro.gamez@hazent.com>,
        Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
 <20180312075252.GA15895@salem.gmr.ssr.upm.es>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <242c2823-258b-d3bb-cd0a-e4eee6b979c6@monstr.eu>
Date: Mon, 12 Mar 2018 11:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312075252.GA15895@salem.gmr.ssr.upm.es>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qs5TyyfJsgZ0V8t5661EJRg3kr8vPLGLp"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qs5TyyfJsgZ0V8t5661EJRg3kr8vPLGLp
Content-Type: multipart/mixed; boundary="fyIaaO2IWtkt217vS6I1OxN265do5Dq3n";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: "Alvaro G. M." <alvaro.gamez@hazent.com>, Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <242c2823-258b-d3bb-cd0a-e4eee6b979c6@monstr.eu>
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
 <20180312075252.GA15895@salem.gmr.ssr.upm.es>
In-Reply-To: <20180312075252.GA15895@salem.gmr.ssr.upm.es>

--fyIaaO2IWtkt217vS6I1OxN265do5Dq3n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.3.2018 08:52, Alvaro G. M. wrote:
> On Fri, Mar 09, 2018 at 01:05:11PM -0600, Rob Herring wrote:
>> On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.com>=
 wrote:
>>> Hi,
>>>
>>> I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d3=
8b
>>> makes microblaze unbootable.
>>>
>>> I'm sorry I can't provide any console output, as nothing appears at a=
ll,
>>> even when setting earlyprintk (or at least I wasn't able to get anyth=
ing
>>> back!).
>>
>> Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
>> memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
>> !CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem and=

>> it can be removed, but I'm still investigating. Can you try out this
>> branch[1].
>>
>> Rob
>>
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>> microblaze-fixes
>=20
> Hi, Rob!
>=20
> This branch does indeed solve the issue. My microblaze system is now
> booting as it did before, and everything seems normal now. Thanks!
>=20
> Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
>=20

I have tested it and I can also confirm that your two patches are fixing
issue with

809d0e2c: 00240034 26000000 746f6f62 206d656d    4.$....&bootmem
809d0e3c: 6f6c6c61 666f2063 33353220 62203830    alloc of 25308 b
809d0e4c: 73657479 69616620 2164656c 00000000    ytes failed!....
809d0e5c: 00000000 0029003c 06000000 6e72654b    ....<.).....Kern
809d0e6c: 70206c65 63696e61 6e202d20 7320746f    el panic - not s

Can you please update that second commit with reasonable description and
send it out? I will take it via my tree and will send pull request to Lin=
us.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--fyIaaO2IWtkt217vS6I1OxN265do5Dq3n--

--qs5TyyfJsgZ0V8t5661EJRg3kr8vPLGLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqmVMIACgkQykllyylKDCGXSgCeMZt2C0qmf47qQYyAE1cQXSVn
jGUAoIErefelcRo9pgDnx3PMih0mh19n
=JP6G
-----END PGP SIGNATURE-----

--qs5TyyfJsgZ0V8t5661EJRg3kr8vPLGLp--
