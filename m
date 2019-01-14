Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F865C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239E02086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="V6f4WGhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfANRju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:39:50 -0500
Received: from sonic308-9.consmr.mail.gq1.yahoo.com ([98.137.68.33]:34483 "EHLO
        sonic308-9.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfANRjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1547487587; bh=7q6a8Zs9Fpycw2Q4KqQsPl6rT4sLI7F0yoZS5PTBcR4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V6f4WGhgtXorZr6u0N2l8JWXo2Xk3REw+4j7FH88whThrf9DmSB8L64xfSD+UvhLYIHkabDKsUK0ajf6tMYozybUKN+JV462r3eFgiHMUUIMpMJy7iSYBtV9J0nZuufiQGm+m1DGSW6l2py9slakAGUK+2hkEd3HDU6NzrVq2z8F7B3W8FCitHGOK5dfjdNvNywFhSmbtLUlV+Z40PoJtkD5o0eVe+qTu9+BJgFlu++wfjOFkL/1tqeYcSpgWAk98/thdsv8LEWeXlZqSudkdru+RJVzk6HQjI3FAaEEAy9wbWXKcqizBJZKcxMOxYipAO9GiD3AexIwQUouRd9FTw==
X-YMail-OSG: 4fVng48VM1kyOb9NWX8xx_MwEQn.fS.QIXhuGrHwlaHRDtKw_SXLgjYZTgfOWQh
 4FeGvVaB39iRbfi27sKKWC7VsihiXAYBQdOA_jzYm5rMUacSsWImJy7DR7cdTORA8W2EHoeX5GoE
 KuHmhImDiQPXZaB.2IC7Drmwj6XBJ2eJ28OpNiQqefRKwQm14UPQ1GQMnUxhGt44.Nhi.qxrVnKN
 bNE7JtAaGe3jvV0Lal0G1vS9OqCWh6A3fAgocg9SeyJ3Mzd_U0W.P5TzxJwTJJPON8dkhhUlk1sb
 NNxiKlipoRp1gQ1te41gC0645WfhkZsyKRJo.UQbqqbNDBzJ10PwIp0D_uDMmKyhyL_oVuNBuWqP
 q2PvAWEXkY70JNgGu1z.8ItYBAu_L9uj_.trCtm4glLLm_AXguvxQ9WMKZXsQEV2Rhutoe498nS1
 RgnEjrgl4D8IWC9yJeB9p4P3P_poVSYOM15R1Es0lA6koVGQ1yA1CNuLQoYzKA3I9WVaH.kb97Rk
 IxYM_M0XDNmtDnYQOWU91b9ombop9zWIM2R98br7eoh5KdZVCrc3erQH75KazNSN7CjmenZgrw1t
 AFMGXbz1SlxWbIwu3ePw6covLq.Ix02AVaQ6hGFVoOxlx5nBRl_SiKzs7giXmpyoSBoAlQCp4fPh
 igG9eUesx5ytDNwtE1TSzmOi2COFWeQ24WeY7_cBxqzmWEAf6LWliHHTwrvsBGLE_OFwY27Qv0iU
 rIyPwYN0AXCi0JUf.zthWJ4wJdtbDCeimnDhzEU_GNJwwt5ItdAj78Yjegt.K89z.i0dO.fYCtjx
 uCIojIzsuXdF8UWOv7UYjgJRZdhqqdIkUNjP43dMH1zyX8JgQX1OhM6QW0jt3l6uJ5rchsXyYbTu
 foyntziwWXaOC74eSXcNOpnIh0FLMBq6SkblTEL02gv.rXn7uA5ROEcO0gqKkDgoCtiYHoMcITNx
 qMYx2f.0UXcVidnFH65umzJFUnvwWI2H_tsghumYQCbcVLk.PwODajSsgINI56dNNx4Z6KZ5ChTN
 KlLufraj95HkRqa85U9PzJhsQ6Hbh2h9X0jeyRYTkP1t0nqIlOpsBQ8MLxiv8mEdRctFe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 14 Jan 2019 17:39:47 +0000
Received: from 125.120.225.24 (EHLO localhost.localdomain) ([125.120.225.24])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8d92f1c9fffc8981b51cba8bca5757d7;
          Mon, 14 Jan 2019 17:39:46 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] staging: erofs: add document
