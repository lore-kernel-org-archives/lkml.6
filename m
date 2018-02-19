Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x22500wgB0EmckXCZGUGLAWREZETT1cV6/AVSrwBJqbI8cJvZlOGLEZkUXno95ZtM4WEo7IqN
ARC-Seal: i=1; a=rsa-sha256; t=1519035297; cv=none;
        d=google.com; s=arc-20160816;
        b=idZ8n2Ap8TNzm02HK3JUR8AqeaYSUdYMiK0JKLO7YehRawNOPMld7akeAVhDE4bDtb
         6YDRYhsnfLpqzPl6qj/AOBifPgSew1iN6SqYW094NbCUMRDQDdUG4jIZwryQnH5y8dDj
         LIFq9oZ+bX7vvAdnBuEg4YQFW0zKOnAICHnlsjzuH9h31HaLGLkVvfKPNxAyn7SjULjX
         Du1Pet2a4V2f6JoR75Ksnn31N2n6FV8dtvUVeGgE9G4QLUO3HxXzEQ90wowF144s/G6A
         hG4NnpLCUjWg/i1LhoEPs3TeU5ZECjlsLxDYb68pg6ufom4aGLVVNJWN0d3pYs1RElLW
         WXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Z0S1j3hz8v2hsL211MhMKIP9Xvjd89cEAimb7ZObk00=;
        b=pc9Ua0jt/uj5fcKIdGsXgSpATIqXb4xnb97vnecreDJxgy8i4YoFSm4hQXqRo0NvzT
         qBrS7Qin4TYcUYv76lRcnbckNfiFnPrbYpQCPcEAIFGUEWezZ5fSgmYohuqalinz6ITq
         MOl5kBg4Aukct3P3pUMW/8JEsWAe1BdHMIioDxcI+AV3MnSQGfQBIFd5YOwBjXOHgW4l
         +lNxzMHEkWLj0D4tfs9Lfud77Jhbv4Hk5LulSeVW+h+hJ24PHE5hrneVngjr1ow+JL2S
         GoARQpKTmxqTfAMsYGUVAAZbLeqPRLLX1gWSUt/mXUjF7cTmoVgssTvISInUGasd0lMQ
         vrSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.187 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [4.9-stable 6/9] idle: i7300: add PCI dependency
Date: Mon, 19 Feb 2018 11:13:25 +0100
Message-Id: <20180219101343.2922561-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:g06e4qV9xrkpekbTSExluJ0u5GD8tMYgF0KeYa1B3rWVU/HKDM0
 ppSn9OY6zbXrM9/19aawXdQGCCAeLJouxaMRk+OBg4InxLhF1H3nUKt7YDqPaSIUZnxRpip
 aRUNd9k63KE3w38NGAsx7bXvo0rkfxn9+UytG8Qe5xNc+KkSD+Rls0CgkVVnsU6skgiAqd1
 ydPyeS7c9G1yDQlE+EAEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HMuwi/jSmFk=:t4cXaZpJRdohHwUWGk+lkm
 GEZ7CeuoG9ItVkw48ryUKC4qcNvqiPD2mEhG1qfHewoJDQvJVF/JIwcY9RcZvde3MwDU8nDJb
 CEWTCt5cAFdJ2zpTxAa+J5nM8PlE6sumTGW7kc5fv7aa/P4tRJEsEuHOIuTz5XFfJa88WE8nO
 0jC0kHooDZh64RApj2a69A4J2loj+rpdj5GtY7+6NF20pTyfXRUx/AcZIPnh22efU+zWynRWH
 +279IOcJNY6R83JoqzEpH4Ek41YHQMqFSZZwLunw9VegAhhXxrWma6RTpTgXIj3dvcvpN+hZX
 x52Gd/O23d+3C96177JnddDaNXGAv3Z1cAGpfXZAvE/BkubRQ28U8jiREOrlngThJvxTbmbCP
 AWS0FzkZ9Lfu2LT1Urbn1dytiYx4cOdQhlckxQdpdrNxGpFp0wPfwEd/u+Uaxbawnqvh8m6TE
 CtX+Q+9SmRokpCOyKvMN/o2EzjoC450/hs8CFSyLpkj4N3BiRMl+m1ot4XibmhbudP0kdrhyt
 uD0/7mBREcyIf+wG4o9bTDHt1i8Ch/kb28u/Lk2lZjFVI+sYodLl0MiMuKVxSnkOYczIQ4ir4
 wEbDvXQghZ5Sc90Xjfk5xQ3VPrpVSO65vbs/nVM9+n8cVLCdc1M4quHdpZG33Bzw1NBdaJ2i9
 QT56dFv3SaeGRSG2y6vDAO2GcZEkOfgzepib98hyw3cVBWOYkpVuo3biVjERUOB7NKwgAA6mS
 3iKiwreFNtao8XjymC5WVVHoMwvPXCk3oHy0hw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592823955675757217?=
X-GMAIL-MSGID: =?utf-8?q?1592823955675757217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC correctly points out an uninitialized variable use when CONFIG_PCI is disabled.

drivers/idle/i7300_idle.c: In function 'i7300_idle_notifier':
include/asm-generic/bug.h:119:5: error: 'got_ctl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (unlikely(__ret_warn_once && !__warned)) {  \
     ^
drivers/idle/i7300_idle.c:415:5: note: 'got_ctl' was declared here
  u8 got_ctl;
     ^~~~~~~

The driver no longer exists in later kernels, so this patch only appplies to
linux-4.9.y and earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/idle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index 4732dfc15447..331adc509f3a 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -17,6 +17,7 @@ config I7300_IDLE_IOAT_CHANNEL
 
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
+	depends on PCI
 	select I7300_IDLE_IOAT_CHANNEL
 	help
 	  Enable memory power savings when idle with certain Intel server
-- 
2.9.0
