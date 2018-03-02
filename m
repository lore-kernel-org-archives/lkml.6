Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AG47ELun0ybxvV66+pmcc8WMRkEf07seL2xJU7+BHlMfb24EgckyqNVlS07lZsAWFl9KrWWzPODY
ARC-Seal: i=1; a=rsa-sha256; t=1520000093; cv=none;
        d=google.com; s=arc-20160816;
        b=lemFQ0ry/0G2bGOsAAGz8HBTLlRYkZuaqeD2JEQGTmNKUzQWH6/ewfvFM1KSTJbnru
         PPHDTl38jtQetTC3IWPRp+7ZwbPdg1beQlT7l0k3TfCH2db2EBcsZw9885yO40wkEPU2
         8pW5fwkZvcdSNTw8W70NUcBp9psZeqYQB6DX1/ebOLKQyOxvncgbwESXiARcBiPDxFuj
         4ttjsWJY+HExJfD4WgsCmB87/hfa20jKiNU2JgMqn7EnqRJYGdy97PP3QxuO5LIL9Vi9
         3nuLiMxGp4Cc8oN2qgIdDy0LUEMP3WHtaasWEsQPKzTXFIDhpA4VYTyOP3wXkiCdbHGd
         lDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=xJzvzEvbTGZ+f+mjC01mUHuC/VXx4r82hQNB5crZooQ=;
        b=GJ2yu1+diI1LDS9QZINuvfbTduMuC7kGxAojJegPRnKQ6iPP6IBo2n72Li/NTRtnrb
         iGCrEiLjYjAzqiIlvtWcKaRScYKcPXcp2u9hhT5m/OhswAKJd8t1SP/agyA8PWYNm6g3
         8LlqwLPvycKy3cAbJKUMtfOnCFxl2pXpCbVkU3YPJoYR7p1hj1mQUAk863LrNQs60IIQ
         KAvY/b3UpuNa5OVOfF4dxn1OnTvD3LgquhxkfKqJebCzBA/gW7coIyICt3C/3HRXEGkx
         tkmqzPrXTGTpkprXf1u8DND61XnuQrwOqdlhpzvMsrZNVhl+tCuQS1gRfz53jnzlGQTS
         8Icg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Corey Minyard <minyard@acm.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	openipmi-developer@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: use ARRAY_SIZE for poweroff_functions array sizing calculation
Date: Fri,  2 Mar 2018 14:14:51 +0000
Message-Id: <20180302141451.656-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593835618533277959?=
X-GMAIL-MSGID: =?utf-8?q?1593835618533277959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Use the ARRAY_SIZE macro on a array poweroff_functions to determine
size of the array. Improvement suggested by Coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/ipmi/ipmi_poweroff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 07fa366bc8f0..fccb1e9fd3b7 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -519,8 +519,7 @@ static struct poweroff_function poweroff_functions[] = {
 	  .detect		= ipmi_chassis_detect,
 	  .poweroff_func	= ipmi_poweroff_chassis },
 };
-#define NUM_PO_FUNCS (sizeof(poweroff_functions) \
-		      / sizeof(struct poweroff_function))
+#define NUM_PO_FUNCS ARRAY_SIZE(poweroff_functions)
 
 
 /* Called on a powerdown request. */
-- 
2.15.1
