Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26F921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391138AbfAKOj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:48262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391114AbfAKOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A79BAC3E;
        Fri, 11 Jan 2019 14:39:51 +0000 (UTC)
Subject: Re: [LKP] [btrfs] 05a37c4860:
 kmsg.BTRFS_error(device_vdd):failed_to_verify_dev_extents_against_chunks
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <DSterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190111140312.GM17624@shao2-debian>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <819023c9-a7f1-44be-6e8d-5525eb6b0fc9@suse.de>
Date:   Fri, 11 Jan 2019 22:39:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111140312.GM17624@shao2-debian>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AlwrSencIS4xsVob8GngbboZs0w5LhynF"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AlwrSencIS4xsVob8GngbboZs0w5LhynF
Content-Type: multipart/mixed; boundary="V0kVSH4sMKZOqFeUohECgFWz1p3SG8iuP";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: kernel test robot <rong.a.chen@intel.com>
Cc: lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
 David Sterba <DSterba@suse.com>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <819023c9-a7f1-44be-6e8d-5525eb6b0fc9@suse.de>
Subject: Re: [LKP] [btrfs] 05a37c4860:
 kmsg.BTRFS_error(device_vdd):failed_to_verify_dev_extents_against_chunks
References: <20190111140312.GM17624@shao2-debian>
In-Reply-To: <20190111140312.GM17624@shao2-debian>

--V0kVSH4sMKZOqFeUohECgFWz1p3SG8iuP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/11 =E4=B8=8B=E5=8D=8810:03, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 05a37c48604c19b50873fd9663f9140c150469d1 ("btrfs: volumes: Make=
 sure no dev extent is beyond device boundary")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> in testcase: xfstests
> with following parameters:
>=20
> 	disk: 6HDD
> 	fs: btrfs
> 	test: btrfs-group1
>=20
> test-description: xfstests is a regression test suite for xfs and other=
 files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>=20
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 4G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):

For the LKP tests, would you please not bind all fstests test cases into
one LKP test case?

That's pretty hard for us to locate the problem. not to mention there
will be tons of generic tests, and new tests could easily screw up your
existing result.

It will make more sense to generate test cases based on
fstests/tests/btrfs/group, and save their result for each fstests test ca=
se.

>=20
>=20
>=20
>=20
> 2019-01-09 07:40:26 export TEST_DIR=3D/fs/vda
> 2019-01-09 07:40:26 export TEST_DEV=3D/dev/vda
> 2019-01-09 07:40:26 export FSTYP=3Dbtrfs
> 2019-01-09 07:40:26 export SCRATCH_MNT=3D/fs/scratch
> 2019-01-09 07:40:26 mkdir /fs/scratch -p
> 2019-01-09 07:40:26 export SCRATCH_DEV_POOL=3D"/dev/vdb /dev/vdc /dev/v=
dd /dev/vde /dev/vdf"
> 2019-01-09 07:40:26 sed "s:^:btrfs/:" /lkp/lkp/src/pack/xfstests-addon/=
tests/btrfs-group1 | grep -F -f merged_ignored_files
> ignored by lkp: btrfs/145
> ignored by lkp: btrfs/147
> ignored by lkp: btrfs/149
> ignored by lkp: btrfs/153
> ignored by lkp: btrfs/155
> 2019-01-09 07:40:26 sed "s:^:btrfs/:" /lkp/lkp/src/pack/xfstests-addon/=
tests/btrfs-group1 | grep -v -F -f merged_ignored_files
> 2019-01-09 07:40:26 ./check btrfs/010 btrfs/026 btrfs/027 btrfs/028 btr=
fs/116 btrfs/117 btrfs/118 btrfs/119 btrfs/120 btrfs/121 btrfs/122 btrfs/=
123 btrfs/124 btrfs/125 btrfs/126 btrfs/127 btrfs/128 btrfs/129 btrfs/131=
 btrfs/132 btrfs/133 btrfs/134 btrfs/135 btrfs/136 btrfs/137 btrfs/138 bt=
rfs/139 btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/144 btrfs/146 btrfs=
/148 btrfs/150 btrfs/151 btrfs/152 btrfs/154 btrfs/156 btrfs/157 btrfs/15=
8 btrfs/159 btrfs/160 btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/165 b=
trfs/166 btrfs/167 btrfs/168 btrfs/169 btrfs/170 btrfs/171
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 vm-snb-4G-105 4.20.0-rc7-00010-g05a37c4
> MKFS_OPTIONS  -- /dev/vdb
> MOUNT_OPTIONS -- /dev/vdb /fs/scratch
>=20
> btrfs/010	 157s
> btrfs/026	 4s
> btrfs/027	 7s
> btrfs/028	 31s
> btrfs/116	[not run] FITRIM not supported on /fs/scratch
> btrfs/117	 6s
> btrfs/118	 1s
> btrfs/119	 1s
> btrfs/120	 1s
> btrfs/121	 1s
> btrfs/122	 8s
> btrfs/123	 2s
> btrfs/124	 25s
> btrfs/125	 15s
> btrfs/126	 0s
> btrfs/127	 1s
> btrfs/128	 0s
> btrfs/129	 1s
> btrfs/131	 1s
> btrfs/132	 32s
> btrfs/133	 2s
> btrfs/134	 1s
> btrfs/135	 1s
> btrfs/136	 91s
> btrfs/137	 0s
> btrfs/138	 80s
> btrfs/139	- output mismatch (see /lkp/benchmarks/xfstests/results//btrf=
s/139.out.bad)
>     --- tests/btrfs/139.out	2018-09-19 20:13:26.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/139.out.bad	2019-01-09 =
07:48:30.619000000 +0000
>     @@ -1,4 +1,616 @@
>      QA output created by 139
>     +pwrite: Disk quota exceeded
>     +/fs/scratch/subvol/file_26: Disk quota exceeded
>     +/fs/scratch/subvol/file_27: Disk quota exceeded
>     +/fs/scratch/subvol/file_28: Disk quota exceeded
>     +/fs/scratch/subvol/file_29: Disk quota exceeded
>     +/fs/scratch/subvol/file_30: Disk quota exceeded

