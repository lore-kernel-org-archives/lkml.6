Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E16ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5220671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7FVpHof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C5220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeGVT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:58:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbeGVT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:58:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6MIxEtQ037032;
        Sun, 22 Jul 2018 19:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=+QnyfFlN/4mZEKne47dVbV+tQyj+6npfo7Up2XdGwjs=;
 b=L7FVpHofCjCH1q4CmkKSznp6S1RQLJCODOie722J/ayMjPktVlKbRocfgg0rHhf7PVW1
 HrP8Quaxt69Yj64RLxqG6YgwbJIEM8LHBdhMg3j27tEYKAOol4ogxtm35tceAPx6HM3F
 iyUQFXpwqfDjnL/fa7UtT0Y4vl5iCDJbPVgYUBptm1vs8j1QFgDtYH4aJe6dG7xoCxax
 E3WpRbNLu2vESmAgiro8etdImkFYI5uJVFMHT6ENuT3PdmUDk1Y1UdbsRuW2itZtjs9o
 OtHVNGQXvGaAPb14gjpQB7PLiaCxJk5Gco1KRVG2mtkpiP7hmn7xGWPKtqcmrdEZ+wp/ FA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kbvsnj59v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jul 2018 19:01:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6MJ15LL012258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jul 2018 19:01:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6MJ14Ji011575;
        Sun, 22 Jul 2018 19:01:04 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Jul 2018 12:01:04 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] fs/nfsd: Delete invalid assignment statements in
 nfsd4_decode_exchange_id
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a6be2d3bf2ff5ac43f82dcb7b29ba32faccbbdaf.camel@hammerspace.com>
Date:   Sun, 22 Jul 2018 15:01:02 -0400
Cc:     "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        Bruce Fields <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B9E4DFD-F651-4478-A82E-CDB759BB1A69@oracle.com>
References: <20180722085044.50701-1-nixiaoming@huawei.com>
 <2C39A9CD-4591-46C8-BB25-5FA2C85149CE@oracle.com>
 <a6be2d3bf2ff5ac43f82dcb7b29ba32faccbbdaf.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8962 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807220227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 22, 2018, at 2:33 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Sun, 2018-07-22 at 14:12 -0400, Chuck Lever wrote:
>>> On Jul 22, 2018, at 4:50 AM, nixiaoming <nixiaoming@huawei.com>
>>> wrote:
>>>=20
>>> dummy =3D be32_to_cpup(p++);
>>> dummy =3D be32_to_cpup(p++);
>>> Assigning value to "dummy" here, but that stored value
>>> is overwritten before it can be used.
>>>=20
>>> delete invalid assignment statements in nfsd4_decode_exchange_id
>>>=20
>>> Signed-off-by: n00202754 <nixiaoming@huawei.com>
>>> ---
>>> fs/nfsd/nfs4xdr.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index a96843c..8e78541 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -1392,8 +1392,8 @@ nfsd4_decode_exchange_id(struct
>>> nfsd4_compoundargs *argp,
>>>=20
>>> 		/* ssp_window and ssp_num_gss_handles */
>>> 		READ_BUF(8);
>>> -		dummy =3D be32_to_cpup(p++);
>>> -		dummy =3D be32_to_cpup(p++);
>>> +		be32_to_cpup(p++);
>>> +		be32_to_cpup(p++);
>>=20
>> If these values are not used, what's the point of byte swapping them?
>> Surely "p +=3D 2;" should be enough.
>>=20
>>=20
>>> 		break;
>>> 	default:
>>> 		goto xdr_error;
>>=20
>=20
> Given that the value of 'p' isn't used either, why not just delete
> those two lines altogether?

Sounds OK, READ_BUF is tracking progress through the buffer,
and it already updates "p" as a side-effect.

Might there be some nearby instances of open-coded "p" updates
that could also be removed, for similar reasons?


--
Chuck Lever



