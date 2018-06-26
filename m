Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D843C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FD121525
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fC9giAn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FD121525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeFZQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:29:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeFZQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:29:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QGNTJ6161118;
        Tue, 26 Jun 2018 16:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=yl9aB5FF1V3sTEalAgNqhnj3J+r/VbUWCut2TV3+T14=;
 b=fC9giAn46rjvCYxKKSNr2c6VdnPfkAdD+YCVy6HGKcQoKExrP106D4VsKML3JYo+Twby
 JLngKSbUlhE5BXqzwiuQIBDxmebE5w0ggKTahafUCJYzxWnEnXBE+De9yXYJqyYxYHbk
 //wrDyr9g5At/MFQdQA6giq8633e6Rgph9WvuZ+0JuVSb8GcR1fHVoS9dYlaUe4n8WFK
 M1JT2ABZMtkla/cA4sp4PlXyF6eR4+fnskCozBdHBKEjIzemfy4azUxpwqQvFrnboUbz
 raDVGYK4nCUibaj4/iUtbpRklyw4qmMQ02PxS9Hvki5QZAQ9pTU5OsRbMAWuIBwbs2Dg Hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jum57sb6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 16:28:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QGSucP001813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 16:28:56 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QGSuVc032250;
        Tue, 26 Jun 2018 16:28:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 09:28:55 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Preparation patch-set for SCSI results rework
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180625112059.12872-1-jthumshirn@suse.de>
Date:   Tue, 26 Jun 2018 12:28:54 -0400
In-Reply-To: <20180625112059.12872-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Mon, 25 Jun 2018 13:20:57 +0200")
Message-ID: <yq18t714im1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=635
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> This is small patch set with obvious prep patches for the SCSI results
> rework discussed at LFS/MM and other occasions on the list.

Applied to 4.19/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
