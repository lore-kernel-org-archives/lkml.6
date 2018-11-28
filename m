Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77071C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350112081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w46ZAEtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350112081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeK1PYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:24:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43396 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1PYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:24:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS4NvA7015695;
        Wed, 28 Nov 2018 04:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=OqJN3hwJVtXN0GLXo6jvJNpUpmhuGv6IkgI5jzanZqM=;
 b=w46ZAEtfZVE7n3X906pfLLs2LKrnVR4VhuXsZzYfyFKp3eoPXP/GmF0FDy6i08TmlaXY
 ukilelGD++/KkUID5m8xEO4WNLEEN5FT5B0Qry5wOCjHKT54jxWgy3StRKkFUNI2GDZj
 hYRGSRvq6cp0tH4udUqgT41F4E//g8Q5Ov1ThjwAlG42eas9nRs4WGLCJsuxR37gOdUE
 s3hCKD59wHeThjRsxsfb5rbWQeQhqlP0u9L+2qZyAkFlPtoVC1W4bqpZeDx6IrX0EMjI
 oa0bAkeWwNbEj4BqUx6CXJCabPC2Quc0LkvA3j0ak3KhMZpXIgXLyYaZHjlQSvH09MdR ug== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9r7ttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 04:24:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAS4OTLX001497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 04:24:30 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAS4OTdq006186;
        Wed, 28 Nov 2018 04:24:29 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 20:24:29 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Small typo fix
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181127210459.11809-1-ates@bu.edu>
Date:   Tue, 27 Nov 2018 21:24:22 -0700
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5740EF93-84C7-4234-B6F3-2D55271F06B1@oracle.com>
References: <20181127210459.11809-1-ates@bu.edu>
To:     Emre Ates <ates@bu.edu>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2018, at 2:04 PM, Emre Ates <ates@bu.edu> wrote:
>=20
> ---
> mm/vmstat.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 9c624595e904..cc7d04928c2e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1106,7 +1106,7 @@ int fragmentation_index(struct zone *zone, =
unsigned int order)
> 					TEXT_FOR_HIGHMEM(xx) xx =
"_movable",
>=20
> const char * const vmstat_text[] =3D {
> -	/* enum zone_stat_item countes */
> +	/* enum zone_stat_item counters */
> 	"nr_free_pages",
> 	"nr_zone_inactive_anon",
> 	"nr_zone_active_anon",
> --
> 2.19.1
>=20
> Signed-off-by: Emre Ates <ates@bu.edu>

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

