Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FFC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0672172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm+jUPMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0672172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHGX3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52808 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHGX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so517518wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kOgpz6fGI0l/XETi96SibRsUyuJliAuClLh0FIfXUQg=;
        b=Fm+jUPMj+BY425UCIrVt7EjEElnAfnk+LKlTvhQFl0151J3R9TClsmeImYFXd66Kz7
         epv+Yt5fgOo3CWH9iZafaDYSVLhlc4Nq91JifyzhlLcxTU6SibgpPpdH2LTil6kWFJag
         WGSHB14Ho1RXmWXKEaC5gymNHXLokJUFVRvH5RaRAdc9LUxSv0OyUbQZ4KRLr1jY0MJB
         QmFWEH/SHmK5oB4DBgsn48pTkHkAC35ie5A9iDliIkd/p+a2PPAiYlopqQO4IuaTXJG+
         HoOZogQAOfMIcisZxLlWVWXfbZSffbfu+XJtkMQ+zYX6QvX37hn4AXCw8oVMQikgApXw
         UiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kOgpz6fGI0l/XETi96SibRsUyuJliAuClLh0FIfXUQg=;
        b=BGdHMz1V/eC0xDQyDRe/hG8PGl0ADVssxv7BuBIGzrfhoBANR1jJRiDy4m5sNs4x92
         MbEMUJQL64zTJmvQR6vSn5imF0pt4WtFTyysaRKkhhWcc87FwbuwzIAIsyMAHa6MvBLj
         0NEOOXzJLTckKwLLTBZi7k17wNaKAo571SpaPlKXAC6jS0mvU43vMD2axj9lfqonxDIA
         rrfw5OtqW2sByGtkjE6LAfEAnA4kNaXW715z9f2oKBORNZOwezLva9Trwk5TrfeLyrce
         J95VidUBaDV4cq/IYtCbO/wXUNxeytK9QETIkIm3bckJgWliC0fHf5bCVs1kiFH0fc1y
         3xyA==
X-Gm-Message-State: AOUpUlEqkpsz+V+odLSSUX6+fpKt8fCEyxImXIlA8NNPkCqvXDVTWcEZ
        Vs08ghDEYB022pAtsz3Kw2nTV7JD
X-Google-Smtp-Source: AA+uWPz960J5Zs/d9LDM4j0sKC0htbb5a2kWRrjrNRoqj0/dxtf8U0DtFA/CNARvKTTKKnwZtWqLcA==
X-Received: by 2002:a1c:149:: with SMTP id 70-v6mr66745wmb.2.1533676390681;
        Tue, 07 Aug 2018 14:13:10 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/17] staging:rtl8192u: Rename __pTa - Style
Date:   Tue,  7 Aug 2018 22:12:45 +0100
Message-Id: <20180807211255.29343-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro parameter __pTa causes a checkpatch issue because of its use
of CamelCase naming. The parameter has this been renamed to addr.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 01adf747f7c8..72fc04e08b34 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -42,8 +42,8 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->enabled)
 #define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(ieee_dev, __pTa) eq_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(ieee_dev, __pTa) cp_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(ieee_dev, addr) eq_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, addr)
+#define UPDATE_CIE_SRC(ieee_dev, addr) cp_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, addr)
 
 #define GET_CIE_WATCHDOG(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
-- 
2.18.0

