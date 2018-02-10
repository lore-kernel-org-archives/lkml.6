Return-Path: <sankhla.dileep96@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518279404; cv=none;
        d=google.com; s=arc-20160816;
        b=QbXoNT7eh9rgpl1xb2cXY7SennJ7z1Z64Mdi77u47ADLd0W8ETlsMdRV0Ryysue7ip
         qYr6GLqMT1ZYOIiVVlQ5PNJ6AyKDWpiE3OvAyy+zJjNm8oEGbD9C/Aplb83v213HntJI
         pS5+nHbJbodehs/zki0S6kdb4y0z/iABspP9LVxCbqpJuKGpBzNy2VoqkAcQ5vEMo3cm
         aRmDuw86GdgXlOisqOphpmlpjXYxBflYkqRpDE6FtOvSWRtvnrcaqGjbszbS2ZXwv1LA
         Ozou+KvavZWTCJ5g7oo1aX+pFr+FGg3u2fd7h4JooRtBcfZpmzGPIb2Frr4aT9Oh05lQ
         5thA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=GXsCUQrt3ua6Yhle+H55rQQQUFPGTGMUPcoCvz6iXdg=;
        b=V6ssYwcfAaIaMJ1W+h4eLJfkGBdjbwv6cKLLYwUbYKijNA1QIyHzLph+u7LyVlsvTC
         SkAnRIvqP4ocGTdvwbL2lYggw5Hs3Tq63TEM2Wndv9a1bdOymWgW9fYMwfCZOAusA24m
         FGyD/cxQSwMsEyxPCE3oKWjXsA6zaSLJyzVXP9wHv2XecC0LDxZZ4L5txzdLoW5ouEvx
         7SYB6X97waY7uKw/nRD60vnPd9lJSyDOdQZWKnO/HdvzUP9+CZu50j/IC+cG30ngLsxP
         E7pIG8Hue+KspdHH0AXvBM0XSvQAJAmUAoGRrsT3kRkl+fpI16L9fyaYFBDJdw7qchLl
         RNHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pgdyfS+y;
       spf=pass (google.com: domain of sankhla.dileep96@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sankhla.dileep96@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pgdyfS+y;
       spf=pass (google.com: domain of sankhla.dileep96@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sankhla.dileep96@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2274pFr4BiRo+Q7+sz3u2N0etGiOcPVkWTAq6ajqsK3KuqiNZuXIXLD/AQRWbXQDtozCjRLGZQ==
From: Dileep Sankhla <sankhla.dileep96@gmail.com>
To: Forest Bond <forest@alittletooquiet.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Arushi Singhal <arushisinghal19971997@gmail.com>,
	=?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
	Dileep Sankhla <sankhla.dileep96@gmail.com>,
	Jitendra Kumar Khasdev <jkhasdev@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Fix "Possible unnecessary 'out of memory' message" checkpatch.pl warning
Date: Sat, 10 Feb 2018 21:46:18 +0530
Message-Id: <20180210161621.22246-1-sankhla.dileep96@gmail.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592031344819070945?=
X-GMAIL-MSGID: =?utf-8?q?1592031344819070945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Dileep Sankhla <sankhla.dileep96@gmail.com>
---
 drivers/staging/vt6656/usbpipe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 273176386a51..5bbc56f8779e 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -194,9 +194,6 @@ static void vnt_submit_rx_urb_complete(struct urb *urb)
 		if (vnt_rx_data(priv, rcb, urb->actual_length)) {
 			rcb->skb = dev_alloc_skb(priv->rx_buf_sz);
 			if (!rcb->skb) {
-				dev_dbg(&priv->usb->dev,
-					"Failed to re-alloc rx skb\n");
-
 				rcb->in_use = false;
 				return;
 			}
-- 
2.15.1
