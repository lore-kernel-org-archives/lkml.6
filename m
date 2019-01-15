Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97258C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603992085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfAOK04 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:26:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbfAOK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:26:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FAOIur021699
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:26:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q1c4fvumk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:26:52 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 15 Jan 2019 10:26:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 10:26:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FAQjI94522494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 10:26:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48366A404D;
        Tue, 15 Jan 2019 10:26:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A85E6A4053;
        Tue, 15 Jan 2019 10:26:43 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Jan 2019 10:26:43 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 15 Jan 2019 12:26:43 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs-rst: Convert user verbs doc to rst
Date:   Tue, 15 Jan 2019 12:26:30 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011510-0020-0000-0000-00000306B69D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011510-0021-0000-0000-00002157CCD1
Message-Id: <1547547991-5314-2-git-send-email-joeln@il.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move user_verbs from infiniband to userspace while changing the
format. Replace the existing Documentation/infiniband/user_verbs.txt
with Documentation/userspace-api/user_verbs.rst. No substantial changes
to the content - just some minor reformatting to have the rendering
come out nicely.

Since this documents a userspace API, its home should be with the
other userspace API docs.

This is in preparation for updating the content in a subsequent
patch.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 Documentation/infiniband/user_verbs.txt    | 69 -----------------------------
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/user_verbs.rst | 70 ++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/infiniband/user_verbs.txt
 create mode 100644 Documentation/userspace-api/user_verbs.rst

diff --git a/Documentation/infiniband/user_verbs.txt b/Documentation/infiniband/user_verbs.txt
deleted file mode 100644
index df049b9..0000000
--- a/Documentation/infiniband/user_verbs.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-USERSPACE VERBS ACCESS
-
-  The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
-  enables direct userspace access to IB hardware via "verbs," as
-  described in chapter 11 of the InfiniBand Architecture Specification.
-
-  To use the verbs, the libibverbs library, available from
-  https://github.com/linux-rdma/rdma-core, is required. libibverbs contains a
-  device-independent API for using the ib_uverbs interface.
-  libibverbs also requires appropriate device-dependent kernel and
-  userspace driver for your InfiniBand hardware.  For example, to use
-  a Mellanox HCA, you will need the ib_mthca kernel module and the
-  libmthca userspace driver be installed.
-
-User-kernel communication
-
-  Userspace communicates with the kernel for slow path, resource
-  management operations via the /dev/infiniband/uverbsN character
-  devices.  Fast path operations are typically performed by writing
-  directly to hardware registers mmap()ed into userspace, with no
-  system call or context switch into the kernel.
-
-  Commands are sent to the kernel via write()s on these device files.
-  The ABI is defined in drivers/infiniband/include/ib_user_verbs.h.
-  The structs for commands that require a response from the kernel
-  contain a 64-bit field used to pass a pointer to an output buffer.
-  Status is returned to userspace as the return value of the write()
-  system call.
-
-Resource management
-
-  Since creation and destruction of all IB resources is done by
-  commands passed through a file descriptor, the kernel can keep track
-  of which resources are attached to a given userspace context.  The
-  ib_uverbs module maintains idr tables that are used to translate
-  between kernel pointers and opaque userspace handles, so that kernel
-  pointers are never exposed to userspace and userspace cannot trick
-  the kernel into following a bogus pointer.
-
-  This also allows the kernel to clean up when a process exits and
-  prevent one process from touching another process's resources.
-
-Memory pinning
-
-  Direct userspace I/O requires that memory regions that are potential
-  I/O targets be kept resident at the same physical address.  The
-  ib_uverbs module manages pinning and unpinning memory regions via
-  get_user_pages() and put_page() calls.  It also accounts for the
-  amount of memory pinned in the process's locked_vm, and checks that
-  unprivileged processes do not exceed their RLIMIT_MEMLOCK limit.
-
-  Pages that are pinned multiple times are counted each time they are
-  pinned, so the value of locked_vm may be an overestimate of the
-  number of pages pinned by a process.
-
-/dev files
-
-  To create the appropriate character device files automatically with
-  udev, a rule like
-
-    KERNEL=="uverbs*", NAME="infiniband/%k"
-
-  can be used.  This will create device nodes named
-
-    /dev/infiniband/uverbs0
-
-  and so on.  Since the InfiniBand userspace verbs should be safe for
-  use by non-privileged processes, it may be useful to add an
-  appropriate MODE or GROUP to the udev rule.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a3233da..c37bbbe 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -20,6 +20,7 @@ place where this information is gathered.
    seccomp_filter
    unshare
    spec_ctrl
+   user_verbs
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/user_verbs.rst b/Documentation/userspace-api/user_verbs.rst
new file mode 100644
index 0000000..ffc4aec
--- /dev/null
+++ b/Documentation/userspace-api/user_verbs.rst
@@ -0,0 +1,70 @@
+======================
+Userspace Verbs Access
+======================
+The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
+enables direct userspace access to IB hardware via "verbs," as
+described in chapter 11 of the InfiniBand Architecture Specification.
+
+To use the verbs, the libibverbs library, available from
+https://github.com/linux-rdma/rdma-core, is required. libibverbs contains a
+device-independent API for using the ib_uverbs interface.
+libibverbs also requires appropriate device-dependent kernel and
+userspace driver for your InfiniBand hardware.  For example, to use
+a Mellanox HCA, you will need the ib_mthca kernel module and the
+libmthca userspace driver be installed.
+
+User-kernel communication
+=========================
+Userspace communicates with the kernel for slow path, resource
+management operations via the /dev/infiniband/uverbsN character
+devices.  Fast path operations are typically performed by writing
+directly to hardware registers mmap()ed into userspace, with no
+system call or context switch into the kernel.
+
+Commands are sent to the kernel via write()s on these device files.
+The ABI is defined in drivers/infiniband/include/ib_user_verbs.h.
+The structs for commands that require a response from the kernel
+contain a 64-bit field used to pass a pointer to an output buffer.
+Status is returned to userspace as the return value of the write()
+system call.
+
+Resource management
+===================
+Since creation and destruction of all IB resources is done by
+commands passed through a file descriptor, the kernel can keep track
+of which resources are attached to a given userspace context.  The
+ib_uverbs module maintains idr tables that are used to translate
+between kernel pointers and opaque userspace handles, so that kernel
+pointers are never exposed to userspace and userspace cannot trick
+the kernel into following a bogus pointer.
+
+This also allows the kernel to clean up when a process exits and
+prevent one process from touching another process's resources.
+
+Memory pinning
+==============
+Direct userspace I/O requires that memory regions that are potential
+I/O targets be kept resident at the same physical address.  The
+ib_uverbs module manages pinning and unpinning memory regions via
+get_user_pages() and put_page() calls.  It also accounts for the
+amount of memory pinned in the process's locked_vm, and checks that
+unprivileged processes do not exceed their RLIMIT_MEMLOCK limit.
+
+Pages that are pinned multiple times are counted each time they are
+pinned, so the value of locked_vm may be an overestimate of the
+number of pages pinned by a process.
+
+/dev files
+==========
+To create the appropriate character device files automatically with
+udev, a rule like::
+
+   KERNEL=="uverbs*", NAME="infiniband/%k"
+
+can be used.  This will create device nodes named::
+
+    /dev/infiniband/uverbs0
+
+and so on.  Since the InfiniBand userspace verbs should be safe for
+use by non-privileged processes, it may be useful to add an
+appropriate MODE or GROUP to the udev rule.
-- 
2.7.4

