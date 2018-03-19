Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451075; cv=none;
        d=google.com; s=arc-20160816;
        b=zqjpzXSnvx5lIhBlOdSMBFH/tmzlMgGklLN36hCtbLICSiqpVhnXFg/kLWyZKIbhRv
         AudxcQW/2Sw5GQJtPwwNd0BLs9pIavjMw5Fa1Dzy+4LtUCJDpBvOUK6N87a197CCUOeU
         x+3Uko+Z9dkpIEUBDc43mTv+pS3BlM9HFGXZbP5Hm767dOvBk3LiaBkJx6if2WH8hXb3
         DubSk8sDuWIryw+vmyPH0l3YjnO2kp7KUK7uMOTpSV7/ivMW1/t9ma+VLCyNIl5Z4vnV
         fQrnod4cTVccJcDv2c2HKLrnBvRw+5Wgl5pGqNaNl0Js8UWzBwlGzAmcJcZiDGnTyhO/
         j6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GEZnAhNVGjilTkBt/3GUn1mDaMZMjTKwx19b9jd8XNw=;
        b=T4foo9nN0FhSSzQjI8mELy86uMnViIDGfLf9QbK5fbm9EBh37WqHNW3atPLla36lP7
         3KrAlsfGA9+eJ8XXqulwmAwEqFEZDBSmezHyXJRulNOj6H5qNK9aPDH9D/AmtG8OVRWk
         QwT33l6QQSFP8zy18beZZYj16xa905tJcuTZ1bQzASeI+vNGKo7ceEe48kkhgfJO8jO+
         I7xMp6D1PV+WwowCNHFKO5EqJAvREPou1JyjEJBpPVkX6zeZEI0yB0bA6ajDUDDJCDzK
         vvZPWSq2pr6/5rL22QvbeRLDf9OEPwg946qpnigaC2Rms0+7FBQcRwtYy3Ip18EqVqWF
         fEiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fSGmbWKd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fSGmbWKd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELsIIFE/kx/pqCCvbDcPyi4Ac/0lHn6TJPEl6/8S4XwHtNg/L2CF9o0lvXND86eZ4pqQDzhoTQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 19/21] eeprom: at24: tweak newlines
Date: Mon, 19 Mar 2018 10:17:19 +0100
Message-Id: <20180319091721.18193-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357082737931727?=
X-GMAIL-MSGID: =?utf-8?q?1595357082737931727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove the newline between the nvmem registration and its return value
check. This is consistent with the rest of the driver code.

Add a missing newline between two pdata checks to stay consistent with
all the others.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f67f5f626617..b4233d914500 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -582,6 +582,7 @@ static int at24_probe(struct i2c_client *client)
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
+
 	if (!is_power_of_2(pdata.page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
@@ -683,7 +684,6 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.size = pdata.byte_len;
 
 	at24->nvmem = nvmem_register(&nvmem_config);
-
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
 		goto err_clients;
-- 
2.16.1
