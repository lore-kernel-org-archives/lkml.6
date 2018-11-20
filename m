Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6E9C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E512087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mTMV6FgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E512087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeKTU6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:58:49 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:56770 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeKTU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:58:49 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AED9110C10B2;
        Tue, 20 Nov 2018 02:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542709823; bh=S3nnm0HhOfZpKN0zObzdpf90249fu1vz/NtqGlK/3Xk=;
        h=From:To:Cc:Subject:Date:From;
        b=mTMV6FgLT5nAtsHSCdfKCQvr7PC0OdOxUqbAHSnyzEl+ctDyVgQlIFSo0IFav5tBF
         bVacvJhC6XxgpuEyPgX5pnVwxhs5ehuffXr3n+rqOCopIExTcuxqzEdyquEKjA7K91
         ce7CDyunfG9zCF/1bSzyyuBxsslHgJpwXlCRNKZb0oSk5bL2KJBwcNGZFomBRHLtzR
         /QOC2C4U1wqVhRHRfVRQRwa1BSAhWbW9ftEzCAaIADzKmTi8GRgUvQHgHTlyBrOwD/
         noVmlshW66XWHBLlyZL3iuRW/cLwwQWtT0YTnqN2MMtNcUbutTzIoZ1sQdok8fuasQ
         G/g0i8nEHpQpQ==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.88])
        by mailhost.synopsys.com (Postfix) with ESMTP id 269443975;
        Tue, 20 Nov 2018 02:30:21 -0800 (PST)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Cupertino Miranda <cupertino.miranda@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] arc: [devboards] Add support of NFSv3 ACL
Date:   Tue, 20 Nov 2018 13:30:19 +0300
Message-Id: <20181120103019.12852-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default NFSv3 doesn't support ACL (Access Control Lists)
which might be quite convenient to have so that
mounted NFS behaves exactly as any other local file-system.

In particular missing support of ACL makes umask useless.
This among other thigs fixes Glibc's "nptl/tst-umask1".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Cupertino Miranda <cmiranda@synopsys.com>
Cc: stable@vger.kernel.org
---
 arch/arc/configs/axs101_defconfig          | 1 +
 arch/arc/configs/axs103_defconfig          | 1 +
 arch/arc/configs/axs103_smp_defconfig      | 1 +
 arch/arc/configs/hsdk_defconfig            | 1 +
 arch/arc/configs/nps_defconfig             | 1 +
 arch/arc/configs/nsimosci_defconfig        | 1 +
 arch/arc/configs/nsimosci_hs_defconfig     | 1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig | 1 +
 arch/arc/configs/vdk_hs38_defconfig        | 1 +
 arch/arc/configs/vdk_hs38_smp_defconfig    | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 41bc08be6a3b..8c23bd086cd0 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -95,6 +95,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 1e1c4a8011b5..666314fffc60 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -94,6 +94,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 6b0c0cfd5c30..429832b8560b 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -97,6 +97,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 1dec2b4bc5e6..2a1d2cbfee1a 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -65,6 +65,7 @@ CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index 31ba224bbfb4..ae7a0d8be98d 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -73,6 +73,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index f14eeff7d308..ad77f20e5aa6 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -66,5 +66,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 025298a48305..1638e5bc9672 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -65,5 +65,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index df7b77b13b82..11cfbdb0f441 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -76,6 +76,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FTRACE=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index db47c3541f15..1e59a2e9c602 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -85,6 +85,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index a8ac5e917d9a..b5c3f6c54b03 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -90,6 +90,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
-- 
2.19.1

