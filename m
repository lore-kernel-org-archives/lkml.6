Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CF120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utwCrC/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CF120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeIKBeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:34:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40617 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeIKBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:34:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so23354059wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uUVun76htdgxLMc2CQYOnfdsX7/Lr/DXr1+n+LlVWLQ=;
        b=utwCrC/eLTgKpVQkWtt7qI8fRVhzlGsRR1/VSAkndPvEG5H1rKah/JqCJo2wO4E431
         igAxqZ6W/pX2pq2YQ2GgwRj7EiggVDY/o2j3IZOW8wc9mywKem7kEz2NqLf99mOd3NuS
         /XaiB35kOw6ffeXk7NlGAKAacQO5SU7c8hK9l9WMUv73Y40w9K0P7A+2ZXywllaqeSNh
         9nP4fv72JkUZ+TkMlFlmsQ7689Cd4rs0HRHJC8dvjc9bALZdSwLwxYu7f6UxRGhoQT1Z
         tKsVOVmZloko5PUoUrjy18+k8c/GY1zsbWL7jVzGRKkId93Qzhr5aeAvM9Qy0MnPA+/r
         /qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uUVun76htdgxLMc2CQYOnfdsX7/Lr/DXr1+n+LlVWLQ=;
        b=tPBReckQOzumZgH+Z57xEf/xk4+W9G/fub2a5CJNVNTXPGRLR3kQvqZx8F0kAulGWl
         0I4ONVzPfg1yya74GbF/EuTu9gLLd9WTkPy1QDy3IzG7J/xUGRymmAz1d4kEOllOtto8
         sXsvq1Npn8vPlxFgNMaL9BSTOCpLvWRtyO/cbGNJd6Ii2xrS/Yxe6Ccp18MzUUhBUzLV
         62qIswvgfY7/UlpON6i45ga9Tzv5eFKc+U7LP5gdR87f9lFoHiq14ZreLkarQjUP27/s
         KvwrLJwqF4G7hk61JCAbZHuHAuRTiTuvllY8KHHdTW9xw+CFuVagLICRTsEdK/zT6sPo
         Blsw==
X-Gm-Message-State: APzg51B2VGC2S4m81KvYaygb2vwqGUkUzIK1HOY9Nh7JhLS07iNUjQ0D
        GatTF3TzLUqPyXsW73SHS3A=
X-Google-Smtp-Source: ANB0VdZPjMy8nDm8OtOO4upR83WnYcxGKQPb8aKvDe1JxPIiXhh04BijyXSuiDy+72nENjht1Fs1XQ==
X-Received: by 2002:adf:824f:: with SMTP id 73-v6mr16628782wrb.130.1536611896372;
        Mon, 10 Sep 2018 13:38:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id h7-v6sm14875786wrs.3.2018.09.10.13.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 13:38:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: change array type to u8
Date:   Mon, 10 Sep 2018 22:38:05 +0200
Message-Id: <20180910203805.10342-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The the last two parameters of write_cam() have type u8.
Change the type of the passed arrays from unsigned char to u8.
Clears a line over 80 characters checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 3e0801858737..fb496ab5a862 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -454,9 +454,9 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 
 void clear_cam_entry(struct adapter *padapter, u8 entry)
 {
-	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-	unsigned char null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-				    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	write_cam(padapter, entry, 0, null_sta, null_key);
 }
-- 
2.18.0

