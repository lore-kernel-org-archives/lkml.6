Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D7DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADBF2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADBF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJKMX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:23:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbeJKMX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:23:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B4ve8I021505
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:58:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1wckw3jd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:58:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 11 Oct 2018 05:58:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 05:58:23 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B4wM9b54263880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 04:58:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6E711C054;
        Thu, 11 Oct 2018 07:57:55 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C44F11C052;
        Thu, 11 Oct 2018 07:57:53 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.69])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Oct 2018 07:57:53 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 11 Oct 2018 07:58:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/2] docs/core-api: rename memory-hotplug-notifier to memory-hotplug
Date:   Thu, 11 Oct 2018 07:58:16 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539233897-10207-1-git-send-email-rppt@linux.ibm.com>
References: <1539233897-10207-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101104-0008-0000-0000-0000027DE719
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101104-0009-0000-0000-000021E72BA7
Message-Id: <1539233897-10207-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

to allow additions of new documentation about memory hotplug under the same
roof.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/index.rst                   |  2 +-
 Documentation/core-api/memory-hotplug-notifier.rst | 84 ---------------------
 Documentation/core-api/memory-hotplug.rst          | 87 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/core-api/memory-hotplug-notifier.rst
 create mode 100644 Documentation/core-api/memory-hotplug.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 4f8a426..29c790f 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -32,7 +32,7 @@ Core utilities
    gfp_mask-from-fs-io
    timekeeping
    boot-time-mm
-   memory-hotplug-notifier
+   memory-hotplug
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/core-api/memory-hotplug-notifier.rst b/Documentation/core-api/memory-hotplug-notifier.rst
deleted file mode 100644
index 35347cc..0000000
--- a/Documentation/core-api/memory-hotplug-notifier.rst
+++ /dev/null
@@ -1,84 +0,0 @@
-.. _memory_hotplug_notifier:
-
-=============================
-Memory hotplug event notifier
-=============================
-
-Hotplugging events are sent to a notification queue.
-
-There are six types of notification defined in ``include/linux/memory.h``:
-
-MEM_GOING_ONLINE
-  Generated before new memory becomes available in order to be able to
-  prepare subsystems to handle memory. The page allocator is still unable
-  to allocate from the new memory.
-
-MEM_CANCEL_ONLINE
-  Generated if MEM_GOING_ONLINE fails.
-
-MEM_ONLINE
-  Generated when memory has successfully brought online. The callback may
-  allocate pages from the new memory.
-
-MEM_GOING_OFFLINE
-  Generated to begin the process of offlining memory. Allocations are no
-  longer possible from the memory but some of the memory to be offlined
-  is still in use. The callback can be used to free memory known to a
-  subsystem from the indicated memory block.
-
-MEM_CANCEL_OFFLINE
-  Generated if MEM_GOING_OFFLINE fails. Memory is available again from
-  the memory block that we attempted to offline.
-
-MEM_OFFLINE
-  Generated after offlining memory is complete.
-
-A callback routine can be registered by calling::
-
-  hotplug_memory_notifier(callback_func, priority)
-
-Callback functions with higher values of priority are called before callback
-functions with lower values.
-
-A callback function must have the following prototype::
-
-  int callback_func(
-    struct notifier_block *self, unsigned long action, void *arg);
-
-The first argument of the callback function (self) is a pointer to the block
-of the notifier chain that points to the callback function itself.
-The second argument (action) is one of the event types described above.
-The third argument (arg) passes a pointer of struct memory_notify::
-
-	struct memory_notify {
-		unsigned long start_pfn;
-		unsigned long nr_pages;
-		int status_change_nid_normal;
-		int status_change_nid_high;
-		int status_change_nid;
-	}
-
-- start_pfn is start_pfn of online/offline memory.
-- nr_pages is # of pages of online/offline memory.
-- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
-  is (will be) set/clear, if this is -1, then nodemask status is not changed.
-- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
-  is (will be) set/clear, if this is -1, then nodemask status is not changed.
-- status_change_nid is set node id when N_MEMORY of nodemask is (will be)
-  set/clear. It means a new(memoryless) node gets new memory by online and a
-  node loses all memory. If this is -1, then nodemask status is not changed.
-
-  If status_changed_nid* >= 0, callback should create/discard structures for the
-  node if necessary.
-
-The callback routine shall return one of the values
-NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
-defined in ``include/linux/notifier.h``
-
-NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
-
-NOTIFY_BAD is used as response to the MEM_GOING_ONLINE, MEM_GOING_OFFLINE,
-MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
-further processing of the notification queue.
-
-NOTIFY_STOP stops further processing of the notification queue.
diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
new file mode 100644
index 0000000..a99f2f2
--- /dev/null
+++ b/Documentation/core-api/memory-hotplug.rst
@@ -0,0 +1,87 @@
+.. _memory_hotplug:
+
+==============
+Memory hotplug
+==============
+
+Memory hotplug event notifier
+=============================
+
+Hotplugging events are sent to a notification queue.
+
+There are six types of notification defined in ``include/linux/memory.h``:
+
+MEM_GOING_ONLINE
+  Generated before new memory becomes available in order to be able to
+  prepare subsystems to handle memory. The page allocator is still unable
+  to allocate from the new memory.
+
+MEM_CANCEL_ONLINE
+  Generated if MEM_GOING_ONLINE fails.
+
+MEM_ONLINE
+  Generated when memory has successfully brought online. The callback may
+  allocate pages from the new memory.
+
+MEM_GOING_OFFLINE
+  Generated to begin the process of offlining memory. Allocations are no
+  longer possible from the memory but some of the memory to be offlined
+  is still in use. The callback can be used to free memory known to a
+  subsystem from the indicated memory block.
+
+MEM_CANCEL_OFFLINE
+  Generated if MEM_GOING_OFFLINE fails. Memory is available again from
+  the memory block that we attempted to offline.
+
+MEM_OFFLINE
+  Generated after offlining memory is complete.
+
+A callback routine can be registered by calling::
+
+  hotplug_memory_notifier(callback_func, priority)
+
+Callback functions with higher values of priority are called before callback
+functions with lower values.
+
+A callback function must have the following prototype::
+
+  int callback_func(
+    struct notifier_block *self, unsigned long action, void *arg);
+
+The first argument of the callback function (self) is a pointer to the block
+of the notifier chain that points to the callback function itself.
+The second argument (action) is one of the event types described above.
+The third argument (arg) passes a pointer of struct memory_notify::
+
+	struct memory_notify {
+		unsigned long start_pfn;
+		unsigned long nr_pages;
+		int status_change_nid_normal;
+		int status_change_nid_high;
+		int status_change_nid;
+	}
+
+- start_pfn is start_pfn of online/offline memory.
+- nr_pages is # of pages of online/offline memory.
+- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
+  is (will be) set/clear, if this is -1, then nodemask status is not changed.
+- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
+  is (will be) set/clear, if this is -1, then nodemask status is not changed.
+- status_change_nid is set node id when N_MEMORY of nodemask is (will be)
+  set/clear. It means a new(memoryless) node gets new memory by online and a
+  node loses all memory. If this is -1, then nodemask status is not changed.
+
+  If status_changed_nid* >= 0, callback should create/discard structures for the
+  node if necessary.
+
+The callback routine shall return one of the values
+NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
+defined in ``include/linux/notifier.h``
+
+NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
+
+NOTIFY_BAD is used as response to the MEM_GOING_ONLINE, MEM_GOING_OFFLINE,
+MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
+further processing of the notification queue.
+
+NOTIFY_STOP stops further processing of the notification queue.
-- 
2.7.4

