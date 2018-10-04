Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D282C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B696720652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaMKpe7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B696720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJEAvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:51:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36266 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeJEAvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:51:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so5898705wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZivVnlNha4ZCurNBHw/tfWfbsCUyglvmtQ7cMFSUJc=;
        b=EaMKpe7xI0EBcuy5HpqroXrgQUEaGCvZJol3MD1bjDwsmebwyZxZbyv0gQK4xv32cm
         C1qRPmJkktO8cLMU0hvVlDFUjOLbPfiggoAoTgCb7P0NjONOLvZjBm2T6+rjKblCsc2F
         Ki/SF+Dc2AXhjjb02rDr/0MQLD4YNK0Yyn+9o8VgtcTOyunntCqHjEC8eftOob+0sZMG
         O9W5WuiH+JZFIzWObO7UxKSIvanKQJXXXBemR5CYw0Anz4I2lDvSrB9LItucHoohM5hX
         ActcsVls21IKuQ8lryZ8GLjjPRkwdU57RmCxMLCdfIn+YFWqwFrBhEFGU+9OlZiqBhSZ
         DHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZivVnlNha4ZCurNBHw/tfWfbsCUyglvmtQ7cMFSUJc=;
        b=kpfcftGqRoTCaqQEl/WdQuiNUVZ5TY06XbBJVAdEqV/0FYnY98bKuts0KVrnAORMvx
         1R663FV4GG3aM3tVsIrdu4mE2IgsHYBmzhG1vb8G6/Ul0mooPSKxfAk2OAT9mq7gqPyj
         iLeLFdWNEwR2Tb+ADJRgbG8Hnofzo5j/nftsDd9fWIYJODsPuWPPJXlAxfxq6iSNEDXk
         gjiRE19+UdU0ka1VJgVRd0QjSg7M0Rwf+Ef3yt/qv4vildTHgjyaythKDLzUHdvSVIq+
         DI+efh3IkjodGSqfby6bMqLU5YODf8w8R7FDHTZBpIOHRBWzIR2QiCuxEJUL4qCew8tU
         aipQ==
X-Gm-Message-State: ABuFfogUpSxX0bALXh+xQe6fWMq1rVj03fmVjE9ixIsbZapSIus0YNsb
        GozdWmcZH4E1ia7XUCmLuIA86fzg
X-Google-Smtp-Source: ACcGV62WhRpG2jp4BUhezCleUHpB2uIkSxp40fbAdHKo78+q27L4GJZfdOofuU5fxclCvGmI0MsWcQ==
X-Received: by 2002:a1c:3795:: with SMTP id e143-v6mr5657053wma.9.1538675837278;
        Thu, 04 Oct 2018 10:57:17 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id o63-v6sm3697353wmd.3.2018.10.04.10.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:57:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: change array type to const u8
Date:   Thu,  4 Oct 2018 19:56:57 +0200
Message-Id: <20181004175700.1500-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of MCS_rate_1R from unsigned char to const u8.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---

NOTE:
This series depends on the previous sent series.
[1/3] staging: rtl8188eu: fix line over 80 characters - style

 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 858b597cb506..6302be43c2e0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -20,7 +20,7 @@
 #include <rtw_ioctl_set.h>
 #include <linux/vmalloc.h>
 
-extern unsigned char	MCS_rate_1R[16];
+extern const u8 MCS_rate_1R[16];
 
 int rtw_init_mlme_priv(struct adapter *padapter)
 {
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index c6945164ee34..6790b840aef8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -39,7 +39,7 @@ extern unsigned char REALTEK_96B_IE[];
 /********************************************************
 MCS rate definitions
 *********************************************************/
-unsigned char MCS_rate_1R[16] = {
+const u8 MCS_rate_1R[16] = {
 	0xff, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 49d23aef47df..8d9d663f0645 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -214,7 +214,7 @@ void hostapd_mode_unload(struct adapter *padapter);
 extern unsigned char WPA_TKIP_CIPHER[4];
 extern unsigned char RSN_TKIP_CIPHER[4];
 extern unsigned char REALTEK_96B_IE[];
-extern unsigned char	MCS_rate_1R[16];
+extern const u8 MCS_rate_1R[16];
 
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf);
 void rtw_survey_event_callback(struct adapter *adapter, u8 *pbuf);
-- 
2.19.0

