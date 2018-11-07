Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62AFC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CnrrIJld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeKGLVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:21:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbeKGLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:21:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA71n0PP061373;
        Wed, 7 Nov 2018 01:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VzX2RqtAcG2y/JosTYz/+A0Bk9zonMxgllc4MjyCdd4=;
 b=CnrrIJldwJmLi+Qx/V993LRYOSp59se+wOpsv2n4NHOlP4vTq9cW+8SRJh0WFYCa6JMc
 4BWKNJK/fwf4j5ELKJbu1YKuiyrSR2dKkX99o/akWzUouNWV6Z4O1tB+KC87Xft9MuU6
 iBmWPIzuvZeWT2lH4sGECy48qepb/UlWsjKcYG2uAx530NzdwyflXQQK9GtspM3q7eTt
 U9dJZmB2nywmCokaAO5beKLP4+RurRlrYwJijNzzCNXvcOGy3ElEvu/gMzmMj49YbtNj
 aE/oH3/REobaauHOeI+Rfe3qyDL9CEZQmL8PFyiRbJ8H4VUfMopYlKztYo2H0AYthdWD Mg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4aqrqnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 01:53:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA71r4Kd004760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 01:53:04 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA71r495029764;
        Wed, 7 Nov 2018 01:53:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Tue, 06 Nov 2018 17:52:23 -0800
ORGANIZATION: Oracle Corporation
USER-AGENT: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Message-ID: <yq1k1lp3b8q.fsf@oracle.com>
Date:   Tue, 6 Nov 2018 17:52:21 -0800 (PST)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the scsi-fixes
 tree
References: <20181107064834.734f322f@canb.auug.org.au>
In-Reply-To: <20181107064834.734f322f@canb.auug.org.au> <(Stephen>
 <Rothwell's> <message> <of> <"Wed> <> <7> <Nov> <2018> <06:48:34> <+1100")>
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

> Commit
>
>   85ee0a7b2d53 ("Revert "scsi: ufs: Disable blk-mq for now"")
>
> is missing a Signed-off-by from its author and committer.

Fixed up, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
