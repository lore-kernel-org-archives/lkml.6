Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49472C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0168C214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD6orZ5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0168C214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeIYRck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:32:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45251 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeIYRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:32:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id m16so6466215wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wjmen5gZEBrDi54Vj066qIyHYFFC6a3VexS7Ty7bVUM=;
        b=JD6orZ5b7U7s6V7obXmyHLiG35d4YAhUlUSyoK3qS5Gx54rbq13vHiamz/AI2Ffi7C
         H1o7l2CHc2XNAI4aezJ3hPOWev3C6PKe0Pbo5IXrD5NNF5dNjxwNrtkLwirFymMc5Adq
         /7tTZdgwTSVVYvXESistW6yC+LGSLxI3CKvUUJg4v7La31thRtWgw1XV73FHVyt3oN5u
         O0eIhdy4UU5iG6Fv2oEfnUrrc/k4I9RZl4KgWTuPOVtD1QnZUB7hUymHhMgoqex3nUfK
         rbudkKSezQV+2k3AVUjQSpPkcOlNBCGB12IlnfordvTMtQXw1611t+oKbWrXTRbGKe8J
         g7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wjmen5gZEBrDi54Vj066qIyHYFFC6a3VexS7Ty7bVUM=;
        b=s27G16OPLko0kOzdC/WkyAlN/jY3OPP5F7/SeXOIG36faaezVXbdeQ8utQ1RE85MS1
         L6YGvxTGyXsJ3OZ4zH1qmxToCBzNdV+9+kE8yTi4+ASUJ2TmD9EJogBxW1Ch8QffFpJN
         KpxPzw/DiSUI+z1YBcntHCVnd0BMf6aluvHAUIo1MPeLUGfPH4JTqD6YsK6+BD/FGoww
         5wvf2ZNXpWTiWIIQQF7DZt5sL5EBs9CwstiQSu8B1iO2mrUDzIxdDZk7ZVqNBLvi4Exi
         XpGAfrkZmCwtpFt1xAWEZ3uT1MvKBQ4hQGtK5MuBUOvTuFNc/I1LN94NxTpdgaxoTW3u
         XxoA==
X-Gm-Message-State: ABuFfoi2CD+4VhTADr2+6WRdqOaqToOnuSWlulT48BIvb/jspU47VUvg
        0VEdilopPm8HTABwrwP068Y=
X-Google-Smtp-Source: ACcGV61sWxsGoZ5cpxb+cot6ltdcNn4dMMKbTR09wn+LbFKv/wykZZS+gTLBrnexZ0NAiglEMK6jZw==
X-Received: by 2002:adf:fe48:: with SMTP id m8-v6mr542235wrs.171.1537874731945;
        Tue, 25 Sep 2018 04:25:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id w13-v6sm598143wrn.56.2018.09.25.04.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:25:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove rtw_qos.h
Date:   Tue, 25 Sep 2018 13:25:21 +0200
Message-Id: <20180925112521.1254-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925112521.1254-1-straube.linux@gmail.com>
References: <20180925112521.1254-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one struct in rtw_qos.h and it is only included from
drv_types.h. Move the struct into drv_types.h to reduce the number
of header files.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/drv_types.h |  7 ++++++-
 drivers/staging/rtl8188eu/include/rtw_qos.h   | 18 ------------------
 2 files changed, 6 insertions(+), 19 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_qos.h

diff --git a/drivers/staging/rtl8188eu/include/drv_types.h b/drivers/staging/rtl8188eu/include/drv_types.h
index 4ae095837bef..35c0946bc65d 100644
--- a/drivers/staging/rtl8188eu/include/drv_types.h
+++ b/drivers/staging/rtl8188eu/include/drv_types.h
@@ -24,11 +24,16 @@
 #include <rtw_recv.h>
 #include <hal_intf.h>
 #include <hal_com.h>
-#include <rtw_qos.h>
 #include <rtw_security.h>
 #include <rtw_pwrctrl.h>
 #include <rtw_eeprom.h>
 #include <sta_info.h>
+
+struct qos_priv {
+	/* bit mask option: u-apsd, s-apsd, ts, block ack... */
+	unsigned int qos_option;
+};
+
 #include <rtw_mlme.h>
 #include <rtw_debug.h>
 #include <rtw_rf.h>
diff --git a/drivers/staging/rtl8188eu/include/rtw_qos.h b/drivers/staging/rtl8188eu/include/rtw_qos.h
deleted file mode 100644
index bf617da3cd6c..000000000000
--- a/drivers/staging/rtl8188eu/include/rtw_qos.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTW_QOS_H_
-#define _RTW_QOS_H_
-
-#include <osdep_service.h>
-
-struct	qos_priv	{
-	unsigned int	  qos_option;	/* bit mask option: u-apsd,
-					 * s-apsd, ts, block ack...
-					 */
-};
-
-#endif	/* _RTL871X_QOS_H_ */
-- 
2.19.0

