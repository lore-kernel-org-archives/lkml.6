Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C34C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687B22145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543301;
	bh=s+leIqEWRmPpaUafOGtZSiYnqS66qD8NMa/nAeSwmbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0R9AgGnY6qVCxLPPlwG5GsagmMCRulyUhFAF/z0HM2KPbH1PIXi+2wUbElEbjGpH
	 GTmp1f4RUjIcTCnCTYJPviR2PoTgxJMR2Rpdly8JzVrJChJwTyNswVWYioi/meeFRg
	 DjMQkQdsG1ArO6V07bUTMH98lHXIjvR6s3J0lO60=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeLKPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbeLKPsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E7520870;
        Tue, 11 Dec 2018 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543295;
        bh=s+leIqEWRmPpaUafOGtZSiYnqS66qD8NMa/nAeSwmbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpZC9DbSqBgz79Q3NHoRQjEcUvo7Qg1S2XvRPNsRAH/0fPlalEYA13DSQn1fX+27f
         iZRZ2YHNd5eAJeVA1jrfvUZNLv/8sQjKMgvHv6HVriPrDwOLyx/ORJwE34tav65y4C
         JUteGxCwGYJ6QDuSYSqr7RrwBQLz6C1Mc6efSpYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Cupertino Miranda <cmiranda@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 53/91] arc: [devboards] Add support of NFSv3 ACL
Date:   Tue, 11 Dec 2018 16:41:12 +0100
Message-Id: <20181211151610.321985421@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arc/configs/nsimosci_defconfig        |    1 +
 arch/arc/configs/nsimosci_hs_defconfig     |    1 +
 arch/arc/configs/nsimosci_hs_smp_defconfig |    1 +
 arch/arc/configs/vdk_hs38_defconfig        |    1 +
 arch/arc/configs/vdk_hs38_smp_defconfig    |    1 +
 8 files changed, 8 insertions(+)

--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -98,6 +98,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -103,6 +103,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -104,6 +104,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
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
@@ -69,5 +69,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -88,6 +88,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FTRACE=y
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -89,6 +89,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -91,6 +91,7 @@ CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set


