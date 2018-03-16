Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs/CpWXoc8Uz336D/aAiFaFNRrM7+AAglzO3PWMWeuzpTYXPKYzG11iibNv62nTBU/p8ric
ARC-Seal: i=1; a=rsa-sha256; t=1521214752; cv=none;
        d=google.com; s=arc-20160816;
        b=bZiHU1NkOYCv19ead04JgvsZzTnai5ePn7PkGOrwqXUbRxQoCeKNrI6P2NemofBfnM
         4Il54uCasRN9WClE9IbUwV4I2PnqgnGL1tLTfHrdXounovcGWg6qDBe2MeOub0QE9zw5
         b9qVrBS0l4p9miB6K2GK3qZCLgvlCW/fdWNcuBqm5Yynq/XivvzcahoTcHjfQqfmZhNX
         qSyhy2zobA4WqZuZhk18bYXxtfx/UTCkB0jEQ/wodgd5Pz27znNGgIAv+dYsnNyKEdAA
         leGkdZtq1Bvk8qWmFd0InW4agg1rZPXE4zEQ85ZkGgNcM0QtRb63vy7sLliuAJktQTqy
         o5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=twi7R1apnwLYHP3znhzOwMIqgK7Hvy3IFfBikVhFddc=;
        b=sR3N6rZubZXKysuh5QRLa4fJZlC5H3IPqBhT/mdFWm081Qwv1hATvjeKmgYIfq8jwN
         3R66WoaA2MFiEPZrAr1ZO2gLMcqmnW/eK8dkWi1aoCuypZxHY2spUIM7pwvVoNQ2PPIY
         QWI5an3LtwOh3IcSAlq31NVJlNmDVOWJb5g2nwdV1xLp9QFWl9gmOyKgWTjrcRhbtVqA
         2zyopCfwW8mLW1soAk4yLaNQh/7od+08i1xmdaORsc+rGTW5IDVauT/H9SNc3Yp+ypz7
         mrrwOHcu99VSRK5tZo3gIqB2p62gIqSso0G3845J+0hSmVkPuS36u3RHMF2617xvXBS7
         IU+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Anusha Srivatsa <anusha.srivatsa@intel.com>
Subject: [PATCH 4.14 109/109] drm/i915/glk: Disable Guc and HuC on GLK
Date: Fri, 16 Mar 2018 16:24:18 +0100
Message-Id: <20180316152335.767835309@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109280552218707?=
X-GMAIL-MSGID: =?utf-8?q?1595109280552218707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anusha Srivatsa <anusha.srivatsa@intel.com>

commit 2afba81c7909ac259720c0d3e7616cf54d4a5368 upstream.

Since the firmwares are not yet released to public repo,
disable them on Geminilake.

v2: Remove the firmware versions (Michal)

v3: Remove unwanted defines (Rodrigo)
Correct commit message (Michal)

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Anusha Srivatsa <anusha.srivatsa@intel.com>
Fixes: 90f192c8241e ("drm/i915/GuC/GLK: Load GuC on GLK")
Fixes: db5ba0d8931e ("drm/i915/GLK/HuC: Load HuC on GLK")
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1515006225-13003-1-git-send-email-anusha.srivatsa@intel.com
(cherry picked from commit a76050a4837860fcadb6ca11d69d41e08f4090d8)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_guc_loader.c |    9 ---------
 drivers/gpu/drm/i915/intel_huc.c        |   11 -----------
 2 files changed, 20 deletions(-)

--- a/drivers/gpu/drm/i915/intel_guc_loader.c
+++ b/drivers/gpu/drm/i915/intel_guc_loader.c
@@ -61,9 +61,6 @@
 #define KBL_FW_MAJOR 9
 #define KBL_FW_MINOR 14
 
-#define GLK_FW_MAJOR 10
-#define GLK_FW_MINOR 56
-
 #define GUC_FW_PATH(platform, major, minor) \
        "i915/" __stringify(platform) "_guc_ver" __stringify(major) "_" __stringify(minor) ".bin"
 
@@ -76,8 +73,6 @@ MODULE_FIRMWARE(I915_BXT_GUC_UCODE);
 #define I915_KBL_GUC_UCODE GUC_FW_PATH(kbl, KBL_FW_MAJOR, KBL_FW_MINOR)
 MODULE_FIRMWARE(I915_KBL_GUC_UCODE);
 
-#define I915_GLK_GUC_UCODE GUC_FW_PATH(glk, GLK_FW_MAJOR, GLK_FW_MINOR)
-
 
 static u32 get_gttype(struct drm_i915_private *dev_priv)
 {
@@ -406,10 +401,6 @@ int intel_guc_select_fw(struct intel_guc
 		guc->fw.path = I915_KBL_GUC_UCODE;
 		guc->fw.major_ver_wanted = KBL_FW_MAJOR;
 		guc->fw.minor_ver_wanted = KBL_FW_MINOR;
-	} else if (IS_GEMINILAKE(dev_priv)) {
-		guc->fw.path = I915_GLK_GUC_UCODE;
-		guc->fw.major_ver_wanted = GLK_FW_MAJOR;
-		guc->fw.minor_ver_wanted = GLK_FW_MINOR;
 	} else {
 		DRM_ERROR("No GuC firmware known for platform with GuC!\n");
 		return -ENOENT;
--- a/drivers/gpu/drm/i915/intel_huc.c
+++ b/drivers/gpu/drm/i915/intel_huc.c
@@ -52,10 +52,6 @@
 #define KBL_HUC_FW_MINOR 00
 #define KBL_BLD_NUM 1810
 
-#define GLK_HUC_FW_MAJOR 02
-#define GLK_HUC_FW_MINOR 00
-#define GLK_BLD_NUM 1748
-
 #define HUC_FW_PATH(platform, major, minor, bld_num) \
 	"i915/" __stringify(platform) "_huc_ver" __stringify(major) "_" \
 	__stringify(minor) "_" __stringify(bld_num) ".bin"
@@ -72,9 +68,6 @@ MODULE_FIRMWARE(I915_BXT_HUC_UCODE);
 	KBL_HUC_FW_MINOR, KBL_BLD_NUM)
 MODULE_FIRMWARE(I915_KBL_HUC_UCODE);
 
-#define I915_GLK_HUC_UCODE HUC_FW_PATH(glk, GLK_HUC_FW_MAJOR, \
-	GLK_HUC_FW_MINOR, GLK_BLD_NUM)
-
 /**
  * huc_ucode_xfer() - DMA's the firmware
  * @dev_priv: the drm_i915_private device
@@ -171,10 +164,6 @@ void intel_huc_select_fw(struct intel_hu
 		huc->fw.path = I915_KBL_HUC_UCODE;
 		huc->fw.major_ver_wanted = KBL_HUC_FW_MAJOR;
 		huc->fw.minor_ver_wanted = KBL_HUC_FW_MINOR;
-	} else if (IS_GEMINILAKE(dev_priv)) {
-		huc->fw.path = I915_GLK_HUC_UCODE;
-		huc->fw.major_ver_wanted = GLK_HUC_FW_MAJOR;
-		huc->fw.minor_ver_wanted = GLK_HUC_FW_MINOR;
 	} else {
 		DRM_ERROR("No HuC firmware known for platform with HuC!\n");
 		return;
