Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F74C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DBC2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dWa69Sc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DBC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeLFER4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:17:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeLFERz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:17:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB64EHMr114109;
        Thu, 6 Dec 2018 04:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bu9/d6xqTZ19J8LHsvHXMGN9Q1LnMmEOm/aiDIYTwS4=;
 b=dWa69Sc0mCDfueI9vB1vzVy7nKmMC9m2GlzV43E+8cNWSd/LvEnBKmr9cAT4PLEPEN5G
 0I293oZgksIM8ElN5Bu5WC2AC7eW8qhDeKppVT0d8hL0tcqKGoH5wGbQf6jdRVm42g1x
 URiRj7wy9SNCsvBPrqvZ8A1RAjd4MBv1eHCbdhFFv+K2YFFPtvC2f9M6NFIoKWgsXIUl
 l7XqmsGN4X6oeQo0TtemMBHHN35TyrJOND6HwNyGY4N1UcUX6X2zF/fz+C6r+G/jcslZ
 yYuu5lo/N/AWOCJml5nIUw9twIgwt52PP5tc/a+dR8LwyrHYDLZpn+BE7uhTLHijdMZy Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p3jxrnyfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 04:17:48 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB64HlUd010944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 04:17:47 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB64HkNw025298;
        Thu, 6 Dec 2018 04:17:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 20:17:46 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v3 4/4] scsi: hisi_sas: Add support for DIF feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1543838994-30028-1-git-send-email-john.garry@huawei.com>
        <1543838994-30028-5-git-send-email-john.garry@huawei.com>
        <yq1ftveszew.fsf@oracle.com>
        <358aae82-394e-9df2-6b05-5af8e0f196b3@huawei.com>
        <yq1k1kosorw.fsf@oracle.com>
        <9c08d3fa-5043-7d38-7b6c-574b7344409b@huawei.com>
Date:   Wed, 05 Dec 2018 23:17:43 -0500
In-Reply-To: <9c08d3fa-5043-7d38-7b6c-574b7344409b@huawei.com> (John Garry's
        message of "Wed, 5 Dec 2018 15:12:27 +0000")
Message-ID: <yq1in07p9ug.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=492
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> patchset with DIF and DIX support separated out, and we can leave the
> DIX patch in limbo until we get to the bottom of the DIX issue.

Sure.

-- 
Martin K. Petersen	Oracle Linux Engineering
