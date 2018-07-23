Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87C920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTGU524S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87C920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeGWVx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33717 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbeGWVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so4079884wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mlAXLB6gM2wUhNR/MgoMvs8c6EKF+595zaTnjL5FRD8=;
        b=nTGU524Sx64bfXu3n4H6B0UJudyDmtZoimJXgCCF2NOfCbCQH9nNTCc49O13so/XUK
         q4snMp6b4pHFD8OD23ruzn4jIn6vsbJ/TjsSqQcSth55/bEpXMJ0oEoInnVbWHRsP73n
         9y+2/K0u7eBzp8GgGZHSHHtPabsgB3xY08oGvJ3ySeGD7Ypf38V1vZbPy+BqXolv6wX7
         4L5h4h6sWDlcEmTPXc1tbUyZvYaYysDg2lEZSi8unkL+/TjhS3Gp+piYhBAb0QSmVE67
         ttsLoI9iBCWDupNTaIJGpW+brtSW3FS526ztyv0Bs34mnaEJBd070L+Y0DSpccNv1q7d
         QYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mlAXLB6gM2wUhNR/MgoMvs8c6EKF+595zaTnjL5FRD8=;
        b=F7YWz1LpyOqHn4ma20aLhTZouMc36mQ1f1AjQOnlIurZwmgEnhLo+IJOx+q8FoOTcl
         3GQ3KgA0rsfKraVjnIYVs5cWgC+9i3g/GZVLb7Kokg4dPVRmsFPTO+F0AS8LyNd06HNQ
         gPJLxjLWuqv380MlEwor4dweN9mWIVt9whvd+XjAGGm6+3/638Ke3y+NlQlLs36t/5St
         3kbuOhcmqumBbGZ4FIVVzH5H/ywYipRDRiC7WmD2yG1ZTeeHzlgGg3Ek3J7WeoURzeg3
         GMsqEDyZtG4WNxEe6SDqFM+KUm/3RDOY2EbjhEBLMSm3XyIVIk45xOF0nau+cy3AfUrU
         AVHw==
X-Gm-Message-State: AOUpUlFKKJjF8cQU5nW9z0TIBoDArZi2bCHYxRRhlyh0PNHCPKO/ZyrC
        1nvwK2wOlCywsS98rtwjfFqf6vxt
X-Google-Smtp-Source: AAOMgpdnv/bI6OuIWn9rt3mZ1ylJnWHtil6M+ojnfyqMpPYDyZtttNnM/SherMzGmf0ZlBEdEK/GSg==
X-Received: by 2002:a1c:80b:: with SMTP id 11-v6mr302218wmi.125.1532379056147;
        Mon, 23 Jul 2018 13:50:56 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/15] staging:rtl8192u: Remove the unused AC_CODING definitions - Style
Date:   Mon, 23 Jul 2018 21:50:24 +0100
Message-Id: <20180723205031.19816-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AC_CODING definitions are unused in code, so have simply been removed
from source. This is a coding style change and should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index e0c51c5c6816..455b87edc7fb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -9,26 +9,6 @@
 
 #define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
 
-//
-// ACI to AC coding.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.13.
-//
-// AC_CODING is redefined for enum can't be ++, | under C++ compiler, 2006.05.17, by rcnjko.
-//typedef	enum _AC_CODING{
-//	AC0_BE	= 0,		// ACI: 0x00	// Best Effort
-//	AC1_BK	= 1,		// ACI: 0x01	// Background
-//	AC2_VI	= 2,		// ACI: 0x10	// Video
-//	AC3_VO	= 3,		// ACI: 0x11	// Voice
-//	AC_MAX = 4,		// Max: define total number; Should not to be used as a real enum.
-//}AC_CODING,*PAC_CODING;
-//
-typedef u32 AC_CODING;
-#define AC0_BE	0		// ACI: 0x00	// Best Effort
-#define AC1_BK	1		// ACI: 0x01	// Background
-#define AC2_VI	2		// ACI: 0x10	// Video
-#define AC3_VO	3		// ACI: 0x11	// Voice
-#define AC_MAX	4		// Max: define total number; Should not to be used as a real enum.
-
 //
 // ACI/AIFSN Field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-- 
2.18.0

