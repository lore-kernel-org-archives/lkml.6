Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5D520880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6+jYTlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5D520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeGWVyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeGWVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so1987054wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YTFezIU1Ip9dVI628B0dABEzpoMmTT4+HK6zvKvy4Dw=;
        b=E6+jYTlS5y8jsgy3kvwLa55BiwvrJ40Y1jMhC9QamQvYElsUpRtsH47Rfa5GBz8i5B
         3Is58AX0bfWiRngCQMTlXX/pt8fX/JRJqyYu/nxNCmysnDUrWO7+KGmlA2gYJURWeGRb
         dJ4EimQCMBvXN91IzNpSp4xddoSP/a9ZZIyBieiiGiBEooUDaJ5dwi7Ux/YmwtOZEqSB
         vgYOQ4+yxpSe1SBiyD2IfaDeSwXxCQQ02bgJOpCwbzY/Cdwt3lZJUkLmgQMz8oXNK5KU
         f363N7SlQ87abc6j9Rg8V0yn2r/WL1tSsCtCoJUViy5Sr8CqQuv+9VH/9yHa3j0IronU
         ccjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YTFezIU1Ip9dVI628B0dABEzpoMmTT4+HK6zvKvy4Dw=;
        b=qSZBCnMeqFJpRlpzjuFhQcPeisTzQDD0H7iLOlx6Icotiy4oBp2PCDHEZif/5pPeV0
         lVtEEaRcpG/r04Z0RhN34oYwHZN2YV0NaccJviAS5bZveOd1YxpyupDxfUVXwzT1CB7f
         2CAzjNHTxxXbPuUK8eNEiEkv+gbPWmMPA1M+OTk05WUAAPKN70IOTpiGB11sRsVnu5vi
         wANgxIvCkSb6PlBTqyR48s9g3QKS4L/wBjExQ/gBHzToA7t/ac/nKhwCXgcCU4vLaZoV
         29gdyXIfWB9vI0XxpBM6h/4fKBT6cV5SVi3GnsU/ejVOCsybZeTVLvU04IUakaZwKunW
         aOmg==
X-Gm-Message-State: AOUpUlFY8+spzmPrvQbPDWyn9cG4urmHK7Gbuy1+qtZpSs+IcUOWrLVB
        tUX2cJPyjqSj//5U7xjV1/cIGHiq
X-Google-Smtp-Source: AAOMgpd860nKdKlllpKrDwmE5B0l546lL4tsS7I8hSHoS1GdJ9aVJ9u8kETtMZ0m8TDwyW9sbdrDEQ==
X-Received: by 2002:a5d:6a03:: with SMTP id m3-v6mr9333772wru.192.1532379060973;
        Mon, 23 Jul 2018 13:51:00 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/15] staging:rtl8192u: Remove unused structure WMM_TSPEC - Style
Date:   Mon, 23 Jul 2018 21:50:27 +0100
Message-Id: <20180723205031.19816-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the structure WMM_TSPEC as it is unused. This change is a coding
style change and should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 7028c9ae888a..58101d1ff2b8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -112,21 +112,6 @@ typedef union _TSPEC_BODY {
 	} f;	// Field
 } TSPEC_BODY, *PTSPEC_BODY;
 
-
-//
-// WMM TSPEC Element.
-// Ref: WMM spec 2.2.11: WME TSPEC Element, p.16.
-//
-typedef struct _WMM_TSPEC {
-	u8		ID;
-	u8		Length;
-	u8		OUI[3];
-	u8		OUI_Type;
-	u8		OUI_SubType;
-	u8		Version;
-	TSPEC_BODY	Body;
-} WMM_TSPEC, *PWMM_TSPEC;
-
 //
 // ACM implementation method.
 // Annie, 2005-12-13.
-- 
2.18.0

