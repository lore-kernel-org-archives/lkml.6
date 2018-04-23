Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754977AbeDWK6q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:58:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44740 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754792AbeDWKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:27 -0400
X-Google-Smtp-Source: AIpwx4/v6CH+nr3mKLZkqvJiIXo28If1jMRGnn2iExFnzmtmve2NVOziB3gbC7+BrUgGKooXV8oJUw==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 2/3] microblaze: remove redundant early_printk support
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180328020700.17050-1-robh@kernel.org>
 <20180328020700.17050-3-robh@kernel.org>
 <584d5be2-6961-5f65-d0d7-bc4661aa21f0@xilinx.com>
 <CAL_Jsq+yEfWZkwWAWKeDuFjxaaZO0uec6eqaq7UNOF-oY30ZuQ@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Message-ID: <71dfbcd9-501c-631f-76a3-53d7265d9321@monstr.eu>
Date: Mon, 23 Apr 2018 12:50:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+yEfWZkwWAWKeDuFjxaaZO0uec6eqaq7UNOF-oY30ZuQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="YTLizl6FzbBZth1fY9aR62vNtjxVLuDhS"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YTLizl6FzbBZth1fY9aR62vNtjxVLuDhS
Content-Type: multipart/mixed; boundary="R6lnnvjbszCRTdzewUUt4qRdkcIEkDqpZ";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <71dfbcd9-501c-631f-76a3-53d7265d9321@monstr.eu>
Subject: Re: [PATCH v2 2/3] microblaze: remove redundant early_printk support
References: <20180328020700.17050-1-robh@kernel.org>
 <20180328020700.17050-3-robh@kernel.org>
 <584d5be2-6961-5f65-d0d7-bc4661aa21f0@xilinx.com>
 <CAL_Jsq+yEfWZkwWAWKeDuFjxaaZO0uec6eqaq7UNOF-oY30ZuQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+yEfWZkwWAWKeDuFjxaaZO0uec6eqaq7UNOF-oY30ZuQ@mail.gmail.com>

--R6lnnvjbszCRTdzewUUt4qRdkcIEkDqpZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.4.2018 16:11, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 8:44 AM, Michal Simek <michal.simek@xilinx.com>=
 wrote:
>> Hi Rob,
>>
>> On 28.3.2018 04:06, Rob Herring wrote:
>>> With earlycon support now enabled, the arch specific early_printk sup=
port
>>> can be removed.
>>
>> earlycon is not the full replacement of early_printk support as is
>> designed right now.
>> Definitely current early_printk is pretty old and contains code
>> duplication but it starts much earlier then earlycon.
>=20
> Yes, essentially it's after MMU enabling rather than before. But it is
> still before any h/w specific setup (dependent on the DT) which is
> where one would typically fail to boot. Generally, I've found before
> DT unflattening to be early enough. What can go wrong at this early
> stage? Memory is flaky or you've passed in bad memory ranges or image
> locations. An earlier console may or may not help there and those
> problems are easier to debug in the bootloader.
>=20
> So it is a question of what you want to maintain.
>=20
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Michal Simek <monstr@monstr.eu>
>>> ---
>>> v2:
>>> - Fix booting. The setup_memory call needed to be before the
>>>   parse_early_param call.
>>
>> What's the reason for calling setup_memory before parse_early_param?
>> Is there any dependency?
>=20
> Yes, either fixmap or ioremap (in your case) has to be functional when
> earlycon is setup which happens via parse_early_param.

Ok. Let's add it and see if there is any issue. Do you have any code
which depends on this series?

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--R6lnnvjbszCRTdzewUUt4qRdkcIEkDqpZ--

--YTLizl6FzbBZth1fY9aR62vNtjxVLuDhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrdumsACgkQykllyylKDCFyJACfUpevq9xlPQ2HeQtztZZL8arc
7b4AnRZodc3KjXjvwekJ1e6NrD6/306E
=mIGA
-----END PGP SIGNATURE-----

--YTLizl6FzbBZth1fY9aR62vNtjxVLuDhS--
