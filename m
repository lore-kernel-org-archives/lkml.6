Return-Path: <kernel-hardening-return-12242-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvapVfVJp86ij8/A5hp0ovf7q95iNOav6hVLeo3p6qbqAredUNlSR1mf0DlqBhNXtgpwwpN
ARC-Seal: i=1; a=rsa-sha256; t=1520530815; cv=none;
        d=google.com; s=arc-20160816;
        b=eWCn+VROq0uhm81SJnM2An9JtT5c7dZd+xYN5AKRzJMsvSPaJtA4C/6MJkHo2Qh62r
         pBJ7DUhDsNLhry/bLyUKm6i61Urg6ZSWMMt8/3c7Onkcb7/BxwxZ5sVwwOFEGPa2h7Zy
         H+LZb4ZAQINbZ6coklYqDpIIGR0UwlE7o8rOY0qmYznHlbIlvN0zf0Oj6LN41ohM7qZC
         KBda1KCjsB1h8nQ0nyh1x2jYOvK6YKq3xMSfk7lAA+s1iQSxmdNCojkwuBYuqb4uGU69
         OhHLFTituJGQ7vi2mag9y3pWJMLYFy9HHHb9Nnc0V5JRCdf0gG/hUvBmgPJHaEUgDO6B
         3utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LU4xsTD12xsveo4/emd62BmocZr7AyEOGft0XrWl5MA=;
        b=eDGhTfBEF2ashx6EHIL/T2FTRCBmenV+qnMnxHpy0rvf7c+l/VRHwF3dIeQNomzwLy
         n0lEWf8hfzCr+Kk4MpJPNGoUmQQEQuubuhsgw0ilwJp6ndCtAWCLGVRU1DywKuDjECnN
         IFzlkEQd0+PjXb0xLkGS+z+StAv0au3Ti3TeiRylk+3m1y6+2SPY+PlkFVpcvzJ+JLAY
         vttzoqcQvOrEZGavN19vZxlyqLScsysuR0MCu7neTxIsqD7AzLGq3D1dquB73tJ1wl8o
         H906lGTvQrBFWv15LtnMpZQcNGViQQQ+aKOoOY7DuA9xqXdOzqDJirL6poYmhsCdGGOR
         UFyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12242-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12242-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12242-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12242-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 11:39:49 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Emil Velikov <emil.l.velikov@gmail.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] video: fbdev: via: remove VLA usage
Message-ID: <20180308173949.GA19305@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1etzW9-002E5U-Hn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:58548
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594392120539391557?=
X-GMAIL-MSGID: =?utf-8?q?1594392120539391557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA usage.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/via/via_aux_sii164.c | 2 +-
 drivers/video/fbdev/via/via_aux_vt1631.c | 2 +-
 drivers/video/fbdev/via/via_aux_vt1632.c | 2 +-
 drivers/video/fbdev/via/via_aux_vt1636.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
index ca1b35f..c27f62c 100644
--- a/drivers/video/fbdev/via/via_aux_sii164.c
+++ b/drivers/video/fbdev/via/via_aux_sii164.c
@@ -36,7 +36,7 @@ static void probe(struct via_aux_bus *bus, u8 addr)
 		.name	=	name};
 	/* check vendor id and device id */
 	const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	u8 tmp[ARRAY_SIZE(id)];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
 		return;
diff --git a/drivers/video/fbdev/via/via_aux_vt1631.c b/drivers/video/fbdev/via/via_aux_vt1631.c
index 06e742f..32978a0 100644
--- a/drivers/video/fbdev/via/via_aux_vt1631.c
+++ b/drivers/video/fbdev/via/via_aux_vt1631.c
@@ -36,7 +36,7 @@ void via_aux_vt1631_probe(struct via_aux_bus *bus)
 		.name	=	name};
 	/* check vendor id and device id */
 	const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	u8 tmp[ARRAY_SIZE(id)];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
 		return;
diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
index d24f4cd..cec8cc4 100644
--- a/drivers/video/fbdev/via/via_aux_vt1632.c
+++ b/drivers/video/fbdev/via/via_aux_vt1632.c
@@ -36,7 +36,7 @@ static void probe(struct via_aux_bus *bus, u8 addr)
 		.name	=	name};
 	/* check vendor id and device id */
 	const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	u8 tmp[ARRAY_SIZE(id)];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
 		return;
diff --git a/drivers/video/fbdev/via/via_aux_vt1636.c b/drivers/video/fbdev/via/via_aux_vt1636.c
index 9e015c1..2b10bc2 100644
--- a/drivers/video/fbdev/via/via_aux_vt1636.c
+++ b/drivers/video/fbdev/via/via_aux_vt1636.c
@@ -36,7 +36,7 @@ void via_aux_vt1636_probe(struct via_aux_bus *bus)
 		.name	=	name};
 	/* check vendor id and device id */
 	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	u8 tmp[ARRAY_SIZE(id)];
 
 	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
 		return;
-- 
2.7.4
