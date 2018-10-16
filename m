Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBEB2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UJsdoWzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBEB2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJQGUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:20:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:20:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GMOnng057567;
        Tue, 16 Oct 2018 22:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=JAmk6JLMIFsLMKgFPeuFek9z0c1q5Zf2iwWRVuBPK90=;
 b=UJsdoWznrQ4gjmzJN01la/1TpLCeoirvZuEdbM0PNud5DDcUE5vaVLe3hNlSK3+BYzJP
 W72RCmwlgLxHRGumiYBU74x3wjbuKQnroBYrfwxKP1Lf0smz6yxCtYaJJkgxP8+4HzmS
 OP45UIK21RJLPIwKhmsvG6HZOuKjGkt55Ip1htAz5QQgPq59VsIBdFxibCFbwL0CcJBi
 Ei8yTcvpIhS+qtUXSlwPXyRP4zwQ1UGHvP6Xzn7ijBCLyvu3a4mY9Fjr+RlFHp2D7MQX
 RWOVGbW8UeMjlARVhBJTl0O6U8T+e5SZ5Id0bf4eA8YDI+9168FeDKSNqK87vRz7uCD5 MQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38nq3m39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:27:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GMRPMd026568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:27:25 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9GMROjE018999;
        Tue, 16 Oct 2018 22:27:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 15:27:24 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Simplify conditional check
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180921002723.16600-1-natechancellor@gmail.com>
Date:   Tue, 16 Oct 2018 18:27:21 -0400
In-Reply-To: <20180921002723.16600-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 20 Sep 2018 17:27:23 -0700")
Message-ID: <yq1zhvdplx2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang generates a warning when it sees a logical not followed by a
> conditional operator like ==, >, or < because it thinks that the logical
> not should be applied to the whole statement:

> Link: https://github.com/ClangBuiltLinux/linux/issues/80
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
