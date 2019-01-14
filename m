Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA95C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B145C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANLrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:47:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbfANLrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:47:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EBiwov142738
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:47:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0pskr34e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:47:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 14 Jan 2019 11:47:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 11:47:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EBlbGT51445822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 11:47:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C2652054;
        Mon, 14 Jan 2019 11:47:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 007BF52051;
        Mon, 14 Jan 2019 11:47:35 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 14 Jan 2019 13:47:35 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] docs/core-api: memory-allocation: add mention of kmem_cache_create_userspace
Date:   Mon, 14 Jan 2019 13:47:34 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19011411-4275-0000-0000-000002FEF2A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011411-4276-0000-0000-0000380D0B8B
Message-Id: <1547466454-29457-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention that when a part of a slab cache might be exported to the
userspace, the cache should be created using kmem_cache_create_usercopy()

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/core-api/memory-allocation.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 8954a88..51a200d 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -113,9 +113,11 @@ see :c:func:`kvmalloc_node` reference documentation. Note that
 
 If you need to allocate many identical objects you can use the slab
 cache allocator. The cache should be set up with
-:c:func:`kmem_cache_create` before it can be used. Afterwards
-:c:func:`kmem_cache_alloc` and its convenience wrappers can allocate
-memory from that cache.
+:c:func:`kmem_cache_create` or :c:func:`kmem_cache_create_usercopy`
+before it can be used. The second function should be used if a part of
+the cache might be copied to the userspace.  After the cache is
+created :c:func:`kmem_cache_alloc` and its convenience wrappers can
+allocate memory from that cache.
 
 When the allocated memory is no longer needed it must be freed. You
 can use :c:func:`kvfree` for the memory allocated with `kmalloc`,
-- 
2.7.4

