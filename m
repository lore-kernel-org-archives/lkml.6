Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451078; cv=none;
        d=google.com; s=arc-20160816;
        b=DSFdU9lAHYJkvKdJ/nDf6IWr3wnRTbYtXdtbBlyJ3p32R9B1OqLfDJSwGSLeaQOHsj
         8PO6RQvnfbgIVpFE9HLb2km2JtxpuoqFTie8+aqQ3JG6ftzKyvNa4ltc38faw3eeMn49
         UNHfFZRKbfGNk43Da4zzNi+E+NCl1R5O9YvjZwlsEUvbzfyKAqYMy5X65vCIxOVWXHbb
         GrWjkprmZErKNy74u1dYdpwENgVyfER9twSmdsyFmWFyCJWsf79/YybOIILge/GIjFv8
         G4DrLopZt6wRWEQCaIDCSqccP2ZMdRPAY2DBfIQg5FBEf1Ni+M0rLdVrIL1V80lmTbSa
         cFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ihHTzqLs1kEMPCeQwqXKLnTCR9AE6WqS2Uyo4mh8Q0I=;
        b=nVXXUe4hpllGczFJc97P3M1xTzdP8rLHz0eDOj1lOaUGbo7JqqLjyiofhiGRX9gqxe
         xLTHo4s9Q2j7Cv0gHCxxQ+2EO1cPpZICoX0MJlohUcDhUTOPjpzUI2VB0duNjMID7kE3
         Kvii4+8AoyhWqEa7l1hHYwEJXODQuV/1NXttZHbWrwomhOyb2EgoRijBvqlThOMFax9x
         oeRIeTdetHXQW2k4AZ3rZl2WSBjLUZVxm+AFmfPCzKEClYWGH/mxkbGbSiRGE/JlKLKZ
         SvsdPZLY+gL2Vab5IGs6OPISE8ZN2Ow/bgxfimvxQOEsAeUPrXI7sGT/Ai/Z7pfH6HZB
         +Yow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=v8j0/RF7;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=v8j0/RF7;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELvoeqLBInmY4+bxwck7SSUU7mOuTvPFDcKAs7QON/2tT2r+9hnF0MmJ2Nb2Aw4DiiaoJ5wsww==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 20/21] eeprom: at24: fix a line break
Date: Mon, 19 Mar 2018 10:17:20 +0100
Message-Id: <20180319091721.18193-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357086078574836?=
X-GMAIL-MSGID: =?utf-8?q?1595357086078574836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Align the broken line with the opening parenthesis to stay consistent
with the rest of the driver code.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b4233d914500..c42e479b880a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -690,8 +690,8 @@ static int at24_probe(struct i2c_client *client)
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		pdata.byte_len, client->name,
-		writable ? "writable" : "read-only", at24->write_max);
+		 pdata.byte_len, client->name,
+		 writable ? "writable" : "read-only", at24->write_max);
 
 	/* export data to kernel code */
 	if (pdata.setup)
-- 
2.16.1
