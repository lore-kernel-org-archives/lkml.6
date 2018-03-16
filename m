Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215106-2-2288734574985616836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215105; b=oOOhhpOXBhVcn/IwitYgM4S42Fcjp0J0cFyDDv/fvayWNAf
    KLg98sADCE59ECMie0D1+7jrqgS2SYEZycrJ0/W3SCMFGDml6LaRitxOtkyqQCLC
    UygQEmJuc4C0ZJlWxyqtEMoyPVch/xjFGInFKtm8WR+mUpTxutWicFjaq8XNPUiq
    mVnazaBaGr2KA5ifKNAn/QxiOZjqKl9bj8XDSQ+v1e5Zh417F/7yIjkzdlvR9x+s
    ctZhcMSayZoxKdCmJ+MRjMBxjI4s731be0ORYE2LnJl7qc1ZKSRqYSRqqxdU54/v
    ufhUjzw8+A56Y3qP2pGi3C+gk4e88iYIFlc3OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215105; bh=HiOXJkGpNFFWHYKR9z6fMAfiFD
    kAvLg3ELXyOWWDKIg=; b=l7eOkzFuZtFVop7OH5lSikkhKwGo8jRVWKDItjlmgj
    SNVF6p9ZmGg1faF2oAV+PqdJdT02taPxyFHkVH/iiDUgnc5hmNn6HABFiw4vwdkb
    KYhBr7IGOO/7/js7AdRKcwsoItW1arDbIB1cO5stnoC2RDqeuLiEWRilozy8lu/g
    c2F0e0dMPbER4Tcn5jBHSY39Qd7cOy2jnioKhjAIAppwSVH7lUilR1SY7DF1QUg6
    T6MAvHZT9m6hg1p9OfEIYoVQriHpHWvQLq0rJ/wo1usucWbE42yNsqgNHXF8gVhJ
    5SsYr2EsPY6EzJ1sQOra/7j5nLRXudzozeN9hMQuRQHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbeCPPpA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:45:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbeCPPo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>
Subject: [PATCH 4.15 128/128] drm/i915/glk: Disable Guc and HuC on GLK
Date: Fri, 16 Mar 2018 16:24:29 +0100
Message-Id: <20180316152342.792732538@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/i915/intel_guc_fw.c |    9 ---------
 drivers/gpu/drm/i915/intel_huc.c    |   11 -----------
 2 files changed, 20 deletions(-)

--- a/drivers/gpu/drm/i915/intel_guc_fw.c
+++ b/drivers/gpu/drm/i915/intel_guc_fw.c
@@ -39,9 +39,6 @@
 #define KBL_FW_MAJOR 9
 #define KBL_FW_MINOR 14
 
-#define GLK_FW_MAJOR 10
-#define GLK_FW_MINOR 56
-
 #define GUC_FW_PATH(platform, major, minor) \
        "i915/" __stringify(platform) "_guc_ver" __stringify(major) "_" __stringify(minor) ".bin"
 
@@ -54,8 +51,6 @@ MODULE_FIRMWARE(I915_BXT_GUC_UCODE);
 #define I915_KBL_GUC_UCODE GUC_FW_PATH(kbl, KBL_FW_MAJOR, KBL_FW_MINOR)
 MODULE_FIRMWARE(I915_KBL_GUC_UCODE);
 
-#define I915_GLK_GUC_UCODE GUC_FW_PATH(glk, GLK_FW_MAJOR, GLK_FW_MINOR)
-
 /**
  * intel_guc_fw_select() - selects GuC firmware for uploading
  *
@@ -85,10 +80,6 @@ int intel_guc_fw_select(struct intel_guc
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
@@ -54,10 +54,6 @@
 #define KBL_HUC_FW_MINOR 00
 #define KBL_BLD_NUM 1810
 
-#define GLK_HUC_FW_MAJOR 02
-#define GLK_HUC_FW_MINOR 00
-#define GLK_BLD_NUM 1748
-
 #define HUC_FW_PATH(platform, major, minor, bld_num) \
 	"i915/" __stringify(platform) "_huc_ver" __stringify(major) "_" \
 	__stringify(minor) "_" __stringify(bld_num) ".bin"
@@ -74,9 +70,6 @@ MODULE_FIRMWARE(I915_BXT_HUC_UCODE);
 	KBL_HUC_FW_MINOR, KBL_BLD_NUM)
 MODULE_FIRMWARE(I915_KBL_HUC_UCODE);
 
-#define I915_GLK_HUC_UCODE HUC_FW_PATH(glk, GLK_HUC_FW_MAJOR, \
-	GLK_HUC_FW_MINOR, GLK_BLD_NUM)
-
 /**
  * intel_huc_select_fw() - selects HuC firmware for loading
  * @huc:	intel_huc struct
@@ -103,10 +96,6 @@ void intel_huc_select_fw(struct intel_hu
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
