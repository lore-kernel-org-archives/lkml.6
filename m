Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C334EC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC6120652
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTXKPJ0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC6120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeGGLi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:38:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37366 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGGLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:38:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so10473670edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=13uMaT1NyjZQ34S0+L35ppYFa3YLa1Py/CAwON7/yS8=;
        b=aTXKPJ0aZA0Y+4pNICpixJ8EzPvBC5SuETV35c5G7HOTiX/NVAanwRe2A0Nnz8sw+x
         8xM+ECZYOgtByhGlNokb+Hm/CcuCT92IyGsB84i9//dW4O7eABZ43tY+A57/DL3Rfr7w
         v6mnPvQDTwwXiQGW4kl837vsIlk+r040THPGLWwO5cDztIo5TSsBY8wUt/BpaCQj+91I
         lutC2yORrXpBHbDNAMKSGjQfEPx93t7fCIYKO78vwEwxBORJ+4jpJm6df3UEsQxajUbt
         aUn2xhoNdNZvlPONq6+SIYcACQnRHyZje+nN6Us3IA4cYfQvrJMSZ2hd36wYEYtLuexM
         EwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=13uMaT1NyjZQ34S0+L35ppYFa3YLa1Py/CAwON7/yS8=;
        b=ZtA1zu3YNdyJCyHi6XmHDBPObOpWW2aidI0U1c4P9nCGB8KnXLrIAiBnwOeXlUklf5
         rhF40oYcgPyMgf1RUWhafSIHjri/AOTaLSS1FVGqv8SUTSO9vOA33Fj4J7xrsdZPt4AR
         9Q1VXVJt8O6ID1hGBQw6bHJEovFyHVEk2Gc6XH5d6ct3B/hRyFxzoQqnPrCrNwgs5YAt
         APTeV1wjp9Xw6pc7DXCO+RybivviQYnOSvdeaiSGUDw+v6HAFP68aQHBIVwGrI+yZsTG
         gGM061OXGuby+Lmbn4QkrqSdsE+Ly6R5721kfNoACLE0dziEQolZLEK64+zLbU7cFaIn
         Iyzw==
X-Gm-Message-State: APt69E24czRFRW1TAkGhYQaVXHxSZkCAf4/G3UziRTi+fqd+1FEJjk9b
        a3GmxzMIPwhjKpKi6hoHl5E=
X-Google-Smtp-Source: AAOMgpdgfEKl8qut1UM1UutDi7bB/6WJ95oj/IKELKEG1z5Nn5wWMzB+6nCY4ufKKNmxvFNYIaURFg==
X-Received: by 2002:a50:ca02:: with SMTP id d2-v6mr14029507edi.53.1530963534482;
        Sat, 07 Jul 2018 04:38:54 -0700 (PDT)
Received: from arch.localdomain (x590e632c.dyn.telefonica.de. [89.14.99.44])
        by smtp.gmail.com with ESMTPSA id y89-v6sm5150306edy.80.2018.07.07.04.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 04:38:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove rtw_br_ext.h
Date:   Sat,  7 Jul 2018 13:38:40 +0200
Message-Id: <20180707113841.23245-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header rtw_br_ext.h is not used anywhere.
'git grep rtw_br_ext.h' returns nothing, remove the file.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_br_ext.h    | 55 -------------------
 1 file changed, 55 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_br_ext.h

diff --git a/drivers/staging/rtl8723bs/include/rtw_br_ext.h b/drivers/staging/rtl8723bs/include/rtw_br_ext.h
deleted file mode 100644
index 5eaeb3c9a97c..000000000000
--- a/drivers/staging/rtl8723bs/include/rtw_br_ext.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTW_BR_EXT_H_
-#define _RTW_BR_EXT_H_
-
-#define MACADDRLEN		6
-#define _DEBUG_ERR		DBG_8192C
-#define _DEBUG_INFO		/* DBG_8192C */
-#define DEBUG_WARN		DBG_8192C
-#define DEBUG_INFO		/* DBG_8192C */
-#define DEBUG_ERR		DBG_8192C
-/* define GET_MY_HWADDR		((GET_MIB(priv))->dot11OperationEntry.hwaddr) */
-#define GET_MY_HWADDR(padapter)		((padapter)->eeprompriv.mac_addr)
-
-#define NAT25_HASH_BITS		4
-#define NAT25_HASH_SIZE		(1 << NAT25_HASH_BITS)
-#define NAT25_AGEING_TIME	300
-
-#define MAX_NETWORK_ADDR_LEN	17
-
-struct nat25_network_db_entry
-{
-	struct nat25_network_db_entry	*next_hash;
-	struct nat25_network_db_entry	**pprev_hash;
-	atomic_t						use_count;
-	unsigned char 				macAddr[6];
-	unsigned long					ageing_timer;
-	unsigned char 				networkAddr[MAX_NETWORK_ADDR_LEN];
-};
-
-enum NAT25_METHOD {
-	NAT25_MIN,
-	NAT25_CHECK,
-	NAT25_INSERT,
-	NAT25_LOOKUP,
-	NAT25_PARSE,
-	NAT25_MAX
-};
-
-struct br_ext_info {
-	unsigned int	nat25_disable;
-	unsigned int	macclone_enable;
-	unsigned int	dhcp_bcst_disable;
-	int		addPPPoETag;		/*  1: Add PPPoE relay-SID, 0: disable */
-	unsigned char nat25_dmzMac[MACADDRLEN];
-	unsigned int	nat25sc_disable;
-};
-
-void nat25_db_cleanup(struct adapter *priv);
-
-#endif /*  _RTW_BR_EXT_H_ */
-- 
2.18.0

