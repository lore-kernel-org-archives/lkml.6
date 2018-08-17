Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D08218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IjHITXvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D08218A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHRBUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:20:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeHRBUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:20:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7HMEgpt169515;
        Fri, 17 Aug 2018 22:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=+kGMdK4b1weM5FCtNKL2SqKAp19G9fifRuz75qfZL9A=;
 b=IjHITXvTppN16eqIu0WZl3uGHuCzAuowRRyLcMGRTSgLxRk6GwddL7zXFqObxnS9IfIZ
 M/w9C9n7o4swXu4/2vihRIP0qNB1i1OkO4o0ynpmaS0QJteSzu95qWmqPowIPv4aacy/
 WtfCnWzbt9gG9KwHyLyEtrd5ur2N6TcDBtDZj30KkvDziVCBfpI+txzx7knviSUT+3zO
 IDpVGQlPmlrTzkVEor/uXjldeuS6Ex1OPGlSChmpNszRaqIZu9XOdcVKV7dpyKyPUU/L
 Hk+rHapJM9FXDNmSJt1NRSy+1lvN9RolZ101cSgdHwKTK99tFy6Dbp9J7kfexXUsuO5Z Vg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ksq7tsrru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 22:14:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7HMEoIt030722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 22:14:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7HMEleQ032379;
        Fri, 17 Aug 2018 22:14:47 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Aug 2018 15:14:47 -0700
Subject: Re: [Xen-devel] linux-next: manual merge of the akpm-current tree
 with the xen-tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Xen Devel <Xen-devel@lists.xensource.com>
References: <20180730190210.48a75b72@canb.auug.org.au>
 <20180816100511.2377dda2@canb.auug.org.au>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <60058ac8-9d9a-f1f5-c6ad-948fbec5583c@oracle.com>
Date:   Fri, 17 Aug 2018 18:15:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816100511.2377dda2@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KWTIYsfcAe45JiJ1gi4zCuPTshKzgiV1S"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8988 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808170235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KWTIYsfcAe45JiJ1gi4zCuPTshKzgiV1S
Content-Type: multipart/mixed; boundary="MeJvDGScHKLqEaur4uZlFUPb7yxmMpEcQ";
 protected-headers="v1"
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Michal Hocko <mhocko@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Xen Devel <Xen-devel@lists.xensource.com>
Message-ID: <60058ac8-9d9a-f1f5-c6ad-948fbec5583c@oracle.com>
Subject: Re: [Xen-devel] linux-next: manual merge of the akpm-current tree
 with the xen-tip tree
References: <20180730190210.48a75b72@canb.auug.org.au>
 <20180816100511.2377dda2@canb.auug.org.au>
In-Reply-To: <20180816100511.2377dda2@canb.auug.org.au>

