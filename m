Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E9CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03840213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03840213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJFGl2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:41:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbeJFGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:41:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95NZfbS031275
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 16:40:28 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mxf4bgfbp-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:40:28 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct
 2018 16:40:26 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 2E5377609B4; Fri,  5 Oct 2018 16:40:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <acme@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause
Date:   Fri, 5 Oct 2018 16:40:00 -0700
Message-ID: <20181005234000.2835585-1-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libbpf is maturing as a library and gaining features that no other bpf libraries support
(BPF Type Format, bpf to bpf calls, etc)
Many Apache2 licensed projects (like bcc, bpftrace, gobpf, cilium, etc)
would like to use libbpf, but cannot do this yet, since Apache Foundation explicitly
states that LGPL is incompatible with Apache2.
Hence let's relicense libbpf as dual license LGPL-2.1 or BSD-2-Clause,
since BSD-2 is compatible with Apache2.
Dual LGPL or Apache2 is invalid combination.
Fix license mistake in Makefile as well.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: David Beckett <david.beckett@netronome.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Joe Stringer <joe@ovn.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Thomas Graf <tgraf@suug.ch>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
vger rejected previous patch. resending with shorter cc list.

 tools/lib/bpf/Makefile       |  2 +-
 tools/lib/bpf/bpf.c          |  2 +-
 tools/lib/bpf/bpf.h          |  2 +-
 tools/lib/bpf/btf.c          |  2 +-
 tools/lib/bpf/btf.h          |  2 +-
 tools/lib/bpf/libbpf.c       | 15 +--------------
 tools/lib/bpf/libbpf.h       | 15 +--------------
 tools/lib/bpf/libbpf_errno.c | 15 +--------------
 tools/lib/bpf/netlink.c      |  2 +-
 tools/lib/bpf/nlattr.c       |  7 +------
 tools/lib/bpf/nlattr.h       |  7 +------
 tools/lib/bpf/str_error.c    |  2 +-
 tools/lib/bpf/str_error.h    |  2 +-
 13 files changed, 13 insertions(+), 62 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index d49902e818b5..6ad27257fd67 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/traceevent/Makefile
 
 BPF_VERSION = 0
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3878a26a2071..d70a255cb05e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
 /*
  * common eBPF ELF operations.
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 4c78f61b7c71..87520a87a75f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 
 /*
  * common eBPF ELF operations.
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index cf94b0770522..449591aa9900 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
 
 #include <stdlib.h>
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index d5d20682eeb6..6db5462bb2ef 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 /* Copyright (c) 2018 Facebook */
 
 #ifndef __LIBBPF_BTF_H
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 85de1ebd4cb0..ceb918c14d80 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
 /*
  * Common eBPF ELF object loading operations.
@@ -7,19 +7,6 @@
  * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
  * Copyright (C) 2015 Huawei Inc.
  * Copyright (C) 2017 Nicira, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
  */
 
 #define _GNU_SOURCE
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index fbfc2aec0f0d..8af8d3663991 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 
 /*
  * Common eBPF ELF object loading operations.
@@ -6,19 +6,6 @@
  * Copyright (C) 2013-2015 Alexei Starovoitov <ast@kernel.org>
  * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
  * Copyright (C) 2015 Huawei Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
  */
 #ifndef __LIBBPF_LIBBPF_H
 #define __LIBBPF_LIBBPF_H
diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
index 2464ade3b326..d83b17f8435c 100644
--- a/tools/lib/bpf/libbpf_errno.c
+++ b/tools/lib/bpf/libbpf_errno.c
@@ -1,23 +1,10 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
 /*
  * Copyright (C) 2013-2015 Alexei Starovoitov <ast@kernel.org>
  * Copyright (C) 2015 Wang Nan <wangnan0@huawei.com>
  * Copyright (C) 2015 Huawei Inc.
  * Copyright (C) 2017 Nicira, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation;
- * version 2.1 of the License (not later!)
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not,  see <http://www.gnu.org/licenses>
  */
 
 #include <stdio.h>
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 2d2edbbd8ae8..0ce67aea8f3b 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
 
 #include <stdlib.h>
diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index e52257a7367a..1e69c0c8d413 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -1,13 +1,8 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
 /*
  * NETLINK      Netlink attributes
  *
- *	This library is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU Lesser General Public
- *	License as published by the Free Software Foundation version 2.1
- *	of the License.
- *
  * Copyright (c) 2003-2013 Thomas Graf <tgraf@suug.ch>
  */
 
diff --git a/tools/lib/bpf/nlattr.h b/tools/lib/bpf/nlattr.h
index 7198584a3040..6cc3ac91690f 100644
--- a/tools/lib/bpf/nlattr.h
+++ b/tools/lib/bpf/nlattr.h
@@ -1,13 +1,8 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 
 /*
  * NETLINK      Netlink attributes
  *
- *	This library is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU Lesser General Public
- *	License as published by the Free Software Foundation version 2.1
- *	of the License.
- *
  * Copyright (c) 2003-2013 Thomas Graf <tgraf@suug.ch>
  */
 
diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 3d211b642cb5..00e48ac5b806 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 #undef _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index b9157f5eebde..a139334d57b6 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #ifndef __LIBBPF_STR_ERROR_H
 #define __LIBBPF_STR_ERROR_H
 
-- 
2.17.1

