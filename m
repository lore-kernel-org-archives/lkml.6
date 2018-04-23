Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514345; cv=none;
        d=google.com; s=arc-20160816;
        b=KiJBD4u5mrlfrP2vwpgkQRLYeTtk/SU0duQQ8Hr06xfgRMz98LjDhy+/4iizpMiWKg
         Bain69uhvmaBcad6DlnP1+O3TFSgRVEZ+OdfDijTmu6IbShcc82FPUXwWLkN37lqPYdf
         xoACSLKZtsq0kAGC8GM/rtqvRlRvKPetpr6pDz64OpHjQW+dlXyP8Xvd37L/gAbjUScF
         7sTE6HnYv6Sfi0zxLoTfpvuFAJmaX0QkMPwY7s9TbWty9vTliJiAYNtVpq9IT/zYT2Lx
         t6a68eQ+JPhJKMpdriIfE9+VtHMELmJR3EhCvjwHj6iAQdiU0JDy17yJ2U4fr0Zu8mkK
         dlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=B0TcwlJB5FTlm/h0kgDWJmp9yU/oYmKQZKiZfWMQMnI=;
        b=FLovTU2B3Re0BE4sMB+OD21Re7zXACodbVBHdkO+wFaJmJI+sDYj9ZafXg47tz76ol
         p10mXLUcisJ+dGfBsQr3V0EowUAReMu7mYfYu4e2aU/Dv5a3g8qJI2A45hx5npgDMZ/V
         bbs9Y82U26hzP/JJXaViTa1FDNsU6KZYH0odFQdoukLGlms13OnllZe0wjSy25mZw6jV
         QBof9PNFcBs9y/SqcC+/s0896SrcNqm5hN2rR4WaRwbnmeZvGg0fJ01/0ti7A9AA366R
         lVXjToMnbxGO1jTPsoMN3BKenIgwLj8VXe/xZrCzm0OFL643yYLqh5ICXYUDHfULdeXW
         DbrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llsSTeEU;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llsSTeEU;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+oZaH2joMIunKQVvSXjnm/9wyJFx+bOUh2ZFlwc8rhepJYFxvARyvcUHkF0rGrzqrEslk71g==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	christian.koenig@amd.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: [PATCH 8/9] ath10k: use request_firmware_nowarn to load firmware
Date: Mon, 23 Apr 2018 16:12:04 -0400
Message-Id: <20180423201205.20533-9-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423201205.20533-1-andresx7@gmail.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569153881185056?=
X-GMAIL-MSGID: =?utf-8?q?1598569153881185056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reduces the unnecessary spew when trying to load optional firmware:
"Direct firmware load for ... failed with error -2"

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index f3ec13b80b20..9a225b7ad2d7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -652,7 +652,7 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
 		dir = ".";
 
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-	ret = request_firmware(&fw, filename, ar->dev);
+	ret = request_firmware_nowarn(&fw, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.14.1