Date:   Tue, 15 Jan 2019 01:39:29 +0800
Message-Id: <20190114173929.22395-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190114114026.11728-2-gaoxiang25@huawei.com>
References: <20190114114026.11728-2-gaoxiang25@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This documents key feature, usage, and on-disk design of erofs.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
 - fix some incorrect descriptions, such as namelen -> nameoff;
 - add description about target EROFS users.

Thanks,
Gao Xiang

 .../erofs/Documentation/filesystems/erofs.txt      | 206 +++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 drivers/staging/erofs/Documentation/filesystems/erofs.txt

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
new file mode 100644
index 000000000000..a9cbbd7196b8
--- /dev/null
+++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
@@ -0,0 +1,206 @@
+Overview
+========
+
+EROFS file-system stands for Enhanced Read-Only File System. Different
+from other read-only file systems, it aims to be designed for flexibility,
+scalability, but be kept simple and high performance.
+
+It is designed as a better filesystem solution for the following scenarios:
+ - read-only storage media or
+
+ - part of a fully trusted read-only solution, which means it needs to be
+   immutable and bit-for-bit identical to the official golden image for
+   their releases due to security and other considerations and
+
+ - hope to save some extra storage space with guaranteed end-to-end performance
+   by using reduced metadata and transparent file compression, especially
+   for those embedded devices with limited memory (ex, smartphone);
+
+Here is the main features of EROFS:
+ - Little endian on-disk design;
+
+ - Currently 4KB block size (nobh) and therefore maximum 16TB address space;
+
+ - Metadata & data could be mixed by design;
+
+ - 2 inode versions for different requirements:
+                          v1            v2
+   Inode metadata size:   32 bytes      64 bytes
+   Max file size:         4 GB          16 EB (also limited by max. vol size)
+   Max uids/gids:         65536         4294967296
+   File creation time:    no            yes (64 + 32-bit timestamp)
+   Max hardlinks:         65536         4294967296
+   Metadata reserved:     4 bytes       14 bytes
+
+ - Support extended attributes (xattrs) as an option;
+
+ - Support xattr inline and tail-end data inline for all files;
+
+ - Support transparent file compression as an option:
+   LZ4 algorithm with 4 KB fixed-output compression for high performance;
+
+The following git tree provides the file system user-space tools under
+development (ex, formatting tool mkfs.erofs):
+>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+Bugs and patches are welcome, please kindly help us and send to the following
+linux-erofs mailing list:
+>> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
+
+Note that EROFS is still working in progress as a Linux staging driver,
+Cc the staging mailing list as well is highly recommended:
+>> Linux Driver Project Developer List <devel@driverdev.osuosl.org>
+
+Mount options
+=============
+
+fault_injection=%d     Enable fault injection in all supported types with
+                       specified injection rate. Supported injection type:
+                       Type_Name                Type_Value
+                       FAULT_KMALLOC            0x000000001
+(no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
+                       by default if CONFIG_EROFS_FS_XATTR is selected.
+(no)acl                Setup POSIX Access Control List. Note: acl is enabled
+                       by default if CONFIG_EROFS_FS_POSIX_ACL is selected.
+
+On-disk details
+===============
+
+Summary
+-------
+Different from other read-only file systems, an EROFS volume is designed
+to be as simple as possible:
+
+                                |-> aligned with the block size
+   ____________________________________________________________
+  | |SB| | ... | Metadata | ... | Data | Metadata | ... | Data |
+  |_|__|_|_____|__________|_____|______|__________|_____|______|
+  0 +1K
+
+All data areas should be aligned with the block size, but metadata areas
+may not. All metadatas can be now observed in two different spaces (views):
+ 1. Inode metadata space
+    Each valid inode should be aligned with an inode slot, which is a fixed
+    value (32 bytes) and designed to be kept in line with v1 inode size.
+
+    Each inode can be directly found with the following formula:
+         inode offset = meta_blkaddr * block_size + 32 * nid
+
+                                |-> aligned with 8B
+                                           |-> followed closely
+    + meta_blkaddr blocks                                      |-> another slot
+     _____________________________________________________________________
+    |  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
+    |________|_______|(optional)|(optional)|__(optional)_|_____|__________
+             |-> aligned with the inode slot size
+                  .                   .
+                .                         .
+              .                              .
+            .                                    .
+          .                                         .
+        .                                              .
+      .____________________________________________________|-> aligned with 4B
+      | xattr_ibody_header | shared xattrs | inline xattrs |
+      |____________________|_______________|_______________|
+      |->    12 bytes    <-|->x * 4 bytes<-|               .
+                          .                .                 .
+                    .                      .                   .
+               .                           .                     .
+           ._______________________________.______________________.
+           | id | id | id | id |  ... | id | ent | ... | ent| ... |
+           |____|____|____|____|______|____|_____|_____|____|_____|
+                                           |-> aligned with 4B
+                                                       |-> aligned with 4B
+
+    Inode could be 32 or 64 bytes, which can be distinguished from a common
+    field which all inode versions have -- i_advise:
+
+        __________________               __________________
+       |     i_advise     |             |     i_advise     |
+       |__________________|             |__________________|
+       |        ...       |             |        ...       |
+       |                  |             |                  |
+       |__________________| 32 bytes    |                  |
+                                        |                  |
+                                        |__________________| 64 bytes
+
+    Xattrs, extents, data inline are followed by the corresponding inode with
+    proper alignes, and they could be optional for different data mappings,
+    _currently_ there are totally 3 valid data mappings supported:
+
+     1) flat file data without data inline (no extent);
+     2) fixed-output size data compression (must have extents);
+     3) flat file data with tail-end data inline (no extent);
+
+    The size of the optional xattrs is indicated by i_xattr_count in inode
+    header. Large xattrs or xattrs shared by many different files can be
+    stored in shared xattrs metadata rather than inlined right after inode.
+
+ 2. Shared xattrs metadata space
+    Shared xattrs space is similar to the above inode space, started with
+    a specific block indicated by xattr_blkaddr, organized one by one with
+    proper align.
+
+    Each share xattr can also be directly found by the following formula:
+         xattr offset = xattr_blkaddr * block_size + 4 * xattr_id
+
+                           |-> aligned by  4 bytes
+    + xattr_blkaddr blocks                     |-> aligned with 4 bytes
+     _________________________________________________________________________
+    |  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
+    |________|_____________|_____________|_____|______________|_______________
+
+Directories
+-----------
+All directories are now organized in a compact on-disk format. Note that
+each directory block is divided into index and name areas in order to support
+random file lookup, and all directory entries are _strictly_ recorded in
+alphabetical order in order to support improved prefix binary search
+algorithm (could refer to the related source code).
+
+                 ___________________________
+                /                           |
+               /              ______________|________________
+              /              /              | nameoff1       | nameoffN-1
+ ____________.______________._______________v________________v__________
+| dirent | dirent | ... | dirent | filename | filename | ... | filename |
+|___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
+     \                           ^
+      \                          |                           * could have
+       \                         |                             trailing '\0'
+        \________________________| nameoff0
+
+                             Directory block
+
+Note that apart from the offset of the first filename, nameoff0 also indicates
+the total number of directory entries in this block since it is no need to
+introduce another on-disk field at all.
+
+Compression
+-----------
+Currently, EROFS supports 4KB fixed-output clustersize transparent file
+compression, as illustrated below:
+
+         |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
+         clusterofs                      clusterofs            clusterofs
+         |                               |                     |   logical data
+_________v_______________________________v_____________________v_______________
+... |    .        |             |        .    |             |  .          | ...
+____|____.________|_____________|________.____|_____________|__.__________|____
+    |-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
+         size          size          size          size          size
+          .                             .                .                   .
+           .                       .               .                  .
+            .                  .              .                .
+      _______._____________._____________._____________._____________________
+         ... |             |             |             | ... physical data
+      _______|_____________|_____________|_____________|_____________________
+             |-> cluster <-|-> cluster <-|-> cluster <-|
+                  size          size          size
+
+Currently each on-disk physical cluster can contain 4KB (un)compressed data
+at most. For each logical cluster, there is a corresponding on-disk index to
+describe its cluster type, physical cluster address, etc.
+
+See "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
+
-- 
2.11.0

