Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4B52073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v/y4OEl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4B52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeH3P13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:27:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47612 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3P13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:27:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UBODxJ139970;
        Thu, 30 Aug 2018 11:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=kGsmpmR8N/cfibv8q0WBLQdCh/nx6GWEOOEefuGMr2I=;
 b=v/y4OEl32LjdpupMgIfJTfimveppgoEzgM1d7o5coSAImXFVqEdfmxT4myypmAmrhCNd
 IgvtFuGyUWtuQuL8AvMetA6BDutzPOUBjQaQRMdjf30t82lp6QpmPMdqZ2Ca3ka51W4v
 6FCt2ScU1cbCymrOUCyhTjDlJSgw896AmsT53efYUgRe3LeRDzXesmQQFGcbbUvmO7lT
 i2msHKrZ089Y5h0WoThYiQMDVkLBU9WifEVXqnalbnj35IktrDr/Z/36m4q7536RlN9B
 gG/LA/q1M6K6VH2RXuEuUgMIujan9oJWjRipD37RD8JX5hCvffimwSRzaVUZMrNxUp++ iQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrqgv96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:25:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBPfmK018021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:25:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBPe8l030644;
        Thu, 30 Aug 2018 11:25:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 04:25:40 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aacraid: remove unused variables dev and cpu
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180816133320.19682-1-colin.king@canonical.com>
Date:   Thu, 30 Aug 2018 07:25:37 -0400
In-Reply-To: <20180816133320.19682-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 16 Aug 2018 14:33:20 +0100")
Message-ID: <yq1zhx43xla.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=633
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variables dev and cpu are not being used and are redundant and hence
> can be removed.
>
> Cleans up clang warnings:
> warning: variable 'dev' set but not used [-Wunused-but-set-variable]
> warning: variable 'cpu' set but not used [-Wunused-but-set-variable]

Applied to 4.20/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
