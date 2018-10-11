Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B24EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63E92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t7KszScS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeJKJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:19:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:19:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B1sWEB032080;
        Thu, 11 Oct 2018 01:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yfavJjfhVoCw2R4O30ZGIq3149w9ikL4D4t8TZakXIM=;
 b=t7KszScStU+kjVAkCBzrFdhG11p2vYLFmh5/aeJ6HUsuPTtRtruKtp61HkXDg/kX4XrU
 DpyHFq4bWQNNinZ3o3HzgsSAHgJ869dq7feoxIWgFtpBK71RfPTEsbm6zThiyPBtspbV
 mpoGm6L02xWiaYK+JYkjGpwFffb1JLAO7xjBKW/SvZCvNHDR2GXBmBlo+EZguSAHEcC6
 lO6kZTz9vT75RDc45dAycMZ81T7tEEpFEdtu80fO7EKysUEP4jmSM37CIvYlOrZ2IrM5
 JhLX2C2q01TEYT5oIUi7rf89D7NqJInv/eMlhw8ko1LHYW/W9M4Yfwa/CEoke7N/Z118 Ug== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7hbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 01:54:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9B1sZou031908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 01:54:35 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9B1sY7W004451;
        Thu, 11 Oct 2018 01:54:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 01:54:34 +0000
To:     Joe Perches <joe@perches.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Neaten logging uses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1537183087.git.joe@perches.com>
Date:   Wed, 10 Oct 2018 21:54:25 -0400
In-Reply-To: <cover.1537183087.git.joe@perches.com> (Joe Perches's message of
        "Mon, 17 Sep 2018 08:01:07 -0700")
Message-ID: <yq1d0sh459q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe,

> Several defects exist in the logging uses
>
> o Missing KERN_<LEVEL>
> o Unnecessary KERN_<LEVEL> uses with panic
> o Mismatched MPT3SAS_FMT and %s: with name and __func__
>
> Correct these defects and perhaps add some clarity to the logging.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
