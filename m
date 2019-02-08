Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6335C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781DC2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E9hUK5Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfBHWdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:33:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47054 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:33:53 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x18MT0l2151703;
        Fri, 8 Feb 2019 22:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=DeXUG8dz+KtUUxfoLvRj2aLTjX1Q8xRJ9S307sRwFOs=;
 b=E9hUK5WlQvzutvfN16iMCKi5pkWHNANlp4wDTpG2gwaug+4pFQoFwZKoH4lhMUFq2ZGt
 /PkgE+I2+/fmoK8E4kzXAk91quNjkBKIR2J/JdzeiJ/miaGVBk1ngKQGZIUrpkGrrgoz
 X/iYDQhVKDQeiRqfogJglMvsZ8PsP1SW7KIa3LxT73qq0mmK6DRHYPJKrisOCIxEvY1c
 DEMjjY5ySpkysAl7dTDKR584barDaBfhuKWMZPwT/OeXgtcaE2C/li73hMcLjAo6H6ZD
 0JyR0N4jq6AWqrWUso8Zi4MX5UaaXpo+8J1PlYJqq4jTmSf0tqqXdsSWH03Co1+qJYtv Pw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qd97ff4yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 22:33:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x18MXRN9016615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 22:33:27 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x18MXQiH011008;
        Fri, 8 Feb 2019 22:33:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Feb 2019 14:33:26 -0800
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Brian King <brking@us.ibm.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Bradley Grove <bgrove@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5] scsi/ata: Use unsigned int for cmd's type in ioctls in scsi_host_template
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190126075256.29608-1-natechancellor@gmail.com>
        <20190207160719.28895-1-natechancellor@gmail.com>
Date:   Fri, 08 Feb 2019 17:33:22 -0500
In-Reply-To: <20190207160719.28895-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 7 Feb 2019 09:07:20 -0700")
Message-ID: <yq1pns1x64t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns several times in the scsi subsystem (trimmed for brevity):

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
