Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AB8JxZpPC+K4vScPuUAV3zTRLPItDlF5/UhQPkkmgZTsZRFTyavYp2r5F83+YQJ/yP3+P/h535Sj
ARC-Seal: i=1; a=rsa-sha256; t=1525817924; cv=none;
        d=google.com; s=arc-20160816;
        b=OXPuEoUhkZ4xJfjWTwUcCvBG5l/Up1kQlrknwoK6Ns1PpTks+YLPDBxIbMDldCmoTQ
         UzgYx4ms74lUaSME0J88/4iB13Knt0QxSY0AguU2DkxYlpMqUD5IB0ApLAk0nkjLiXED
         QjgJwAJxjzN6UPzGWHgYUXqpWJqgaHT/Y2IkvnKImZllvbSs6unRfytoj0RURWvT8FVs
         6tx0aPm7gDwOPW9SHzQnKIyun3RLGBNfsUWoQP2xPEgmFgVvsZ/POtSf/2hjwysjf+J/
         hTp98qmTYDEWrSU8N7liZFa6Y3eDu/4hGU3kNRuBwGDe7T/CgHngkALrRnTDSQtOc8XU
         jrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=3j1wDinT45K6IAiYmys6vHpysV0nd9zimRIHOULOFVc=;
        b=FzjzyFN0dt0ISVTlkhlS1DvN9988MPB5nlpbpf4dS6WDDAw+awy6msltk1P7SVXs3C
         wZ8Mz03UYAa8HbDGpITknebi6Hm8S7kGangJuWslytnN80rQSJ2qyi6KU0XWsa6KUw+y
         9yfFalQq+VtUluB3c+0vE7ZLMX3Xk8arhcqdpBsOicaC4I0RYdNbAW1WuAu/Fr7oU3tt
         uGaZMJ2VbA1/1PTahFj8eKcPZ5X5j+HprwADiuhi66e4+80IPLazt4lkpB1GOc3VONsH
         9nUFq9NIDk/qSIUMEcO/WnmANEkVxcmWEqOCSkeAq64tvyV7lpjt07yMfbOZ5Dw0R280
         fKEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: n2: fix spelling mistake: "restesting" -> "retesting"
Date: Tue,  8 May 2018 23:18:42 +0100
Message-Id: <20180508221842.22198-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599936056039744694?=
X-GMAIL-MSGID: =?utf-8?q?1599936056039744694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/hw_random/n2-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 92dd4e925315..f8411515fe1c 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -435,7 +435,7 @@ static int n2rng_data_read(struct hwrng *rng, u32 *data)
 			*data = np->test_data & 0xffffffff;
 			len = 4;
 		} else {
-			dev_err(&np->op->dev, "RNG error, restesting\n");
+			dev_err(&np->op->dev, "RNG error, retesting\n");
 			np->flags &= ~N2RNG_FLAG_READY;
 			if (!(np->flags & N2RNG_FLAG_SHUTDOWN))
 				schedule_delayed_work(&np->work, 0);
-- 
2.17.0
