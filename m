Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08052C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4198208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hw31VadW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4198208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeGKCzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:55:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:55:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6B2j23n010225;
        Wed, 11 Jul 2018 02:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=uy2Q6Fijo5UDtucvpNGAL2QpPssY0if79atjWuoV5Fo=;
 b=hw31VadWDtk5Sl9s27YzgNKreYmCyj65iiznSRKO9hImq/hac5WoRQA7WeFGUgb+rZ3E
 vkz52D1pBt75habGvqE5W34Xo+r5AcjIr8ieg3m0eMHv8aXr/kZgZQf5Fb3tzwEXjMsG
 YH/4OdxXelOBfqT+70uLIKwx5xG3zbW3h8sOoMyL5Jp52TtZFmHJdFxD2PD6dSj8ipP3
 cwiZVoghTmLOJitiSG92wuHqb8aRCgf53q5+CCd4UbAu7FtVo5Ij3WgNRJT8MOYlFF44
 DrNRVao0xhBIAskMx3Oy3E5oejLdajWhm5+gjVYGzrh/n4CqPe9hR5jZxtilj55naHF+ sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k2p7vca6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:53:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6B2rfU4009770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:53:41 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6B2rf6C009437;
        Wed, 11 Jul 2018 02:53:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 02:53:41 +0000
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/4] SCSI results rework preparation part 2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180705110140.19545-1-jthumshirn@suse.de>
Date:   Tue, 10 Jul 2018 22:53:39 -0400
In-Reply-To: <20180705110140.19545-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Thu, 5 Jul 2018 13:01:36 +0200")
Message-ID: <yq1va9mo53g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> As the first part of the preparation work for my scsi results handling
> rework is done, here's the second batch.
>
> The first patch changes the AAC_STAT_GOOD define into an open-coded
> version in aacraid. The other three patches convert the three
> ScsiResult() macros in bfa, lpfc and ncr53c8xx to their open-coded
> equivalen.
>
> This is helpful for subsequent refactoring, as it's easier to identify
> which code parts need more work and Coccinelle Spatches are easier to
> apply.

Applied to 4.19/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
