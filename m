Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267112-2-8162786724158688565
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267112; b=RtTbjFOEKUwkeYQ3YAcraBIeYAUL3zmS3i0WAGJszA8k0ul/74
    MZ16J1p6L0ypWyfWC+FPKSz6DwMZZvt5lVSEzksbH6K0KoOXupmDpV72I4aIgTNG
    AQtbaeuOAe9mtoEXEC12lPV1DWpv3gJo/1dnC5KGaUlFBLpMshVgUuJy2xChDhjB
    bYcqIAY9ECdwXK9jIvjA56IFxxyIMRKv42i3x1E2svSJ7DOjUBCjD8VQsxP9/1Pu
    Z1Of29OkNOzUBg/olFqNa442YvpWk2sl6KHCgcc1W2SWiUFDP1DWqYU1JEcv5wjc
    71nkoON6cygUDcLQ8CgYSAFArzuIYOgGjXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267112;
    bh=UIDP4RALKGZS3Hi3GvMLAncdOpafps1KstDWAUUsDO4=; b=dCSZZCLQ6WmX
    bMB98kBhPItp1gMODygTOCwPOkB5V5TmGLbW+kZv/BI4lxV3ZCF89R3MVu8cPlMt
    l9G17gZX4GQmdZwx9GgZ+Fs44zmYbzrqcL7woAqHKBy6+9etiZGzqUpxEgjW/a9x
    RQwJux0h6RXhU8CcktFQrAjqEjfB1OJHVmiUYo56W+dtsD0HJtfbg2IisJTXUjwa
    JtndQoIPCf0DAxfh7xeUKRBChZa1rQYNuDi1jBfdquPGiWkj+fJUeW5TBZ+glqXh
    /bcYMROzpJ5bL7kUU8ywLA0GtzMnKmBbhCke5iPBTA6bLtNNymGv6VYHJslvTv+o
    3zD9XB50WQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfNixYFtaXqEtHYHGGnxY/a9TLUi3iphNM/oKa8Fp3sVtew1tdRTvJKGQtjxDGCGk5wh8kXMJROy26a1AXU63EhqTetgz+GCAQHUIBSdUbV0m4buoVeVD
    fFQkWID5/AvD9JvgqDw3TtwL3qGEiNtzMcbm50o425Xcj7CNE0RAxeCr7QKlLDoAmWfVyV6vB1zYAy0BmP4iGPIVSO0Y4wh/yhInwnoBRhO6B/N05RtyPtvO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=tj6WMx0YFKV4Snufot4A:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeENDFJ (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:05:09 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:38195
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbeENDFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:05:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKCQBP/Pha/+U/0XZcHAEBAQQBAQoBA?=
 =?us-ascii?q?YMUL2F7KINylHBFAQEBAwaBO3yTMoF4HggQAYRAAoMJITYWAQIBAQEBAQECbBw?=
 =?us-ascii?q?MhSkGI1YQGAEECAIYDgICRwIOBhODJYFyDKl9ghwaAogggieBCYccgQyBB4Nli?=
 =?us-ascii?q?CiCNCAChziEYGKLPAmFZ4JUhhaHa4UEkggjDCWBUk0uCoJ+CYl7hlcyMHoBAY9?=
 =?us-ascii?q?hAQE?=
X-IPAS-Result: =?us-ascii?q?A2BKCQBP/Pha/+U/0XZcHAEBAQQBAQoBAYMUL2F7KINylHB?=
 =?us-ascii?q?FAQEBAwaBO3yTMoF4HggQAYRAAoMJITYWAQIBAQEBAQECbBwMhSkGI1YQGAEEC?=
 =?us-ascii?q?AIYDgICRwIOBhODJYFyDKl9ghwaAogggieBCYccgQyBB4NliCiCNCAChziEYGK?=
 =?us-ascii?q?LPAmFZ4JUhhaHa4UEkggjDCWBUk0uCoJ+CYl7hlcyMHoBAY9hAQE?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179734"
Subject: [PATCH 09/10] autofs - use autofs instead of autofs4 in
 documentation
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:04:50 +0800
Message-ID: <152626709055.28589.416082809460051475.stgit@pluto.themaw.net>
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

Finally remove autofs4 references in the filesystems documentation.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/00-INDEX                 |    4 ++--
 Documentation/filesystems/autofs-mount-control.txt |    8 ++++----
 Documentation/filesystems/autofs.txt               |   10 +++++-----
 Documentation/filesystems/automount-support.txt    |    2 +-
 Documentation/filesystems/path-lookup.md           |    2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index b7bd6c9009cc..a8bd4af7fbce 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -10,8 +10,8 @@ afs.txt
 	- info and examples for the distributed AFS (Andrew File System) fs.
 affs.txt
 	- info and mount options for the Amiga Fast File System.
-autofs4-mount-control.txt
-	- info on device control operations for autofs4 module.
+autofs-mount-control.txt
+	- info on device control operations for autofs module.
 automount-support.txt
 	- information about filesystem automount support.
 befs.txt
diff --git a/Documentation/filesystems/autofs-mount-control.txt b/Documentation/filesystems/autofs-mount-control.txt
index e5177cb31a04..6eba86e1ac72 100644
--- a/Documentation/filesystems/autofs-mount-control.txt
+++ b/Documentation/filesystems/autofs-mount-control.txt
@@ -1,5 +1,5 @@
 
-Miscellaneous Device control operations for the autofs4 kernel module
+Miscellaneous Device control operations for the autofs kernel module
 ====================================================================
 
 The problem
@@ -164,7 +164,7 @@ possibility for future development due to the requirements of the
 message bus architecture.
 
 
-autofs4 Miscellaneous Device mount control interface
+autofs Miscellaneous Device mount control interface
 ====================================================
 
 The control interface is opening a device node, typically /dev/autofs.
@@ -244,7 +244,7 @@ The device node ioctl operations implemented by this interface are:
 AUTOFS_DEV_IOCTL_VERSION
 ------------------------
 
-Get the major and minor version of the autofs4 device ioctl kernel module
+Get the major and minor version of the autofs device ioctl kernel module
 implementation. It requires an initialized struct autofs_dev_ioctl as an
 input parameter and sets the version information in the passed in structure.
 It returns 0 on success or the error -EINVAL if a version mismatch is
@@ -254,7 +254,7 @@ detected.
 AUTOFS_DEV_IOCTL_PROTOVER_CMD and AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD
 ------------------------------------------------------------------
 
-Get the major and minor version of the autofs4 protocol version understood
+Get the major and minor version of the autofs protocol version understood
 by loaded module. This call requires an initialized struct autofs_dev_ioctl
 with the ioctlfd field set to a valid autofs mount point descriptor
 and sets the requested version number in version field of struct args_protover
diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index f10dd590f69f..373ad25852d3 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -30,15 +30,15 @@ key advantages:
 Context
 -------
 
-The "autofs4" filesystem module is only one part of an autofs system.
+The "autofs" filesystem module is only one part of an autofs system.
 There also needs to be a user-space program which looks up names
 and mounts filesystems.  This will often be the "automount" program,
-though other tools including "systemd" can make use of "autofs4".
+though other tools including "systemd" can make use of "autofs".
 This document describes only the kernel module and the interactions
 required with any user-space program.  Subsequent text refers to this
 as the "automount daemon" or simply "the daemon".
 
-"autofs4" is a Linux kernel module with provides the "autofs"
+"autofs" is a Linux kernel module with provides the "autofs"
 filesystem type.  Several "autofs" filesystems can be mounted and they
 can each be managed separately, or all managed by the same daemon.
 
@@ -215,7 +215,7 @@ of expiry.
 The VFS also supports "expiry" of mounts using the MNT_EXPIRE flag to
 the `umount` system call.  Unmounting with MNT_EXPIRE will fail unless
 a previous attempt had been made, and the filesystem has been inactive
-and untouched since that previous attempt.  autofs4 does not depend on
+and untouched since that previous attempt.  autofs does not depend on
 this but has its own internal tracking of whether filesystems were
 recently used.  This allows individual names in the autofs directory
 to expire separately.
@@ -415,7 +415,7 @@ which can be used to communicate directly with the autofs filesystem.
 It requires CAP_SYS_ADMIN for access.
 
 The `ioctl`s that can be used on this device are described in a separate
-document `autofs4-mount-control.txt`, and are summarized briefly here.
+document `autofs-mount-control.txt`, and are summarized briefly here.
 Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
 
         struct autofs_dev_ioctl {
diff --git a/Documentation/filesystems/automount-support.txt b/Documentation/filesystems/automount-support.txt
index 7eb762eb3136..b0afd3d55eaf 100644
--- a/Documentation/filesystems/automount-support.txt
+++ b/Documentation/filesystems/automount-support.txt
@@ -9,7 +9,7 @@ also be requested by userspace.
 IN-KERNEL AUTOMOUNTING
 ======================
 
-See section "Mount Traps" of  Documentation/filesystems/autofs4.txt
+See section "Mount Traps" of  Documentation/filesystems/autofs.txt
 
 Then from userspace, you can just do something like:
 
diff --git a/Documentation/filesystems/path-lookup.md b/Documentation/filesystems/path-lookup.md
index 1933ef734e63..e2edd45c4bc0 100644
--- a/Documentation/filesystems/path-lookup.md
+++ b/Documentation/filesystems/path-lookup.md
@@ -460,7 +460,7 @@ this retry process in the next article.
 Automount points are locations in the filesystem where an attempt to
 lookup a name can trigger changes to how that lookup should be
 handled, in particular by mounting a filesystem there.  These are
-covered in greater detail in autofs4.txt in the Linux documentation
+covered in greater detail in autofs.txt in the Linux documentation
 tree, but a few notes specifically related to path lookup are in order
 here.
 
