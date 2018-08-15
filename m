Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17CBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1F8214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNkAnW+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1F8214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeHOSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:51:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeHOSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:51:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7FFrqLD144658;
        Wed, 15 Aug 2018 15:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=A2KAu6tSCJn9RyXv/XUF6p+rsFNRNu7EU6m2L5+Zei0=;
 b=SNkAnW+gdkOT5154VT90g1oRrIVkz3nwGHZkujmiP3yDNWoJF+UJq4HbENkT7MR+1eT9
 dePoIB6Vs55Bsnu97JdyUWPkgMrHVSj4ZSCSFqDc8OwMpBFrProIfTdRA1kROfsU0fhX
 SRAU3OzY6WEW+FrkrwBPqp1t0/jqoOPXE1s0GQzWAHUXllsZoJMu2vcaX5S8eQuZw5v3
 xMZ7I86+82vTlqZbcYZH3dvC7fvkRSbvGZZhK0Yq3tg+XVQlpU7pR98IQNm5iZBozRPj
 y0v6V3V2/mgJMP+s0rlestTK682VMfwaZnqHL2IA35utGn8kSms/fq7t39O1cUvvtyPY fA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ksreq57vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 15:58:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7FFwlp6010683
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 15:58:48 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7FFwlIF010132;
        Wed, 15 Aug 2018 15:58:47 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Aug 2018 08:58:47 -0700
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        JFS Discussion <jfs-discussion@lists.sourceforge.net>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [GIT PULL] jfs patches for v4.19
Openpgp: preference=signencrypt
Message-ID: <0937cae2-6fc5-49cb-1989-9472515fdeb4@oracle.com>
Date:   Wed, 15 Aug 2018 10:58:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=557
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba4dbdedd3edc2798659bcd8b1a184ea8bdd04dc:

  Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy
(2018-06-19 07:47:32 +0900)

are available in the Git repository at:

  git://github.com/kleikamp/linux-shaggy.git tags/jfs-4.19

for you to fetch changes up to bd646104ac5a6bf8bdddaeaf4e441f5d439ded96:

  jfs: use time64_t for otime (2018-06-19 14:09:30 -0500)

----------------------------------------------------------------
Just one jfs patch for 4.19

----------------------------------------------------------------
Arnd Bergmann (1):
      jfs: use time64_t for otime

 fs/jfs/jfs_incore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
