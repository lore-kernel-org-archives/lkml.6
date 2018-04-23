Return-Path: <simon@nikanor.nu>
ARC-Seal: i=1; a=rsa-sha256; t=1524505498; cv=none;
        d=google.com; s=arc-20160816;
        b=AB0wWHfguFqJg5tCWXLjFA7mggeAlEZ8ZcTSyn+9bOGzaD7dKbyE8iah1O5dGLGylN
         xKgUB/WXdc+dKgyaZ2GGMHyQ+xrd/9nsXKg1QDg3xGgipkeiwyZ6xMu+B4pHcZK/quc1
         eUF8kJyy6t89CQ2w9/MrFVS1DzO6eOwmnRLL1Mfw7+XJ0LAZ+uL1ZidtBA7bvZwg3aNY
         3olwGuz0FcSFVfZ21oMOytJeS1eu845KFAoOTpgatm/FAafBpol+duouMSuid8vlhUGl
         3hPIwGKvUBum/7QzHSf/mj5xzPX2MnBCOYHJ1ih29GgrCGsJKhuXRNWSfU7L6AZt78hQ
         wkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=/LZvLPgfz3BuXz/6mKsg8kqRk24BL5+KlYiSpsX0VMs=;
        b=O8HoaYlMTzvNWpOT/m0wW1Bk0NJ3+FJChR5N54RJwbjDCWMKHOm+4zGWTj5EUvWg/1
         iT4TTDuGg9ie8HMwg2bubZQIK5wBx23fQiWcDRaF1dv/pbmpGbZN2iTsvOxmZzO1eDsE
         hWc0gh0a736VLfA1I4Qv9dh8UWCdn+BGVdPX8nYrdow4vRNWb85s0DNSs4R0xFSJ8Aqz
         fHb5iSm00cXz+nnJ3/3oTsvi/XW437Y4C8C5qrGxem0zaUgiqpSnr/q5DPRIXTFMnF7O
         yCdBFXiT0y7hP73VHXr2ekfrOGUCJjqUqhW6WGevMYDavFHzXLZfU7HrFe37Jwiwp2rq
         4UAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nikanor-nu.20150623.gappssmtp.com header.s=20150623 header.b=hjn0CZLa;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of simon@nikanor.nu) smtp.mailfrom=simon@nikanor.nu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nikanor-nu.20150623.gappssmtp.com header.s=20150623 header.b=hjn0CZLa;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of simon@nikanor.nu) smtp.mailfrom=simon@nikanor.nu
X-Google-Smtp-Source: AIpwx4/wURCb5aLC35jyNpIMHk/ItXBVLMLH1a2JhOX8VVTOnX2cPMjdab8XMcPBhKVdQkQwbavGNA==
From: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To: gregkh@linuxfoundation.org
Cc: Valentin.Vidic@CARNet.hr,
	linux@wolf-entwicklungen.de,
	minhnpq16@gmail.com,
	viro@zeniv.linux.org.uk,
	srishtishar@gmail.com,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] staging: pi433: break long lines in pi433_if.c
Date: Mon, 23 Apr 2018 19:44:56 +0200
Message-Id: <20180423174456.27309-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559877910340227?=
X-GMAIL-MSGID: =?utf-8?q?1598559877910340227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Breaks long lines in pi433_if.c, fixing checkpatch.pl warnings:
"WARNING: line over 80 characters"

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/pi433/pi433_if.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 2a05eff88469..b061f77dda41 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -591,13 +591,17 @@ pi433_tx_thread(void *data)
 		 */
 		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
-			dev_dbg(device->dev, "reading tx_cfg from fifo failed: got %d byte(s), expected %d", retval, (unsigned int)sizeof(tx_cfg));
+			dev_dbg(device->dev,
+				"reading tx_cfg from fifo failed: got %d byte(s), expected %d",
+				retval, (unsigned int)sizeof(tx_cfg));
 			continue;
 		}
 
 		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
 		if (retval != sizeof(size_t)) {
-			dev_dbg(device->dev, "reading msg size from fifo failed: got %d, expected %d", retval, (unsigned int)sizeof(size_t));
+			dev_dbg(device->dev,
+				"reading msg size from fifo failed: got %d, expected %d",
+				retval, (unsigned int)sizeof(size_t));
 			continue;
 		}
 
@@ -619,7 +623,11 @@ pi433_tx_thread(void *data)
 
 		/* add length byte, if requested */
 		if (tx_cfg.enable_length_byte  == OPTION_ON)
-			device->buffer[position++] = size - 1; /* according to spec length byte itself must be excluded from the length calculation */
+			/*
+			 * according to spec, length byte itself must be
+			 * excluded from the length calculation
+			 */
+			device->buffer[position++] = size - 1;
 
 		/* add adr byte, if requested */
 		if (tx_cfg.enable_address_byte == OPTION_ON)
@@ -1047,7 +1055,7 @@ static int setup_gpio(struct pi433_device *device)
 		/* configure irq */
 		device->irq_num[i] = gpiod_to_irq(device->gpiod[i]);
 		if (device->irq_num[i] < 0) {
-			device->gpiod[i] = ERR_PTR(-EINVAL);//(struct gpio_desc *)device->irq_num[i];
+			device->gpiod[i] = ERR_PTR(-EINVAL);
 			return device->irq_num[i];
 		}
 		retval = request_irq(device->irq_num[i],
-- 
2.11.0
