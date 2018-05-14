Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267073-2-14576013869484956389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267073; b=OvlIKiY/E2hLKtmgWw2ynmb+FX7KBU2MAAZKm2NET6l9hUfHRt
    HCnjsyUlzLXo/qWSqbHBoVS5YYTCyT4B0O3CZTlr1v7X/qBpMw13ZZz+cc8JlHIS
    QEEJPV2tmFEDQuaRPi333UiszygMEIbRnS9smesU0IXBhtqe20SYR3P+cIsuw/WS
    XBpZRqEmK8ZhDs6j0om+aGUaI2O3GMf+dzoyxfg5p0A1eW965qQw3XXV/lDMxCD1
    6DXVelj1jbk1VIBXJZ4Lj29uKT3lKlTGmqv4ppNskiDySlTSCKY7gZ9ucKypj/GL
    P37ujw+Dn/wBu2T6zCu+YVR7lECUci4Cdtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267073;
    bh=B9TEfZC9tANwEdz1Ftye7vz2MtECpmWl8lYs6o8XlB8=; b=BT/LoZPUq6DS
    7eA4moVWki21HLJx23yT0dwzOBQYwE9gAmYOHkWASH70ujQiZhBNXT8cFNsMRfGN
    mN76s2OWnGlPEtxJSDuLaAR59dsMBgDjo0dcIcfcc+cfS3cszkVlPLBo7lCkHza/
    jyaogGT6EN259jEc1lTJNb+qN67Ho57SFAseoG6YPkumTm5uPNAcC3FzwJyDmETf
    fuC0uTzaMMwwrOoA2Qa0IBfJM7gae+NHgGTIsIXYaJofT67ixtYflhgBiKlUsC05
    UH5eeVqqTYfTaNMaTnb5bOb8M6eUbVIA0TbKTQEHxkjhkC7wNje7fxtDtPHcknyb
    jtmkcOWC9A==
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
X-CM-Envelope: MS4wfGOIfHM2c73TVKLoUcxwBrfNSXPjjUed1BeU4tdO3K+oaDkMKpscZCdVEnfiTF6IcjMVlA3xl8Lvqsl/nxiTLHpkSnfaMN8V1US073sYgzzW7XHfBGJh
    zsaO/yZWLkuWoEh7BJUEsMvd1KeeSk7+mh7ETcRtFpyS9neHtdtDywPd6MtC0hsSZeyCVVyeS891r3/q9hhAZ54YepudqTJLuTBpkWIUD0FfEIhhMPRSszFF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=VwQbUJbxAAAA:8 a=eSjIhVUwEp_bJBdyRPIA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeENDEa (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:04:30 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:37992
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752020AbeENDE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:04:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DSCgBP/Pha/+U/0XZcHQEBBQELAYNDY?=
 =?us-ascii?q?Xsog3KUcEUBAQEDBoE7fJMygXgeEAgBhEACgwkhNhYBAgEBAQEBAQJsHAyFKQY?=
 =?us-ascii?q?jVhAYAQwCGA4CAkcQBhODJYFyDBCpbYIcGgKIIIIiBYEJhxyBDIEHiHKDG4I0I?=
 =?us-ascii?q?AKMeos8CY5Rh2uFBJIIIwkogVJNLgqCbgEBDosQhUsyMHoBAY0cgkUBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DSCgBP/Pha/+U/0XZcHQEBBQELAYNDYXsog3KUcEUBAQE?=
 =?us-ascii?q?DBoE7fJMygXgeEAgBhEACgwkhNhYBAgEBAQEBAQJsHAyFKQYjVhAYAQwCGA4CA?=
 =?us-ascii?q?kcQBhODJYFyDBCpbYIcGgKIIIIiBYEJhxyBDIEHiHKDG4I0IAKMeos8CY5Rh2u?=
 =?us-ascii?q?FBJIIIwkogVJNLgqCbgEBDosQhUsyMHoBAY0cgkUBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179562"
Subject: [PATCH 04/10] autofs - create autofs Kconfig and Makefile
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:04:15 +0800
Message-ID: <152626705591.28589.356365986974038383.stgit@pluto.themaw.net>
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Create Makefile and Kconfig for autofs module.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/Kconfig         |    1 +
 fs/Makefile        |    1 +
 fs/autofs/Kconfig  |   20 ++++++++++++++++++++
 fs/autofs/Makefile |    7 +++++++
 4 files changed, 29 insertions(+)
 create mode 100644 fs/autofs/Kconfig
 create mode 100644 fs/autofs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index bc821a86d965..e712e62afe59 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -108,6 +108,7 @@ source "fs/notify/Kconfig"
 
 source "fs/quota/Kconfig"
 
+source "fs/autofs/Kconfig"
 source "fs/autofs4/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index c9375fd2c8c4..2e005525cc19 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_AFFS_FS)		+= affs/
 obj-$(CONFIG_ROMFS_FS)		+= romfs/
 obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
 obj-$(CONFIG_QNX6FS_FS)		+= qnx6/
+obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_FUSE_FS)		+= fuse/
diff --git a/fs/autofs/Kconfig b/fs/autofs/Kconfig
new file mode 100644
index 000000000000..6a2064eb3b27
--- /dev/null
+++ b/fs/autofs/Kconfig
@@ -0,0 +1,20 @@
+config AUTOFS_FS
+	tristate "Kernel automounter support (supports v3, v4 and v5)"
+	default n
+	help
+	   The automounter is a tool to automatically mount remote file systems
+	   on demand. This implementation is partially kernel-based to reduce
+	   overhead in the already-mounted case; this is unlike the BSD
+	   automounter (amd), which is a pure user space daemon.
+
+	   To use the automounter you need the user-space tools from
+	   <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	   to answer Y to "NFS file system support", below.
+
+	   To compile this support as a module, choose M here: the module will be
+	   called autofs.
+
+	   If you are not a part of a fairly large, distributed network or
+	   don't have a laptop which needs to dynamically reconfigure to the
+	   local network, you probably do not need an automounter, and can say
+	   N here.
diff --git a/fs/autofs/Makefile b/fs/autofs/Makefile
new file mode 100644
index 000000000000..43fedde15c26
--- /dev/null
+++ b/fs/autofs/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux autofs-filesystem routines.
+#
+
+obj-$(CONFIG_AUTOFS_FS) += autofs.o
+
+autofs-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o
