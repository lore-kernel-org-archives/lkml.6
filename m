Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517793822; cv=none;
        d=google.com; s=arc-20160816;
        b=v+eg+urDt9v2ifp5Br3Yh9QKFXkOZ2a/Ep7Rdz0O/helfxUFIWsKdzV/DcReCi/28O
         n0JDxVy2yfY9oTguO4yihnCrd0mpIyqzqw8IQ8Wd97c7StUPR/H4CWnFj2pcH2v6x3ag
         LZCkw+EH1gt1vUUTY1mUo/T6vAOvAW1jLHvYihSvGzmTssA7sy66Qk3az8ffIGkE/8Z0
         hAhcXLxrVbPut7C3t17tNf5UY8ZPN6MQnprdtzV5/ZYhWEdkHRUEuxfSgGLgOKq+tpo+
         5CMoHhszgGp9PIO6ZINIdxMsApXlbTNu49ND3MS/SChkF4sOo3HuI/DlTXwlWXSPj8e0
         QT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Iv4r0CnjvaFbkPNpvTR1JJl2g+99Hdb4CqR/zJ2inZk=;
        b=gtOU/oPGtsVBxYGMT/XEM5f/tLz4y+0hgLolZ6/NQZRwJPPYgHfh31R5bSSBSDQC/Y
         tcVtKfCu6au5LmYn3YBa8bgpTS6lefcJpIefIMvs19eSe8iNNiQk4kCmdsgGjxPGDvVo
         Dg0dZywu+vMgS32VJFzzBBTumK2RLuWnxHbXD6Cbjm8zdb3afGhqNzcxfXBSQTb3fB4/
         zzkIwz+YBCi8tfMxJAA2ZpTdo66KrwlBXgt8gJL73KQLFRlEz0S83lce6JwLt+qtS9fz
         LyCfaSXUZb+v/9vXQtakVrJ5MFvysvhBuAjV2NhJQy8aMWcklH8VJBzZv7Hfa3W70Fyk
         3/YQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OpqGG/On;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OpqGG/On;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226e0akFRtjhyxYWyvZoXtNAc+mYLQd38mD/mzgiiTGsERq8nKUYKg8LSx1l27jbdkN8r6A9GA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	tfiga@chromium.org,
	paul.burton@mips.com,
	m.szyprowski@samsung.com,
	egtvedt@samfundet.no,
	linus.walleij@linaro.org,
	vgupta@synopsys.com,
	mgorman@techsingularity.net,
	hch@lst.de,
	mina86@mina86.com,
	robh@kernel.org,
	sboyd@codeaurora.org,
	paulus@ozlabs.org,
	will.deacon@arm.com,
	tony@atomide.com,
	npiggin@gmail.com,
	yamada.masahiro@socionext.com,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/20] misc: atmel: Remove CPU_AT32AP700X (AVR32) reference
Date: Mon,  5 Feb 2018 02:21:16 +0100
Message-Id: <20180205012146.23981-5-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591522174878326387?=
X-GMAIL-MSGID: =?utf-8?q?1591522174878326387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The CPU_AT32AP700X symbol symbol went away when when AVR32 was removed
in commit 26202873bb51 ("avr32: remove support for AVR32 architecture")

Remove the prompt from ATMEL_TCB_CLKSRC_BLOCK. The prompt condition
could never be satisfied now.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 03605f8fc0dc..5d713008749b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -75,7 +75,6 @@ config ATMEL_TCB_CLKSRC
 config ATMEL_TCB_CLKSRC_BLOCK
 	int
 	depends on ATMEL_TCB_CLKSRC
-	prompt "TC Block" if CPU_AT32AP700X
 	default 0
 	range 0 1
 	help
-- 
2.14.1
