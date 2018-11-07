Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1479EC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58AF2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxsEpu2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58AF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbeKGKKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:10:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36981 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbeKGKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:10:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so6578019pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S39Mv51iEkJcVIuan/+ZK715xonqoHeM2mSCQNP07nk=;
        b=qxsEpu2vJh3GCLQ8nXS5Bnf14OqU1idAncgLWJHCKp/P1iyvPgOzkCKj9UALFxrb36
         yIZ7ATuzF5SsMmrwSX7m/OHJRDGTh2ZORzmWyZ/mHXsBqeBIz+CmjGdYvQfUN+e/xpcz
         7EIJFrNtNAPv3F/7udT/HR6vcnil9pq2OehXCppFMGKTLQTx4wiz7JWNKAcKfgRi1HQK
         tb+q+hsqu6dHPgjo28gMeJ5CLU4aUSLi4bS4jUHGxUjsuC8Ig6wQDl7eWWKegrmGXxRg
         wh1PsckSyTgDGBqwbYqnnp35wPlwZ+kObUYzZIBs/NV1WXD5SVh6GCGA1yQTM1ySTIDM
         0v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S39Mv51iEkJcVIuan/+ZK715xonqoHeM2mSCQNP07nk=;
        b=WnTNTUb/quU+tO1O7kjj5fFHQpjl9IOKBmehIwSuBqYiqkUWnAKvdtrbzg/joBtgRf
         W7adm6TjGEjCPULPLJxsF+/VMcdlMIV/jW82n6ZAdK01W23PcK98iPcNvnDo44tnpJyq
         /rZeOLXXUDyVCyfjWeE0f6uZTDBqIvFVVFXAhDqrAvEF2WfYl66R62AWeuJHUIoRgNTQ
         Wz0ypVRU7UpO2JbfgjljP3KBDHCTeTMu89Wk/F8rGoKxxwLH8hMGiOyYl+J1cxtV7E16
         3n4BkLdpU7qGdWGYrvas0VtPSQPZWtXzkodvmRp9Uwc0ph826AxbsKGnGLyqRwKJ5tfu
         MQwA==
X-Gm-Message-State: AGRZ1gLR+4ElX+P1+cZtvC1eo2zwAGKpfFmXHJ66a8KMweElU0apUBOo
        V5HcpzsF6QybFl+z+IDGK+k=
X-Google-Smtp-Source: AJdET5dnw7pc6slKSvhLUQ5C9HD/LgviI/iHm/dIZ/sXxXzrQc4TN9av/gxA/zZ1kX9KuAii0IS+Tg==
X-Received: by 2002:a63:f210:: with SMTP id v16-v6mr24934387pgh.371.1541551327183;
        Tue, 06 Nov 2018 16:42:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k75-v6sm53509581pfb.119.2018.11.06.16.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:42:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add entry for 7255
Date:   Tue,  6 Nov 2018 16:41:48 -0800
Message-Id: <20181107004151.20370-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Add in BCM7255 entry and reorder entries to keep ascending order. Also
moved 7278 cause it was out of order.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 0f580caa81e5..bf8702ee8f86 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -26,8 +26,9 @@
 
 #define UARTA_3390		REG_PHYS_ADDR(0x40a900)
 #define UARTA_7250		REG_PHYS_ADDR(0x40b400)
-#define UARTA_7260		REG_PHYS_ADDR(0x40c000)
-#define UARTA_7268		UARTA_7260
+#define UARTA_7255		REG_PHYS_ADDR(0x40c000)
+#define UARTA_7260		UARTA_7255
+#define UARTA_7268		UARTA_7255
 #define UARTA_7271		UARTA_7268
 #define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
@@ -82,15 +83,16 @@ ARM_BE8(	rev	\rv, \rv )
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
 21:		checkuart(\rp, \rv, 0x72500000, 7250)
-22:		checkuart(\rp, \rv, 0x72600000, 7260)
-23:		checkuart(\rp, \rv, 0x72680000, 7268)
-24:		checkuart(\rp, \rv, 0x72710000, 7271)
-25:		checkuart(\rp, \rv, 0x73640000, 7364)
-26:		checkuart(\rp, \rv, 0x73660000, 7366)
-27:		checkuart(\rp, \rv, 0x07437100, 74371)
-28:		checkuart(\rp, \rv, 0x74390000, 7439)
-29:		checkuart(\rp, \rv, 0x74450000, 7445)
-30:		checkuart(\rp, \rv, 0x72780000, 7278)
+22:		checkuart(\rp, \rv, 0x72550000, 7255)
+23:		checkuart(\rp, \rv, 0x72600000, 7260)
+24:		checkuart(\rp, \rv, 0x72680000, 7268)
+25:		checkuart(\rp, \rv, 0x72710000, 7271)
+26:		checkuart(\rp, \rv, 0x72780000, 7278)
+27:		checkuart(\rp, \rv, 0x73640000, 7364)
+28:		checkuart(\rp, \rv, 0x73660000, 7366)
+29:		checkuart(\rp, \rv, 0x07437100, 74371)
+30:		checkuart(\rp, \rv, 0x74390000, 7439)
+31:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.17.1

