Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZo4F6RL9VvjyHgtIPU6jIOPjWcXMOirtfYDcXGpkYvZRYV9+YRK6oDAgvBIOYc6IdAYGzh5
ARC-Seal: i=1; a=rsa-sha256; t=1525982943; cv=none;
        d=google.com; s=arc-20160816;
        b=n2wKBbFzZFUO4MXD4kikCPJVNe4GSmB7aRmZ/VWdoQj/CKgHj2l8TXamlK7ROAmjXF
         UE6vWynHW/IzHFWPSZl6qamYgetE5Ktja+AlYQjLlDZuH9sRIZpOBIQvla0SuClgmYyq
         owDYckzUZXs5e1OI+2FbLN0+a8p5AuSaAvex6//GFY3jXeQaX6mu5+O4bUlPY7VQvF3U
         oNsxdIKARf+wsxS2BZoR073SEeE2wV3MJRkidAIxcUPhI0bR7WhTxGdPuKvz4nwozJNr
         xkAKiXmCBD1s3CGuOroVkg/1zwN6hXjEK0ohxgr682gGwkQvZ5mfs1tsi1LrPSQUKCjM
         CnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zh3wGEdOzIpJyYN2Kz5vXoZI6qGB8bWpNzLl0IwjPNY=;
        b=HqDOZp7QQc0weYDTtHcjaVPJt3awPkYiAbNbamdQy3TZ5yE0hMIkI6LgzpvgCuTaWw
         df56rzXYGHyPC+SXxEBRCvie3ncVeSXnflkkFQDkWRrnVffBiqI1IBhs+BdWogYUruJ9
         7rHlLJP+WY3tyhKs4h2WWjg8yWQatCqzK1dq2lDfgRqVwYAWNIef8MB1SRH/42zvbcrS
         9shuq4Hhnb9WWq3ekD51aMHd92dmDX2u9sq7gTJFOrXQFvsicRz+yL66zY8IJv69tOOk
         bANbhpVDJY5u6RnNoj78cx7yP2t7xJz2QPSVCcXTAlHsaF6VEHYRDOCkyq16FXzDrMpA
         xGHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jsAK2xZd;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jsAK2xZd;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 06/14] firmware_loader: replace ---help--- with help
Date: Thu, 10 May 2018 13:08:42 -0700
Message-Id: <20180510200850.5958-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109090192294120?=
X-GMAIL-MSGID: =?utf-8?q?1600109090192294120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As per checkpatch using help is preferred over ---help---.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index db2bbe483927..0c38df32c7fe 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -93,7 +93,7 @@ menu "Firmware loader"
 config FW_LOADER
 	tristate "Firmware loading facility" if EXPERT
 	default y
-	---help---
+	help
 	  This enables the firmware loading facility in the kernel. The kernel
 	  will first look for built-in firmware, if it has any. Next, it will
 	  look for the requested firmware in a series of filesystem paths:
-- 
2.17.0
