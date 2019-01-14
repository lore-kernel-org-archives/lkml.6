Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF06C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B1020663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfANJB3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:01:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfANJB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:01:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E8vxIe124990
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0mxwpj9s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Mon, 14 Jan 2019 09:01:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 09:01:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E91J9659310298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 09:01:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02301A4055;
        Mon, 14 Jan 2019 09:01:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5951DA4057;
        Mon, 14 Jan 2019 09:01:17 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Jan 2019 09:01:17 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Mon, 14 Jan 2019 11:01:16 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Nider <joeln@il.ibm.com>
Subject: [PATCH 1/3] docs-rst: infiniband: Convert user verbs doc to rst
Date:   Mon, 14 Jan 2019 11:00:49 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011409-0028-0000-0000-00000338E02E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011409-0029-0000-0000-000023F5FE07
Message-Id: <1547456451-7102-2-git-send-email-joeln@il.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing Documentation/infiniband/user_verbs.txt with
Documentation/infiniband/user_verbs.rst. No substantial changes to
the content - just some minor reformatting to have the rendering
come out nicely.
This is in preparation for updating the content in a subsequent
patch.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 Documentation/infiniband/user_verbs.rst | 70 +++++++++++++++++++++++++++++++++
 Documentation/infiniband/user_verbs.txt | 69 --------------------------------
 2 files changed, 70 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/infiniband/user_verbs.rst
 delete mode 100644 Documentation/infiniband/user_verbs.txt

diff --git a/Documentation/infiniband/user_verbs.rst b/Documentation/infiniband/user_verbs.rst
new file mode 100644
index 0000000..ffc4aec
--- /dev/null
+++ b/Documentation/infiniband/user_verbs.rst
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
-- 
2.7.4

