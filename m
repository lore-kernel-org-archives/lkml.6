Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E0C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75380215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hobe5q3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75380215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeHCB4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42719 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1553374edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ax4oM9OpGDVGWW1xVnh9QmvW0pRDUFDQvwBBtbySsrA=;
        b=Hobe5q3hdZSfEXvw9ncnxZ5bW2F3CqkndbQyrqk9eTNCB531Sk5xNy7uxQZEQBT4o6
         qwNEvFWO+Y3oOnRdeGaMUeyaoCtTXc7XkHrMdNwoMLCWnh5YKy4IIEX2OrEjtkO37ccp
         GeN+I2eJ3KQtRkMvNC+MqljugD5YgTtI0nLlp+YM18Ftp7WGDogoTS/V6RMWDDDgOAnV
         YOSW+KQ52JbQBmM6wmIkznNsvcI3GG1tTID8cXJVuFuupIWTp5AMaOBEu/V2Clfz1WrR
         mr8TPLwqPdUAD0nOi9Yyn1qN8Mv6Rgbi/7UeLiyvZvERYuTO9XgKEUJRP5n8SG2Zv+/8
         S77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ax4oM9OpGDVGWW1xVnh9QmvW0pRDUFDQvwBBtbySsrA=;
        b=l45qDJfL6V4NfD/xbrH0H4SKdOJQ3Zyo7Uq2adEOZHNdcL7h5rOG1foyFPCHQma3A1
         wssQklkmbVYlepKbTV0ihA1yQ99l+pbC2m0lAQHEZldmFt/p6PBMOYe7hXBzxfSFMphS
         B6hTuHGd5Pq63IrQQ9KgqieIJcu/0kFJ4dklAniaGsqVG2JbHRKlXAJ4PYjb59AqN+Z6
         1prfbvqcLGrCDwgj9/vo8WF1H+q4OuOomQHsLTPUImHkK/0lat/uQdertYurpgoXrtJn
         Bby6pddxmwzq7vzvGZdd6jbvZEu04FQeNPiYO6xj2Olv9lpNLswsKose1dgdWeLwS5qH
         zZoQ==
X-Gm-Message-State: AOUpUlGrrHa64B+9qDRUZ1ewTnR7qAlB0tPVbrQhxa60FiuT2eLSml6m
        JeMEt28dhhQ8qIABz0aNd6jCLlIH
X-Google-Smtp-Source: AAOMgpd00Y34OFfxq04uLy3ocD3R6k87aNQ7UJDjleLKws/j6At9mbCNQ/q18GMCTAyMU+YNL7WsOw==
X-Received: by 2002:aa7:c50d:: with SMTP id o13-v6mr5103478edq.224.1533254566013;
        Thu, 02 Aug 2018 17:02:46 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/18] staging:rtl8192u: Remove member initialgain_lowerbound_state - Style
Date:   Fri,  3 Aug 2018 01:01:56 +0100
Message-Id: <20180803000211.10589-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure 'dig' defines a member variable
'initialgain_lowerbound_state', which although initialised to false,
is never used in the code. As a result this unused member variable
has been removed.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 1 -
 drivers/staging/rtl8192u/r8192U_dm.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 8b9d011e9eec..ede596a91c03 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1640,7 +1640,6 @@ static void dm_dig_init(struct net_device *dev)
 	/* 2007/10/04 MH Define init gain threshold. */
 	dm_digtable.dig_state		= DM_STA_DIG_MAX;
 	dm_digtable.dig_highpwr_state	= DM_STA_DIG_MAX;
-	dm_digtable.initialgain_lowerbound_state = false;
 
 	dm_digtable.rssi_low_thresh	= DM_DIG_THRESH_LOW;
 	dm_digtable.rssi_high_thresh	= DM_DIG_THRESH_HIGH;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index f3e3db18fdd0..ba73dd1d1793 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -119,7 +119,6 @@ struct dig {
 
 	u8		backoff_val;
 	u8		rx_gain_range_min;
-	bool		initialgain_lowerbound_state;
 
 	long		rssi_val;
 };
-- 
2.18.0

