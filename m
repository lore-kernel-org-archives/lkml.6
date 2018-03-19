Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451054; cv=none;
        d=google.com; s=arc-20160816;
        b=WV5r7G1KRJ53wxDooY6mf9XHPcIKT7+d422gmaqgxkqdz0T8oG8y2EAMkQcWuUnk1q
         5gTDA5tg6l8avwXVhs/AdWdhIDYb8rYE+YDEqSb9JUViPMI8gW9k4AJvlQvu55sJJhND
         2t9pzImsgcJmqkK+Qwoxdnf6QtvOuBsqhOHM7ypBU7TZYM8AkCdD99lXvUmUpjMmyjbg
         nKsFCDzih+VJfY9vamqTaLE9baP7VjVckEBldVTivXBajTZowqhSQZZQC30murBqCy3u
         EImTnJyow62GvlExiPBMOloiRRjzYeKdCep3zPCy0o8OhpI0GM8FHBKqcu2CD4QtlQu2
         Vjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FxAKBDOkmmd+0QaP3/e3MWUtjVQYZZMwsjprwdcsZUI=;
        b=lqWdd/vWohemk4fXUy06FQkl7U4reaFGJ4uw5Bp4kkEnDAnXXbO7B66zFzh/oO2LDQ
         zizGPipeFT5Y5e8dLw7vfh1R+TiADHp5u3xMJZsTcYWbBw/8VwbFVw0Fbbntx3llDXA7
         e3bhgHUvnfDvagyWpE5d3j6AG2ORW4feC3kmcNom4O45Wi1O3TNoPFra/I89yoY6AEuV
         O3+oe6+VnzzC4UBo5EoFKC+C29XXj//liLB9qCHkDWI/WCPEQGQctOLwQ29W02vjwD6G
         PO1xl74tXSHv+hpY1IvmvgnD8a0BHlQzxxyPgeyQpyREKd/FPwXbnqRRzG8hGl6aZbj+
         XRUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TmHAUs8B;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=TmHAUs8B;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELufbzzxlCKHomzTYwKA63ycew1vIw8YtCYffvXtU/42oJhG+P2TukEKBlQdW2PO8ZGwpIK8sw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 08/21] eeprom: at24: make struct initialization uniform in at24_probe()
Date: Mon, 19 Mar 2018 10:17:08 +0100
Message-Id: <20180319091721.18193-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357060361041755?=
X-GMAIL-MSGID: =?utf-8?q?1595357060361041755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When zeroing structs, use "{ }" everywhere.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d9d55310ffa4..83a9223e62fb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -515,7 +515,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
-	struct at24_platform_data chip = { 0 };
+	struct at24_platform_data chip = { };
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	bool writable;
-- 
2.16.1
