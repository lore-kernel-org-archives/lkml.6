Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470750; cv=none;
        d=google.com; s=arc-20160816;
        b=RTb9Ya41ooov0m0kYHe4bfo+cobnKm3CAYVk8lWkX8Gywa/6M1nzSFsvZrDpM17IYl
         MzdoEIK6N0Fp5HJfjGt6n3SiKguA1XgOK5aGIQAOSMF4Op9WJn3QAORHNw+c8QUCN5lo
         O48OlLyaHh6PaK3cRoBhy3W6h/WTG4P5A4Cd/NrOuo6K0Xtzb0kXVzl3QrSnIhV04XyL
         FVDuWVip2uGO/5d471lP9jfEHZpyfA/Hd8UBlzetGpfDCRQcYrV0gXQxpCLljcDTBxnl
         InHwDP2obJeg07Ph/B3SFynCz+pj74ucwv9zajTYkwtMfBifexiVjijixniTuwyRasN7
         SOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WHl8y2e/CNxRLOFMGZ23TuP+wCFFLpgrtDsLMJiqlxg=;
        b=U7e9iUpbn2N4cR1igRF8Uvy5PJAkcUmiCD4zfl7DXjGABeZb+mBBmlv0oXfKTLuGWo
         0cUpmxGg56rn8+d1EQhYqkrTE7M3/vxnCWKVNB6umiJdzubVaTxfP1eFrkwZHxXXYCzI
         3QRAP2M3yiRwOZg4p4kwWekSev7hBFeK5KxeDl4GZI0uDkMXVO60yJS8eGY1B3ayBXgH
         l943QnLrWa/q2MbjoCkRQG4Hy0bHRSdqkuqFocp2wMMn5nw/64+06IQaKZc0aULkWtCQ
         hon8JpRZ2tCSHLlMlK6FVxTpSSt+RW+0MAezCyPZ25dPtO+HaWUlFOcfCTurS7/PzlB8
         nqdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q5lhRHcG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q5lhRHcG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoQSGvC8MCk0qWvYvo6WkEfkq5L8EW3AY0F79V7bVFgwSI9jrg3p6k4Xa0G1RPS/gaensIYUA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] slimbus: core: rearrange slim_eaddr structure
Date: Wed, 16 May 2018 12:36:37 +0100
Message-Id: <20180516113642.28136-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620593604820552?=
X-GMAIL-MSGID: =?utf-8?q?1600620593604820552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
