Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58620C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172AD2156B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOWHXlCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172AD2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeHCB4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43575 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCB4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so1550446edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5vAIjOTZsvHoUcXZNByzOeviblSBW6rX+2tn6440jkM=;
        b=cOWHXlCXhZ3uGhq9W6y64FEy+ahY1R/fwKhao5frQQYpr7ULQ7xrGD2A+rJVfIUPH9
         /Ka12AZ/EjaHlWL7lKsibOKTCmccNpzqBZxEUIbPTosV3fERV2VfXE3ipk9E64ljmfR9
         wRiCZUmtzYu2g2vhEkHQtR/Ma+sAlS+qzKXQu45133UIm6kkh/CUfKMoupg7sDjmhmoC
         ExmwHbxc3pHnt4qBCCoF1TqlO+emWx6RK96BdylT7454lcNvwXb6iyC/d/bLnqLnXq/N
         rgQ5kbQcVHmmTLJM6sTmnJq9/qGc3UY29xFjvpqt39T5vxjGz3lm7jYhuLgxjfl9z/Bm
         Ot8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5vAIjOTZsvHoUcXZNByzOeviblSBW6rX+2tn6440jkM=;
        b=GJj61xdwo5ORuCM51NEy18a4Myh1g5w9a5vZyq7dC6QagF75IFhuv73oPPbTZEStvc
         hajNOrVcVF4nbC+T9JPC8cBeZa+wQGRjZyZSlLQwfpWAiXJsjZikN7nB77j9dsI60SK1
         DbL6e501YuZvgjiyVG+bDBexyBQn0Bn6lBLMl3d8N1RVTusfRfHFs48GQxmL8Vq4qV0p
         uNd2MGkQkBrzIevYA3Y5mT2c/HAwYh6rNRb/A2LPZWJoEiB0y0a9EEjJV5bDd7q33yoh
         p9dzjfnyZXE/6GHIUzhIZc3rtcNG/ACPR9rd1X8SWb0PibggTCYFBnPKKK3GHOWvQdRq
         UkIA==
X-Gm-Message-State: AOUpUlEVDDliZSNk8aguhHQcz4iLmE0NCuA+uT7dzwOOZfGDlL/2BOcO
        cThPNom5tA3bfgk/iI6mUK497o+O
X-Google-Smtp-Source: AAOMgpekxKd1WyLZqhINM9u5aRtDvj7ft0k02JcjEIURbNIJOAgDwTd4QOmyN/xKn08MJZI0upb+Og==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr5245159edn.57.1533254568702;
        Thu, 02 Aug 2018 17:02:48 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/18] staging:rtl8192u: Remove unused extern DM_RxPathSelTable - Style
Date:   Fri,  3 Aug 2018 01:01:58 +0100
Message-Id: <20180803000211.10589-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file r8192U_dm.h defines the structure DM_RxPathSelTable as being
external. The structure is however declared in r8192U_dm.c and only
used locally in that file.

As a result the external definition has been removed and the declaration
in r8192U_dm.c changed to being of type static.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 2 +-
 drivers/staging/rtl8192u/r8192U_dm.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 86f443ad75f5..54390587ba07 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -41,7 +41,7 @@ struct dig dm_digtable;
 /* Store current software write register content for MAC PHY. */
 u8		dm_shadow[16][256] = { {0} };
 /* For Dynamic Rx Path Selection by Signal Strength */
-struct dynamic_rx_path_sel DM_RxPathSelTable;
+static struct dynamic_rx_path_sel DM_RxPathSelTable;
 
 /*------------------------Define global variable-----------------------------*/
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index d51c20eafef4..06ebd820de52 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -154,7 +154,6 @@ typedef struct tag_Tx_Config_Cmd_Format {
 /*------------------------Export global variable----------------------------*/
 extern struct dig dm_digtable;
 extern u8 dm_shadow[16][256];
-extern struct dynamic_rx_path_sel DM_RxPathSelTable;
 /*------------------------Export global variable----------------------------*/
 
 
-- 
2.18.0

