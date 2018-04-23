Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514344; cv=none;
        d=google.com; s=arc-20160816;
        b=gB6FD6k0nkbcY0oHgcuQumJTrhe1/9dP1CxSOsHUI1il6/c8W7LpnDT8KYZCKlrDyX
         W0hs5x8eM7Cc6X0x4+kAxb05k+hGdSiM7EMzfrB8fGcrJy22+uNlBmt4UUUTNI0LKCEO
         nQZzGGYWilfWFuSCmmIMvW6AoeJ8jDS0ZKMsvN9uF3qH5P3ahXWx4R0jCg1OGx5Lv51W
         SqVaFJSe2PBt3qycyBhBK/l6vYfSFayoj4ZpCBq8KeVe5A6ImtQH7N2xiSJpWeip0v7h
         qRXzxemmKOwPoGwEkMtl/QCeW+IAFCfG7rFNsReY0tteg3yBLO1WD+w9+vPpgG2BwTR2
         5hjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5rD/bAQTEZ5lLAoQ9ShkCtxtXoEReRqM+uz4O205vg4=;
        b=AJLS5wBXPCRu3tLFnxAPK8qYw+b4HfBATuuqhjL7uoykN7QFjLmJrfQBb3cVQItTgh
         ZOh26jhMB2RSjAusFZ/se67mfu9RKsyDGXYGOcJh0QZ4mezh//6zKrKaRCvMw/n1zPnx
         KVQNW+nIufTko71VJN6pnSLD5ODrxeu1ohoFBj9twxMvVy894D7g3ZPFvQWGhacGSpHA
         xkG8TeXPpIyX3e8C4L9LgOSiGcDTpDmfPeiopU2BZTJeQpyk/We8leJ5auPD2ydmraVE
         qiLXFtsSPTm95Q38u+Az+joj2pv3z9gNMoI4455rhpB4TtUT+hXxO0yyTfkSOsfEXK1j
         +d8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eCe6Xxcr;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eCe6Xxcr;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/8Cu/ii4V7is0BMi+4c11wq2vV1aTj9rz3oRJxX25uIz1Orbamj07lulNTuNviirzPSz3ttQ==
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
Subject: [PATCH 7/9] firmware: use rename fw_sysfs_fallback to use the firmware_ prefix
Date: Mon, 23 Apr 2018 16:12:03 -0400
Message-Id: <20180423201205.20533-8-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423201205.20533-1-andresx7@gmail.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569153121101514?=
X-GMAIL-MSGID: =?utf-8?q?1598569153121101514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the correct prefix for symbols exported by firmware_loader(). This
is done since firmware_sysfs_fallback() is now exposed through
kernel-doc.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/fallback.c | 8 ++++----
 drivers/base/firmware_loader/fallback.h | 4 ++--
 drivers/base/firmware_loader/firmware.h | 6 +++---
 drivers/base/firmware_loader/main.c     | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 1a47ddc70c31..fc186b5bccce 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -661,10 +661,10 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-int fw_sysfs_fallback(struct firmware *fw, const char *name,
-		      struct device *device,
-		      enum fw_opt opt_flags,
-		      int ret)
+int firmware_sysfs_fallback(struct firmware *fw, const char *name,
+			    struct device *device,
+			    enum fw_opt opt_flags,
+			    int ret)
 {
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index a3b73a09db6c..8cfaa3299bb7 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -31,7 +31,7 @@ struct firmware_fallback_config {
 };
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
-int fw_sysfs_fallback(struct firmware *fw, const char *name,
+int firmware_sysfs_fallback(struct firmware *fw, const char *name,
 		      struct device *device,
 		      enum fw_opt opt_flags,
 		      int ret);
@@ -43,7 +43,7 @@ void fw_fallback_set_default_timeout(void);
 int register_sysfs_loader(void);
 void unregister_sysfs_loader(void);
 #else /* CONFIG_FW_LOADER_USER_HELPER */
-static inline int fw_sysfs_fallback(struct firmware *fw, const char *name,
+static inline int firmware_sysfs_fallback(struct firmware *fw, const char *name,
 				    struct device *device,
 				    enum fw_opt opt_flags,
 				    int ret)
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index a405d400a925..59836d50c5bd 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -15,12 +15,12 @@
  * enum fw_opt - options to control firmware loading behaviour
  *
  * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
- *                  when the firmware is not found. Userspace is in charge
- *                  to load the firmware using the sysfs loading facility.
+ *                 when the firmware is not found. Userspace is in charge
+ *                 to load the firmware using the sysfs loading facility.
  * @FW_OPT_NOWAIT: Used to describe the firmware request is asynchronous.
  * @FW_OPT_USERHELPER: Enable the fallback mechanism, in case the direct
  *                     filesystem lookup fails at finding the firmware.
- *                     For details refer to fw_sysfs_fallback().
+ *                     For details refer to firmware_sysfs_fallback().
  * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
  * @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
  *                  cache the firmware upon suspend, so that upon resume
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 58aaadf81e12..f009566acd35 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -581,7 +581,7 @@ _firmware_request(const struct firmware **firmware_p, const char *name,
 			dev_warn(device,
 				 "Direct firmware load for %s failed with error %d\n",
 				 name, ret);
-		ret = fw_sysfs_fallback(fw, name, device, opt_flags, ret);
+		ret = firmware_sysfs_fallback(fw, name, device, opt_flags, ret);
 	} else
 		ret = assign_fw(fw, device, opt_flags);
 
-- 
2.14.1
