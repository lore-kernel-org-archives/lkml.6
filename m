Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZrwVw5HoC3yOLPxrlTxt7lJq8DnWFn/w0qaPbkkGhb4/gc9ofn/hm9eQWvhbXc6RG/ITPMX
ARC-Seal: i=1; a=rsa-sha256; t=1526392277; cv=none;
        d=google.com; s=arc-20160816;
        b=e5XO6LKEUeWktFngFLliv0XSSqeBWJV8tm3a0q1EOCO8/VcNZxXlaEI7VK1vmLDU48
         9qu0UwPwATALW8cF5HKTTuxTp9S163GV8Eq/YXKpGcWfpqM05Z5iCSo2usT86f9/u4jI
         aJHjLdCwEpI0J1brKcd1jakIIihoojuFdu4WIvOL1XPmWOUE11CHnJ0AFeZbovID10xI
         EnwxG9Rxz5ZQpzYVsUqK+A1DRSI+yoHmq8uwT974noDbjP49lbsxHTM9ePbs/6b18rZF
         nIxtBNHZymod4JYH7I7AULUS97K3fzX7NNAg1LsPRPA/ZX50+JDQ89OfVP0bXm1xg8/d
         WBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vdHxjgl4qpjo/jXw50ERUGBBbe4w5ARWRsSycmKOfGU=;
        b=vgJTJwdEc/ovdKj8SE9zcTmOvVZQ0JRYk0d2QQiUciOldbMqvd/Km48pY/s7LtRSVz
         Gg5drQEbjSNRuVEqlBAcaxygWS0pfztpetfxLdWsjl98GjKLbx9+x0WE0mNNi0byxXE1
         G76pevEb2NVSQoZ3XwT+f53U5eB6xYBlsRtU/hE34nSXX9KNOk31rdhHm1FHcpIy310t
         8cJ40KyHk6n2MyB9Hn9fytXqAnw87bw5rD8pmDpLvM2ayMscihiPHDcHI8v5Wopo3QjZ
         JYKr1Be3gMIYPNo89RiMoYJMs6ZfqGwQ6IDz7sEZHoD+Bp0SW9ibbPMSicy/3b61md9t
         QOaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] driver-core: print bus registration error value
Date: Tue, 15 May 2018 15:51:14 +0200
Message-Id: <20180515135114.31939-4-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
References: <20180504132357.31771-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538308576095679?=
X-GMAIL-MSGID: =?utf-8?q?1600538308576095679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 drivers/base/driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index afd5b08b7677..c68d35139c0f 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -149,8 +149,9 @@ int driver_register(struct device_driver *drv)
 	struct device_driver *other;
 
 	if (!drv->bus->p) {
-		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
-			   drv->name);
+		printk(KERN_ERR "Driver '%s' was unable to register bus_type "
+			   "(error: %d)\n",
+			   drv->name, drv->bus->bus_register_retval);
 		return -EINVAL;
 	}
 
-- 
2.16.1
