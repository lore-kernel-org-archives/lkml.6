Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeCPSCn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:02:43 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38230 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeCPSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:02:42 -0400
X-Google-Smtp-Source: AG47ELsVu7SiSdDQ87ykLtCWodFAMtPHDte+jVLb9e/4K3iVXRPA74QJmrQqFAths+u/69tHB22U/g==
Reply-To: monstr@monstr.eu
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
To: Rob Herring <robh@kernel.org>
Cc: "Alvaro G. M." <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
 <20180312075252.GA15895@salem.gmr.ssr.upm.es>
 <242c2823-258b-d3bb-cd0a-e4eee6b979c6@monstr.eu>
 <4d5dc903-0e88-e1b9-9761-43a84865c45b@monstr.eu>
 <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <c46e343b-ad1e-b2f3-b1da-3f17e7b47845@monstr.eu>
Date: Fri, 16 Mar 2018 19:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KiKbsc5sA1WdcQw0KLwjVYMmOZ0otTgKu"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KiKbsc5sA1WdcQw0KLwjVYMmOZ0otTgKu
Content-Type: multipart/mixed; boundary="JEmNhZhh2duBwoAKSOm0HiQhAOuQvPqkn";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>
Cc: "Alvaro G. M." <alvaro.gamez@hazent.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <c46e343b-ad1e-b2f3-b1da-3f17e7b47845@monstr.eu>
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
 <20180312075252.GA15895@salem.gmr.ssr.upm.es>
 <242c2823-258b-d3bb-cd0a-e4eee6b979c6@monstr.eu>
 <4d5dc903-0e88-e1b9-9761-43a84865c45b@monstr.eu>
 <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>
In-Reply-To: <CAL_JsqLY5+Za_TjxyoH_ozoi8S-6L47eZ94W8qdV9DsO4HLXHw@mail.gmail.com>

--JEmNhZhh2duBwoAKSOm0HiQhAOuQvPqkn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.3.2018 16:18, Rob Herring wrote:
> On Wed, Mar 14, 2018 at 10:04 AM, Michal Simek <monstr@monstr.eu> wrote=
:
>> On 12.3.2018 11:21, Michal Simek wrote:
>>> On 12.3.2018 08:52, Alvaro G. M. wrote:
>>>> On Fri, Mar 09, 2018 at 01:05:11PM -0600, Rob Herring wrote:
>>>>> On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.c=
om> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c0=
9d38b
>>>>>> makes microblaze unbootable.
>>>>>>
>>>>>> I'm sorry I can't provide any console output, as nothing appears a=
t all,
>>>>>> even when setting earlyprintk (or at least I wasn't able to get an=
ything
>>>>>> back!).
>>>>>
>>>>> Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
>>>>> memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
>>>>> !CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem =
and
>>>>> it can be removed, but I'm still investigating. Can you try out thi=
s
>>>>> branch[1].
>>>>>
>>>>> Rob
>>>>>
>>>>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>>>>> microblaze-fixes
>>>>
>>>> Hi, Rob!
>>>>
>>>> This branch does indeed solve the issue. My microblaze system is now=

>>>> booting as it did before, and everything seems normal now. Thanks!
>>>>
>>>> Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
>>>>
>>>
>>> I have tested it and I can also confirm that your two patches are fix=
ing
>>> issue with
>>>
>>> 809d0e2c: 00240034 26000000 746f6f62 206d656d    4.$....&bootmem
>>> 809d0e3c: 6f6c6c61 666f2063 33353220 62203830    alloc of 25308 b
>>> 809d0e4c: 73657479 69616620 2164656c 00000000    ytes failed!....
>>> 809d0e5c: 00000000 0029003c 06000000 6e72654b    ....<.).....Kern
>>> 809d0e6c: 70206c65 63696e61 6e202d20 7320746f    el panic - not s
>>>
>>> Can you please update that second commit with reasonable description =
and
>>> send it out? I will take it via my tree and will send pull request to=
 Linus.
>>>
>>
>> I couldn't wait to fix current issue till 4.16 is done that's why I ha=
ve
>> sent that patches with updated commit message to lkml.
>=20
> Thanks for writing my commit msg. :) I got distracted looking at
> whether other arches got broken too and didn't get this sent out.
>=20
> BTW, there is a more simple fix of just moving setup_memory() call to
> before unflattening if you prefer for 4.16.

I have sent pull request to Linus with your two patches and a lot of
architectures is setting this up that's why not a problem. I need to
also look at the rest of your patches and how in-kernel dtb is handled
because there is a size limit which was fine for years but we have
reached the case that it is not enough. Simple extension is easy but not
generic solution.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--JEmNhZhh2duBwoAKSOm0HiQhAOuQvPqkn--

--KiKbsc5sA1WdcQw0KLwjVYMmOZ0otTgKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqsBroACgkQykllyylKDCHWWACeJzvB8l9G5rRkuH+/eRJE2Wjv
dBsAoI+5yULw7/Jaqd83js70Y72PtuWm
=XjM6
-----END PGP SIGNATURE-----

--KiKbsc5sA1WdcQw0KLwjVYMmOZ0otTgKu--
