Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeDYJtF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:49:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:46815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbeDYJtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:49:01 -0400
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: ridiculously slow VM memory performance on Ryzen CPU
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
Date: Wed, 25 Apr 2018 17:48:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq"
X-Provags-ID: V03:K1:UyY6a5S9qXv8HeJ96ICEk2ZM7iaCKQNjT1U6c43uRRwwKjCesX2
 RkJ2gX6uXIi01aG7ZXo6j+XMVqbRaEtIxJUV00EtcEs9kDLWtJZDfEEBs4z3ry/ihgFS5fM
 hsYDnc1UFfwQLyRyiG5sxDM8mGBj5K02+BP3VAuC8/Id/ZV80IU0P0cipRBZ5yM7ZpoF9h2
 V/snDSKdC076q81ERBgdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a6WgYp3FQTA=:l3dqH47bzT5ZcrlCfK/4Lt
 xY0r4KJa9hx63H2x8SD/U9eqKE7L7eL2rA7k+kd5jYnBqfdddQSBHI04mDGHbl64g+wc2R5Cy
 RnbHr2naRnxmobBFR8GfN3Y/cNx2meFF1lkMp/fmFXlmtdOQ3WFZIwIROYhRMO0uAVTgR28+W
 ijS5vDC/JZv0J6XRZKOLaSkaVHrb3Iq7mZbJVz8u7RYe50QOYvNhYHfdkL22yJvcBrWCPvM6j
 OkvmXUD1Cqce+urL0QAzqc4qa87IYgne8jLjfMPJ/4K5PByUtHc8UaIuBmhOtolV7a6k8NTGm
 QjLkIZf1MjansHcLhTjnpxFiW4yJnFDSzdv9Bjhjlec1GDKJGft0kEDqLFTKEum1nnQiz63Z4
 Lx7mFkTWsbaxG4l0PvYHHdbJQX8+O2SRNGXHfsUVZcmxpv8Laql6kqTRqdpUlXVK8l1TpweH8
 RLfjFCfdinUcMzI/r7QF6RsQj/BtGy6oNHGzbqm83FhChViNjv/XZMBDDEm6v0CbdhCA4Y1pm
 UtLFnkyuHOE7nOxJPMho1d3FcZBofwfSsOZU1AM3wJe0qoIph4Fui3X9gcQWpFHd9uoKIaKBC
 gO59f6GTIei1kZpkxsexPRoaYvvRmUJ7B425Ahh6QN9KDgjXe3GVinjcqGYeNuuwQWproFkeY
 IqTTD/Xfpo184NN3eyky4AZYzX3nh5g4kNdmN5Pu0IG5ElA1BGi/sdNgylXMmKRA26rjt54QK
 z0265hxAS11vN1apf6VswIyU1ar4Nn5Stp+xuNXQ+EPQy3gym6ViYzZE6nq21bbxf1X7SFNQf
 WiaRCUMXe+SflT1Ii3iONfgd/0MgA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq
Content-Type: multipart/mixed; boundary="ewIvWyEpQ5cyPhrj7WR4uKUJBwPZMfZG0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
Subject: ridiculously slow VM memory performance on Ryzen CPU

--ewIvWyEpQ5cyPhrj7WR4uKUJBwPZMfZG0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

When testing IO heavy work on my VM backed by Ryzen 1700 CPU, I turned
to brd modules, but surprisingly, the speed is even slower than some HDD:=


---
$ sudo modprobe brd rd_nr=3D1 rd_size=3D1048576
$ dd if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.9928 s, 107 MB/s
---
107MB is pretty lame...
Even some HDD could be faster than this.

On host, it's much better:
---
$ if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.754641 s, 1.4 GB/s
---

For host hardware:
CPU: Ryzen 1700 All cores @ 3.8G
Mem: DDR4 2400 dual channel (8G x 2)

For host software:
Kernel:       4.16.3-1-ARCH
Qemu:         2.11.1-2
Distribution: Archlinux

VM setup is mostly default setup done by libvirt.

I'm not sure if this is related to this bug:
https://www.redhat.com/archives/vfio-users/2017-April/msg00019.html

Thanks,
Qu


--ewIvWyEpQ5cyPhrj7WR4uKUJBwPZMfZG0--

--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlrgTvoACgkQwj2R86El
/qhsqQgAlHEgMh4WOzZhYL464zlCGeiEJxoulYvJCPQ0MyVHcUQUXizevvAJUE95
62+mmJTHzGS6Leeh/alfDbrES8aevE3R0ewNrFGxcPBNwgjbVZoAaA5hRfAW+fsb
HzcjUmiS4dheLjk3LppCWcb7VQehY0L8lxZ93BwzCC9mXztEUnLhnG0p+hJ5dZX/
/000A22OvOcv04BRnjRo+OVjXTJrDY+5192Psd1u1ZEBQEG/tNPAJg4TG+CY9FIz
W5B3JD8h2UCS0GOnvA+z2yyIL+5cR06dGOhfaxc31WmSYmsASDNEqfnmjsvic1KO
dzRWBHFwHQmsKC8nR8ukzVlnawmSUQ==
=Osjm
-----END PGP SIGNATURE-----

--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq--