--MeJvDGScHKLqEaur4uZlFUPb7yxmMpEcQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 08/15/2018 08:05 PM, Stephen Rothwell wrote:
> Hi all,
>
> On Mon, 30 Jul 2018 19:02:10 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>> Today's linux-next merge of the akpm-current tree got a conflict in:
>>
>>   drivers/xen/gntdev.c
>>
>> between commit:
>>
>>   1d3145675538 ("xen/gntdev: Make private routines/structures accessib=
le")
>>
>> from the xen-tip tree and commit:
>>
>>   aaefcabe9c25 ("mm, oom: distinguish blockable mode for mmu notifiers=
")
>>
>> from the akpm-current tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tr=
ee
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particular=
ly
>> complex conflicts.
>>
>> --=20
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc drivers/xen/gntdev.c
>> index c866a62f766d,55b4f0e3f4d6..000000000000
>> --- a/drivers/xen/gntdev.c
>> +++ b/drivers/xen/gntdev.c
>> @@@ -479,7 -441,20 +479,20 @@@ static const struct vm_operations_struc=

>>  =20
>>   /* -----------------------------------------------------------------=
- */
>>  =20
>>  -static bool in_range(struct grant_map *map,
>> ++static bool in_range(struct gntdev_grant_map *map,
>> + 			      unsigned long start, unsigned long end)
>> + {
>> + 	if (!map->vma)
>> + 		return false;
>> + 	if (map->vma->vm_start >=3D end)
>> + 		return false;
>> + 	if (map->vma->vm_end <=3D start)
>> + 		return false;
>> +=20
>> + 	return true;
>> + }
>> +=20
>>  -static void unmap_if_in_range(struct grant_map *map,
>>  +static void unmap_if_in_range(struct gntdev_grant_map *map,
>>   			      unsigned long start, unsigned long end)
>>   {
>>   	unsigned long mstart, mend;
>> @@@ -503,15 -472,26 +510,26 @@@
>>   	WARN_ON(err);
>>   }
>>  =20
>> - static void mn_invl_range_start(struct mmu_notifier *mn,
>> + static int mn_invl_range_start(struct mmu_notifier *mn,
>>   				struct mm_struct *mm,
>> - 				unsigned long start, unsigned long end)
>> + 				unsigned long start, unsigned long end,
>> + 				bool blockable)
>>   {
>>   	struct gntdev_priv *priv =3D container_of(mn, struct gntdev_priv, m=
n);
>>  -	struct grant_map *map;
>>  +	struct gntdev_grant_map *map;
>> + 	int ret =3D 0;
>> +=20
>> + 	/* TODO do we really need a mutex here? */
>> + 	if (blockable)
>> + 		mutex_lock(&priv->lock);
>> + 	else if (!mutex_trylock(&priv->lock))
>> + 		return -EAGAIN;
>>  =20
>> - 	mutex_lock(&priv->lock);
>>   	list_for_each_entry(map, &priv->maps, next) {
>> + 		if (in_range(map, start, end)) {
>> + 			ret =3D -EAGAIN;
>> + 			goto out_unlock;
>> + 		}
>>   		unmap_if_in_range(map, start, end);


I think I mentioned this earlier --- this doesn't look right. Not the
conflict resolution but the original patch.

Should I send a patch against -next? Or -mm?


-boris




--MeJvDGScHKLqEaur4uZlFUPb7yxmMpEcQ--

--KWTIYsfcAe45JiJ1gi4zCuPTshKzgiV1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAlt3SRIACgkQit52kIbK
wbILOw//YDazJTGDrB5WB/WhYAGdv5YsU2hZegwBCY4dHkqyUqpJs1fK5IQIjNJd
Per5xwVOhqweSS9Glr+tpJnUOVunxFtMw0IwEgtOT8NPuWZEqgb+ePe16wi4+RDe
pMHAag7fTwGjfljxC1RFueFowQ5QhuDzBzUff212of8EIMibOJlVd/EQ3Tcv8LyB
aBWb9IxtNEAwH68Quo0YdJ2nJmNOGMFD6q89nYJY1OGEOOzYV9HnthpnyqXxjUB8
OkWThkBKzfiUmbMwXoi8xeR2lrNifU52titWocGQ1ZpfB5OCgeJ2MAX5VnUyfzJ3
5o13qyzhaCGSCWfvp4urVDS7YecqXkC00JiIhGbbGNuIESxV28d9IseUJC/n7I/3
2xT/lTNGiCr4pBBL3C7/jZe3TbEC+3IF+X3n5LS3wI8gi2OOrRWQuRFW85Hfag0x
i3+Unoc5JzmaKT0gxRS2a4Emg31BtrbpjNYtJH5y+nxTWrMgStmH3V0AJdOoeoaN
NQXD4fx2ghc+LomRoVizjXv5EtTrikeo+4J2pxNywVk45TZFDcEpRBbui6iIyeHc
DBNPKZ1M8Z+yJjRAGvWjC46+KTEu5gcYmhwZj5S+kx651ZBuT1TtBlgDK0ldShjB
UoPdy1PftbHwe7lVylZ9ilsnwkNRhPh7zkTse362pKOIoM8a7Rs=
=o+v2
-----END PGP SIGNATURE-----

--KWTIYsfcAe45JiJ1gi4zCuPTshKzgiV1S--
