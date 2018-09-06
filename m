Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F346C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514F32083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514F32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIFNyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:54:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeIFNyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:54:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 358D64023344;
        Thu,  6 Sep 2018 09:19:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA5210FD2B7;
        Thu,  6 Sep 2018 09:19:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/11] UAPI: ndctl: Remove use of PAGE_SIZE [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 06 Sep 2018 10:19:30 +0100
Message-ID: <153622557095.14298.10281337300003012767.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:19:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 09:19:32 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro PAGE_SIZE isn't valid outside of the kernel, so it should not
appear in UAPI headers.

Furthermore, the actual machine page size could theoretically change from
an application's point of view if it's running in a container that gets
migrated to another machine (say 4K/ppc64 to 64K/ppc64).

Fixes: f2ba5a5baecf ("libnvdimm, namespace: make min namespace size 4K")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dan Williams <dan.j.williams@intel.com>
cc: linux-nvdimm@lists.01.org
---

 include/linux/ndctl.h      |   22 ++++++++++++++++++++++
 include/uapi/linux/ndctl.h |    4 ----
 2 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/ndctl.h

diff --git a/include/linux/ndctl.h b/include/linux/ndctl.h
new file mode 100644
index 000000000000..cd5a293ce3ae
--- /dev/null
+++ b/include/linux/ndctl.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2014-2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU Lesser General Public License,
+ * version 2.1, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT ANY
+ * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
+ * more details.
+ */
+#ifndef _LINUX_NDCTL_H
+#define _LINUX_NDCTL_H
+
+#include <uapi/linux/ndctl.h>
+
+enum {
+	ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
+};
+
+#endif /* _LINUX_NDCTL_H */
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 2f2c43d633c5..f57c9e434d2d 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -202,10 +202,6 @@ enum nd_driver_flags {
 	ND_DRIVER_DAX_PMEM	  = 1 << ND_DEVICE_DAX_PMEM,
 };
 
-enum {
-	ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
-};
-
 enum ars_masks {
 	ARS_STATUS_MASK = 0x0000FFFF,
 	ARS_EXT_STATUS_SHIFT = 16,

