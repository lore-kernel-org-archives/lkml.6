Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZoPdA2TEytQOUwePl4QCxvYv+X9QEr8GQoP+xfoHbW4F0kkLHpHtRlHxUXHB7/45EOE79F6
ARC-Seal: i=1; a=rsa-sha256; t=1525982938; cv=none;
        d=google.com; s=arc-20160816;
        b=sHvlPw/9SvsBBqROwpTOmP19HUQB4x5RRLY4SwvVMQ1WQusxDvEH8lMdvP4/85HW4+
         cXpwN/Q+OBjGsPAlaSWtkyHnM3LJgr0q0a3QtR3frKZrV+x56kgUt+1l5em0OPYYaLRv
         yWqXpwLx1Ngxc0TxydqBQqH0N/xXZ+gvo0ancbOhZeOLGDZ95XjBuFYEHlUZqLhPoOeE
         hw6G0uefoHPSzgkXzfmsl9TUCwOZ9mumpsthVU6FUAs62IeEflYzwaKzZAKvEEDtq6YT
         JEVgkQOwcWwGfTnxEWNBoNLeRCBwZf607YNgh1bZ9awUUAtyv0s7RsUPE3Aoh6OXeKb2
         v5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TB9Dc5RpLDYcltyCq6AiqD1QDmHp8oKcvPHL/Fhx4KE=;
        b=pN7h/xkF5liQl8kqDIymHjY9UpmLldtynFM8iARY4Q3QyPi4sC57fJqtcexOxjAxzk
         V28s/Gdpe67Wzi3AYFiw76ybFYwCMgAyegpWInyUM3EfjPUenseAEkFaDlEIFfCxL1xZ
         iYPj1m5i+MTP7JYP2LgoG6ZHPb6ZdljovlhYMpdDaL2oaphizS0V331kkgtwcndP+s0Y
         W8ekJ0fMxdoagrQSijZjX0Wl4F4zEPg94CYufkDI4ov0Ig0qwHWw7/wigo+DmM4C3n0K
         NUuMLAaXIMNzcUjBnm6dcu8YnAUCRKB5xxMaRu3NNpMicDzQojFWEie5fYsB2UyFr+eL
         3jpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IFTutav0;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IFTutav0;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 03/14] firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()
Date: Thu, 10 May 2018 13:08:39 -0700
Message-Id: <20180510200850.5958-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109086278286241?=
X-GMAIL-MSGID: =?utf-8?q?1600109086278286241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

This is done since this call is now exposed through kernel-doc,
and since this also paves the way for different future types of
fallback mechanims.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
[mcgrof: small coding style changes]
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c |  8 ++++----
 drivers/base/firmware_loader/fallback.h | 16 ++++++++--------
 drivers/base/firmware_loader/firmware.h |  2 +-
 drivers/base/firmware_loader/main.c     |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 529f7013616f..3db9e0f225ac 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -662,10 +662,10 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-int fw_sysfs_fallback(struct firmware *fw, const char *name,
-		      struct device *device,
-		      enum fw_opt opt_flags,
-		      int ret)
+int firmware_fallback_sysfs(struct firmware *fw, const char *name,
+			    struct device *device,
+			    enum fw_opt opt_flags,
+			    int ret)
 {
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index a3b73a09db6c..21063503e4ea 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -31,10 +31,10 @@ struct firmware_fallback_config {
 };
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
-int fw_sysfs_fallback(struct firmware *fw, const char *name,
-		      struct device *device,
-		      enum fw_opt opt_flags,
-		      int ret);
+int firmware_fallback_sysfs(struct firmware *fw, const char *name,
+			    struct device *device,
+			    enum fw_opt opt_flags,
+			    int ret);
 void kill_pending_fw_fallback_reqs(bool only_kill_custom);
 
 void fw_fallback_set_cache_timeout(void);
@@ -43,10 +43,10 @@ void fw_fallback_set_default_timeout(void);
 int register_sysfs_loader(void);
 void unregister_sysfs_loader(void);
 #else /* CONFIG_FW_LOADER_USER_HELPER */
-static inline int fw_sysfs_fallback(struct firmware *fw, const char *name,
-				    struct device *device,
-				    enum fw_opt opt_flags,
-				    int ret)
+static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
+					  struct device *device,
+					  enum fw_opt opt_flags,
+					  int ret)
 {
 	/* Keep carrying over the same error */
 	return ret;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 4f433b447367..4c1395f8e7ed 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -20,7 +20,7 @@
  * @FW_OPT_NOWAIT: Used to describe the firmware request is asynchronous.
  * @FW_OPT_USERHELPER: Enable the fallback mechanism, in case the direct
  *	filesystem lookup fails at finding the firmware.  For details refer to
- *	fw_sysfs_fallback().
+ *	firmware_fallback_sysfs().
  * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
  * @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
  *	cache the firmware upon suspend, so that upon resume races against the
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 4d11efadb3a4..abdc4e4d55f1 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -581,7 +581,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 			dev_warn(device,
 				 "Direct firmware load for %s failed with error %d\n",
 				 name, ret);
-		ret = fw_sysfs_fallback(fw, name, device, opt_flags, ret);
+		ret = firmware_fallback_sysfs(fw, name, device, opt_flags, ret);
 	} else
 		ret = assign_fw(fw, device, opt_flags);
 
-- 
2.17.0
