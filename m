Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979205; cv=none;
        d=google.com; s=arc-20160816;
        b=cilKTl7uXokIoDsqE2W09st3WmsEgDvkXnltWCiiE4twgATeOXaDO2V0R10lltYgnw
         1a8gKvGjCcSpg4wY4A3H2GMfcnlTrQpujFe9TVn5RSTDBQlGnyRQBvCmECAVmmhD/LOL
         bezvq/ltDNjoTZ19n9DBdHoXN1GpwHQEzysFJYp+qlcZl34S0g5EFAffw6r14NS2xDL0
         w79LSQ53hmr+PsATYyRkoRKcF/hAsK2z0Qjc7Vx6jD/nQoJSfi6PThKEHHWKYoBSfesf
         N1FqEHcOEvHfrrWuuWWjxfW2xHpLi8xB7wB7Dq1fS4jhq6X+wMunmOlw5CrlH67Br7eo
         chWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FZqLMfP5Fq/FiDTtpf8kPf0+q86JiGVc41UC5mU3ikw=;
        b=mLZus+dQAT7lx9O5JfCZjyigOTT6IozGKc6eE8FNcrv5hM10D90cGg/DYOnKmZ7FaO
         4h8LNdyShl2kVqZiFHSikFXq7cc8EI0KP45E+HMlMo8gcEKOfteCBIlzwXiE+pWWliui
         dC93s9W3AESmdcarpvok2tpoHfGi15xSRZKGd4CSaCx6BxH1OSSezfOeQwvzjH6Z7zuW
         p7v5NMiGf9UjFCrNJRutU7A5YACwtnEp917X4JgQCCX5VfPirc36lAIHWI+3MsIl6hDC
         4soPGeXWxMs/DgL18HBx4ZPbg8aMoU0RCD/7jv18ISltnoFA6vb0fvQnhN1tElFpMfBQ
         l7PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=skgAl55K;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=skgAl55K;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48DytQ9921vJpH+vB+1xG42x7YB3PDBeuJTo9wEPOwijOCDQguKOqbhLaPmmOoQmST/ubvaqg==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 8/9] ath10k: use request_firmware_nowarn to load firmware
Date: Tue, 17 Apr 2018 11:33:06 -0400
Message-Id: <20180417153307.3693-9-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008019864458634?=
X-GMAIL-MSGID: =?utf-8?q?1598008019864458634?=
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
