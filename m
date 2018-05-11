Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036974; cv=none;
        d=google.com; s=arc-20160816;
        b=MUe9QVchb5ZUfcfqhmm7SP94PlPJTjHjD45ZagbR9jVu92jh5fj9YJm3cY1s6eRDiV
         QDrRXtc3HmuTUS5ETJ5sTIkfozVTUvZKgv/GOkYd1askNwQkgFotxOPJa53KhdTLXJyO
         W1MgCXzwteuIikCFDd/bNjw9pdJtqbDQeMbQJBSYJniwzlf+092FYL/6dXefzb5C+YPm
         dBczYiCAZNQdmTnW4LqFJM0UzECJB38xB62CPApk7ggVzTIFaNiIxwDJnLzbCmZy+zKH
         7ScrJW+5ncwgsMYy6afKa/YqR830AiO0nS56FJviQoPiEJApLseVm8TW01Itur4k41v+
         Y7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oZHKLnNhfOD1TR9nUEnOw2v6BtOs+0YTR6k9PM6W1Ns=;
        b=nhp/ByraerqF+T0FNerIzqR8aHD7fCS3oQ2zqDTtdzaU/+nCcYMB6Qetzat5lqlgzw
         SACRP8B9xGVMVZLA9sJaQMlRvH9aeN8bSwtGRM07bIpPvFGBtAIpyF4b9hMJ6TCNhfM3
         gwrhN6OvP7KZ0M2cJ3hjf3l1z3m/BwqHCpCIyiUnhMES3ONwo8MoFwNJnTclHE9yiKQ/
         fsWPt7MByCP23YWbEAgRXkriG4DirFo/Bx2VYhoyKMOF+smkctI5498AdfrukBDauPeW
         1DvxQ0LVMSaHIUqCXT8XjHWKg05BSHRfQPpiNmSyTOGp11nLE4DDgjBtC5lnhG0MHKTO
         H9Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b1NSEzoB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b1NSEzoB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqiQ7Ty5/VNksFRmKvvpstZ6Yj8cM27HtsKpmcJ1tSPd4TeBnoNxibjJsJHXYYpptcWPavd3w==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 5/8] nvmem: meson-efuse: simplify read callback
Date: Fri, 11 May 2018 12:07:00 +0100
Message-Id: <20180511110703.4924-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165747000522714?=
X-GMAIL-MSGID: =?utf-8?q?1600165747000522714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

Most of the code and variables in the read callback is not necessary.
Keep only what is required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 2df9b0094f45..4623249dfd87 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -24,15 +24,8 @@
 static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
-	u8 *buf = val;
-	int ret;
-
-	ret = meson_sm_call_read(buf, bytes, SM_EFUSE_READ, offset,
-				 bytes, 0, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return meson_sm_call_read((u8 *)val, bytes, SM_EFUSE_READ, offset,
+				  bytes, 0, 0, 0);
 }
 
 static const struct of_device_id meson_efuse_match[] = {
-- 
2.16.2
