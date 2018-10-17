Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5BAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57778214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OwR4uyrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57778214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJQJd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:33:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54850 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:33:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H1Xm5E184269;
        Wed, 17 Oct 2018 01:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CMGSH3rds+XgvKU8gOAqCCCf4C7VuqTf+5HtxMpLLRw=;
 b=OwR4uyrXXpnBATE+e2V/7lhUrnf4DoRuAbcOz5ua6x6qNn/4xLFbEq6jbfP32xT7vfy1
 kCFe+7HyqFZ6FXQWwQe1bHlN1de2sQowuEjwUyYEBBrQrjksQ5A6B7JT1EI3GvzJ5cQ2
 ZBBPQO5hqUzSK0gWWTqSI5ML9fZrkhXcTBSzxNXqCJmAYEw5ClkTkc7sR5B9rubAqVEJ
 A4Ww6YoD8/Pd/qPVYUjk6LAOaHtl1WFos0CPlnPBx1ffSBpz1w0LBUGiDpblklwyYsrA
 qBfqlLZHN+Y1I6DsXbFwZuv9AewgE6n62odxy2NXn6/dR+02XPXNx0cWlbCNFsrAFv5k 2A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n38nq4311-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:40:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1e9u8002843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:40:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1e9RB013210;
        Wed, 17 Oct 2018 01:40:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 18:40:09 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: Use proper enumerated type in atapi_d2h_reg_frame_handler
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180927001150.26212-1-natechancellor@gmail.com>
Date:   Tue, 16 Oct 2018 21:40:07 -0400
In-Reply-To: <20180927001150.26212-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Wed, 26 Sep 2018 17:11:50 -0700")
Message-ID: <yq1in21pczs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=378
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> -			status = SCI_IO_FAILURE_RESPONSE_VALID;
> +			status = SCI_FAILURE_IO_RESPONSE_VALID;

Naming fail!

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
