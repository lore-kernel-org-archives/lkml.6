Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917487; cv=none;
        d=google.com; s=arc-20160816;
        b=C1PbVW5vf1PD0SIeeNscllkmj3uojP+DZwAVSs0dJ88toFumseIwiglGhhSKn2rsxv
         KuVfywaEPuT7doOrecVv6dJucliWJYZdJhZrimQnJ0zelsB2vPwnowGUAnPxZ2JYuW9M
         va4wh0gLG3YjUQddARaZ5q4Lxdck/PCxTHhCqrrRGBrXDn9WKx9M0L3ECN9mFkcRX5Br
         IA6uOr9z6cye6U+qTwaeFfEoRlU1oVTcYu9qLN0RtqA9aDVCDBdzBtt88swDokahrpbi
         jGU533n7caVYKGDZ1s7xmH45Zl00G79FjTJGE5fs94hspkhm0mz2YhIjOS8Uha1dfaK1
         r22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sZNDez+BKRD/LkLHyHwp97KQJeMerjpoJlKDi2AEzxU=;
        b=Ayk3q6Rfmxv7OfrFPGYvHIWW/8JflkTx+2WhZ2Yk7/vOw50ZTuS+1cyL/5/0E+1DD3
         Ftcm6lI35LZ4uKjZonfWk2OOvaQufcNHAfRCtEop1bAkSfJWnEnNQfzcGN56XTGSP7th
         04jQnHES9L5M3YeHKYBHQ9ugMqyY2R0RCJmCWaEk3TXGlodCz/4A64LL8PnxT3GXje0V
         MIeE4l23DVK00TigTeo7dwOambXyexHsN0z+Uzl3/iFpD7xkrKQz2bHnZ0QEvvbEZb1j
         ReWWoKFkVGBlOLtOjjJS8GpdxzBv4oiNEwGpCxwlnB+6TBXSYQIdhir3Ut7rMABl1jpq
         JFkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bfTualF8;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bfTualF8;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/Ax9PvSkgq142OOLuwft4vCPpC7JD36hr4doA9mndWYiPdKycOvv6qPXhg+crT2yMY8sA5Fw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 3/8] firmware: add kernel-doc for enum fw_opt
Date: Mon, 16 Apr 2018 18:24:22 -0400
Message-Id: <20180416222427.29683-4-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416222427.29683-1-andresx7@gmail.com>
References: <20180416222427.29683-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943303808295565?=
X-GMAIL-MSGID: =?utf-8?q?1597943303808295565?=
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
