Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48579C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9951208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XS+7jt07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9951208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbeHAQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:01:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389370AbeHAQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:01:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71EDvMZ111759;
        Wed, 1 Aug 2018 14:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=2+hq52ztDsBJ25LVztnKXC1Pj+yziswl1j5d9BXi5UQ=;
 b=XS+7jt07imPSUrlIEqNRoMuU4gdfXlTuuPWRbUoxPwnLsQmvAEeVpDtf8PWHqgs0s8iS
 TQ7cXdhVU/4MfYzz5iP894I4eICFVe07LnyahyIqQbFMaIdE3wjV8iVUXMizhcrx2J3G
 9s2N6AeQOJpFPWQomlzFWKRG3PngKtiWONT3tIIdkK36QNL7moIpQGREIaniqXJmaOhq
 QD2EIigu2jlLgfimrtTjcD+kU5f3JJCkQh13YNXJwZj53z79FvySGf4PptqWHGUyTF+B
 hVyrksht/sYToMC1nKVkL3jew2uFZ8ZpmOQlOkBWv6MND6ssn4UFHWLgJyZsqnVqNbcX 1A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kgh4q5srk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 14:15:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w71EFZ3w024935
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 14:15:35 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71EFWal026639;
        Wed, 1 Aug 2018 14:15:32 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 07:15:32 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] sunrpc: remove redundant variables
 'checksumlen','blocksize' and 'data'
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20180801062810.19752-1-yuehaibing@huawei.com>
Date:   Wed, 1 Aug 2018 10:15:29 -0400
Cc:     davem@davemloft.net, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        ebiggers@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BA49886-5754-480E-BBB3-CC76E5A2C3B7@oracle.com>
References: <20180801062810.19752-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2018, at 2:28 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>=20
> Variables 'checksumlen','blocksize' and 'data' are being assigned,
> but are never used,hence they are redundant and can be removed.
>=20
> fix fllowing warning:

^fllowing^following

For the svc_rdma.c part:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> net/sunrpc/auth_gss/gss_krb5_wrap.c:443:7: warning: variable =
=E2=80=98blocksize=E2=80=99 set but not used [-Wunused-but-set-variable]
> net/sunrpc/auth_gss/gss_krb5_crypto.c:376:15: warning: variable =
=E2=80=98checksumlen=E2=80=99 set but not used =
[-Wunused-but-set-variable]
> net/sunrpc/xprtrdma/svc_rdma.c:97:9: warning: variable =E2=80=98data=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> net/sunrpc/auth_gss/gss_krb5_crypto.c | 2 --
> net/sunrpc/auth_gss/gss_krb5_wrap.c   | 2 --
> net/sunrpc/xprtrdma/svc_rdma.c        | 2 --
> 3 files changed, 6 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c =
b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> index 8654494..84a16fd 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -373,7 +373,6 @@ make_checksum_v2(struct krb5_ctx *kctx, char =
*header, int hdrlen,
> 	struct scatterlist sg[1];
> 	int err =3D -1;
> 	u8 *checksumdata;
> -	unsigned int checksumlen;
>=20
> 	if (kctx->gk5e->keyed_cksum =3D=3D 0) {
> 		dprintk("%s: expected keyed hash for %s\n",
> @@ -393,7 +392,6 @@ make_checksum_v2(struct krb5_ctx *kctx, char =
*header, int hdrlen,
> 	tfm =3D crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, =
CRYPTO_ALG_ASYNC);
> 	if (IS_ERR(tfm))
> 		goto out_free_cksum;
> -	checksumlen =3D crypto_ahash_digestsize(tfm);
>=20
> 	req =3D ahash_request_alloc(tfm, GFP_NOFS);
> 	if (!req)
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c =
b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> index a737c2d..9a1347f 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -440,7 +440,6 @@ static u32
> gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
> 		     struct xdr_buf *buf, struct page **pages)
> {
> -	int		blocksize;
> 	u8		*ptr, *plainhdr;
> 	s32		now;
> 	u8		flags =3D 0x00;
> @@ -473,7 +472,6 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 =
offset,
> 	*ptr++ =3D 0xff;
> 	be16ptr =3D (__be16 *)ptr;
>=20
> -	blocksize =3D crypto_skcipher_blocksize(kctx->acceptor_enc);
> 	*be16ptr++ =3D 0;
> 	/* "inner" token header always uses 0 for RRC */
> 	*be16ptr++ =3D 0;
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c =
b/net/sunrpc/xprtrdma/svc_rdma.c
> index 357ba90..134bef6a 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -94,7 +94,6 @@ static int read_reset_stat(struct ctl_table *table, =
int write,
> 		atomic_set(stat, 0);
> 	else {
> 		char str_buf[32];
> -		char *data;
> 		int len =3D snprintf(str_buf, 32, "%d\n", =
atomic_read(stat));
> 		if (len >=3D 32)
> 			return -EFAULT;
> @@ -103,7 +102,6 @@ static int read_reset_stat(struct ctl_table =
*table, int write,
> 			*lenp =3D 0;
> 			return 0;
> 		}
> -		data =3D &str_buf[*ppos];
> 		len -=3D *ppos;
> 		if (len > *lenp)
> 			len =3D *lenp;
> --=20
> 2.7.0
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-nfs" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Chuck Lever



