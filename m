Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40FC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A622083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWuLEH+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A622083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937165AbeFSCHE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:07:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937001AbeFSCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:07:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J202lo013913;
        Tue, 19 Jun 2018 02:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=MrCTUc+y3Df8tNEI2llMwixTipNHQEYimC3fAckEubU=;
 b=qWuLEH+rC5RNAEXMrErpYuUWNj0K6GzDR+vrQMFSF29pJeV9sGS7LjfxIJB49ZdowgRx
 ESXI1XG1wgPkpwdmweIOAK0gsXZfKvPYYWhVibS9GESeE2sq39HdC25OZC2J58QeGgL/
 9tSHCH4aaTCDr18e9hTb4eYXL6vtEi1erAgpNWbQAk5JdhXb3YMTiuua681UQvVMyx/Y
 Wx62EeV/mT9HpIy5XvZBKrRHfAoRSCis+sgZi78aS/kbyKejM6GQ8YOcqWbWen+SEx/p
 rSX33U8H/wUzdv92I7adXqXlcXcSE/CsLYqzLys/AAJqd1pEgf1oIv3pIoFRSMx7bVhU gg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jmt01e9fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:06:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J26wV9029891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:06:58 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J26vFl003544;
        Tue, 19 Jun 2018 02:06:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 19:06:57 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] scsi: remove Scsi_Cmnd typedef
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180613075349.7509-1-jthumshirn@suse.de>
        <20180613075349.7509-2-jthumshirn@suse.de>
Date:   Mon, 18 Jun 2018 22:06:55 -0400
In-Reply-To: <20180613075349.7509-2-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Wed, 13 Jun 2018 09:53:47 +0200")
Message-ID: <yq1wouvil6o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=484
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> This will make subsequent refactoring easier to handle.

So much yes!

Applied to 4.19/scsi-queue. Please fix up patches 2 and 3.

-- 
Martin K. Petersen	Oracle Linux Engineering
