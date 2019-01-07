Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD35C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5602070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfAGTpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:45:31 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:18954 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfAGTpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:45:31 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a9a9:5e6d:35c6:d37d])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id A86905FFC3;
        Mon,  7 Jan 2019 20:45:17 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH] MIPS: ath79: Enable OF serial ports in the default config
Date:   Mon,  7 Jan 2019 20:45:15 +0100
Message-Id: <20190107194515.16552-1-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
boards, enable it in the default config to get a working setup out of
the box.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/configs/ath79_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 4e4ec779f182..6f981af67826 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -66,6 +66,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AR933X=y
 CONFIG_SERIAL_AR933X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
2.19.1

