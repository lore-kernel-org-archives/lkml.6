Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08335C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF7214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpiCVzuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfAJMMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:12:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfAJMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:12:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AC41L2126227;
        Thu, 10 Jan 2019 12:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=f8thXKqGmXAcAg92JOqwvN4UTlK63hLPBTTcunmF/Yk=;
 b=VpiCVzuUhmx7SBCUVoFZ7XNr/F1TepG0jas0tBYO4wSywiG0VKuqrHQGbXF4ATcbOOam
 ENiwcr49XCkeHXiGdWUu+wjNwXk9fcptxpLVhw1AvMfhNqa4pBSUFPEUyrAEJ/q6jVrK
 3jtcO3Cv8weW8SAISSfzhNv/qtUmNlL0v+3OOa3n64J7ane0n8R7UxALUtEH0DAmegUs
 +IHDZaJxTUezbPiQvxjRDd2fWwz9AFPLv0lnfPlyljnqxW5JaanH5HRnigY0ZoTxZx+D
 q1PWOxrLjNmk8kh23VkshejivJk9FOJP6+gOj+B/oAm1rFCLzEZ/wyFxEJlmgYJ2D1PJ bw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7r6p1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:12:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0ACCK8O020518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:12:20 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ACCJBO002576;
        Thu, 10 Jan 2019 12:12:19 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 04:12:18 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm: memcontrol: use struct_size() in kmalloc()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190104183726.GA6374@embeddedor>
Date:   Thu, 10 Jan 2019 05:12:17 -0700
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B12C965-1406-4464-96FF-B9C04187DD7D@oracle.com>
References: <20190104183726.GA6374@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 4, 2019, at 11:37 AM, Gustavo A. R. Silva =
<gustavo@embeddedor.com> wrote:
>=20
> One of the more common cases of allocation size calculations is =
finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>    int stuff;
>    void *entry[];
> };
>=20
> instance =3D kmalloc(sizeof(struct foo) + sizeof(void *) * count, =
GFP_KERNEL);
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>=20
> instance =3D kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> mm/memcontrol.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index af7f18b32389..ad256cf7da47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3626,8 +3626,7 @@ static int =
__mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
> 	size =3D thresholds->primary ? thresholds->primary->size + 1 : =
1;
>=20
> 	/* Allocate memory for new array of thresholds */
> -	new =3D kmalloc(sizeof(*new) + size * sizeof(struct =
mem_cgroup_threshold),
> -			GFP_KERNEL);
> +	new =3D kmalloc(struct_size(new, entries, size), GFP_KERNEL);
> 	if (!new) {
> 		ret =3D -ENOMEM;
> 		goto unlock;
> --=20
> 2.20.1
>=20

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
