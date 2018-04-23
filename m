Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx49MXbjU4qk/MiALSgG76jXmnBTcaUBuhtT4GMsvVMyZwEkCF/05FV32S7XEFJEYfbRGJVzO
ARC-Seal: i=1; a=rsa-sha256; t=1524505605; cv=none;
        d=google.com; s=arc-20160816;
        b=jFlCBBG1pVmu7n1x7qw45ROYUjlJs/yKdcFh9Pa4+usmJTzjdtaHURxnROTZB+JWiC
         p4NIZXG9tIgcC/wHcFpOZ7oX+xXOMUUS0eLOEeApq0jg9BeyAnCq1xs6KgRm78jbnnF/
         J2MRkKPaolMrf0obyvNTZD4Mq9IM7Rglc2IpDCM9DxhICNfzKR7WMd9onizYTIRwTSME
         hreyvT0VlZVUt5Cz1qPe2z97Le0GA2N5Dqb3xLBInIC0img9AdJgjZVqIMK8qImw2deM
         bXdHFpiYad+r7pbehgz/+u+BrO6Bq8rKTTfUFKMhdiZJmVmyb9v+LCcdebF7nDETXQiL
         5ZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UFj8+KaPKd+RZ0NcGN+ZweNvx440WLGqN69IYE8mZr0=;
        b=sPZtxqWaCBKtjbvthCPP1jV10CYzZ1fGqX3JkVO17R8q8Ve3E+CPJtztFZb5ByFg72
         I3VkuOAdt18HhEQr0pKkMQNG9iZgfF3tsUjz3LHTY1L4sfjsulF/Uary+cjtHjrfZfO1
         Qz4ViO0tAwnVVtgDGVflrQ0NMI7olP5LLhhpqwVEoH6F3eKDphLipCqZC8XCtKrBkA6E
         SXVsdeTHgsSWr6qO4ehAB6BAVhpHvqbjMQvg34rdhF5yLRtUlYAXwj90BD2p1OoEOtvI
         bI4DoA0xSN0U0fdZ1ZsJRU+QGt+0ivK9HjMnyKBetYUmWbL7tjfuha+NcVnQ32NNQh2A
         3IGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/16] bus: ti-sysc: Show module information for suspend if DEBUG is enabled
Date: Mon, 23 Apr 2018 10:45:49 -0700
Message-Id: <20180423174549.57412-17-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559989852033594?=
X-GMAIL-MSGID: =?utf-8?q?1598559989852033594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Let's show module info if DEBUG is enabled to make it easier to follow
what happens on the suspend and resume path.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -891,6 +891,24 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+
+#ifdef DEBUG
+	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
+	SYSC_QUIRK("gpu", 0, 0x1fc00, 0x1fc10, -1, 0, 0, 0),
+	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff, 0),
+	SYSC_QUIRK("hsi", 0, 0, 0x10, 0x14, 0x50043101, 0xffffffff, 0),
+	SYSC_QUIRK("iss", 0, 0, 0x10, -1, 0x40000101, 0xffffffff, 0),
+	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44306302, 0xffffffff, 0),
+	SYSC_QUIRK("mcbsp", 0, -1, 0x8c, -1, 0, 0, 0),
+	SYSC_QUIRK("mailbox", 0, 0, 0x10, -1, 0x00000400, 0xffffffff, 0),
+	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40000902, 0xffffffff, 0),
+	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40002903, 0xffffffff, 0),
+	SYSC_QUIRK("spinlock", 0, 0, 0x10, -1, 0x50020000, 0xffffffff, 0),
+	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
+	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
+	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
+		   0xffffffff, 0),
+#endif
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
