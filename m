Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA697C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7122190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBGO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:27:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbfBGO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:27:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17EH45i043013
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 09:27:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qgncykqnf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:27:33 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 7 Feb 2019 14:27:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 14:27:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17ERRhf5505452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 14:27:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C847B42047;
        Thu,  7 Feb 2019 14:27:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5272D4203F;
        Thu,  7 Feb 2019 14:27:26 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Feb 2019 14:27:26 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 07 Feb 2019 16:27:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RESEND PATCH 0/3] docs/core-api/mm: fix return value descriptions
Date:   Thu,  7 Feb 2019 16:27:21 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19020714-0016-0000-0000-00000253A4C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020714-0017-0000-0000-000032ADB365
Message-Id: <1549549644-4903-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many kernel-doc comments referenced by Documentation/core-api/mm-api.rst
have the return value descriptions misformatted or lack it completely. This
makes kernel-doc script unhappy and produces more than 100 warnings when
running 

	make htmldocs V=1

These patches fix the formatting of present return value descriptions and
add some new ones.

As these patches touch lots of mm/ files, I think it's better to merge them
via -mm tree.

Side note:
----------
I've noticed that kernel-doc produces

	warning: contents before sections

when it is parsing description of a function that has no parameters, but
does have a return value, i.e.

	unsigned long nr_free_buffer_pages(void)

As far as I can tell, the generated html is ok no matter if the detailed
description present before 'the sections', so probably this warning is not
really needed?

Mike Rapoport (3):
  docs/mm: vmalloc: re-indent kernel-doc comemnts
  docs/core-api/mm: fix user memory accessors formatting
  docs/core-api/mm: fix return value descriptions in mm/

 arch/x86/include/asm/uaccess.h |  24 +--
 arch/x86/lib/usercopy_32.c     |   8 +-
 mm/dmapool.c                   |  13 +-
 mm/filemap.c                   |  73 ++++++--
 mm/memory.c                    |  26 ++-
 mm/mempool.c                   |   8 +
 mm/page-writeback.c            |  24 ++-
 mm/page_alloc.c                |  24 ++-
 mm/readahead.c                 |   2 +
 mm/slab.c                      |  14 ++
 mm/slab_common.c               |   6 +
 mm/truncate.c                  |   6 +-
 mm/util.c                      |  37 ++--
 mm/vmalloc.c                   | 394 ++++++++++++++++++++++-------------------
 14 files changed, 409 insertions(+), 250 deletions(-)

-- 
2.7.4

