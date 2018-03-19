Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451049; cv=none;
        d=google.com; s=arc-20160816;
        b=uNzOKCJrWBJ/pARq7p0UJF55yOZm9mujht5IW64O7v5V2xRDxS5am+RW4tz9sdSsZ/
         L7uicr8lV5Sr/ydOLO9Ou9IIW4eowwGXG7CNYZ4BXKK7t7Fp6xe5VpSXhrxZpG6mzmAm
         LF+xy8o/S16vpJadlqip7yRZyaQ3EGJzjwqlj0OU5EBh7JmgDNs5OimKbK/YWxCqJTot
         gsR4PjP2JIKV8utLh0Z0UP39jny3kwQJT4AW6mHrCS412vXd67OtzT2jNm+9lQsSarsR
         2pDzKvC0bc0fIA+RZqMPKXEzF23veF/t+djrn5knT1bLIuH7dIYMuVWW+7Ysifd5LEK9
         fGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ZPlCIZDvkWmAI66C/mzNr64aWtJzkU1nMgljV+r/Xa0=;
        b=HI+LP2DIDHcjjlBMpsiDIcZZlEy8sg/WeTBUSJhivKZ6xFKxp0g3eMWVUZ3BrGB7nD
         EZSY1ASF2Xyi3itlyWqQ8bNNi3Be5bXSJSEOMjjk/TMuwyRGkLZvQi5t6plPqHT1eBjt
         EhZu3CzupjtSMKOiDgPlMkE2PBp510zBew5BSgvrv+Xjxa6CPJejRlmmQbpbz9fwj2QB
         Bxr1NTD2txV/lQk2c6ogCVlAUQ/qvNYaZRm7l2EdWXfoxeDZhg/y5l9VECQ4pkgeI/We
         IwzYU5NDS7sb+sXlEKg4oIYxut2EEOZVZEg5NWzcf7+q38NLbyNlATSKt/nbfOhaMjSZ
         0ODw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=BphuBs2+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=BphuBs2+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELt8eEC+Gn61ac0Cyth3W2leT0fIYSRNd2Ax5qHH4Id0utGmX2202tSpowXeZXoYrCkSgTmjsQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 03/21] eeprom: at24: arrange local variables
Date: Mon, 19 Mar 2018 10:17:03 +0100
Message-Id: <20180319091721.18193-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357055264032124?=
X-GMAIL-MSGID: =?utf-8?q?1595357055264032124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arrange declarations of local variables by line length as visually
it's easier to read.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2600657c7034..2a4154eeb1bd 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -370,11 +370,14 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
-	struct at24_data *at24 = priv;
-	struct device *dev = &at24->client[0].client->dev;
+	struct at24_data *at24;
+	struct device *dev;
 	char *buf = val;
 	int ret;
 
+	at24 = priv;
+	dev = &at24->client[0].client->dev;
+
 	if (unlikely(!count))
 		return count;
 
@@ -416,11 +419,14 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
-	struct at24_data *at24 = priv;
-	struct device *dev = &at24->client[0].client->dev;
+	struct at24_data *at24;
+	struct device *dev;
 	char *buf = val;
 	int ret;
 
+	at24 = priv;
+	dev = &at24->client[0].client->dev;
+
 	if (unlikely(!count))
 		return -EINVAL;
 
@@ -515,15 +521,15 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct at24_platform_data chip = { 0 };
-	const struct at24_chip_data *cd = NULL;
-	bool writable;
-	struct at24_data *at24;
-	int err;
-	unsigned int i, num_addresses;
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
+	const struct at24_chip_data *cd = NULL;
+	struct at24_platform_data chip = { 0 };
+	unsigned int i, num_addresses;
+	struct at24_data *at24;
+	bool writable;
 	u8 test_byte;
+	int err;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
-- 
2.16.1
