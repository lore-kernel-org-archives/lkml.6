Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3A21848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWNWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:22:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAWNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:22:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NDHFfw099155
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:22:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6q2ydb1n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:22:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 23 Jan 2019 13:22:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 13:22:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NDMWDA50987206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 13:22:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 186CBA4060;
        Wed, 23 Jan 2019 13:22:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F10EEA405B;
        Wed, 23 Jan 2019 13:22:31 +0000 (GMT)
Received: from [9.152.212.191] (unknown [9.152.212.191])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jan 2019 13:22:31 +0000 (GMT)
Subject: Re: [PATCH] gcov: no need to check return value of debugfs_create
 functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190122152151.16139-49-gregkh@linuxfoundation.org>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 23 Jan 2019 14:22:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-49-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012313-0012-0000-0000-000002EBDEE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012313-0013-0000-0000-000021230E69
Message-Id: <b277b33b-bcc0-c1c5-52d6-9e1580531df3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.2019 16:21, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Also delete the dentry variable as it is never needed.
> 
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/gcov/fs.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Compile test was successful, but the patch introduces a compile warning.
Could you merge the attached patch?

8<===
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Subject: [PATCH] gcov: Fix compiler warning

Fix compiler warning when compiling with CONFIG_GCOV_KERNEL=y:

  CC      kernel/gcov/fs.o
kernel/gcov/fs.c: In function ‘gcov_fs_init’:
kernel/gcov/fs.c:756:6: warning: unused variable ‘rc’ [-Wunused-variable]
  int rc = -EIO;
      ^~

Signed-off-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
---
 kernel/gcov/fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index aa9a49f72024..e5eb5ea7ea59 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -753,8 +753,6 @@ void gcov_event(enum gcov_action action, struct gcov_info *info)
 /* Create debugfs entries. */
 static __init int gcov_fs_init(void)
 {
-	int rc = -EIO;
-
 	init_node(&root_node, NULL, NULL, NULL);
 	/*
 	 * /sys/kernel/debug/gcov will be parent for the reset control file
-- 
2.17.0

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

