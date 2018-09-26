Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22BEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9034A2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3iFnTs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9034A2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0CSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:18:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34949 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:18:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so3677494wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NslCIAcdFGd1N7mUs3Oc70HzG5D+6kN/y3Iaoy670nA=;
        b=d3iFnTs1Yya+8FoG3AsxlrsTL1ATT4d7yp1ykyrAxf5f5PTl9XdNx9yD0wSSBfKrIS
         LI18m9S1eSUKNFRSl828zQ+HR4z6pOLqtFU5C2ocr2X+vpsaJqBZaGh+3vk26Rx+H8Oj
         wiViIoQv4Hn9vdsZu/qbV9x7NW37LJoab8aKwcSzsiI+/bphpnRCKcgl73Y/1DkxjHDB
         fP23xgqemqMiY/mho0tfcauR80S50vONmiiJFBwwmXYTIT8/Bwf/tvzo6OiVHT4I+xDc
         Z19SuSC8gZd0U0J4810IrARwDZez2rey+iQF6/+pXdmsKXbfoEu2cA0c/mBt/u5DYsen
         dOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NslCIAcdFGd1N7mUs3Oc70HzG5D+6kN/y3Iaoy670nA=;
        b=rj56pPMHzosAkVM3NWtEPkuXFkCHkcQAho5pK/aBqkjLEPCRVJcjmMF6la9C+cd2ur
         Y3zx1rWlgMfJh5HNzIXpCc3dUYJJZoLdMI/TvJJPp5/CCZFnEURLGuzpiNskfkdjpikl
         fRf0vkZQHCuoz8WwPuE8lm1Nw8H6I8S5SU5cafMeqVUEAiYz2+9IQp7FX1jqjf7cOzKs
         IVDBP/oblGX5xWQ/ymLqaIaK1uqUfLx296qNR9b1T7NFSmFMpN04aU1N8WYR8jPUxR70
         FHVpg6fPG8Nk+K1PNAZcBvYSDw45eF+RrhvSL/bNbcxOKbDrfXiolMmaKKvPsKD2F+YA
         GtuA==
X-Gm-Message-State: ABuFfogUbbswMcZ9JnzYgFGSA4ArTiZ3p/JDWXRNLDdbqEk1pLb4KX8+
        +8BUwaSwyZDKm8VJKNH8JBYckV6U
X-Google-Smtp-Source: ACcGV60R+B8TbG1z6IvNiVgHyc8Z0e1dZO0ZB31AR7jhhMvVyAkVqEc10ruelGHsvKGvBhKOK9O9GQ==
X-Received: by 2002:a1c:c444:: with SMTP id u65-v6mr5742073wmf.10.1537992256052;
        Wed, 26 Sep 2018 13:04:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7447403wrr.21.2018.09.26.13.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:04:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: simplify function comments - style
Date:   Wed, 26 Sep 2018 22:04:05 +0200
Message-Id: <20180926200408.2372-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify function comments. Clears a 'line over 80 characters'
checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index ddd7f67fe5a2..9226a96aba67 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -22,13 +22,9 @@ enum{
 	};
 
 /*
- * Function:	efuse_power_switch
- *
- * Overview:	When we want to enable write operation, we should change to
- *				pwr on state. When we stop write, we should switch to 500k mode
- *				and disable LDO 2.5V.
+ * When we want to enable write operation, we should change to pwr on state.
+ * When we stop write, we should switch to 500k mode and disable LDO 2.5V.
  */
-
 void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 {
 	u8 tempval;
@@ -872,9 +868,7 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data)
 	return result;
 }
 
-/*
- * Overview:   Read allowed word in current efuse section data.
- */
+/* Read allowed word in current efuse section data. */
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 {
 	if (!(word_en & BIT(0))) {
@@ -895,9 +889,7 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 	}
 }
 
-/*
- * Overview:	Read All Efuse content
- */
+/* Read All Efuse content */
 static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse)
 {
 	efuse_power_switch(pAdapter, false, true);
@@ -907,9 +899,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse)
 	efuse_power_switch(pAdapter, false, false);
 }
 
-/*
- * Overview:	Transfer current EFUSE content to shadow init and modify map.
- */
+/* Transfer current EFUSE content to shadow init and modify map. */
 void EFUSE_ShadowMapUpdate(
 	struct adapter *pAdapter,
 	u8 efuseType)
-- 
2.19.0

