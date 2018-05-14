Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267041-2-1938342243188161152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267040; b=iFwNynrncBX853AW8KVwqbzPlbJ5NyZvQyL4BxiZ/nWgI2nOiD
    yVaLpRfuHaXp2y41nE/HnSKWYYvSiwQpYP+Xt1swMI+g5kBGCyWpTJbuqFR2UCo2
    MjBOClcWoFC4vfEBt+wnB5T2/qfnaNM6jpNcftN0hiWWHnPyzMEobTvxvsjPdNQF
    OVVBwxBLwfPJtL9rbNPJJEkZztgLH5qxxBPK3yjeulwjf918lMc4LAjEQ0JxAMDE
    q7lEnZVQZapL50igCOSEY7bSm2IqKPTKtGID6WRXs2OgmD4DLFe40lTw64np2OaF
    9+oTrx0c52AUyOIqLhrKorgvA2/ZGUdGj6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526267040; bh=hCwGqeZ6teq3MTUWoHODFUuoSAxpSS
    CAFLcJWioTlNQ=; b=nYAaDT6xhB193CJk+qoAb6rVfzrYSccsac/OfCGW7OyNql
    Ra9uVF0u3wUyKFpGJe+SlGRHQvDZjJy9Zh5X4qgSd5dkq1OljokG0HppHbJ/II7y
    VxF22is0Qa8MeeS5iwcqNKe+I1lAzJvDm5BWJwCkgz0IWAURXqJxHEvhKsFs9nl0
    UVjLMtJDRqa9QbgNi4j8jfQkBuHUoxd7e+JU3cEgsq1SdhQ3EMzfh1RSpnBuZJ/n
    Fg1Se0nZV476xcRY2pNAGDxruaLXBJ7d7MryXKJGEXIwmg9Gf/vsTHsnrsCO+3o4
    gEYzwUnr3ydFTtlcXqoRlpZ2JSH77sJmZuONcTAw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB7I/HiZMX5X79cmHRD3/hJAzPFIaBD9I3jNUDjnuHto8sRSRX0NPH1A5LVOGPgf7GmWNhO7UgUsva9iY20kQXVNCk7sXdcX0cZBaPEpe7Y8J8Z7ZcxT
    Fsa7ripzQ3anzAflV1FPm2fxTJ7wj2YE6jWiRu6CNFZ7Kk2BVY7+eFz1hzVfiGNb6UOLiDBbVlIO2ZEpsidnGFUg79fajkMfKcSCs44SXpXlVL9vXTxx8Zl8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=ZfRw4ET0AAAA:8 a=KXRqhX9D9Ypx03CsscsA:9
    a=0RSJk1pKl1VMC7Zg:21 a=T8tm6bR_7pvZiNxF:21 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=CCLsn7l-3eYpXwuFc0al:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeENDD5 (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:03:57 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:37880
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751953AbeENDD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:03:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A/BAAr+/ha/+U/0XZcHQEBBQELAYNDg?=
 =?us-ascii?q?Vwog3KIBIxsRQEBAQMGgQc0fJMyFIFkHhgBhECDCyE0GAECAQEBAQEBAmwohVJ?=
 =?us-ascii?q?WKAEMAhgOAkkWE4UXDKoCghwaAogggieBCYccgQyBB4EPL4cUI4MYglQChziEY?=
 =?us-ascii?q?AtXizwJjlGHa4UEK5FdHDiBUk0uCoJ+giAXjiQyMHoBAY9hAQE?=
X-IPAS-Result: =?us-ascii?q?A2A/BAAr+/ha/+U/0XZcHQEBBQELAYNDgVwog3KIBIxsRQE?=
 =?us-ascii?q?BAQMGgQc0fJMyFIFkHhgBhECDCyE0GAECAQEBAQEBAmwohVJWKAEMAhgOAkkWE?=
 =?us-ascii?q?4UXDKoCghwaAogggieBCYccgQyBB4EPL4cUI4MYglQChziEYAtXizwJjlGHa4U?=
 =?us-ascii?q?EK5FdHDiBUk0uCoJ+giAXjiQyMHoBAY9hAQE?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179404"
Subject: [PATCH 01/10] autofs4 - merge auto_fs.h and auto_fs4.h
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:03:50 +0800
Message-ID: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The autofs module has long since been removed so there's no need to have
two separate include files for autofs.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h         |    2 
 fs/compat_ioctl.c             |    1 
 include/uapi/linux/auto_fs.h  |  169 ++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/auto_fs4.h |  153 +------------------------------------
 4 files changed, 161 insertions(+), 164 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4737615f0eaa..01636f3945d5 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -9,7 +9,7 @@
 
 /* Internal header file for autofs */
 
-#include <linux/auto_fs4.h>
+#include <linux/auto_fs.h>
 #include <linux/auto_dev-ioctl.h>
 
 #include <linux/kernel.h>
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ef80085ed564..b3e1768b636e 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -39,7 +39,6 @@
 #include <linux/if_pppox.h>
 #include <linux/mtio.h>
 #include <linux/auto_fs.h>
-#include <linux/auto_fs4.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/fb.h>
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 2a4432c7a4b4..e13eec3dfb2f 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
- *   Copyright 1997 Transmeta Corporation - All Rights Reserved
+ * Copyright 1997 Transmeta Corporation - All Rights Reserved
+ * Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ * Copyright 2005-2006,2013,2017-2018 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -8,7 +10,6 @@
  *
  * ----------------------------------------------------------------------- */
 
-
 #ifndef _UAPI_LINUX_AUTO_FS_H
 #define _UAPI_LINUX_AUTO_FS_H
 
@@ -18,13 +19,11 @@
 #include <sys/ioctl.h>
 #endif /* __KERNEL__ */
 
+#define AUTOFS_PROTO_VERSION		5
+#define AUTOFS_MIN_PROTO_VERSION	3
+#define AUTOFS_MAX_PROTO_VERSION	5
 
-/* This file describes autofs v3 */
-#define AUTOFS_PROTO_VERSION	3
-
-/* Range of protocol versions defined */
-#define AUTOFS_MAX_PROTO_VERSION	AUTOFS_PROTO_VERSION
-#define AUTOFS_MIN_PROTO_VERSION	AUTOFS_PROTO_VERSION
+#define AUTOFS_PROTO_SUBVERSION		2
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed
@@ -76,9 +75,155 @@ enum {
 #define AUTOFS_IOC_READY        _IO(AUTOFS_IOCTL, AUTOFS_IOC_READY_CMD)
 #define AUTOFS_IOC_FAIL         _IO(AUTOFS_IOCTL, AUTOFS_IOC_FAIL_CMD)
 #define AUTOFS_IOC_CATATONIC    _IO(AUTOFS_IOCTL, AUTOFS_IOC_CATATONIC_CMD)
-#define AUTOFS_IOC_PROTOVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOVER_CMD, int)
-#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(AUTOFS_IOCTL, AUTOFS_IOC_SETTIMEOUT_CMD, compat_ulong_t)
-#define AUTOFS_IOC_SETTIMEOUT   _IOWR(AUTOFS_IOCTL, AUTOFS_IOC_SETTIMEOUT_CMD, unsigned long)
-#define AUTOFS_IOC_EXPIRE       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_CMD, struct autofs_packet_expire)
+#define AUTOFS_IOC_PROTOVER     _IOR(AUTOFS_IOCTL, \
+				     AUTOFS_IOC_PROTOVER_CMD, int)
+#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(AUTOFS_IOCTL, \
+				      AUTOFS_IOC_SETTIMEOUT_CMD, \
+				      compat_ulong_t)
+#define AUTOFS_IOC_SETTIMEOUT   _IOWR(AUTOFS_IOCTL, \
+				      AUTOFS_IOC_SETTIMEOUT_CMD, \
+				      unsigned long)
+#define AUTOFS_IOC_EXPIRE       _IOR(AUTOFS_IOCTL, \
+				     AUTOFS_IOC_EXPIRE_CMD, \
+				     struct autofs_packet_expire)
+
+/* autofs version 4 and later definitions */
+
+/* Mask for expire behaviour */
+#define AUTOFS_EXP_IMMEDIATE		1
+#define AUTOFS_EXP_LEAVES		2
+
+#define AUTOFS_TYPE_ANY			0U
+#define AUTOFS_TYPE_INDIRECT		1U
+#define AUTOFS_TYPE_DIRECT		2U
+#define AUTOFS_TYPE_OFFSET		4U
+
+static inline void set_autofs_type_indirect(unsigned int *type)
+{
+	*type = AUTOFS_TYPE_INDIRECT;
+}
+
+static inline unsigned int autofs_type_indirect(unsigned int type)
+{
+	return (type == AUTOFS_TYPE_INDIRECT);
+}
+
+static inline void set_autofs_type_direct(unsigned int *type)
+{
+	*type = AUTOFS_TYPE_DIRECT;
+}
+
+static inline unsigned int autofs_type_direct(unsigned int type)
+{
+	return (type == AUTOFS_TYPE_DIRECT);
+}
+
+static inline void set_autofs_type_offset(unsigned int *type)
+{
+	*type = AUTOFS_TYPE_OFFSET;
+}
+
+static inline unsigned int autofs_type_offset(unsigned int type)
+{
+	return (type == AUTOFS_TYPE_OFFSET);
+}
+
+static inline unsigned int autofs_type_trigger(unsigned int type)
+{
+	return (type == AUTOFS_TYPE_DIRECT || type == AUTOFS_TYPE_OFFSET);
+}
+
+/*
+ * This isn't really a type as we use it to say "no type set" to
+ * indicate we want to search for "any" mount in the
+ * autofs_dev_ioctl_ismountpoint() device ioctl function.
+ */
+static inline void set_autofs_type_any(unsigned int *type)
+{
+	*type = AUTOFS_TYPE_ANY;
+}
+
+static inline unsigned int autofs_type_any(unsigned int type)
+{
+	return (type == AUTOFS_TYPE_ANY);
+}
+
+/* Daemon notification packet types */
+enum autofs_notify {
+	NFY_NONE,
+	NFY_MOUNT,
+	NFY_EXPIRE
+};
+
+/* Kernel protocol version 4 packet types */
+
+/* Expire entry (umount request) */
+#define autofs_ptype_expire_multi	2
+
+/* Kernel protocol version 5 packet types */
+
+/* Indirect mount missing and expire requests. */
+#define autofs_ptype_missing_indirect	3
+#define autofs_ptype_expire_indirect	4
+
+/* Direct mount missing and expire requests */
+#define autofs_ptype_missing_direct	5
+#define autofs_ptype_expire_direct	6
+
+/* v4 multi expire (via pipe) */
+struct autofs_packet_expire_multi {
+	struct autofs_packet_hdr hdr;
+	autofs_wqt_t wait_queue_token;
+	int len;
+	char name[NAME_MAX+1];
+};
+
+union autofs_packet_union {
+	struct autofs_packet_hdr hdr;
+	struct autofs_packet_missing missing;
+	struct autofs_packet_expire expire;
+	struct autofs_packet_expire_multi expire_multi;
+};
+
+/* autofs v5 common packet struct */
+struct autofs_v5_packet {
+	struct autofs_packet_hdr hdr;
+	autofs_wqt_t wait_queue_token;
+	__u32 dev;
+	__u64 ino;
+	__u32 uid;
+	__u32 gid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 len;
+	char name[NAME_MAX+1];
+};
+
+typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_expire_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_missing_direct_t;
+typedef struct autofs_v5_packet autofs_packet_expire_direct_t;
+
+union autofs_v5_packet_union {
+	struct autofs_packet_hdr hdr;
+	struct autofs_v5_packet v5_packet;
+	autofs_packet_missing_indirect_t missing_indirect;
+	autofs_packet_expire_indirect_t expire_indirect;
+	autofs_packet_missing_direct_t missing_direct;
+	autofs_packet_expire_direct_t expire_direct;
+};
+
+enum {
+	AUTOFS_IOC_EXPIRE_MULTI_CMD = 0x66, /* AUTOFS_IOC_EXPIRE_CMD + 1 */
+	AUTOFS_IOC_PROTOSUBVER_CMD,
+	AUTOFS_IOC_ASKUMOUNT_CMD = 0x70, /* AUTOFS_DEV_IOCTL_VERSION_CMD - 1 */
+};
+
+#define AUTOFS_IOC_EXPIRE_MULTI		_IOW(AUTOFS_IOCTL, \
+					     AUTOFS_IOC_EXPIRE_MULTI_CMD, int)
+#define AUTOFS_IOC_PROTOSUBVER		_IOR(AUTOFS_IOCTL, \
+					     AUTOFS_IOC_PROTOSUBVER_CMD, int)
+#define AUTOFS_IOC_ASKUMOUNT		_IOR(AUTOFS_IOCTL, \
+					     AUTOFS_IOC_ASKUMOUNT_CMD, int)
 
 #endif /* _UAPI_LINUX_AUTO_FS_H */
diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 1f608e27a06f..d01ef0a0189c 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -7,156 +7,9 @@
  * option, any later version, incorporated herein by reference.
  */
 
-#ifndef _LINUX_AUTO_FS4_H
-#define _LINUX_AUTO_FS4_H
+#ifndef _UAPI_LINUX_AUTO_FS4_H
+#define _UAPI_LINUX_AUTO_FS4_H
 
-/* Include common v3 definitions */
-#include <linux/types.h>
 #include <linux/auto_fs.h>
 
-/* autofs v4 definitions */
-#undef AUTOFS_PROTO_VERSION
-#undef AUTOFS_MIN_PROTO_VERSION
-#undef AUTOFS_MAX_PROTO_VERSION
-
-#define AUTOFS_PROTO_VERSION		5
-#define AUTOFS_MIN_PROTO_VERSION	3
-#define AUTOFS_MAX_PROTO_VERSION	5
-
-#define AUTOFS_PROTO_SUBVERSION		2
-
-/* Mask for expire behaviour */
-#define AUTOFS_EXP_IMMEDIATE		1
-#define AUTOFS_EXP_LEAVES		2
-
-#define AUTOFS_TYPE_ANY			0U
-#define AUTOFS_TYPE_INDIRECT		1U
-#define AUTOFS_TYPE_DIRECT		2U
-#define AUTOFS_TYPE_OFFSET		4U
-
-static inline void set_autofs_type_indirect(unsigned int *type)
-{
-	*type = AUTOFS_TYPE_INDIRECT;
-}
-
-static inline unsigned int autofs_type_indirect(unsigned int type)
-{
-	return (type == AUTOFS_TYPE_INDIRECT);
-}
-
-static inline void set_autofs_type_direct(unsigned int *type)
-{
-	*type = AUTOFS_TYPE_DIRECT;
-}
-
-static inline unsigned int autofs_type_direct(unsigned int type)
-{
-	return (type == AUTOFS_TYPE_DIRECT);
-}
-
-static inline void set_autofs_type_offset(unsigned int *type)
-{
-	*type = AUTOFS_TYPE_OFFSET;
-}
-
-static inline unsigned int autofs_type_offset(unsigned int type)
-{
-	return (type == AUTOFS_TYPE_OFFSET);
-}
-
-static inline unsigned int autofs_type_trigger(unsigned int type)
-{
-	return (type == AUTOFS_TYPE_DIRECT || type == AUTOFS_TYPE_OFFSET);
-}
-
-/*
- * This isn't really a type as we use it to say "no type set" to
- * indicate we want to search for "any" mount in the
- * autofs_dev_ioctl_ismountpoint() device ioctl function.
- */
-static inline void set_autofs_type_any(unsigned int *type)
-{
-	*type = AUTOFS_TYPE_ANY;
-}
-
-static inline unsigned int autofs_type_any(unsigned int type)
-{
-	return (type == AUTOFS_TYPE_ANY);
-}
-
-/* Daemon notification packet types */
-enum autofs_notify {
-	NFY_NONE,
-	NFY_MOUNT,
-	NFY_EXPIRE
-};
-
-/* Kernel protocol version 4 packet types */
-
-/* Expire entry (umount request) */
-#define autofs_ptype_expire_multi	2
-
-/* Kernel protocol version 5 packet types */
-
-/* Indirect mount missing and expire requests. */
-#define autofs_ptype_missing_indirect	3
-#define autofs_ptype_expire_indirect	4
-
-/* Direct mount missing and expire requests */
-#define autofs_ptype_missing_direct	5
-#define autofs_ptype_expire_direct	6
-
-/* v4 multi expire (via pipe) */
-struct autofs_packet_expire_multi {
-	struct autofs_packet_hdr hdr;
-	autofs_wqt_t wait_queue_token;
-	int len;
-	char name[NAME_MAX+1];
-};
-
-union autofs_packet_union {
-	struct autofs_packet_hdr hdr;
-	struct autofs_packet_missing missing;
-	struct autofs_packet_expire expire;
-	struct autofs_packet_expire_multi expire_multi;
-};
-
-/* autofs v5 common packet struct */
-struct autofs_v5_packet {
-	struct autofs_packet_hdr hdr;
-	autofs_wqt_t wait_queue_token;
-	__u32 dev;
-	__u64 ino;
-	__u32 uid;
-	__u32 gid;
-	__u32 pid;
-	__u32 tgid;
-	__u32 len;
-	char name[NAME_MAX+1];
-};
-
-typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
-typedef struct autofs_v5_packet autofs_packet_expire_indirect_t;
-typedef struct autofs_v5_packet autofs_packet_missing_direct_t;
-typedef struct autofs_v5_packet autofs_packet_expire_direct_t;
-
-union autofs_v5_packet_union {
-	struct autofs_packet_hdr hdr;
-	struct autofs_v5_packet v5_packet;
-	autofs_packet_missing_indirect_t missing_indirect;
-	autofs_packet_expire_indirect_t expire_indirect;
-	autofs_packet_missing_direct_t missing_direct;
-	autofs_packet_expire_direct_t expire_direct;
-};
-
-enum {
-	AUTOFS_IOC_EXPIRE_MULTI_CMD = 0x66, /* AUTOFS_IOC_EXPIRE_CMD + 1 */
-	AUTOFS_IOC_PROTOSUBVER_CMD,
-	AUTOFS_IOC_ASKUMOUNT_CMD = 0x70, /* AUTOFS_DEV_IOCTL_VERSION_CMD - 1 */
-};
-
-#define AUTOFS_IOC_EXPIRE_MULTI    _IOW(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_MULTI_CMD, int)
-#define AUTOFS_IOC_PROTOSUBVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOSUBVER_CMD, int)
-#define AUTOFS_IOC_ASKUMOUNT       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_ASKUMOUNT_CMD, int)
-
-#endif /* _LINUX_AUTO_FS4_H */
+#endif /* _UAPI_LINUX_AUTO_FS4_H */
