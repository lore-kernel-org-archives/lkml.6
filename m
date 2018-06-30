Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5482C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7025775
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF7025775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeF3O5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:57:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751861AbeF3Ozn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErWjI126318
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx5xvacwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:42 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:37 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtbWD32309312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90BB411C054;
        Sat, 30 Jun 2018 15:55:23 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F39F911C050;
        Sat, 30 Jun 2018 15:55:21 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 30 Jun 2018 15:55:21 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:34 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 11/11] docs/mm: add description of boot time memory management
Date:   Sat, 30 Jun 2018 17:55:06 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-0008-0000-0000-0000024E31D7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0009-0000-0000-000021B43447
Message-Id: <1530370506-21751-12-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both bootmem and memblock are have pretty good internal documentation
coverage. With addition of some overview we get a nice description of the
early memory management.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/boot-time-mm.rst | 92 +++++++++++++++++++++++++++++++++
 Documentation/core-api/index.rst        |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 Documentation/core-api/boot-time-mm.rst

diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
new file mode 100644
index 0000000..03cb164
--- /dev/null
+++ b/Documentation/core-api/boot-time-mm.rst
@@ -0,0 +1,92 @@
+===========================
+Boot time memory management
+===========================
+
+Early system initialization cannot use "normal" memory management
+simply because it is not set up yet. But there is still need to
+allocate memory for various data structures, for instance for the
+physical page allocator. To address this, a specialized allocator
+called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
+introduced. Several years later PowerPC developers added a "Logical
+Memory Blocks" allocator, which was later adopted by other
+architectures and renamed to :ref:`memblock <memblock>`. There is also
+a compatibility layer called `nobootmem` that translates bootmem
+allocation interfaces to memblock calls.
+
+The selection of the early allocator is done using
+``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
+configuration options. These options are enabled or disabled
+statically by the architectures' Kconfig files.
+
+* Architectures that rely only on bootmem select
+  ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=n``.
+* The users of memblock with the nobootmem compatibility layer set
+  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
+* And for those that use both memblock and bootmem the configuration
+  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y``.
+
+Whichever allocator is used, it is the responsibility of the
+architecture specific initialization to set it up in
+:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
+
+Once the early memory management is available it offers a variety of
+functions and macros for memory allocations. The allocation request
+may be directed to the first (and probably the only) node or to a
+particular node in a NUMA system. There are API variants that panic
+when an allocation fails and those that don't. And more recent and
+advanced memblock even allows controlling its own behaviour.
+
+.. _bootmem:
+
+Bootmem
+=======
+
+(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
+Memory Manager" `book`_)
+
+.. _book: https://www.kernel.org/doc/gorman/
+
+.. kernel-doc:: mm/bootmem.c
+   :doc: bootmem overview
+
+.. _memblock:
+
+Memblock
+========
+
+.. kernel-doc:: mm/memblock.c
+   :doc: memblock overview
+
+
+Functions and structures
+========================
+
+Common API
+----------
+
+The functions that are described in this section are available
+regardless of what early memory manager is enabled.
+
+.. kernel-doc:: mm/nobootmem.c
+
+Bootmem specific API
+--------------------
+
+These interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``
+
+.. kernel-doc:: include/linux/bootmem.h
+.. kernel-doc:: mm/bootmem.c
+   :nodocs:
+
+Memblock specific API
+---------------------
+
+Here is the description of memblock data structures, functions and
+macros. Some of them are actually internal, but since they are
+documented it would be silly to omit them. Besides, reading the
+descriptions for the internal functions can help to understand what
+really happens under the hood.
+
+.. kernel-doc:: include/linux/memblock.h
+.. kernel-doc:: mm/memblock.c
+   :nodocs:
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index f5a66b7..93d5a46 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -28,6 +28,7 @@ Core utilities
    printk-formats
    circular-buffers
    gfp_mask-from-fs-io
+   boot-time-mm
 
 Interfaces for kernel debugging
 ===============================
-- 
2.7.4

