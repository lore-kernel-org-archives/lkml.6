Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELtwwUye+FCWP7zk036UUEfWSY4HdG2FWfdrdohiMJ8AiQD7Ef+pJdsFf2cNuRNKLi9SJvhx
ARC-Seal: i=1; a=rsa-sha256; t=1521042888; cv=none;
        d=google.com; s=arc-20160816;
        b=F69Qysd5yeoExNaQU7YL2vHxlrkILrj7zaecWK4galGebsz8mjs83nZHKYB+SozhgS
         sBZsOo2GNg1TPuVgxUcLy5YhQkGaou+tUlqt4KgRvUndJwYqpmifnQs4c8M5jJqQ6zEf
         rMBiQ59Q6QQtVZLp8ntFWCaPiVDz5CxNqpwgW1do67jb1fdwKcfsjUJJi9BD1vZBt3tW
         Pl0JZ2XTmELWZyFcBVPAOQi8BM4Rxebv1o24DuZvj20bZRpHMe9BJeyNdYvhrEq1ybzt
         kH/xZdLbOl2yip2CF3zyVcI4avcRqbYy48A1P+rOZo8fEVpgBix2Ev1Z9oK8U1wqpA1Z
         Vjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uUyEXaBuLlguqo17KpnK7wY4T8kmfz2VAb1sdpzcYB8=;
        b=vH3JCrF9q1kKOM+dQcK6PTEoPNOrSGSyTt1I7vzxgbAWruBF9kdtpFO1wAk75ohQ2K
         zCxbve9Iw59VBE0KkT9F6iw//VfeKHckSX1gKyqxH92kg3qn8Tu+OGGgMElBTkhegC+c
         0KcxZn2iS6nflEaHIU7t9JBmiyulRSLrmJuPK6YZVxAoHwTYxmF9IMzSgp8GGiX8UZ4k
         Rk5xsfueIkBa/NEAFchIY0phn4UK5nhIfH636o94TckmvM7ekE9vNfvAIh0zu68drtBO
         VR95TNyFUKiX3/W87MjvZAYOH+ssKJXJrXX8g/UieCXmFifRs/GC5uHPaX3SI5vdDPwZ
         g4zA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.135 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.135 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 45/47] tty: hvc: remove tile driver
Date: Wed, 14 Mar 2018 16:35:58 +0100
Message-Id: <20180314153603.3127932-46-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:IYqio9LbG3LE6qRCQu8k3AQjgNH9uuDaaai81Asp3xiHvR59yVF
 +jfV3saHd8TgxCiMc8fPYgYdSNepuiuhOcECHqYaQ7ymRIUs8KpnVJjcXH5KAn11lXK4wHq
 93Mg6jjjxdi8+lJxXGNatjTgdbdIKyPcrJ2ZQHFE0mbkCkW1uA7D/MeAh8BK6XaqUronfOK
 LLHXLurqYmyX/vgjNgi0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i1DVAOPo//8=:yajV/muC/ZOyO/QTOotfWu
 0xuqR9wNLoKFo7GbqAVoE/6ErqUd6Tj5sEu6V1qHWlirL8TbE+lbgmI4MHpvGeSGbiBN6Nx30
 Oxi0e/lJ1G0AmmC1gAUNbAH2l4Cn2GzBbHmijhp/k+yVEvVkbJtTeYWyFqgxrxHGpNinXUg1h
 JSEYnk1BNYKpbJUzMe0QDo0T9R929XjMlobZD5g6ZSbpmLaerhOdE5My6sa6MVfqMcLDcH35L
 DkhgobEstaM9H6KooyKlAx9orWD1C8PdgIqaRk46ov2/68F7+7IjO5UZPKxZj2mF52dfrJnj4
 1/ihG3jnbHodRxTIPyYwo5gSHKdENEOU54bacf1RiiG0iwe7lVHn+O2UIFbP5xZzZpbO1l0f6
 N1LJ3mr9e8YEYq8Czse9co01sDT+v7TgFsXqBDqQBUfLRT/hLH/4hfZ9YQ65IxDSeTBvq3iln
 nLA6tKJ52u4vJFPsQHoS3yJgt22IlY/J4BfRBMOVa2ULT02mmsOKkzYN24GDZwpj2o7s5M6Jm
 Edjg+/vEZFIQiaelCKjMQ9z2Frnh/UuQI83y3LuQ8zZ+OCi+Itw6pgV5ZrGFhx8+2SqDG4ukp
 Zcaeq4MeyHloomm3BL8IH82QO+ODdMbqMYi8Br4C40amCN39H6l5pnKb2HM+HdH2HwiNhe4eL
 QlH98+O3W4Dpja15KO9RpsHds8iAnNGWAf2L5jzESGnnawd/vbw3NlQHNHc4U8IULalXz4MF9
 StLClxM5lUpQgXQXwieA60t83r7+4aEC0qYvXA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929068150478014?=
X-GMAIL-MSGID: =?utf-8?q?1594929068150478014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tile architecture is obsolete and getting removed from the kernel,
this removes the corresponding console driver as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/hvc/Makefile   |   1 -
 drivers/tty/hvc/hvc_tile.c | 196 ---------------------------------------------
 2 files changed, 197 deletions(-)
 delete mode 100644 drivers/tty/hvc/hvc_tile.c

diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index b82f9f68cd23..7da1934d34e8 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi_lib.o
 obj-$(CONFIG_HVC_OPAL)		+= hvc_opal.o hvsi_lib.o
 obj-$(CONFIG_HVC_OLD_HVSI)	+= hvsi.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
-obj-$(CONFIG_HVC_TILE)		+= hvc_tile.o
 obj-$(CONFIG_HVC_DCC)		+= hvc_dcc.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
diff --git a/drivers/tty/hvc/hvc_tile.c b/drivers/tty/hvc/hvc_tile.c
deleted file mode 100644
index b517c0661abb..000000000000
-- 
2.9.0
