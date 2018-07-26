Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1493CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A192083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A192083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbeGZSvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:51:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731646AbeGZSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:50:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6QHSqXT043157
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:33:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kfj32stsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:33:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 18:33:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 18:33:04 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6QHX3hT39125130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jul 2018 17:33:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5576A4051;
        Thu, 26 Jul 2018 20:33:16 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C75C3A404D;
        Thu, 26 Jul 2018 20:33:14 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Jul 2018 20:33:14 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 26 Jul 2018 20:33:00 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 7/7] docs/core-api: mm-api: add section about GFP flags
Date:   Thu, 26 Jul 2018 20:32:40 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532626360-16650-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532626360-16650-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072617-4275-0000-0000-0000029E6E4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072617-4276-0000-0000-000037A672E0
Message-Id: <1532626360-16650-8-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807260180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/mm-api.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index b5913aa..46ae353 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -14,6 +14,27 @@ User Space Memory Access
 .. kernel-doc:: mm/util.c
    :functions: get_user_pages_fast
 
+Memory Allocation Controls
+==========================
+
+Functions which need to allocate memory often use GFP flags to express
+how that memory should be allocated. The GFP acronym stands for "get
+free pages", the underlying memory allocation function. Not every GFP
+flag is allowed to every function which may allocate memory. Most
+users will want to use a plain ``GFP_KERNEL``.
+
+.. kernel-doc:: include/linux/gfp.h
+   :doc: Page mobility and placement hints
+
+.. kernel-doc:: include/linux/gfp.h
+   :doc: Watermark modifiers
+
+.. kernel-doc:: include/linux/gfp.h
+   :doc: Reclaim modifiers
+
+.. kernel-doc:: include/linux/gfp.h
+   :doc: Common combinations
+
 The Slab Cache
 ==============
 
-- 
2.7.4

