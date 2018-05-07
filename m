Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682451-2-11708655020565478333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682450; b=FQeKSEJTlCWxSLEvPzGWyssHea7m0aeVbOiB96DtGEgz+CTjbG
    vGF/vR1eC7zjChaJW2+tq7hW+0kcqWN9eAyHql6UZ6v56zq3+SUndPPimvb45FNH
    wVO/mQFsdvvsViFlL7Qb/j0A+yXWLSXeUQnzL5slZO2F7n1dF2cJsEpKKoPwxM+p
    oTQCLUN7Uf9HBwoOT1ereoZgCFu5YVPNkovBMhmTyKoZ9Ssz9/2S+ZqqwLlbXmPD
    X209FZEKh/FCFWsQ6aV9d2PT+nou19QG9lKAkJ44BwAiGifUVi39k4LPxqqPE2K6
    0aKnR2zO5sTjuXMnMpBDjMY2qAOpmEQXVRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682450; bh=
    td+UCIejA55cGIIycPwmWF8TMv5APeGbpivp6u5CX84=; b=UjgQU5TCW1r8moEL
    aqVqhCmpvXFnWldJV/O1dFFauViSSlDqaXKgPgJyENis9ggxYsHQZLmj0eDlYEu3
    tya1fPbxD+8nLFrB4LHkq1/axFTlFcXyVaJVI4b2EX3qaqQkpQa5p6rbfegWaMst
    lCF5JvVO/cqrFgWqIalsZ/hZuf4AijGOZkWKuBnqdlXVy/joL0njXAaUhHHQNaCZ
    3QTBPmAvaR/BbliuzWnyJAIQQdszLj9d5kxbHNf2e63hHslU4bLGGjLSEnD6MRJc
    2VenJx63e2EnW+nKLCz/jFOKQ3i7nT+bNFdNRWpa1lwMFajlKcQR7NYnsMQvedkE
    U4HJhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=YLGpFAAR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=YLGpFAAR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGZngDU5CwmF+lSizCMM7xjEL958Ml586SGwyF9RvMRdRP8eyb+AmDJZHXS+eloIEh65JsB6L2kG5DT8/FGq+Sm3d7HoNJ5KgnXXI99s209EbHbwnDYQ
    besllEtaYIgQO7aj54vqkSjfVozOLOBPNRSnutlAsDeeoZIcWRvrC/xDw0GQmSr4Lewxl08Z9DrCYaEm4XV+dqkKglBTWS/BKSdFKSUE+3MmDp943vDWvdZM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=hS5vZTBx3W6bqiiGNnkA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeEGIkq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:40:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39105 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeEGIix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:53 -0400
X-Google-Smtp-Source: AB8JxZrwwK8FrL20s0BzqOTvz0Di3rrUZGld6jnt1F7wI2bo1CBEVV++a3oUa3kGNBhg84zzhsmFeQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/35] ovl: fix documentation of non-standard behavior
Date: Mon,  7 May 2018 10:38:07 +0200
Message-Id: <20180507083807.28792-36-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can now drop description of the ro/rw inconsistency from the
documentation.

Also clarify, that now fully standard compliant behavior can be enabled
with kernel/module/mount options.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.txt | 60 +++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 961b287ef323..97eae826adf9 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -10,10 +10,6 @@ union-filesystems).  An overlay-filesystem tries to present a
 filesystem which is the result over overlaying one filesystem on top
 of the other.
 
-The result will inevitably fail to look exactly like a normal
-filesystem for various technical reasons.  The expectation is that
-many use cases will be able to ignore these differences.
-
 
 Overlay objects
 ---------------
@@ -306,27 +302,49 @@ the copied layers will fail the verification of the lower root file handle.
 Non-standard behavior
 ---------------------
 
-The copy_up operation essentially creates a new, identical file and
-moves it over to the old name.  Any open files referring to this inode
-will access the old data.
+Overlayfs can now act as a POSIX compliant filesystem with the following
+features turned on:
+
+1) "redirect_dir"
+
+Enabled with the mount option or module option: "redirect_dir=on" or with
+the kernel config option CONFIG_OVERLAY_FS_REDIRECT_DIR=y.
+
+If this feature is disabled, then rename(2) on a lower or merged directory
+will fail with EXDEV ("Invalid cross-device link").
+
+2) "inode index"
+
+Enabled with the mount option or module option "index=on" or with the
+kernel config option CONFIG_OVERLAY_FS_INDEX=y.
+
+If this feature is disabled and a file with multiple hard links is copied
+up, then this will "break" the link.  Changes will not be propagated to
+other names referring to the same inode.
+
+3) "xino"
+
+Enabled with the mount option "xino=auto" or "xino=on", with the module
+option "xino_auto=on" or with the kernel config option
+CONFIG_OVERLAY_FS_XINO_AUTO=y.  Also implicitly enabled by using the same
+underlying filesystem for all layers making up the overlay.
 
-The new file may be on a different filesystem, so both st_dev and st_ino
-of the real file may change.  The values of st_dev and st_ino returned by
-stat(2) on an overlay object are often not the same as the real file
-stat(2) values to prevent the values from changing on copy_up.
+If this feature is disabled or the underlying filesystem doesn't have
+enough free bits in the inode number, then overlayfs will not be able to
+guarantee that the values of st_ino and st_dev returned by stat(2) and the
+value of d_ino returned by readdir(3) will act like on a normal filesystem.
+E.g. the value of st_dev may be different for two objects in the same
+overlay filesystem and the value of st_ino for directory objects may not be
+persistent and could change even while the overlay filesystem is mounted.
 
-Unless "xino" feature is enabled, when overlay layers are not all on the
-same underlying filesystem, the value of st_dev may be different for two
-non-directory objects in the same overlay filesystem and the value of
-st_ino for directory objects may be non persistent and could change even
-while the overlay filesystem is still mounted.
+4) "copy_up_shared"
 
-Unless "inode index" feature is enabled, if a file with multiple hard
-links is copied up, then this will "break" the link.  Changes will not be
-propagated to other names referring to the same inode.
+Enabled with the mount option or module option "copy_up_shared=on" or with
+the kernel config option CONFIG_OVERLAY_FS_COPY_UP_SHARED=y.
 
-Unless "redirect_dir" feature is enabled, rename(2) on a lower or merged
-directory will fail with EXDEV.
+If this feature is disabled, then a memory mapping created with MAP_SHARED
+might contain stale data if the file has been copied up and modified in the
+meantime.
 
 
 Changes to underlying filesystems
-- 
2.14.3
