Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEQJDS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:03:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35257 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeEQJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:00:58 -0400
X-Google-Smtp-Source: AB8JxZoh7E7Aynxm4Bea6fyq9ffXiszdrf10PVyJP0OHLGOyvBRMoZULfI16PEkHszH7eL3Ox8dpUw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 2/8] slimbus: core: rearrange slim_eaddr structure
Date: Thu, 17 May 2018 09:58:44 +0100
Message-Id: <20180517085850.14276-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange struct slim_eaddr so that the structure is packed correctly
to be able to send in SLIMBus messages.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/slimbus.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index efa36a852dc3..63801bcc5e60 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -14,16 +14,16 @@ extern struct bus_type slimbus_bus;
 
 /**
  * struct slim_eaddr - Enumeration address for a SLIMbus device
- * @manf_id: Manufacturer Id for the device
- * @prod_code: Product code
- * @dev_index: Device index
  * @instance: Instance value
+ * @dev_index: Device index
+ * @prod_code: Product code
+ * @manf_id: Manufacturer Id for the device
  */
 struct slim_eaddr {
-	u16 manf_id;
-	u16 prod_code;
-	u8 dev_index;
 	u8 instance;
+	u8 dev_index;
+	u16 prod_code;
+	u16 manf_id;
 } __packed;
 
 /**
-- 
2.16.2
