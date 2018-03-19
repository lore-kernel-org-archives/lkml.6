Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451051; cv=none;
        d=google.com; s=arc-20160816;
        b=ZZB3EIA0VHRJ3jJKHbH6VmNqBsE8orJgbAMJpyYl8zsWK/O2dQZcarfkamLkp9Tc5i
         U/FJEL1b2ls2OKuNC1XO09326Yzborc1AE5mjyOZHovLnlYaz+g+lfo+0Z7CJhikANQk
         aGcF/K7dquo9KzJry3Fep0vJN8mP8uH9ga7bEPM8nggT3bSUhKVB9gh3/WtkL0q48Shr
         /gb+FwikXTb/8mbaMH3HH2TaCYQmri1CC2T02xKn5+tON07Ei5aX5NGp25zQpaDc54oa
         is5L0kF48Mb+B2o40OaKcuqn7bYG2+OTA+0VMV639Cdw6lkXtXcN8w3+RSHa3Dp+kjCc
         NTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bLnxJTIBNvdInu38oJWeKFvbnt8/GUCrO8fvhPHT3Oo=;
        b=ivxuTa2EqZPTTf8cbf8en5KTqYGz0/zGs107LePrdueNpn8ubFzI/dCHyV402ADB3Y
         usZi/tKUBWW2PjRgrREtRGwv5FZHDewlMNqBqaVAZelh7n8LO33xR4gqTAjpsea66VUP
         J6vBlQSX9Io7YcKke90Pjf6ECUSEf4WtgWBQV3NMQL9z1u35k89ROyV/oqTL6w7NLr+u
         FaTE5pIU7tAyvoWZp0Kl52y9M2ENUffD/04h3xtZ3SWKhVSs5Gs0Qelwe2sxYiCN5XO8
         gXFgibTarSE6EzGRcP/VH845LQZgj8rwoVl0pXtLfXjOUTk9IMOudVRh0i5yqAJOznmh
         sq6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XP5JLkxF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XP5JLkxF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELvkuq/jkSPWeOaJQejpvrzbze0VJ+OWjeJXqaMUvYitsrfIie2zZjwsjaMzQRT+9AyAyQ3Ygw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 05/21] eeprom: at24: remove code separators
Date: Mon, 19 Mar 2018 10:17:05 +0100
Message-Id: <20180319091721.18193-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357057571787349?=
X-GMAIL-MSGID: =?utf-8?q?1595357057571787349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These are just two left-overs from times when this driver was bigger.

They are not really useful anymore. Remove them.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0e06201d33c9..d1ad73d94fa8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -235,8 +235,6 @@ static const struct acpi_device_id at24_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
 
-/*-------------------------------------------------------------------------*/
-
 /*
  * This routine supports chips which consume multiple I2C addresses. It
  * computes the addressing information to be used for a given r/w request.
@@ -712,8 +710,6 @@ static int at24_remove(struct i2c_client *client)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
-- 
2.16.1
