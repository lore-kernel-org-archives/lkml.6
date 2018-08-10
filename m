Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE19C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B42089F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8B42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeHJJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:57:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:53259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbeHJJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:57:57 -0400
Received: from [0.0.0.0] ([210.140.77.29]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Ls8Qd-1ftxeV3pXz-013ui3; Fri, 10
 Aug 2018 09:28:29 +0200
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
To:     Naohiro Aota <naota@elisp.net>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <d5473558-47a1-708e-551b-fabb4ea0842e@gmx.com>
Date:   Fri, 10 Aug 2018 15:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R8wAbo4rRVyRTQk9Epi28bnt1OjMrRl8D"
X-Provags-ID: V03:K1:l/6izOOMzVTBF860EVTaXruiEig6+awHfO0P0YxjdQL1q8XG1Ub
 JK9Y0sKSSaCOuwVa0v0ob1J2I5L8r2EBzfSvh+U3ZQK3yQmyd75uCOpaLCFcw1TBNwJhPVD
 7NbKFraRWzbtkePQS+hudHLyNU39LqLtQrdNXQCWsH984qIlpezZwSUe7bmeSHEyN8V5j8a
 4d5zQg+6eqPMJBTr2stYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:89kI9eCxYP4=:gcxdBtTGNqPqJKshaFpfXb
 HRA4/kZKLqzCTxjQDfPgQKZmwtaWZVT3sSizGHbLqfvb00aWMWfouEy0tUW1GYfTX4by2tB6O
 TfL6iw3aqGpDXzCtJhdRSP3cg4XYX9DglWqf5s3EV9vDV6sTNIin+UqubrQl5DiynipGCbesb
 xi7+BZ+7VXzixe0yz3Us86jGyr+euGuQXKd8v2tUjXVAjMR4Xs6WLgp5Uic7VPxlJzCdRjt0Q
 +Ielg1wxWkfdmE5c4fhowGKRLqZ2WsCXVhptuXydKz7WZjKr8PKmGSfPsMdgX2OaiUCJOV94y
 +0PKcpq3ZHHda8o6dUFo3W/pQ+6lE1R8tl0LcyPK7AzSMBKsx+U+oG6W7TZ4ZQf0N69N9QDpk
 SgVF7Kp4LjhTubJAkmjZajH2mswXkRfyby6uxK/MvbsrF5p79LbEUb/AUGA+AesL5iSYy3GP2
 HKgzXRMq2UNCxCtzIKEhJg38Rk3sGawnGUd8UmAle5CIKYDi3IVDoLe33p7wiLalruykZpv15
 tj2oTFHi/9Nt9i/WQPg37igmJ0D45wh/dTb9U0DrxZ0YwmepTbf8cOA+4Nu2bZRo2iNyeXJcN
 tsLY6ixtVUXu2esqoNbRxinpFSqLY6+EZwwO+UEYyVwaPkK9pG8DgjAqx3VYt/QGXvx6zrp1o
 q7WmQFIvw9i4Zi8xYeoDDvF1HL4R0uf5jQ1+oxsyq+za3FzfvU8q9QRrnrPvuhEuJgvNQNXD9
 cnKLAvqNv74xcyP+r5lC+kSqU9laN9+Q8+5aUE0jmR5+Ulhfyfm/PkZsMAE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R8wAbo4rRVyRTQk9Epi28bnt1OjMrRl8D
Content-Type: multipart/mixed; boundary="2v6oRw8L6APg1BNYTsqyP1hxUxGxKmNct";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Naohiro Aota <naota@elisp.net>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Bart Van Assche <bart.vanassche@wdc.com>, Matias Bjorling <mb@lightnvm.io>
Message-ID: <d5473558-47a1-708e-551b-fabb4ea0842e@gmx.com>
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
References: <20180809180450.5091-1-naota@elisp.net>
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>

--2v6oRw8L6APg1BNYTsqyP1hxUxGxKmNct
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 8/10/18 2:04 AM, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.
>=20
> A zoned block device consists of a number of zones. Zones are either
> conventional and accepting random writes or sequential and requiring th=
at
> writes be issued in LBA order from each zone write pointer position.

Not familiar with zoned block device, especially for the sequential case.=


Is that sequential case tape like?

> This
> patch series ensures that the sequential write constraint of sequential=

> zones is respected while fundamentally not changing BtrFS block and I/O=

> management for block stored in conventional zones.
>=20
> To achieve this, the default dev extent size of btrfs is changed on zon=
ed
> block devices so that dev extents are always aligned to a zone. Allocat=
ion
> of blocks within a block group is changed so that the allocation is alw=
ays
> sequential from the beginning of the block groups. To do so, an allocat=
ion
> pointer is added to block groups and used as the allocation hint.  The
> allocation changes also ensures that block freed below the allocation
> pointer are ignored, resulting in sequential block allocation regardles=
s of
> the block group usage.

This looks like it would cause a lot of holes for metadata block groups.
It would be better to avoid metadata block allocation in such sequential
zone.
(And that would need the infrastructure to make extent allocator
priority-aware)

>=20
> While the introduction of the allocation pointer ensure that blocks wil=
l be
> allocated sequentially, I/Os to write out newly allocated blocks may be=

> issued out of order, causing errors when writing to sequential zones. T=
his
> problem s solved by introducing a submit_buffer() function and changes =
to
> the internal I/O scheduler to ensure in-order issuing of write I/Os for=

> each chunk and corresponding to the block allocation order in the chunk=
=2E
>=20
> The zones of a chunk are reset to allow reusing of the zone only when t=
he
> block group is being freed, that is, when all the extents of the block =
group
> are unused.
>=20
> For btrfs volumes composed of multiple zoned disks, restrictions are ad=
ded
> to ensure that all disks have the same zone size. This matches the exis=
ting
> constraint that all dev extents in a chunk must have the same size.
>=20
> It requires zoned block devices to test the patchset. Even if you don't=

> have zone devices, you can use tcmu-runner [1] to emulate zoned block
> devices. It can export emulated zoned block devices via iSCSI. Please s=
ee
> the README.md of tcmu-runner [2] for howtos to generate a zoned block
> device on tcmu-runner.
>=20
> [1] https://github.com/open-iscsi/tcmu-runner
> [2] https://github.com/open-iscsi/tcmu-runner/blob/master/README.md
>=20
> Patch 1 introduces the HMZONED incompatible feature flag to indicate th=
at
> the btrfs volume was formatted for use on zoned block devices.
>=20
> Patches 2 and 3 implement functions to gather information on the zones =
of
> the device (zones type and write pointer position).
>=20
> Patch 4 restrict the possible locations of super blocks to conventional=

> zones to preserve the existing update in-place mechanism for the super
> blocks.
>=20
> Patches 5 to 7 disable features which are not compatible with the seque=
ntial
> write constraints of zoned block devices. This includes fallocate and
> direct I/O support. Device replace is also disabled for now.
>=20
> Patches 8 and 9 tweak the extent buffer allocation for HMZONED mode to
> implement sequential block allocation in block groups and chunks.
>=20
> Patches 10 to 12 implement the new submit buffer I/O path to ensure seq=
uential
> write I/O delivery to the device zones.
>=20
> Patches 13 to 16 modify several parts of btrfs to handle free blocks
> without breaking the sequential block allocation and sequential write o=
rder
> as well as zone reset for unused chunks.
>=20
> Finally, patch 17 adds the HMZONED feature to the list of supported
> features.
>=20
> Naohiro Aota (17):
>   btrfs: introduce HMZONED feature flag
>   btrfs: Get zone information of zoned block devices
>   btrfs: Check and enable HMZONED mode
>   btrfs: limit super block locations in HMZONED mode
>   btrfs: disable fallocate in HMZONED mode
>   btrfs: disable direct IO in HMZONED mode
>   btrfs: disable device replace in HMZONED mode
>   btrfs: align extent allocation to zone boundary

According to the patch name, I though it's about extent allocation, but
in fact it's about dev extent allocation.
Renaming the patch would make more sense.

>   btrfs: do sequential allocation on HMZONED drives

And this is the patch modifying extent allocator.

Despite that, the support zoned storage looks pretty interesting and
have something in common with planned priority-aware extent allocator.

Thanks,
Qu

>   btrfs: split btrfs_map_bio()
>   btrfs: introduce submit buffer
>   btrfs: expire submit buffer on timeout
>   btrfs: avoid sync IO prioritization on checksum in HMZONED mode
>   btrfs: redirty released extent buffers in sequential BGs
>   btrfs: reset zones of unused block groups
>   btrfs: wait existing extents before truncating
>   btrfs: enable to mount HMZONED incompat flag
>=20
>  fs/btrfs/async-thread.c     |   1 +
>  fs/btrfs/async-thread.h     |   1 +
>  fs/btrfs/ctree.h            |  36 ++-
>  fs/btrfs/dev-replace.c      |  10 +
>  fs/btrfs/disk-io.c          |  48 +++-
>  fs/btrfs/extent-tree.c      | 281 +++++++++++++++++-
>  fs/btrfs/extent_io.c        |   1 +
>  fs/btrfs/extent_io.h        |   1 +
>  fs/btrfs/file.c             |   4 +
>  fs/btrfs/free-space-cache.c |  36 +++
>  fs/btrfs/free-space-cache.h |  10 +
>  fs/btrfs/inode.c            |  14 +
>  fs/btrfs/super.c            |  32 ++-
>  fs/btrfs/sysfs.c            |   2 +
>  fs/btrfs/transaction.c      |  32 +++
>  fs/btrfs/transaction.h      |   3 +
>  fs/btrfs/volumes.c          | 551 ++++++++++++++++++++++++++++++++++--=

>  fs/btrfs/volumes.h          |  37 +++
>  include/uapi/linux/btrfs.h  |   1 +
>  19 files changed, 1061 insertions(+), 40 deletions(-)
>=20


--2v6oRw8L6APg1BNYTsqyP1hxUxGxKmNct--

--R8wAbo4rRVyRTQk9Epi28bnt1OjMrRl8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlttPpUACgkQwj2R86El
/qjuOgf+M6fEUKywpjPLhBLl3Qs0jeFfD95N9C4kC6unzBh+ZglaDFalFB2Z+LiG
zrgHl2kYxArXDH7zrkV1WqkDM31K3m9HiynBv1e2ygwS6RWs0gZIRrEAHySbKPz9
IQUmDbOoWMyQHIXchikF6ZV41umVuud+XONlg3VA1lB/rLa0a2iKNWZ4pHRc0upN
sLd1qV0v7yJ+PMi6V/O3/ry2cwr8c1wZIkfs3a4mVHgo64QHBZnDNPjhXtYrO63H
ZnUtQBrON7hkNWkRhmuSEewmU5KsbIGDmpabkz/xr9+gz3fIJnOO3nLy8NY8Q0GW
WGRdya/xXfRE8aDyhyXAF59JzaREkg==
=99BS
-----END PGP SIGNATURE-----

--R8wAbo4rRVyRTQk9Epi28bnt1OjMrRl8D--
