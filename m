Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A92C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107398;
	bh=0APJJ3fdh6D4VhvySZF+ntDZMdm1ryX2e5rSsDGvcg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehT8QNMgo2FcqHcG8RteNrv2TowwPW2ad8KRwyOCD5wBs3rFr4f0lPcIAlIiUcjcY
	 O/JRtJlBTmq/SEOLwt/tiLSuRl9yJ3oZqPI7joevoCZC0g9YT3ZIzBFhHWvWXbslpg
	 mV2cMwi585FRAAAMfFdezrsjjWTGYzHTyGKk0DsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeLFOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbeLFOnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E2820661;
        Thu,  6 Dec 2018 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107389;
        bh=0APJJ3fdh6D4VhvySZF+ntDZMdm1ryX2e5rSsDGvcg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUNHwvq1rzJ0ypz+icK7SYZpN6W0H0BYQqyBtZze8gLUA+l1HknBBxg+Ud9uJ53Ev
         o5RpoGCv7K4MHb5rpxL7JQ2y7ALqE3wIP/eU4/+5lqEdJb7k9gYaYh+08san9AK5BL
         e0LiSGyaYia4Ext3yvBIjQTuQpDd82qaymIWeR6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Cupertino Miranda <cmiranda@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 43/55] arc: [devboards] Add support of NFSv3 ACL
Date:   Thu,  6 Dec 2018 15:39:17 +0100
Message-Id: <20181206143004.072424638@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -99,6 +99,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -97,6 +97,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -100,6 +100,7 @@ CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -66,6 +66,7 @@ CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -75,6 +75,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -70,5 +70,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -68,5 +68,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -79,6 +79,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FTRACE=y
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -88,6 +88,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -92,6 +92,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set


