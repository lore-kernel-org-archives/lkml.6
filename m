Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE687C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C28620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeIMA1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:27:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeIMA1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:27:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJL4IM2744305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:21:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJL41T2744300;
        Wed, 12 Sep 2018 12:21:04 -0700
Date:   Wed, 12 Sep 2018 12:21:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-35x71oei2hdui9u0tarpimbq@git.kernel.org>
Cc:     wangnan0@huawei.com, namhyung@kernel.org, mingo@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        dsahern@gmail.com, hpa@zytor.com, glebfm@altlinux.org,
        peterz@infradead.org
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, dsahern@gmail.com,
          hpa@zytor.com, glebfm@altlinux.org, peterz@infradead.org,
          mingo@kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
          jolsa@kernel.org, acme@redhat.com, davem@davemloft.net,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 linux/vhost.h
Git-Commit-ID: 7f28785c41f4d5635e69c183b3de8ea19093ccef
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7f28785c41f4d5635e69c183b3de8ea19093ccef
Gitweb:     https://git.kernel.org/tip/7f28785c41f4d5635e69c183b3de8ea19093ccef
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Sep 2018 13:12:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 13:12:40 -0300

tools headers uapi: Update tools's copy of linux/vhost.h

To get the changes in:

	c48300c92ad9 ("vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request definition")

This makes 'perf trace' and other tools in the future using its
beautifiers in a libbeauty.so library be able to translate these new
ioctl to strings:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh  > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2018-09-11 13:10:57.923038244 -0300
  +++ /tmp/after	2018-09-11 13:11:20.329012685 -0300
  @@ -15,6 +15,7 @@
        [0x22] = "SET_VRING_ERR",
        [0x23] = "SET_VRING_BUSYLOOP_TIMEOUT",
        [0x24] = "GET_VRING_BUSYLOOP_TIMEOUT",
  +     [0x25] = "SET_BACKEND_FEATURES",
        [0x30] = "NET_SET_BACKEND",
        [0x40] = "SCSI_SET_ENDPOINT",
        [0x41] = "SCSI_CLEAR_ENDPOINT",
  @@ -27,4 +28,5 @@
   static const char *vhost_virtio_ioctl_read_cmds[] = {
        [0x00] = "GET_FEATURES",
        [0x12] = "GET_VRING_BASE",
  +	[0x26] = "GET_BACKEND_FEATURES",
  };
  $

We'll also use this to be able to express syscall filters using symbolic
these symbolic names, something like:

	# perf trace --all-cpus -e ioctl(cmd=*GET_FEATURES)

This silences the following warning during perf's build:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-35x71oei2hdui9u0tarpimbq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index c51f8e5cc608..84c3de89696a 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -65,6 +65,7 @@ struct vhost_iotlb_msg {
 };
 
 #define VHOST_IOTLB_MSG 0x1
+#define VHOST_IOTLB_MSG_V2 0x2
 
 struct vhost_msg {
 	int type;
@@ -74,6 +75,15 @@ struct vhost_msg {
 	};
 };
 
+struct vhost_msg_v2 {
+	__u32 type;
+	__u32 reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
@@ -160,6 +170,14 @@ struct vhost_memory {
 #define VHOST_GET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x24,	\
 					 struct vhost_vring_state)
 
+/* Set or get vhost backend capability */
+
+/* Use message type V2 */
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+
+#define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
