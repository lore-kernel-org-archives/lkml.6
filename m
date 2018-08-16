Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BE520C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BE520C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbeHPQC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:02:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391531AbeHPQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:02:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7GD0uGL122221
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:03:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kw6p4fqk6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:03:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 16 Aug 2018 14:03:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 14:03:43 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7GD3gYX37945558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Aug 2018 13:03:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E250AE064;
        Thu, 16 Aug 2018 16:03:26 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0647AAE057;
        Thu, 16 Aug 2018 16:03:25 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.148])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Aug 2018 16:03:24 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 16 Aug 2018 16:03:39 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] docs/core-api: add memory allocation guide
Date:   Thu, 16 Aug 2018 16:03:35 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18081613-0016-0000-0000-000001F7B1C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081613-0017-0000-0000-0000324DE84B
Message-Id: <1534424618-24713-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=742 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808160137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As Vlastimil mentioned at [1], it would be nice to have some guide about
memory allocation. This set adds such guide that summarizes the "best
practices". 

The changes from the RFC include additions and corrections from Michal and
Randy. I've also added markup to cross-reference the kernel-doc
documentation.

I've split the patch into three to separate labels addition to the exiting
files from the new contents.

Note that the second patch depends on the mm docs update [2] that Andrew
took to the -mm tree.

[1] https://www.spinics.net/lists/netfilter-devel/msg55542.html
[2] https://lkml.org/lkml/2018/7/26/684

Mike Rapoport (3):
  docs: core-api/gfp_mask-from-fs-io: add a label for cross-referencing
  docs: core-api/mm-api: add a lable for GFP flags section
  docs: core-api: add memory allocation guide

 Documentation/core-api/gfp_mask-from-fs-io.rst |   2 +
 Documentation/core-api/index.rst               |   1 +
 Documentation/core-api/memory-allocation.rst   | 124 +++++++++++++++++++++++++
 Documentation/core-api/mm-api.rst              |   2 +
 4 files changed, 129 insertions(+)
 create mode 100644 Documentation/core-api/memory-allocation.rst

-- 
2.7.4

