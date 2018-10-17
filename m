Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A33C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B90B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6OY8PmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B90B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeJQJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:33:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:33:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H1Xm1e184275;
        Wed, 17 Oct 2018 01:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+oFhzt/hxbeDQQu6awd/P0BBIRgGI2ut8Zt77C8VpcM=;
 b=m6OY8PmHfjJhESZv0WsQ7Bpt/SRBuLZ0UgiioDZdm2faQe4xacgkAyEABj20RYJrYlDU
 10sJrxn/pj+L9w80JNW/Wer1EgkVmsdAxrBYCr+/2OXc6F6kPhL/4ewd0m/3VuUa3BQm
 sJKbbsapTlWYQwfAQwrDjrj10/2OEz5JLsMsRFI77kjQJP8H5K0UMqKw9OXVQUxfSyRb
 1TCVEG/r7g5BRTzgaSQ55SMLEjvNRMbMU9g4ONORk6a86MKHPh8+izg6enTYgoUVkkNU
 31h+qo01g3JLzmNy8t2iWKQHa4BLp9CZkAeqhYLARbuOzLwGQeBDEr4Syb9vRLVleObC Pg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38nq431h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:40:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1eR58024731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:40:27 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1eRY9000643;
        Wed, 17 Oct 2018 01:40:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 18:40:27 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: Change sci_controller_start_task's return type to sci_status
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180927001200.26343-1-natechancellor@gmail.com>
Date:   Tue, 16 Oct 2018 21:40:24 -0400
In-Reply-To: <20180927001200.26343-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Wed, 26 Sep 2018 17:12:00 -0700")
Message-ID: <yq1efcppczb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=447
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Avoid all of these implicit conversion by just making
> sci_controller_start_task use sci_status. This silences Clang and has
> no functional change since sci_task_status has all of its values
> mapped to something in sci_status.

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