That's a known regression, it's recommended to blacklist this test case.
We know the cause, but find it pretty tricky to fix.

>     ...
>     (Run 'diff -u tests/btrfs/139.out /lkp/benchmarks/xfstests/results/=
/btrfs/139.out.bad'  to see the entire diff)
> btrfs/140	 6s
> btrfs/141	 1s
> btrfs/142	 0s
> btrfs/143	 2s
> btrfs/144	 1s
> btrfs/146	 1s
> btrfs/148	 1s
> btrfs/150	 0s
> btrfs/151	 3s
> btrfs/152	 3s
> btrfs/154	[failed, exit status 1]- output mismatch (see /lkp/benchmarks=
/xfstests/results//btrfs/154.out.bad)
>     --- tests/btrfs/154.out	2018-09-19 20:13:26.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/154.out.bad	2019-01-09 =
07:48:51.928000000 +0000
>     @@ -6,5 +6,5 @@
>      scan missing dev and write
>     =20
>      run balance
>     -
>     -mount reconstructed dev only and check md5sum
>     +failed: '/bin/btrfs balance start --full-balance -dconvert=3Draid1=
 -mconvert=3Draid1 /fs/scratch'
>     +(see /lkp/benchmarks/xfstests/results//btrfs/154.full for details)=

>     ...
>     (Run 'diff -u tests/btrfs/154.out /lkp/benchmarks/xfstests/results/=
/btrfs/154.out.bad'  to see the entire diff)
> btrfs/156	[not run] FITRIM not supported on /fs/scratch
> btrfs/157	 1s
> btrfs/158	 0s
> btrfs/159	 10s
> btrfs/160	 1s
> btrfs/161	 0s
> btrfs/162	 1s
> btrfs/163	[failed, exit status 1]- output mismatch (see /lkp/benchmarks=
/xfstests/results//btrfs/163.out.bad)
>     --- tests/btrfs/163.out	2018-09-19 20:13:26.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/163.out.bad	2019-01-09 =
07:49:07.384000000 +0000
>     @@ -3,7 +3,5 @@
>      0000000 abab abab abab abab abab abab abab abab
>      *
>      1000000
>     --- sprout --
>     -0000000 abab abab abab abab abab abab abab abab
>     -*
>     -1000000
>     ...
>     (Run 'diff -u tests/btrfs/163.out /lkp/benchmarks/xfstests/results/=
/btrfs/163.out.bad'  to see the entire diff)

This error is already fixed by patch "btrfs: Use real device structure
to verify dev extent".

Maintainer has merged that patch, so it would be fixed in v5.0-rcs.

Thanks,
Qu

> btrfs/164	 1s
> btrfs/165	 1s
> btrfs/166	 0s
> btrfs/167	 1s
> btrfs/168	 1s
> btrfs/169	 0s
> btrfs/170	 1s
> btrfs/171	 0s
> Ran: btrfs/010 btrfs/026 btrfs/027 btrfs/028 btrfs/116 btrfs/117 btrfs/=
118 btrfs/119 btrfs/120 btrfs/121 btrfs/122 btrfs/123 btrfs/124 btrfs/125=
 btrfs/126 btrfs/127 btrfs/128 btrfs/129 btrfs/131 btrfs/132 btrfs/133 bt=
rfs/134 btrfs/135 btrfs/136 btrfs/137 btrfs/138 btrfs/139 btrfs/140 btrfs=
/141 btrfs/142 btrfs/143 btrfs/144 btrfs/146 btrfs/148 btrfs/150 btrfs/15=
1 btrfs/152 btrfs/154 btrfs/156 btrfs/157 btrfs/158 btrfs/159 btrfs/160 b=
trfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/165 btrfs/166 btrfs/167 btrf=
s/168 btrfs/169 btrfs/170 btrfs/171
> Not run: btrfs/116 btrfs/156
> Failures: btrfs/139 btrfs/154 btrfs/163
> Failed 3 of 54 tests
>=20
>=20
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scrip=
t is attached in this email
>=20
>=20
>=20
> Thanks,
> Rong Chen
>=20


--V0kVSH4sMKZOqFeUohECgFWz1p3SG8iuP--

--AlwrSencIS4xsVob8GngbboZs0w5LhynF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw4qrEACgkQwj2R86El
/qhVzAf/Y5i2+T70ztvhVc8j5jEwHs7dEMD6zlhOx2Innfye9akXe3IQRPG2nreC
sGZ5RuL9x27QIa3t5el29TRVbF2h7J/eCJJFRal/j9joOc/n4lm073/JlKlSvnbc
eATcgNh9eKFpRyFci+gjX7Aa8xCBMUMQ0zWTMz86rASnLXG2e/Y+ftkNOe0qB7V3
bEhufWHpqQZMG03xFS8F0xWeSN4n1TPbNxO/Tckj5PYHezAHNum+B76z1cAeoag2
siBKZz1IpT9dni6+u1ZL85wxmGZy+33eB9BC8+J43gNaeB2pz6ANuQM9qHi2ehbI
tQD/hZUF52rp030vWAz8cOuoYx9vHA==
=xQ7e
-----END PGP SIGNATURE-----

--AlwrSencIS4xsVob8GngbboZs0w5LhynF--
