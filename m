Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C3FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7A22085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0qDA3veG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7A22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbeKFTKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:10:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:10:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA69hwmF085680;
        Tue, 6 Nov 2018 09:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=tD7ZJ7tOM4z9u8Iruq0Ff71UI5ebhD1tLfBiF5eP3JY=;
 b=0qDA3veGgv1Kqe4yS3BF59iOnqzM9ooJMsgFdDbdCmamUfUmgLYFTidfW1wm83pxhl34
 dGHIsx5j7iccBSMYk7UcysGc669oU72y6AMeT/y7daluLzYX45Hq0l8neFABAeVVDDbC
 FFrZcGvw7XQAFNrr4q2sYe9cMrQcEJs6clgIiA15spaYCxzbqFNDSRv904UIkPomieZH
 S5KNJSFEkThAvshIZfbMFfqVDtBAB74D1ioTmYDp3M9xl389ZHPCuZzUJakbNTPY4vO1
 ki6tMY/LT68P0rTjy4OIzbQEXXNH+6MhrfzPYHr4qdLb09RcNONl0AhlkNbNpt3m/qr/ zw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33tv4j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 09:45:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA69jWbd013770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 09:45:32 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA69jUXC001617;
        Tue, 6 Nov 2018 09:45:30 GMT
Received: from [192.168.0.191] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 01:45:30 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   William Kucharski <william.kucharski@oracle.com>
X-Mailer: iPad Mail (16C5036c)
In-Reply-To: <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
Date:   Tue, 6 Nov 2018 02:45:28 -0700
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <210D9DA6-67F2-4CF3-94FC-883AA890F53A@oracle.com>
References: <20181105204000.129023-1-bvanassche@acm.org> <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2018, at 14:13, Andrew Morton <akpm@linux-foundation.org> wrote:=

>=20
>> On Mon,  5 Nov 2018 12:40:00 -0800 Bart Van Assche <bvanassche@acm.org> w=
rote:
>> -    return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
>> +    return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;
>> }
>>=20
>> /*
>=20
> I suppose so.
>=20
> That function seems too clever for its own good :(.  I wonder if these
> branch-avoiding tricks are really worthwhile.

At the very least I'd like to see some comments added as to why that approac=
h was taken for the sake of future maintainers.

William Kucharski


