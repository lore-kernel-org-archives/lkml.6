Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48162C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478C21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GxVdnijF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E478C21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeHBWRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:17:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeHBWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:17:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w72KJY8G190815;
        Thu, 2 Aug 2018 20:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=SWfQ3v/xS9qKtPqvjEr53Qa6rz8nMP0bkUrc9fYq0Ag=;
 b=GxVdnijFmPcSI7pgXog0ddRsGafvYuXzKn+ZmuGY1yT2cQiLJ/DbkVjh2p9c+Xm/0S2X
 1MNuh+zDYeQr9UKOkZKYQr9jZr+qbSVdNYxk+aTWSnjKXYz0TqFiY/P2ts87fYnAIEjy
 +29+cdKdjNByX6KyzPI+7sh4z4ju/yIGeTbgfRIrh8EGxzdAy/er3nuqzN5zOu2iXsMR
 aorkVOL9zYjEjYRSVkt6IPXZofweEL6NKySQGVH3Kt7PUV83DzHBzp2MiGoA4XMcF0id
 +gklGt55auuJwdHUNm3gR84IYBoB23h1gYrmscXaVW2sluV/tmPRqmyRWOtTBjnSyYxS Jg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2km6j3rkw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 20:24:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w72KO1S4013078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 20:24:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w72KO03L020865;
        Thu, 2 Aug 2018 20:24:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Aug 2018 13:24:00 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SCSI] sym53c8xx: remove some redundant variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180801145841.5877-1-colin.king@canonical.com>
Date:   Thu, 02 Aug 2018 16:23:50 -0400
In-Reply-To: <20180801145841.5877-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 1 Aug 2018 15:58:41 +0100")
Message-ID: <yq1zhy4y0tl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8973 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=649
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808020200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variables scriptb0 and dp_sgmin are being assigned but are never
> used hence they are redundant and can be removed.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
