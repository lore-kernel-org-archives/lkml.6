Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB4ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFEF20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFEF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeINOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:41:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727670AbeINOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:41:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E9OFuo033181
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:28:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mg9hs28h0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:28:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 10:28:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 10:28:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8E9S5aE43450372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 09:28:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF81D4C050;
        Fri, 14 Sep 2018 12:27:55 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 036AB4C044;
        Fri, 14 Sep 2018 12:27:54 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Sep 2018 12:27:53 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 12:28:02 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v4 1/3] docs: core-api/gfp_mask-from-fs-io: add a label for cross-referencing
Date:   Fri, 14 Sep 2018 12:27:56 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536917278-31191-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091409-0016-0000-0000-000002055046
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091409-0017-0000-0000-0000325C2554
Message-Id: <1536917278-31191-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/gfp_mask-from-fs-io.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index e0df8f4..e7c32a8 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -1,3 +1,5 @@
+.. _gfp_mask_from_fs_io:
+
 =================================
 GFP masks used from FS/IO context
 =================================
-- 
2.7.4

