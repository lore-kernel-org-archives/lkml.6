Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6507C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PbvBypwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4642420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeILGUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:20:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeILGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:20:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8C19xK6046480;
        Wed, 12 Sep 2018 01:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Q3ljhs0FtyHAHNHsIUAuPYv4StgxzkpJS5YxXB0hw4Q=;
 b=PbvBypwhE68AsMKK3JZLVmqfYazKF8h6C0UFIfGRwONzEqzwpCIt3EHcW2Qyg2sGjpSd
 uDn5RSJZdQPjY0zSRnhlF7kpsC7DxOGYoI62YaDP/nluGBO6OamTD7XgGOXh1/Wuf2mz
 TotLsiQR4KoJPz6zykVVWPM4f7SXVRmE2dXRMSV3LarPHGs8d7eSfYNJol2QEVehqvA3
 660alL9E84wfBHYLXRYPNHahFEKnN442bKI3QxTyepcNv1JLGQeSMvsN6AiK+Blzp3qN
 /wBVZjAFkDyDP2rO+ppfUgWwQDd7be5B5xP2gK036Gu/DboS1trIhn9iWmsGKwZIA8tH IQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mc72qq9gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 01:18:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8C1IYO1023598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 01:18:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8C1IYHA029038;
        Wed, 12 Sep 2018 01:18:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 18:18:34 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] scsi: message: fusion: fix a few trivial spelling mistakes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180910091107.26366-1-colin.king@canonical.com>
Date:   Tue, 11 Sep 2018 21:18:31 -0400
In-Reply-To: <20180910091107.26366-1-colin.king@canonical.com> (Colin King's
        message of "Mon, 10 Sep 2018 10:11:07 +0100")
Message-ID: <yq1tvmvwm1k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> From: Colin Ian King <colin.king@canonical.com>
>
> Trival fix to spelling mistakes:
>  PrimativeSeqErrCount -> PrimitiveSeqErrCount
>  Primative -> Primitive
>  primative -> primitive
>  mptsas_broadcast_primative_work -> mptsas_broadcast_primitive_work
>  Broadcase -> Broadcast

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
