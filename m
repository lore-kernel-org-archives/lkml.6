Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979199; cv=none;
        d=google.com; s=arc-20160816;
        b=E2HEy9lurq7XaeF/aKlbdUy5cnfWaUUJKGbLdrTT2GNS/g7Fjt6Ah28rGXiY8LEKf6
         Vj+cMuOkX/aBPAI0mcDQZO0CzE9XWq84hTUXd4qOzKWYwE9qrc+luk4spMLKqBCojaPz
         pyHYmxYsfn/IqtM1ApLevo/OxyjLr0gR3s4VYLdOqF8RKFVUjn51cqMvqE8h9Edewaqn
         mrf4PVuH8o5rvb6Mtbb7sS8LbOKAYeUNSZHp7N11iZn6134PtiHHwiq83zxbZRw5fvd+
         f/7w+GWJQK/pFhdirveWQ4Nn6f0Hp+ZdBHpjPMlj7B6+ZmcWJeaJZOjsYq5Yxyc41mDK
         JTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sZNDez+BKRD/LkLHyHwp97KQJeMerjpoJlKDi2AEzxU=;
        b=YCAOWIoPoUPYBu6ALL//CpdaXNNsfedBgTrHwjGY51alUeQmycoQs3gdJR1Qqr8ZIT
         Kw2lJtweS0fX88DEOE8HPp+oKxA2TwC5tIknvZVYPE8T3MNQCimO6rkq4V/5dyFd/+15
         rr2orFCTaQH9K775wo3xLxhuKkkqRgftZG70xtk3sVlDYGqlnVPWbW6K+hOcIwOozhIj
         Di1uIuVyP641SodFsZUPYn+jD/Xyji6/cyhklAwSeoO2rNAZ+WbkbtVTUtrUSQKOGomr
         evB/n2L3x2+IYJIR0Qxra60tuoUn2NUsF334GCM8fM/D0z0VsSeOhrecwznffbkT4BNF
         MBAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sldxi/XZ;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sldxi/XZ;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49k/56t1EufPjBO7lVBNpI3/WQ04CSTzIc/3PPeRYQ0q4Ou57daWmi+NC/6eKvaBP9RLkQ3RA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 3/9] firmware: add kernel-doc for enum fw_opt
Date: Tue, 17 Apr 2018 11:33:01 -0400
Message-Id: <20180417153307.3693-4-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008013395123690?=
X-GMAIL-MSGID: =?utf-8?q?1598008013395123690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some basic definitions for the FW_OPT_* values

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/firmware.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 957396293b92..8ef23c334135 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -10,6 +10,17 @@
 
 #include <generated/utsrelease.h>
 
+/**
+ * enum fw_opt - options to control firmware loading behaviour
+ *
+ * @FW_OPT_UEVENT: Enable the uevent fallback path.
+ * @FW_OPT_NOWAIT: Executing inside an asynchronous firmware request.
+ * @FW_OPT_USERHELPER: Enable the usermode fallback path.
+ * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
+ * @FW_OPT_NOCACHE: Firmware caching will be disabled for this request.
+ * @FW_OPT_NOFALLBACK: Disable the fallback path. Takes precedence over
+ *                     &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ */
 enum fw_opt {
 	FW_OPT_UEVENT =         (1U << 0),
 	FW_OPT_NOWAIT =         (1U << 1),
-- 
2.14.1
