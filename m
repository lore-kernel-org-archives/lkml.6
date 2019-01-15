Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510AFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165DE2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BF5ZW1h+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfAOVjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:39:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbfAOVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:39:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0FLcuf3082306;
        Tue, 15 Jan 2019 21:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=HuI4OPW7zTl+QRvK1kdSB15UOh7kZHzWVmr5tbV6sOM=;
 b=BF5ZW1h+bq8rSDly93GOsIjWivc9j73fcdqy3vPLHQj499b2sN5rsUkRGu3MlVdqOUlD
 MxiIDALXsH1zMJxW6r+eeaxIOd5+Y6+DVJec2UnBoAYNE081jySyp57sDpMQv5pDhiUD
 3GmD1ren4QODXTsmqKajgdLnpb/bAJ/LEe4KMIQmdpq+0LAqEnWYF8O1OitfvnVp7Q0b
 0scO25F87kqAt1jiE3HVQgB1i+tqbdmm+6I6b11IHVAUP+bG7Qu46tfgbQrPBEFo4jkr
 gUofFMYym8NreQK1aSgRr9Cl/hhoe7wuTAsGyrIjWMVYcH282nUKBUC7jx7xjryoygq/ Lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pybkceeg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 21:39:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0FLd8Nd013089
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 21:39:08 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0FLd6Ms028658;
        Tue, 15 Jan 2019 21:39:07 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 13:39:06 -0800
Subject: Re: linux-next: Fixes tag needs work in the xen-tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
References: <20190116080620.4c2c143f@canb.auug.org.au>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <3b87ef37-3ca8-88cf-fe8f-3e8ee6af6975@oracle.com>
Date:   Tue, 15 Jan 2019 16:39:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190116080620.4c2c143f@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z4JFOmEhMLFZ69tj1UJhy3wiMr4AN4hVK"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901150172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z4JFOmEhMLFZ69tj1UJhy3wiMr4AN4hVK
Content-Type: multipart/mixed; boundary="s7roISkloo2Amv68gzmhPrcOFHbozNHy9";
 protected-headers="v1"
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Juergen Gross <jgross@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Xen Devel <Xen-devel@lists.xensource.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wen Yang <wen.yang99@zte.com.cn>,
 Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <3b87ef37-3ca8-88cf-fe8f-3e8ee6af6975@oracle.com>
Subject: Re: linux-next: Fixes tag needs work in the xen-tip tree
References: <20190116080620.4c2c143f@canb.auug.org.au>
In-Reply-To: <20190116080620.4c2c143f@canb.auug.org.au>

--s7roISkloo2Amv68gzmhPrcOFHbozNHy9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 1/15/19 4:06 PM, Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   786e1048e7f4 ("pvcalls-front: fix potential null dereference")
>
> has a malformed Fixes tag:
>
>   Fixes: 9f51c05dc41a ("pvcalls-front: Avoid get_free_pages(GFP_KERNEL)=

>   under spinlock")
>
> It should not be split over 2 lines.
>


Thanks, fixed.

-boris


--s7roISkloo2Amv68gzmhPrcOFHbozNHy9--

--Z4JFOmEhMLFZ69tj1UJhy3wiMr4AN4hVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAlw+UvYACgkQit52kIbK
wbJLWxAAlYJb5qTJcKP7aPrZvOsOP7f/YR3FtbUvwxH1JqzXMkcrY1lQaf47+SdE
7ZlfD0to+iG3RYqG2aQHEdWmEqXUeBJDLegzPgAFQv2veKu8YIx7LPT7PWAuSsiG
ttg0KTt3jq8bFvjaJElwnt0pG9DKiz+VSsyeSzFA32ecdBsE67PqrNbj4QE/8WJ/
cikqypygxRgu6zJnellkQKpekIkMUE5cEqLo5d5i9Xi/nCunAxOWuVZBusUexm8J
6ibEIjskfjqxYB+/QONrtCxmK9PqT9Sj5v2S3fcVxthDVqtTL/VbHhEeybzeJGaw
U/78/e7jKaDDUAaeBuss5A1jNaE+HHX3IQh+D6ZYXwdPmYmvCIKSmTzChXzAfIXw
h6tBDdMJ3rgtQNcQQFgGFjgJLQOxccoMZ5qmACD3CikwWGMi8z7QLM39ZRRLI7mp
lsJWpoG94B9PmyzA2WLEp+UDyMbsib+BiNhzl1cPrz+Dv5SOGva/y4LlBwDa2eas
5hRIZIvySf3AVEwXTuF3mWDtNGL64JlRaR3ITQNWn7v0KHF4rIBxpDDl9rzIpAbJ
qp/8LT+ZUarZBjwkgMu0PYnLcNMz2jUcd0jueew9rrjpShhBn20PWmZSws2P7bs5
ZfJ3/ZFNTtFFS0GlH0/ZJ5RQvMiEh6nEVHZh2OZvNhBNU8Ew3Gc=
=xBW/
-----END PGP SIGNATURE-----

--Z4JFOmEhMLFZ69tj1UJhy3wiMr4AN4hVK--
