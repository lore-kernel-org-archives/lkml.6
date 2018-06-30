Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BAC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E8924916
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E8924916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeF3OzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:55:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750802AbeF3OzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErVI0124364
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx5v4t9d8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:15 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtATR18677928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C2FAE051;
        Sat, 30 Jun 2018 15:55:00 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB5D6AE04D;
        Sat, 30 Jun 2018 15:54:58 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:54:58 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 00/11] docs/mm: add boot time memory management docs
Date:   Sat, 30 Jun 2018 17:54:55 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18063014-0016-0000-0000-000001E1E348
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0017-0000-0000-0000323632A8
Message-Id: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Both bootmem and memblock have pretty good documentation coverage. With
some fixups and additions we get a nice overall description.

v2 changes:
* address Randy's comments

Mike Rapoport (11):
  mm/bootmem: drop duplicated kernel-doc comments
  docs/mm: nobootmem: fixup kernel-doc comments
  docs/mm: bootmem: fix kernel-doc warnings
  docs/mm: bootmem: add kernel-doc description of 'struct bootmem_data'
  docs/mm: bootmem: add overview documentation
  mm/memblock: add a name for memblock flags enumeration
  docs/mm: memblock: update kernel-doc comments
  docs/mm: memblock: add kernel-doc comments for memblock_add[_node]
  docs/mm: memblock: add kernel-doc description for memblock types
  docs/mm: memblock: add overview documentation
  docs/mm: add description of boot time memory management

 Documentation/core-api/boot-time-mm.rst |  92 +++++++++++++++
 Documentation/core-api/index.rst        |   1 +
 include/linux/bootmem.h                 |  17 ++-
 include/linux/memblock.h                |  76 ++++++++----
 mm/bootmem.c                            | 159 +++++++++----------------
 mm/memblock.c                           | 203 +++++++++++++++++++++++---------
 mm/nobootmem.c                          |  20 +++-
 7 files changed, 380 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/core-api/boot-time-mm.rst

-- 
2.7.4

