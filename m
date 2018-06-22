Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A95C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3956124330
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3956124330
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbeFVOCU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:02:20 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:41857 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933135AbeFVOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:02:17 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 9FE2358C5A0;
        Fri, 22 Jun 2018 16:02:12 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Fri, 22 Jun 2018 16:02:12 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     florian.harbecke@fau.de, linux-kernel@i4.cs.fau.de,
        gregkh@linuxfoundation.org, shreeya.patel23498@gmail.com,
        garsilva@embeddedor.com, tavery321@gmail.com,
        jeremy.lefaure@lse.epita.fr, aishpant@gmail.com,
        georgiana.chelu93@gmail.com, himanshujha199640@gmail.com,
        joe@perches.com, keescook@chromium.org, natechancellor@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        xmrancho@gmail.com, Henriette Hofmeier <passt@h-hofmeier.de>
Subject: [PATCH 2/3] staging: rtl8723bs: Remove unnecessary initializations
Date:   Fri, 22 Jun 2018 16:01:58 +0200
Message-Id: <1529676119-21591-3-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529676119-21591-1-git-send-email-passt@h-hofmeier.de>
References: <1529676119-21591-1-git-send-email-passt@h-hofmeier.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove initializations of global variables with 0.
Criticized by checkpatch.

Signed-off-by: Henriette Hofmeier <passt@h-hofmeier.de>
Signed-off-by: Florian Harbecke <florian.harbecke@fau.de>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index bbf6f3f..9d265f4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -13,18 +13,18 @@
 
 
 /*------------------------Define local variable------------------------------*/
-u8 fakeEfuseBank = 0;
-u32 fakeEfuseUsedBytes = 0;
+u8 fakeEfuseBank;
+u32 fakeEfuseUsedBytes;
 u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE] = {0};
 u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN] = {0};
 u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN] = {0};
 
-u32 BTEfuseUsedBytes = 0;
+u32 BTEfuseUsedBytes;
 u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
 u8 BTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 BTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 
-u32 fakeBTEfuseUsedBytes = 0;
+u32 fakeBTEfuseUsedBytes;
 u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
 u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
-- 
2.7.4

