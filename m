Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A33C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86820854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T37IkL7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C86820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeIMBbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKO6D5041220;
        Wed, 12 Sep 2018 20:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BgUFdWmTW4g8bFO+cR3WOQwK/nWdihiqPWZP+p36KpQ=;
 b=T37IkL7fRt667QSrO0DhbhjBMVgkatGJQ8UWVbbEeUxcBVIuZjIDt7SuK+etZxmAPXoM
 ycfqNgV3jlG+onleGUryB/KSafqNUkKQJBbpssxkWKZCndlT9a/f+dsPmJZgMB2Q3ukd
 7XOer//7YFA6rqjh2BZLjVveW7lyhnoh4m2o0MCFt0tqkeIZRrfS2YEGQP4oNV6UDkGx
 Kk0yYuk9PkOg91FOzy3sgcz3/gk1y1zDkB3Ik031gm03LJp7L/5HzJrQOY+vNIP8cpTM
 kTKvJmvSbHjVUaMO91dHGeVfwBRLEMEzFGnXqV6RN78ja7hBX5ceMUYKgXhYQWcttZB/ sg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mc72qvbvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKP1i5015346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:01 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKP1BL015860;
        Wed, 12 Sep 2018 20:25:01 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:25:00 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 6/6] /proc/pid/numa_vamaps: document in Documentation/filesystems/proc.txt
Date:   Wed, 12 Sep 2018 13:24:04 -0700
Message-Id: <1536783844-4145-7-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for /proc/<pid>/numa_vamaps in
Documentation/filesystems/proc.txt

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 Documentation/filesystems/proc.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 22b4b00..7095216 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -150,6 +150,9 @@ Table 1-1: Process specific entries in /proc
 		each mapping and flags associated with it
  numa_maps	an extension based on maps, showing the memory locality and
 		binding policy as well as mem usage (in pages) of each mapping.
+ numa_vamaps	Presents information about mapped address ranges to numa node
+		from where the physical memory is allocated.
+
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
@@ -571,6 +574,24 @@ Where:
 node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
 size, in KB, that is backing the mapping up.
 
+The /proc/pid/numa_vamaps shows mapped address ranges to numa node id from
+where the physical pages are allocated. For mapped address ranges not having
+any pages mapped a '-' is shown instead of the node id. Each line in the file
+will show address range to one numa node.
+
+address-range	numa-node-id
+
+00400000-00410000 N1
+00410000-0047f000 N0
+0047f000-00480000 N2
+00480000-00481000 -
+00481000-004a0000 N0
+004a0000-004a2000 -
+004a2000-004aa000 N2
+004aa000-004ad000 N0
+004ad000-004ae000 -
+..
+
 1.2 Kernel data
 ---------------
 
-- 
2.7.4

