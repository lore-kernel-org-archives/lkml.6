Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B7ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2BE2085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wVCPWzNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2BE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeKDXJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbeKDXJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F212086C;
        Sun,  4 Nov 2018 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339643;
        bh=6AApVXRnvnCpSeb5pwoPSmBbt1kdBm6Agkd1FphtE+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVCPWzNoH5YBUftVmpBN/KJMzZehqeEkn48ub3GyEfqdBXE/bTGKsbQnhpCCaKiO5
         GjexLAsKo3/eUbAMOKIAC7976EJQ89vcxAegUEyAQYBa39M5WhaeNoCcWdi2hci9sL
         DSBHPg1qTjB498F7NZCVejJfbBIjMw2lQiFQLbwI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/21] ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL
Date:   Sun,  4 Nov 2018 08:53:40 -0500
Message-Id: <20181104135355.88602-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135355.88602-1-sashal@kernel.org>
References: <20181104135355.88602-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 35d3cbe84544da74e39e1cec01374092467e3119 ]

Andreas Müller reports:

"Fixes:

| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[220]: Failed to apply ACL on /dev/v4l-subdev0: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[224]: Failed to apply ACL on /dev/v4l-subdev1: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[215]: Failed to apply ACL on /dev/v4l-subdev10: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[228]: Failed to apply ACL on /dev/v4l-subdev2: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[232]: Failed to apply ACL on /dev/v4l-subdev5: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[217]: Failed to apply ACL on /dev/v4l-subdev11: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[214]: Failed to apply ACL on /dev/dri/card1: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[216]: Failed to apply ACL on /dev/v4l-subdev8: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[226]: Failed to apply ACL on /dev/v4l-subdev9: Operation not supported

and nasty follow-ups: Starting weston from sddm as unpriviledged user fails
with some hints on missing access rights."

Select the CONFIG_TMPFS_POSIX_ACL option to fix these issues.

Reported-by: Andreas Müller <schnitzeltony@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8ec4dbbb50b0..47c3fb8d4313 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -361,6 +361,7 @@ CONFIG_ZISOFS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
-- 
2.17.1

