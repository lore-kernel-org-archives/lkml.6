Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8027ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE8320881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzYYSWga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE8320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbeGWVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbeGWVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so2001468wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1iZcfFqFZX3yC+yAPsqbZaUyUYfpI8aFU8ktitDP2LA=;
        b=KzYYSWgaQOXXnrOChMSRjVT4/yWmTT8Nid9Nv9UTKbRf0x4hFfGUkXiagVKtSzwZXp
         86TAdByMHuAqQ2CWNl8P9Rb1bxelcIJ8ApKUl+pt4R3wtyQQssJLd3ULEh2kdfPqv9oE
         dDHwzVEgyAM/59N5EoTDDYUiFg31BHOD4S51z4sy7dCE0nJeUwEKwK2uyLZG+2znukM9
         1EcMu8ffJ1Ci8WJCpPEKuLeIIlfqrpwawP7YIk2z2Phs1rZk8bR/P9VP9znE6ZjJ6RDy
         OdaIlgYRtpD6fahf9VIJUpF76fyI8Zf686e71rVi0A3YhpfP7k6VFFoZ8xOo2hXQAY6N
         87iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1iZcfFqFZX3yC+yAPsqbZaUyUYfpI8aFU8ktitDP2LA=;
        b=B1aDYYgzaRMwS3HCn3dzb1lMOMUkTYplA22RbCNMM8jt3h0QbBKZjHCQSU2gcUy4F4
         TFNtn9BmHzOr+aDlEJR1aC6lL8VvjSD/F0YeED7m8DjiinEfWFTCQ/Eotjmhwcl5WT1V
         J42j5PoX2ORsh1uDZ8U1d2zSaBqeEj0Rf/vXsTvW4OuQdsEe8HxprI9H8tpaly/sqC4j
         vosHwTI2J7VWFmoE1ii10AK6jFkMOXBUfCjn1x2e9Rq7RHvLFAsuAo7xdRpn2JVKK4et
         FxRgigidvX8i/veyFVnPXGMOxnVgj2Fm1AN4d8qWT1Py16YPVNcpOulZXueoCO8Pxawp
         sGEQ==
X-Gm-Message-State: AOUpUlEumeGy0MkYOFSoSTNXJY4PAMXExtIvDJ8DzkXLbOP4GWBKp7jp
        7XmHQU19XrRfl8vO514XWQsDjsaM
X-Google-Smtp-Source: AAOMgpfKQeIIHTnF7XzmpdqjcBixmjopUJopQdOrGQ1kYenEIlyhbcOw9wGGHqvf1xEdH4cuAU9C5A==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr9667693wrc.7.1532379045395;
        Mon, 23 Jul 2018 13:50:45 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/15] staging:rtl8192u: Remove typedef of u32 to QOS_MODE - Style
Date:   Mon, 23 Jul 2018 21:50:17 +0100
Message-Id: <20180723205031.19816-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typedef of QOS_MODE as a u32 is contrary to coding standard and fails
the checkpatch tests for defining new types in code. Definitions of type
QOS_MODE have simply been replaced with a u32 type.

This is a coding style change which should not impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 96e9621e9887..45ba96a13b13 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -16,7 +16,6 @@
 //	QOS_HCCA			= 4,
 //}QOS_MODE,*PQOS_MODE;
 //
-typedef u32 QOS_MODE, *PQOS_MODE;
 #define QOS_DISABLE		0
 #define QOS_WMM			1
 #define QOS_WMMSA		2
@@ -454,8 +453,8 @@ typedef struct _STA_QOS {
 	u8				*WMMIE;
 
 	// Part 1. Self QoS Mode.
-	QOS_MODE			QosCapability; //QoS Capability, 2006-06-14 Isaiah
-	QOS_MODE			CurrentQosMode;
+	u32			        QosCapability;  // QOS_MODE QoS Capability, 2006-06-14 Isaiah
+	u32			        CurrentQosMode; // QOS_MODE
 
 	// For WMM Power Save Mode :
 	// ACs are trigger/delivery enabled or legacy power save enabled. 2006-06-13 Isaiah
@@ -502,7 +501,7 @@ typedef struct _STA_QOS {
 // Ref: BssDscr in 8185 code. [def. in BssDscr.h]
 //
 typedef struct _BSS_QOS {
-	QOS_MODE		bdQoSMode;
+	u32		        bdQoSMode;    // QOS_MODE
 
 	u8			bdWMMIEBuf[MAX_WMMELE_LENGTH];
 	u8		*bdWMMIE;
-- 
2.18.0

