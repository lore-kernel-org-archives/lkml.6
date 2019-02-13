Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC787C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC62222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025695;
	bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCaowY2NGgBqw5A+VEiDOg+qwqAFD7VlmDtcTD1BT9Nk9HGe12EkztAjBuMoSa9Ws
	 gIJ2yN+PRSX37kHPl5g9tQYBKfAUbfT/3YzbMLt7M15fEWRM70S3PykYrcxmO+NBx+
	 N5PmrkTl5ThkbR6CZvpgpjzPIKHwP/rK3n+RB59M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfBMCle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389285AbfBMCl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CDD222C7;
        Wed, 13 Feb 2019 02:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025686;
        bh=vU9FBR8zMZmPYzMM+UQCbhw06l0bFoddS/mbVyVQNtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1Aoloaj3uAthPEeroBtAzyauqyxJ0B6/1MkPvijzyIfLg5iNRAfGDWDREs5h/D1i
         j5ylnT752B8+zIZDc7wxBFTIAX6nQdJT5mIfEqLG8iF8q1m1XGunnKZeOWLewy/vjt
         Sg2LPq/NjSnLwhw6LJd7oBhHguyFzy/ptDZLJdjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/16] MIPS: ath79: Enable OF serial ports in the default config
Date:   Tue, 12 Feb 2019 21:41:05 -0500
Message-Id: <20190213024112.22038-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024112.22038-1-sashal@kernel.org>
References: <20190213024112.22038-1-sashal@kernel.org>
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

