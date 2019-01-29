Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F6CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A2D2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uMWjhhA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfA2GRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:17:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfA2GRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:17:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T698Oh126070;
        Tue, 29 Jan 2019 06:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cxOOuBiDxSqVoXdgoRodmHJoKbbZvgIK1NK1+8BquyY=;
 b=uMWjhhA/RY9Nt+3ku0Ulm7/89bbghsUJ3hF33WA+vFZMpNUPP8AbvJnDA3ZbqsUsF0Rm
 t1QnrPvlDxVkENwBEWgUIcQTnKzaqSrSzAdPDOE0Y0rLMGlO0B6ReyFuNU0BWAvG8aYC
 jKwoh0T5ncOsvSl92xfel3aIHpil/2En3q7GGL/GR3/RE/Hr5W4OVO9R9OtGxnml+C3X
 LZ893Dyv3RDv4QDNnidbMSKKUHC0Da3o080Z4AAd5gIamBl0T9FQlhtq7l36/aLWF7fD
 hS7y4b0r1OTJ/fLmyOKFn03gTuSQFSRsRddZ0cHMzLiJ+ar6QDXfygrS9H97hPGCHldD zg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q8eyuaaxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:16:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6GruT018670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:16:53 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6Gq2f002228;
        Tue, 29 Jan 2019 06:16:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 22:16:52 -0800
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: fnic: Remove set but not used variable 'vdev'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190125020014.11184-1-yuehaibing@huawei.com>
Date:   Tue, 29 Jan 2019 01:16:49 -0500
In-Reply-To: <20190125020014.11184-1-yuehaibing@huawei.com> (YueHaibing's
        message of "Fri, 25 Jan 2019 10:00:14 +0800")
Message-ID: <yq1ef8wdm3y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=738
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/fnic/vnic_wq.c: In function 'vnic_wq_alloc_bufs':
> drivers/scsi/fnic/vnic_wq.c:50:19: warning:
>  variable 'vdev' set but not used [-Wunused-but-set-variable]
>
> drivers/scsi/fnic/vnic_rq.c: In function 'vnic_rq_alloc_bufs':
> drivers/scsi/fnic/vnic_rq.c:30:19: warning:
>  variable 'vdev' set but not used [-Wunused-but-set-variable]

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
