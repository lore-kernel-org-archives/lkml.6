Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZrhdGMqauhrcaqIVAZTPe6RLokOyE1LlHxYzs0CXooBJ6Hm2lY3S3dYW6EFBZ6JVx8sdL6q
ARC-Seal: i=1; a=rsa-sha256; t=1525455844; cv=none;
        d=google.com; s=arc-20160816;
        b=xJH+UJAxZ3EdTAWzsbT24zG86A4PFGBpOjy9d12MTMQqZ1xniOpCLtkd+8jgH6Q9kk
         CB1u4TdwJ8PrW23Z/0zVDO6gSgj3fGnxB/oNx/cAWzYBFpMQ4ptBP4WCIQOp9VjVf8IT
         XCOtRBpI8yAITJ06Rx04otww+XwMb+8jT3jx0osGPaZQWTvlBuyQhsZ3GLpqwJrrZrmS
         vkWVxualYbrhgN8RpXM8Mk4/yOc920NrvRdXedFZh3F/Xg/1e/uIcs4KDHOsyBlgVrPM
         5YUsQ0536dh2ixFrxylxvhCsBttLgOquhHgtbUSGM+HXDWJ0zT7/VyitAYcM9lry1I5T
         +MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sFLRgTHgxeYbCiMbyHuCvTP7Hg+jDIttVO9afuWQWtE=;
        b=FUMth4rasowdKvXY075O1/hJcLQ50ed0XN4j9NpB4f0c+b5V9DPetogccTbvQ4uS5x
         IGKLK0TROvIYDvqLZB6SoRy+CUY9yIK0a3TK4SvhlMiw/uQaYc3LT00bKM7/5mkft5Od
         UHS52SbnehVIRnGslC9HPbW/DUeJil60dQu05QOClO1QPY6h0jKrjzgfXw4HKKwLZuCJ
         zd5ih2RKsN3feHzDOwoktKPbGjo2mZGO2jZ5ogNWAEQgPkMZTFil3M41oMSutSvTHBrv
         GmSBnoMp4rQoxWfpAdva22khX1GG+t+sZ4fUOdTWoWR+So5vs66k9GQM02/npwLVv6iK
         Yjew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0kV4OYrj;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0kV4OYrj;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
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
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	maco@android.com,
	arve@android.com,
	tkjos@android.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 3/6] firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()
Date: Fri,  4 May 2018 10:43:52 -0700
Message-Id: <20180504174356.13227-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504174356.13227-1-mcgrof@kernel.org>
References: <20180504174356.13227-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556387173662948?=
X-GMAIL-MSGID: =?utf-8?q?1599556387173662948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

This is done since this call is now exposed through kernel-doc,
and since this also paves the way for different future types of
fallback mechanims.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
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
index 7f2bc7e8e3c0..d951af29017a 100644
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
