Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979197; cv=none;
        d=google.com; s=arc-20160816;
        b=iwFsAJP6I2Y9aCWRKozTlwUV7mUv828IlOM+FWmm0IM6sz5A938SwlX5wtvrHng5uy
         LX+NWv91nAzSLjCRyaZ/Y3SuE44Cw5Y5uWGN4xmDBHvH6cnbqJ0/RMIiooE6NkJOi6Mc
         lkbjHKep+DJgMRApp9U7h5JPvzfnXI59MMP0NLOyZtMsnKTrwqQwyjxk7Eoih4baKlq4
         SbE/RNR6VxqbGSyNw9Yj2tva1lDFYufuZakc2sTgkTNzj84Yz4b4KL58lwrgsJ1s7ghE
         hZSZ+ES3ZpC7ZP1Ydbb1WN+f2/jtfByhgIIw5rCi+hCWWqG+2FZRBQISpLEH6n+IFqXd
         t1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pFVa8UChjt88Sb1aip39w+x6+lytthy+XOvOofff2QI=;
        b=FhSLnKsJvPSWYaAGoPfd4kbzxf4S9mzrP1agm5Wbm7BW+2ukjIEAbXXpNW8AjFPaIv
         yXy8e7m44bNF13TeKQfHutkmjnjQege55xvO1fzQiIhQUwV90G0/UZgcAxbVgX/w2OxA
         X/EaxCfzzxa7WN5eA7ro+cwbuJbkrKvOO7vihzhZK+RHxBOFxQxLMvS38zSVOgzGeUaA
         tWz40SCZf0sEpNp918Cv07qVAoEUhhVORhbas9xzAdeoCwftewuWBtOw0rF9HRcedUky
         5ZI1p9e4Tfusrb4ZrzXQ2tOmOewCCte8QUGgJQ2AVhDgQr+OtRwv7hCf8w2xDwQrIBJm
         sqag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fMTiNIYc;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fMTiNIYc;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx499Z9jJtwMnI3Nq/t1WyYbMS4lB4EpPSWerwgyfyeTBZKBtvetKFeww5VJFXoGgXa3GcTnITQ==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 1/9] firmware: some documentation fixes
Date: Tue, 17 Apr 2018 11:32:59 -0400
Message-Id: <20180417153307.3693-2-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008010982700219?=
X-GMAIL-MSGID: =?utf-8?q?1598008010982700219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Including:
 - Fixup outdated kernel-doc paths
 - Slightly too short title underline
 - Some typos

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 Documentation/driver-api/firmware/request_firmware.rst | 16 ++++++++--------
 drivers/base/firmware_loader/fallback.c                |  4 ++--
 drivers/base/firmware_loader/fallback.h                |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 9305bf4db38e..7632f8807472 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -17,17 +17,17 @@ an error is returned.
 
 firmware_request
 ----------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request
 
 firmware_request_direct
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_direct
 
 firmware_request_into_buf
 -------------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_into_buf
 
 Asynchronous firmware requests
@@ -41,7 +41,7 @@ in atomic contexts.
 
 firmware_request_nowait
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_nowait
 
 Special optimizations on reboot
@@ -50,12 +50,12 @@ Special optimizations on reboot
 Some devices have an optimization in place to enable the firmware to be
 retained during system reboot. When such optimizations are used the driver
 author must ensure the firmware is still available on resume from suspend,
-this can be done with firmware_request_cache() insted of requesting for the
-firmare to be loaded.
+this can be done with firmware_request_cache() instead of requesting for the
+firmware to be loaded.
 
 firmware_request_cache()
------------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+------------------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_cache
 
 request firmware API expected driver use
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 71f529de5243..da97fc26119c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -536,8 +536,8 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 }
 
 /**
- * fw_load_sysfs_fallback - load a firmware via the syfs fallback mechanism
- * @fw_sysfs: firmware syfs information for the firmware to load
+ * fw_load_sysfs_fallback - load a firmware via the sysfs fallback mechanism
+ * @fw_sysfs: firmware sysfs information for the firmware to load
  * @opt_flags: flags of options, FW_OPT_*
  * @timeout: timeout to wait for the load
  *
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index dfebc644ed35..f8255670a663 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -6,7 +6,7 @@
 #include <linux/device.h>
 
 /**
- * struct firmware_fallback_config - firmware fallback configuratioon settings
+ * struct firmware_fallback_config - firmware fallback configuration settings
  *
  * Helps describe and fine tune the fallback mechanism.
  *
-- 
2.14.1
