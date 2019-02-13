Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2223BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89AF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025781;
	bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQsET6PvQ+wq+TPcMzhoxWrFKjvmd/Es6xoYjR0jfnIyPYywruTqKyFrzCAqpTHZ8
	 Hw8MS0TF8juvbOxse6LN0NCP3WTaF0nrJdZXEjvlyHHcaUaqmeQlESYPefoOHoJPnN
	 Im/5YYdIIqgcf14Ktt1WRrC/7IPE2RnT5SOcunmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfBMCm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389364AbfBMClt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AE12175B;
        Wed, 13 Feb 2019 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025708;
        bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1vy9ermfZxsE2+R0DZmbULZnP9y4Y/QFRuNOriYyTLzGs8PXDrhAQeNI9K14XbVl
         e1Y12sUdWfWZpbOLk1hY5JcufO8Rn2REeRq4/0r7vcIING/yACt/wrGuSjPp0ekAV1
         f/KUFKlAq2USMe57ztPrQ/dqOxO66FmiVRJpUEys=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 07/14] MIPS: ath79: Enable OF serial ports in the default config
Date:   Tue, 12 Feb 2019 21:41:31 -0500
Message-Id: <20190213024139.22268-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024139.22268-1-sashal@kernel.org>
References: <20190213024139.22268-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

[ Upstream commit 565dc8a4f55e491935bfb04866068d21784ea9a4 ]

CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
boards, enable it in the default config to get a working setup out of
the box.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/configs/ath79_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 134879c1310a..4ed369c0ec6a 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -74,6 +74,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AR933X=y
 CONFIG_SERIAL_AR933X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
2.19.1

