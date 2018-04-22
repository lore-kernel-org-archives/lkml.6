Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeDVKsV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:48:21 -0400
Received: from mout.web.de ([212.227.15.4]:46975 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeDVKsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:48:19 -0400
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0
Openpgp: preference=signencrypt
Message-ID: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
Date: Sun, 22 Apr 2018 12:47:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XiZTcn02tWew94JAhInbm1kYiOtwVc395"
X-Provags-ID: V03:K1:cqvBZ/07dhlLrDfo9bzOo+pncIIBbHvrqnTLVpwLg8SuphgsgdS
 fif0I+Q4PRZElyVt79Ysypsc7MqvC0pChY36+uqjy9knHJx0HMF5wnBhiVPPO+UQo0kB9n2
 KN7nsEAPk0I3CLTjQo2sXaxNHZUhEapxDiJWrCRw/0ltsKmdUjLuDgwzN3c9E9erwQesAh/
 IwPuMHKqscU7XLdlBoexw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AaM0TqaSO3s=:Y98qZhDk+RShvgeoKqTbSf
 jXcNvuWal60hgw+D45wr7+zMZMvbfJkncrjDtNvpQ8TebWccTHAjpNQx44vjW9Azz+CPNAfJe
 R1qDO6UmJ93hWA/hcOz1tTNqXtq+c5d5uFgKsxHYcJPxEOq4yCloUi5hP5indg6+TSbFyWkwh
 0xap6ntRiqr+faP9mkgfPr8FiR6gySCI789B4bsgN4WvkRtlz0hQ75M2+tS6jqIuz7bfepRNt
 nvJo0TxSHN61U4VgUvx5+fROxx8u63XGNje89u7k/KTU/zYNLufPjUuBPciLvhz1rYttarjdl
 /4uat3OEY476hsoCN2lJJvxjYwVDPJ7UcGMOjB6aoMj1g6BMv17UKfQ+UJdGeRkT1Ekf/pXL3
 iLOIp7pgqhimanUZ+wkj9RSbwwk0kbmU2RfkY5Mhq7TB9W+cp4MFSQuG/j64WQIq5M0yW4lX3
 7KuFN+h6ZJBJbR2ESvnOK71Ycu41i32OqrOQnCDqrQnVMhUlyRA6laPL5+JROEVJmRSOlCv4q
 d1aGchvNafw7fk/lto+x8EFWQ8he+WYnTG/4K3qb9tw1MxuqMlgSY8eSZDF9eeaVCGdk51pyb
 0HF+OWx5WrlZb0bKIaF3J2DVQjbgqTJfNDfQ9aUMHtKG0+ysdHxyiCC/n4feteY76tZD9kO6G
 DZC8u7FXdPInyIMsNK8CY7+q0Tzg7r8auKmbW4gKigcjdKdBKaceYtLLufpSM0BPv4ZqOIvIz
 EbbXpCA9Hp+GPb6EKNhtwMLK7nhlqy5TkgXMrzdCMA+cMUBa6PmEwv3asyLtTD0odejmVbMN2
 O8UhCTDtu7mZMgwUjOd9KTuuO3rJw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XiZTcn02tWew94JAhInbm1kYiOtwVc395
Content-Type: multipart/mixed; boundary="fDpkrILmI58V4gP4C2rN6innfk8vksT4f";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
Subject: BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0

--fDpkrILmI58V4gP4C2rN6innfk8vksT4f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

this can be triggered simply by running

# echo 0 > /sys/devices/system/cpu/cpu3/online
# echo 1 > /sys/devices/system/cpu/cpu3/online

[  455.904854] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  455.906108] BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x=
70/0x1a0
[  455.906668] Read of size 4 at addr ffff200008e3a9d8 by task swapper/3/=
0
[  455.907122]=20
[  455.907647] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.17.0-rc1-00257=
-gbf20b92a3b12 #76
[  455.908158] Hardware name: linux,dummy-virt (DT)
[  455.908802] Call trace:
[  455.909126]  dump_backtrace+0x0/0x230
[  455.909522]  show_stack+0x14/0x20
[  455.909848]  dump_stack+0xa8/0xcc
[  455.910180]  print_address_description+0x13c/0x250
[  455.910576]  kasan_report+0x254/0x328
[  455.910985]  __asan_load4+0x88/0xb0
[  455.911326]  unmap_kernel_at_el0+0x70/0x1a0
[  455.911702]  __verify_local_cpu_caps+0x78/0x178
[  455.912098]  verify_local_cpu_caps+0x4c/0x60
[  455.912509]  check_local_cpu_capabilities+0x64/0x158
[  455.912955]  secondary_start_kernel+0x178/0x260
[  455.913366]=20
[  455.913586] The buggy address belongs to the variable:
[  455.914026]  kpti_safe_list.26846+0x18/0x1460
[  455.914382]=20
[  455.914606] Memory state around the buggy address:
[  455.915349]  ffff200008e3a880: 00 00 00 01 fa fa fa fa 00 00 04 fa fa =
fa fa fa
[  455.915942]  ffff200008e3a900: 03 fa fa fa fa fa fa fa 04 fa fa fa fa =
fa fa fa
[  455.916483] >ffff200008e3a980: 00 00 00 06 fa fa fa fa 00 00 00 fa fa =
fa fa fa
[  455.917077]                                                     ^
[  455.917539]  ffff200008e3aa00: 00 00 00 00 00 00 00 05 fa fa fa fa 00 =
00 00 00
[  455.918055]  ffff200008e3aa80: 00 00 00 00 03 fa fa fa fa fa fa fa 00 =
00 00 00
[  455.918579] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Issue is new with 4.17-rc. Can provide .config if needed. Device was
qemu-system-aarch64.=20

Jan


--fDpkrILmI58V4gP4C2rN6innfk8vksT4f--

--XiZTcn02tWew94JAhInbm1kYiOtwVc395
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlrcaGEACgkQitSsb3rl5xT+dQCggZccd6aJ7hcoZYan3Ij8Ujn5
I5sAnidG5D8wltcyQpn6mO+xzXnpRQNJ
=AybG
-----END PGP SIGNATURE-----

--XiZTcn02tWew94JAhInbm1kYiOtwVc395--
