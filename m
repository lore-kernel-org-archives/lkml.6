Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9281C04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76312215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76312215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHQRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:51:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727654AbeHQRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:51:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HEiAH3106572
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:47:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kwwjkqe6d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 10:47:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 17 Aug 2018 15:47:32 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 15:47:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HElSbQ37748882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 14:47:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF47AE04D;
        Fri, 17 Aug 2018 17:47:11 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD426AE051;
        Fri, 17 Aug 2018 17:47:09 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Aug 2018 17:47:09 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 17 Aug 2018 17:47:25 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] docs: core-api/mm-api: add a lable for GFP flags section
Date:   Fri, 17 Aug 2018 17:47:15 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081714-0016-0000-0000-000001F83AC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081714-0017-0000-0000-0000324E7802
Message-Id: <1534517236-16762-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/mm-api.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 46ae353..5ce1ec1 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -14,6 +14,8 @@ User Space Memory Access
 .. kernel-doc:: mm/util.c
    :functions: get_user_pages_fast
 
+.. _mm-api-gfp-flags:
+
 Memory Allocation Controls
 ==========================
 
-- 
2.7.4

