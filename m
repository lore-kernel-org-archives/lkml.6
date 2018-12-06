Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA3FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228832082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107297;
	bh=RTRxGqY6fj2b0j1y+qVs2DxEvDw3oUFvyU/NLithKfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B69+zivYzUaiENM0Ma7F88eAqfcPLYbXxWACt7mrBfxR5RsBu7pHu3VZMrnT6t1x4
	 jQuLPqwjbS87YhzrUGWIFg4P5995RyU+LJ43GGJXQww1rpRVSieSZWSsYB29gknfzn
	 S9NoJiME8KGaDmZjAjFw/7u6OHsAyUo63TSvt7yE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228832082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbeLFOlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeLFOlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B406F20661;
        Thu,  6 Dec 2018 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107291;
        bh=RTRxGqY6fj2b0j1y+qVs2DxEvDw3oUFvyU/NLithKfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wk8lQpUcZUPIDbIzOcSO98xFInQ86oT7Jc6xmj4NRijoNjFw6oF5DAgi0qfhToJnJ
         IQciXEpK0+AHyOA54mStd/SQG7WeALWLJ3t2+fGfbxXteZH74tAdQ+iLLcMpT8y1d3
         FlSXgjVNraMz3DaCWJaihqZCnT0KayPpkkx4KJcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Cupertino Miranda <cmiranda@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.19 40/41] arc: [devboards] Add support of NFSv3 ACL
Date:   Thu,  6 Dec 2018 15:39:20 +0100
Message-Id: <20181206142953.964639360@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 6b04114f6fae5e84d33404c2970b1949c032546e upstream.

By default NFSv3 doesn't support ACL (Access Control Lists)
which might be quite convenient to have so that
mounted NFS behaves exactly as any other local file-system.

In particular missing support of ACL makes umask useless.
This among other thigs fixes Glibc's "nptl/tst-umask1".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Cupertino Miranda <cmiranda@synopsys.com>
Cc: stable@vger.kernel.org	#4.14+
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/configs/axs101_defconfig          |    1 +
 arch/arc/configs/axs103_defconfig          |    1 +
 arch/arc/configs/axs103_smp_defconfig      |    1 +
 arch/arc/configs/hsdk_defconfig            |    1 +
 arch/arc/configs/nps_defconfig             |    1 +
 arch/arc/configs/nsimosci_defconfig        |    1 +
 arch/arc/configs/nsimosci_hs_defconfig     |    1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig |    1 +
 arch/arc/configs/vdk_hs38_defconfig        |    1 +
 arch/arc/configs/vdk_hs38_smp_defconfig    |    1 +
 10 files changed, 10 insertions(+)

--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -96,6 +96,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
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
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -74,6 +74,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -67,5 +67,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -65,5 +65,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
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


