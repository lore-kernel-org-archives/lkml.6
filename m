Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qpb5/pB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJKJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:23:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:23:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B1so5g032186;
        Thu, 11 Oct 2018 01:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=YrffBd6yVKUn2MDdxdq1tLEj3VMrRSytXeHAJhWE4cU=;
 b=qpb5/pB1qyM4Cz6pUtQbsiRIOz63GKghjnaxNI0IbsF3UjjbGya/2nBDBTMuwwmzSueD
 fc4HtwIKi1hwxodQESZbVMjQv0U35kZXRetjgWnk8IZVOu/dDCKmNOMVmTonFxzrtBat
 RGDE/qqZbBA3BZk1rchHb9uPJ55eB0cTeezYqQl5j3p8FetXOOMiypZF7qG1/FydZl0d
 HncvY315OYeNrkIQ11dDUGNnpoW4vmRBcIpwQbzQ/azIcYeL0AtGKdkLeUhAMpTtaXE6
 fJzgbFIwkRgB8nEopIgLXVdFyW5AkCEUZYG4J4VSAOik4Sp2NQdyPeeKBwEMlVgjCo7D mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7hk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 01:58:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9B1wRYk006515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 01:58:28 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B1wRfu032442;
        Thu, 11 Oct 2018 01:58:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 01:58:27 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
Date:   Wed, 10 Oct 2018 21:58:25 -0400
In-Reply-To: <1537801594-207139-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 24 Sep 2018 23:06:27 +0800")
Message-ID: <yq18t354532.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> However it does block us in future from enabling SCSI MQ in the driver.

We're going to remove the legacy I/O path so I'm not particularly keen
on merging something that's going in the opposite direction.

> This is because the IPTT index must be a unique value per HBA. However,
> if we switched to SCSI MQ, the block layer tag becomes unique per queue,
> and not per HBA.

That doesn't sound right.

-- 
Martin K. Petersen	Oracle Linux Engineering
