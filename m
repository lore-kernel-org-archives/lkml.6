Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0682C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE7C20671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/Igasa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE7C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeGVTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:10:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43314 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeGVTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:10:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6MI9PGR005186;
        Sun, 22 Jul 2018 18:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=u5FueHwAvDOYML9SDSpRzkby/SodOsUY89dVOBU1+GY=;
 b=C/Igasa9Ub5nHf/mCuFdnDXTI/mB7sXhfeioMDmtdoY+y6oIit4B6MWAA6FNuZGJwgIi
 HyWUB6sqKHW3WSxCqg83anF3PxT6VnC0hxJQ7zcKfT7GXMXowPgexQ7ZL+lKdVlWwYQA
 rFjl+Dxn9R6wQKHWQkVrNiW8+5XmbJcQs5SJQ81188jCN5uL9p/vLrPJUuLYkt4QmBUw
 dc5o121J4afCNSzD3hh9OW9RbNqzYBcxd9TWXjs6EA8gDb1KNlmuIRP8ce6sWM+941ug
 DyvwzNBCSON4Acd8dyf5jb8VqHpJmEimh0+nFJiuw2sSgxvNzL5xqHuXogS42fuqW6A2 pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kbtbcj8t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jul 2018 18:12:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6MICMDH018361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jul 2018 18:12:23 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6MICL2f029608;
        Sun, 22 Jul 2018 18:12:21 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Jul 2018 11:12:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20180722085044.50701-1-nixiaoming@huawei.com>
Date:   Sun, 22 Jul 2018 14:12:20 -0400
Cc:     Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
References: <20180722085044.50701-1-nixiaoming@huawei.com>
To:     nixiaoming <nixiaoming@huawei.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8962 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807220217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 22, 2018, at 4:50 AM, nixiaoming <nixiaoming@huawei.com> wrote:
>=20
> dummy =3D be32_to_cpup(p++);
> dummy =3D be32_to_cpup(p++);
> Assigning value to "dummy" here, but that stored value
> is overwritten before it can be used.
>=20
> delete invalid assignment statements in nfsd4_decode_exchange_id
>=20
> Signed-off-by: n00202754 <nixiaoming@huawei.com>
> ---
> fs/nfsd/nfs4xdr.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index a96843c..8e78541 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1392,8 +1392,8 @@ nfsd4_decode_exchange_id(struct =
nfsd4_compoundargs *argp,
>=20
> 		/* ssp_window and ssp_num_gss_handles */
> 		READ_BUF(8);
> -		dummy =3D be32_to_cpup(p++);
> -		dummy =3D be32_to_cpup(p++);
> +		be32_to_cpup(p++);
> +		be32_to_cpup(p++);

If these values are not used, what's the point of byte swapping them?
Surely "p +=3D 2;" should be enough.


> 		break;
> 	default:
> 		goto xdr_error;

--
Chuck Lever



