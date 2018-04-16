Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917492; cv=none;
        d=google.com; s=arc-20160816;
        b=htqaq4d3Ggh0p3tiROh8M+EE+dzrN4HY3WOahj1NSv/Flhf8AwFSiVEisIBHCIBqet
         LRQNzu8eeAmcj9tISFkc4OzhBLoY5YpNK+3nSSkFkB5dE8Ybt/jXC/785EH1AdY4iouK
         U7UG4uSfFVLbSi7h6GfpDYrGpaMUy7/8r61f1dhfUkT4K+2Drkc2xRf1PSWRBISrJLZc
         3zj50eEmA5ixGXuJ187bveSTv0drED+wJaD5LiO91qvBm6XmmO6CKcKVjoKtVWq9fxsn
         GLCCXeYhMokgln/HW0CJ0WW3DaSfUqn35nwufd84FAgbUq4xtjNhSYEzXzUt70Vfache
         Rw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FZqLMfP5Fq/FiDTtpf8kPf0+q86JiGVc41UC5mU3ikw=;
        b=ZhW6yzeXx7UUKnSxGUI08ohlYpoU2FDMOJa/N4LYolwg7Smr0qmWbi8Idvmx7gFJp2
         Ho+KqoVny8qmz9So9HSuKFmSbw19s0u/qE4NKdg00LjT1THWvTZL5rZnDAQRDg2wdgpx
         Mnd0vVuDltbnR6TxItZ2lRgrzwoBy8xJmqZyHVWEwOI+Tpvk9zmIQCMbCh/3kwA+j7w2
         BT4ObERbK6OUhRysxf6yHZ5MZcfVha5mLettElwFOhsgrEGFj6tSWnvcdmx1TZ70oFuj
         z3RbSnpRZa2ifsBUfjkuqs4vNixq3tKOBS5SJX44x/WKxetnFEJ0Af2qw8/kDfPAJ/Fr
         v32w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tuDn0q8X;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tuDn0q8X;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+Kmwzi8N0dX5I65mgSTODOC4Lsegq7QgmRhQ+TU6Oa6ycFUY1IbX2xYLjC5krXJcQlPg15jw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 7/8] ath10k: use request_firmware_nowarn to load firmware
Date: Mon, 16 Apr 2018 18:24:26 -0400
Message-Id: <20180416222427.29683-8-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416222427.29683-1-andresx7@gmail.com>
References: <20180416222427.29683-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943307825530003?=
X-GMAIL-MSGID: =?utf-8?q?1597943307825530003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reduces the unnecessary spew when trying to load optional firmware:
"Direct firmware load for ... failed with error -2"

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index f3ec13b80b20..9a225b7ad2d7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -652,7 +652,7 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
 		dir = ".";
 
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-	ret = request_firmware(&fw, filename, ar->dev);
+	ret = request_firmware_nowarn(&fw, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.14.1
