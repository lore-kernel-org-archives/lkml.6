Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B779620890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1pjgelQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B779620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeG3Sig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:38:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35354 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeG3Sig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:38:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UGwrqu153930;
        Mon, 30 Jul 2018 17:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=u4ifZXIvj0t+7CUUE1keyXfIsxqjQj7DZGks9szLhhE=;
 b=1pjgelQ2quhiNkIAxzH9lHmj/ZzciANePHxk4VmwzDOtnv4Y7+r4Iv7S6Ts8bkSNPtLY
 jkSaLoPJ72RJ8YN6UTpzmSOgnCxZBWBrTuzNyJUpeS1MhvfbQvioD7eGkYiu2ow16VqK
 s1hjs/sno8yeWxqXQpDozaLcMKYaSi891KKWwS14Hjcyd/PoIee3FGdChfG90u5nIYdb
 yjylrBirgD5isIoEX4fwffXf1H473gj67x6eEMNqkrAtExtvI//6TtOeG/tKYVQXXoAx
 KGJtTeGynNXfXj6m4ceAFQldTx0Kn7COiqdzNiO3hE40Yy6lPXq/f2EfBPbQ8o9eAgVw KQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kge0cwkep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 17:02:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UH2MnZ013762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 17:02:22 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6UH2K3T004409;
        Mon, 30 Jul 2018 17:02:21 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 10:02:20 -0700
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 xen-tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Hocko <mhocko@suse.com>
References: <20180730190210.48a75b72@canb.auug.org.au>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <6bf747ac-13d0-f77b-4983-2015a5703a12@oracle.com>
Date:   Mon, 30 Jul 2018 13:02:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180730190210.48a75b72@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wMuxWcyZQF33UfI3MCNgXDjXbmejdZI10"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wMuxWcyZQF33UfI3MCNgXDjXbmejdZI10
Content-Type: multipart/mixed; boundary="t1s42VOlINq6E8TMwtHOkTxQcGDMxjjlC";
 protected-headers="v1"
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Xen Devel <Xen-devel@lists.xensource.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Michal Hocko <mhocko@suse.com>
Message-ID: <6bf747ac-13d0-f77b-4983-2015a5703a12@oracle.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 xen-tip tree
References: <20180730190210.48a75b72@canb.auug.org.au>
In-Reply-To: <20180730190210.48a75b72@canb.auug.org.au>

--t1s42VOlINq6E8TMwtHOkTxQcGDMxjjlC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 07/30/2018 05:02 AM, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>
>   drivers/xen/gntdev.c
>
> between commit:
>
>   1d3145675538 ("xen/gntdev: Make private routines/structures accessibl=
e")
>
> from the xen-tip tree and commit:
>
>   aaefcabe9c25 ("mm, oom: distinguish blockable mode for mmu notifiers"=
)
>
> from the akpm-current tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tre=
e
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularl=
y
> complex conflicts.
>
> -- Cheers, Stephen Rothwell diff --cc drivers/xen/gntdev.c index
> c866a62f766d,55b4f0e3f4d6..000000000000 --- a/drivers/xen/gntdev.c +++
> b/drivers/xen/gntdev.c @@@ -479,7 -441,20 +479,20 @@@ static const
> struct vm_operations_struc /*
> ------------------------------------------------------------------ */
> -static bool in_range(struct grant_map *map, ++static bool
> in_range(struct gntdev_grant_map *map, + unsigned long start, unsigned
> long end) + { + if (!map->vma) + return false; + if
> (map->vma->vm_start >=3D end) + return false; + if (map->vma->vm_end <=3D=

> start) + return false; + + return true; + } + -static void
> unmap_if_in_range(struct grant_map *map, +static void
> unmap_if_in_range(struct gntdev_grant_map *map, unsigned long start,
> unsigned long end) { unsigned long mstart, mend; @@@ -503,15 -472,26
> +510,26 @@@ WARN_ON(err); } - static void mn_invl_range_start(struct
> mmu_notifier *mn, + static int mn_invl_range_start(struct mmu_notifier
> *mn, struct mm_struct *mm, - unsigned long start, unsigned long end) +
> unsigned long start, unsigned long end, + bool blockable) { struct
> gntdev_priv *priv =3D container_of(mn, struct gntdev_priv, mn); - struc=
t
> grant_map *map; + struct gntdev_grant_map *map; + int ret =3D 0; + + /*=

> TODO do we really need a mutex here? */ + if (blockable) +
> mutex_lock(&priv->lock); + else if (!mutex_trylock(&priv->lock)) +
> return -EAGAIN; - mutex_lock(&priv->lock); list_for_each_entry(map,
> &priv->maps, next) { + if (in_range(map, start, end)) { + ret =3D
> -EAGAIN; + goto out_unlock; + } unmap_if_in_range(map, start, end); }
> list_for_each_entry(map, &priv->freeable_maps, next) {


I clearly missed this (aaefcabe9c25) patch but now that I am looking at
it I don't think I understand the logic for changes in
list_for_each_entry() loops.

Aren't we ending up never unmapping grant pages? Michal, can you explain
what you are trying to do here?


-boris




--t1s42VOlINq6E8TMwtHOkTxQcGDMxjjlC--

--wMuxWcyZQF33UfI3MCNgXDjXbmejdZI10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAltfRLUACgkQit52kIbK
wbIeVg/8CLPEQPoU6oMttBxgdLPR4zD6rNjSevB81pYlvNAzZyfWQiQuGjOaaZNz
h9jrBuza9IIx0PoFnu9nly/nPlzS4d0A1/npaxEDrpKH+BG7q4Wk2wkO72vqtCzz
fC2UQ6TV0mGMiUXoQ7PChRe8fbgWp3edDnURDJDyY7xtERLNc9QDn4UVq4tGj0OE
F1+aDpFNpoRFTR/mcKFL1Ypcj4Qu/z7QLpuLlmsNLqfpOjEnNmXGINwWMcMUiL/s
aeZ3hrHdTLI282tviMoD9qNYFX/8Kcu/UFlUluXQEWsFyKZpReqwvRMALdENZt5o
2857Jzi/D1VQcIu9Tm5HycJ5vSZd6zdg1zRYRcNwYnjciAtqhnjAEO5x/XlxMwpv
6j6sJ+xrtX53U9fIu2X/TxP/3OB068KT3o42qTHMsnOTpLmSNAy0EY5nt2jq3Hft
UVJzByrhMQXn5Mj1aiVEHzd2zVFz68jpyGbfiQERnmROi699uZA2xmICRa4wOEQG
BYjvBNx5BFxXmQ4KW0B7JRRMkEQmkMPjMM7JZZmB6ibIhzvh4x3cpDSyjLLVT5mQ
4nD5b3TKOxLEu34xYiaeVUmGBvtC3tA94aITQK81itBh4eZbW/XeI4SUwyEyob1+
gd0OKqHRVXlXvYDQ02sEBz7kMkBpOmdHNfyhGPZNa6GObSJfxjM=
=S2lv
-----END PGP SIGNATURE-----

--wMuxWcyZQF33UfI3MCNgXDjXbmejdZI10--
