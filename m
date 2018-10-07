Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E8C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D80420882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzK8tcHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D80420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeJHEsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeJHEst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so17964881wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfpgAlVDGSSoROnCWHqEXuG2A6USETtvsLBWJ2Dz2rQ=;
        b=uzK8tcHQYGSYEP2FmYU4bZ1gmYqlk8rHo8jf7Kt7L99Pz25X2pVIyKe7di4VYA6JCP
         U/GVru3AzTS35ZPFi+5WXoHBSRZb6ZYME/TQcU8SRMQuXraZxz9ZKRgs3tPs/8sGyf83
         MuMwKopWYEFEQAQmoxjnXZqRS9xUHj8vV7V1fW49GlAGj+fLLt8Hx1grYVO7S9LPhGv0
         h733YBDPkoNLlbNb0JNnT81XOndla6wY0GXaVAxbduRboRwMcwZxOOr0a7znJMFJ+WTv
         YM4uE5ZnpFLXT8OHoPvHmvV37Hdb5fK+m5Cu0WZLuoX4ob3/xAMn7DyD03vJFZ3kvAoV
         vMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfpgAlVDGSSoROnCWHqEXuG2A6USETtvsLBWJ2Dz2rQ=;
        b=iYQAcMHaLI5FqqymBwqActyDf9m1zswflvhVyEPsUZrNXMmgfc0LQxr8K1qPCSM9b+
         poTZxty8lHpw3viXN5kOa6bkVEFIuB++xKa/RiX+oZsC/JE5v3MWkDJpB5p0PBXBg+Uh
         WzVF0VuZZQ2ifc33Nbf/8ygKGqkrPsZ6/+zU58Fgu/I8QzfP2QayeY2bQjCCnzrF3KwB
         LB47CvQ4b7stAWluvS9deinqq1X/zWPyIAzxmLKSVNxtljGA+eMI97WjY+W1BEIbNeAv
         h8UjgYcNR+2WMwc/SF96ngfGdSEZfaYOgGDJVkP+D1dPdC4bdJ55r8AnW8soDIvBYddN
         IwSw==
X-Gm-Message-State: ABuFfogKqShvNGd9OoHAtWVjyjYUyJ/4b0h60qokvdtOHByUEvJ0inGb
        jk8nQQ16EWQAKtOKFzh5GO0NuKDc
X-Google-Smtp-Source: ACcGV603mdn1eN0QY0fgIDAcxhDrWasR0VyXe5HlfwGEtmX1IZl0oPtB397mVSpPxkkA9/Y7WUilkQ==
X-Received: by 2002:adf:fa4e:: with SMTP id y14-v6mr14755490wrr.155.1538948412646;
        Sun, 07 Oct 2018 14:40:12 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/11] staging:rtl8192u: Remove extra blank lines - Style
Date:   Sun,  7 Oct 2018 22:40:18 +0100
Message-Id: <20181007214025.25469-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extra blank lines to clear checkpatch issue.

This is a simple coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 20348a1f2d32..c52eac0bf6f6 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -94,7 +94,6 @@ static inline void ieee80211_networks_initialize(struct ieee80211_device *ieee)
 		list_add_tail(&ieee->networks[i].list, &ieee->network_free_list);
 }
 
-
 struct net_device *alloc_ieee80211(int sizeof_priv)
 {
 	struct ieee80211_device *ieee;
@@ -121,7 +120,6 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	}
 	ieee80211_networks_initialize(ieee);
 
-
 	/* Default fragmentation threshold is maximum payload size */
 	ieee->fts = DEFAULT_FTS;
 	ieee->scan_age = DEFAULT_MAX_SCAN_AGE;
@@ -186,7 +184,6 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	return NULL;
 }
 
-
 void free_ieee80211(struct net_device *dev)
 {
 	struct ieee80211_device *ieee = netdev_priv(dev);
-- 
2.19.0

