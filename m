Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514338; cv=none;
        d=google.com; s=arc-20160816;
        b=i+WF4kipDfv+OLVxlwKEG3nrjlTcd7wxFI+X0Fey7mkjbnI/qLfKSCm0Pbyh3i1iCL
         59mGd8jb535T76NBVwh8WHYvAIoUyOYxZEwyGArRs2JtyS/9F9jzFwiPqBaWGdYJ9S7e
         6j6VQya1ya+mXSL7BqDAv7cNsrmUx+FKvY24Wfm5hdV0pU5DEqX1kanFm+bwGFhEMTQT
         KMyWUewtnPNqnjihQ9Y1hGVTVxuGujtm+aU6fs0KF5Ze/ChIvP0D8WBp70cFRJZWPvpO
         Ph6xjjYritI9COlhnxx2voyIFzUQmeHZQWrCBqzXhgKftDc+f1K5pIbC9TMgpxFayJXA
         LYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vpDHO6j3TJdgX+FHVGSYaqDzVYqWU0JNJ8rAWoP2l5Q=;
        b=OB9xFRW0XtVzXY+tfVsO3Az0Jz6FPRPiBVZTRKMkf2Gv5Lyk5cllBWUSUj3YsQ89+t
         NoYiEOHivkArPfoSOnRALyBuwWO0sWDN2JITWek0EDX2SV2EVU8WarTlExhg2oa2BQI3
         PFsCrJYlHKhpJPr6ziO9RhJhbkv1FMC6TPpLEpdZn0+EEfyUQl5cluywisoP0Uy6mP1N
         QYsJ1iN6ah/oRL6ljjgwpRbBeCYxgXcnbvGJ3HouEe9zyoSF7aJrrMeSO0ZGvKeaFO93
         WLPZVuATM1fyMD7JaO3mmgt1zZ5p1fn+7FMNLT3B7S8VOkW65MubVmnNfqEErjyXPGV0
         v9yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lDgZCBzN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lDgZCBzN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/EWlWNQyC0e8S9YP2vsStGOSnVSa5XFtmB8c6MhDNNzqPr81CTrhuWKpYryn+LDBA4ZvvGpg==
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
Subject: [PATCH 3/9] firmware: add kernel-doc for enum fw_opt
Date: Mon, 23 Apr 2018 16:11:59 -0400
Message-Id: <20180423201205.20533-4-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423201205.20533-1-andresx7@gmail.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569147115158619?=
X-GMAIL-MSGID: =?utf-8?q?1598569147115158619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some basic definitions for the FW_OPT_* values

v2: Documentation corrections from Luis.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/firmware.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index b252bfa82295..a405d400a925 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -11,6 +11,26 @@
 
 #include <generated/utsrelease.h>
 
+/**
+ * enum fw_opt - options to control firmware loading behaviour
+ *
+ * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
+ *                  when the firmware is not found. Userspace is in charge
+ *                  to load the firmware using the sysfs loading facility.
+ * @FW_OPT_NOWAIT: Used to describe the firmware request is asynchronous.
+ * @FW_OPT_USERHELPER: Enable the fallback mechanism, in case the direct
+ *                     filesystem lookup fails at finding the firmware.
+ *                     For details refer to fw_sysfs_fallback().
+ * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
+ * @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
+ *                  cache the firmware upon suspend, so that upon resume
+ *                  races against the firmware file lookup on storage is
+ *                  avoided. Used for calls where the file may be too
+ *                  big, or where the driver takes charge of its own firmware
+ *                  caching mechanism.
+ * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence over
+ *                     &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
+ */
 enum fw_opt {
 	FW_OPT_UEVENT =         BIT(0),
 	FW_OPT_NOWAIT =         BIT(1),
-- 
2.14.1
