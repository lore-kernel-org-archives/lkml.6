Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3D1213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Paxwm4OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfB0UcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:32:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36837 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0UcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:32:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so6847898wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XokJhdyvlG1KC8fDnh7arVZ5KXnDHBwfslx12u7rSDU=;
        b=Paxwm4OYjDhQGGWsyK+Lq3s5qTEMi+ZTCsN1zIFATL/Wv53I1wVtxi3MSJURD6Vg0R
         VXlucyqkEigpO4mOqnleWgUqhn3/Z/sCVMHKMVBzCYVkMW5KXpGklSH9BxqGdck9izUb
         5lwogW3s/3ud2po71MEM+BkJQNvAMgHedXu5BPZgcGz43Z38UXQfx5iJ7vHaCxTmBvpT
         DI78SEs/pG8TlVBUCK08MbDdQofj7kMuhCII+N/tvJ35u1fXGDtI1zVKnKytDGJ38my1
         PgGEgvsf/ItxWfP0MI7+vG+fvGGKST7YwdwL687OCHJRU43X8/rMMXOoljkRDc1n+G3L
         3uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XokJhdyvlG1KC8fDnh7arVZ5KXnDHBwfslx12u7rSDU=;
        b=erwdrpnR6oYvp8WUqddTlQmKREe8L53JXogONYnl36OBFNXMA++dw56Li62yOsmWnb
         3ogJ5wPDzFEVIafSB4+6N/lG2T+5Kx4QU1Jw06ywIxqivCHd5v0CL2WT8ldRwc3TjoHC
         3oBeKsl/qOCdMnuNcnWZxT7ydNZaUTL5fGNrrNGJpyxkVsp9vGjfLm8BDsY9YyHjyTLF
         d1mXqho+B669Tp8iLOHgYBnNYMXwJbRNrr9iwkVIhuEzx7pBAooIAUHhcTtSmCxAktRK
         Dk1s3WjfGKzO8SVxK3ASjBUJkMwWhFj8H3dvBvJ2AYEzjRMSRo50a3NY4Skfo8IPhzYP
         R/yw==
X-Gm-Message-State: AHQUAubtl3S4vIYTm2bLHqzRsiOJmM7iITq1HvJ1l+LRGwLy76207Cg1
        OTaLxdP1PKU5alVfANccRECz8Tc3
X-Google-Smtp-Source: APXvYqzCxuwaebqSLZC0KCaHgFIIiz/ZeB/cTpthUAcZolkGNO/sI7uWOVRgeM8h2RJ4uLQOk8uyXA==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr667874wmb.92.1551299529138;
        Wed, 27 Feb 2019 12:32:09 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb76.dynamic.kabel-deutschland.de. [95.90.187.118])
        by smtp.gmail.com with ESMTPSA id z12sm1933589wmf.31.2019.02.27.12.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:32:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove unused enum P2P_PROTO_WK_ID
Date:   Wed, 27 Feb 2019 21:31:49 +0100
Message-Id: <20190227203150.14445-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumeration P2P_PROTO_WK_ID is not used in the driver code,
so remove it from wifi.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 0664d5f30a96..873aea9cf83a 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -793,16 +793,6 @@ enum ht_cap_ampdu_factor {
 
 #define	P2P_PRIVATE_IOCTL_SET_LEN		64
 
-enum P2P_PROTO_WK_ID {
-	P2P_FIND_PHASE_WK = 0,
-	P2P_RESTORE_STATE_WK = 1,
-	P2P_PRE_TX_PROVDISC_PROCESS_WK = 2,
-	P2P_PRE_TX_NEGOREQ_PROCESS_WK = 3,
-	P2P_PRE_TX_INVITEREQ_PROCESS_WK = 4,
-	P2P_AP_P2P_CH_SWITCH_PROCESS_WK = 5,
-	P2P_RO_CH_WK = 6,
-};
-
 /*	=====================WFD Section===================== */
 /*	For Wi-Fi Display */
 #define	WFD_ATTR_DEVICE_INFO		0x00
-- 
2.21.0

