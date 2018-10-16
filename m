Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA412147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gge/84i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA412147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJQGZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:25:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQGZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:25:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GMTYr1005060;
        Tue, 16 Oct 2018 22:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=r0+fVZVlpyo7j9NLofyiMNtE1r7CMzg/nUyUgGfMFWA=;
 b=Gge/84i247xnI1jCITtxU/R1wLl633gA7ncpxnORghW9tAF/gxkmO+SslwSLlSmuOfZR
 ccckX+fEL+GubdZmBJyqvhgh1C7EIHhndSfMadXPrPdTTufWzuT3dbg61ZBgd97vsvlp
 E3SFsgf5g0N9s/ZpquZDnINbtbcEMC9HUyhVTr1dL8wnm+sG3/u9x0A8VzvJQ7fMbN2/
 EjmXyk+eMI4KHmNThqpukhthWIos7n5gnt9vurIMjhuOkJh1fX/JPUn9LAiHCeCm+uZy
 yVXJHTdZ3a2Hcc6J1t1P9SxdOSHdHP7dT5HitdFCYvbv/JzMq+X/aYSX58lhIFZnOyfV GA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brbgnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:33:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GMXEa9008944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:33:15 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GMXE3a023778;
        Tue, 16 Oct 2018 22:33:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 15:33:13 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: megaraid: remove set but not used variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180926110940.16024-1-yuehaibing@huawei.com>
Date:   Tue, 16 Oct 2018 18:33:11 -0400
In-Reply-To: <20180926110940.16024-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 26 Sep 2018 19:09:40 +0800")
Message-ID: <yq1va61plnc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 mlxscore=1 mlxlogscore=197
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_sync_scb':
> drivers/scsi/megaraid/megaraid_mbox.c:2193:14: warning:
>  variable 'ccb' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_reset_handler':
> drivers/scsi/megaraid/megaraid_mbox.c:2580:7: warning:
>  variable 'recovering' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'mbox_post_sync_cmd':
> drivers/scsi/megaraid/megaraid_mbox.c:2728:12: warning:
>  variable 'mbox64' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_support_random_del':
> drivers/scsi/megaraid/megaraid_mbox.c:3138:11: warning:
>  variable 'mbox' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_flush_cache':
> drivers/scsi/megaraid/megaraid_mbox.c:3266:10: warning:
>  variable 'mbox' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_fire_sync_cmd':
> drivers/scsi/megaraid/megaraid_mbox.c:3302:12: warning:
>  variable 'mbox64' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/megaraid/megaraid_mbox.c: In function 'gather_hbainfo':
> drivers/scsi/megaraid/megaraid_mbox.c:3797:10: warning:
>  variable 'dmajor' set but not used [-Wunused-but-set-variable]

Applied by hand to 4.20/scsi-queue due to conflict with Christoph's DMA
API cleanup.

-- 
Martin K. Petersen	Oracle Linux Engineering
