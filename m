Return-Path: <ianwmorrison@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523342159; cv=none;
        d=google.com; s=arc-20160816;
        b=bpAenbN9LkWxp016gwMEg5ElyCUwUyqVLHeFN1SCeTS5g3dkSP8kPZtAA27Kh/WqYj
         Enm56ZBN9v9WK5jcp/vGnj5dfYTK81optz9CYhewyNM1pJivNY4YZu+zhNrAdwzPDWjR
         xfZWhRPiH9/6BUzzIa6CfEu0iedMdS79dqPS94p/GmNzT3GpEIWcCRszZoaaYMOM+HC6
         Z841jntAdSVg4iQUJd6Knmi8uecMc+Kiaj4TAWZB9WhjztLE1EGTuuP9zxsyXxbliy6q
         knav3Z8QpglJtnC7vm2rM4a8SzPQfIJ8/aLgVPw2GFR6ttp9oSUxgwSf2oBRZ7p5drBe
         Oq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=t41SIZ77TenOTSivCUBNZRO4XROInqe3IoobaTZ9I+Q=;
        b=UN9gMpLfJxnOW27+u5KxXqOWaOWQjYj40L3n33TTZSBK9EDP7c2lodHN8pZGMlySXS
         oEx53Ncs01ZBfWNb1aOoNi0zbLlH6QT2Z6Wwjzso1zS5EeNSa+ZapA/4mami/cEaUNF9
         GJGuehFQj0l47VwFGYnxvwQcJI3e8WNWId8AqWsEr57DdYO9kIW3CmgV1O/V4PgEqpT6
         r2EVzAn4j+nxElt43sUC7UeB1AMzozAa7XCLDFmOHEnfu8YbsjTjqCUa7t/VT30r/hn7
         m2kKmOrSN0EDFgtEJIm1eJkJVXkpZGRVKF4tFqoIG+T9uuMfGr+Oi3D67WGwCMDK6Pqy
         q9ig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JGIxjJSF;
       spf=pass (google.com: domain of ianwmorrison@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ianwmorrison@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JGIxjJSF;
       spf=pass (google.com: domain of ianwmorrison@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ianwmorrison@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx489iaGwsZrD9rwoMU31K3EOp4mglTf392jFpO8yOYvp/4XpUqOOkn4Axwlau+UW49qQvZeB9Q==
From: ianwmorrison@gmail.com
To: rodrigo.vivi@intel.com,
	anusha.srivatsa@intel.com,
	michal.wajdeczko@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
Date: Tue, 10 Apr 2018 16:35:47 +1000
Message-Id: <20180410063547.12124-1-ianwmorrison@gmail.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597340028351694942?=
X-GMAIL-MSGID: =?utf-8?q?1597340028351694942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ian W MORRISON <ianwmorrison@gmail.com>

As the Geminilake firmware is now merged to linux-firmware.git
use MODUE_FIRMWARE to load the firmware.

This removes the error message in the dmesg log: 

    i915 0000:00:02.0: Direct firmware load for 
        i915/glk_dmc_ver1_04.bin failed with error -2
    i915 0000:00:02.0: Failed to load DMC firmware 
        i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
    i915 0000:00:02.0: DMC firmware homepage:
        https://01.org/linuxgraphics/downloads/firmware

and now shows that the firmware has correctly loaded:

    [drm] Finished loading DMC firmware i915/glk_dmc_ver1_04.bin (v1.4)

Cc: stable@vger.kernel.org
Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/gpu/drm/i915/intel_csr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_csr.c b/drivers/gpu/drm/i915/intel_csr.c
index 41e6c75a7f3c..f9550ea46c26 100644
--- a/drivers/gpu/drm/i915/intel_csr.c
+++ b/drivers/gpu/drm/i915/intel_csr.c
@@ -35,6 +35,7 @@
  */
 
 #define I915_CSR_GLK "i915/glk_dmc_ver1_04.bin"
+MODULE_FIRMWARE(I915_CSR_GLK);
 #define GLK_CSR_VERSION_REQUIRED	CSR_VERSION(1, 4)
 
 #define I915_CSR_CNL "i915/cnl_dmc_ver1_07.bin"
-- 
2.11.0
