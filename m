Return-Path: <xypron.glpk@gmx.de>
X-Google-Smtp-Source: AG47ELuMWvDb7OgkpVE5JROavJnzvVqy053mV1V7b9jxlwu7uw/wVeESiGeMvvaaxAhXyv3vD8Hy
ARC-Seal: i=1; a=rsa-sha256; t=1521443554; cv=none;
        d=google.com; s=arc-20160816;
        b=cwW0n2LK5NLj0Mt///H+0hc7mvvgc4vRNUPqYq43NnRmwRlc1sbMf+Nao6xB8e7+nh
         SHXO1lmGWh8mF8lHSYgcvuqdHrHnNxCRF52Mknv+zgnA2yhSkbHhTBeLnjm+H7EE10I2
         OybDM5Ovqa1ixNPt7qGV+KMqZk9m8ZSX2hAXteUdgT2B2uVWjktDhXPxAl+dj+qc7oss
         qd0m/JNvk8qS+8yyxveqMiiiNgmWkMIJ2r6Y6JzyTho/YAC6VtiSh6lrk8rfS+EAKIO0
         0wwMOHyVlBUQ2rfn1oiIlTN/YquSY0fHAnH2JesqkXeshxWgSVNY229U/opCAErwSxtu
         OsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=0JcYsDD+CzvuXRrb2+gWeEsfm3CLs1YvoeMeml7cPh4=;
        b=xwoggoWy/wXv8SVCj4CVMfKeQ5V00+KFi2DGusqjBNYLcRPQg9ep6oxQpHxtECp1GZ
         Jcaen9iVcz3FACY3t1CiiXIHvihK2PNTikP8eOChDoerV0PVkQeBZlgP5BVYOOm+ZXwW
         God7A8CTYmAzeGGTVRaM0ZOM6AVIQ6BfVbO9LHxoNudspcpp/HAMQBLi5sKkYLVkIFmm
         lAzNmeqqTdCYFQmDev60BfABJcDOk9kbUR1h9Zt9s4aY6cdNYqJBil84hsvLvoI1PI3q
         O14jrJTIgE3RXPSAPK2G3f9p07CJd395+6A51xcFUiA1e1rqOxajwjh5o53z4Lc6qDZc
         w1Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xypron.glpk@gmx.de designates 212.227.15.15 as permitted sender) smtp.mailfrom=xypron.glpk@gmx.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xypron.glpk@gmx.de designates 212.227.15.15 as permitted sender) smtp.mailfrom=xypron.glpk@gmx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] usb: musb: gadget: misplaced out of bounds check
Date: Mon, 19 Mar 2018 08:12:28 +0100
Message-Id: <20180319071228.11051-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:k0ePUfNbB+CRys/P6swwWzOg+QuQzPgbmwskRb9FBggHclhVSZj
 yhfuKCWo+7oEaA99NbqSGqUHpnukTd3HJqWeeUFvljSSu5XGaAWgyPFd43wlipAu7kzmcam
 S2BlnRjDROJfO+KWlG7D99bEwTEUOW/XxC0JeS5e7v2g54uvAG5HKJ6bIonN+7ArocpL9z9
 QS4v0rS1YaG607uKkX4TA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e3sWqG0qMEs=:/ovch+g7LinaqnCCePinjV
 OOAcjd3kt1+Uu3oDhVTw17rvSp0nbvF3gdIjoMt/4X8RlNIK4A71xTW1YZ7QJynTJHsgd+iFB
 fcvaEDOyKnnr8td84RWHOrM2AKe+v0hGDsWvrbLdrwJJDOW+NveLeNtM9ZB1XGozGeF/XKB1o
 R5vvCK4sYXD1tEM+B+mpede4I8xik4IDN4azf7wgeqYmWd8qp/JjrE5fecECrGV/+0aMu3H25
 Ii0InT3+M52GNoye5YvI6d0pHL7dVIYmpZGDzKnVXnHppMRr59vUi/epBiOTz+RrvuDn0ePKL
 qFJ8Md1LpvpUY9xzBQOKRGI5fqR/AJOAlK21GwS6KJpzvZukgiCbSyvqf0lsmSwXHWIzqHSHQ
 bFyTNJhCScbi6o8/DjupIqlbD6yOwRQYnIleviLMhS/WeoSELEtwHdL+b3G0j8EVG5StdMrCa
 tb3aQYl3va3xh8/OaSYxU61OJGEggURfMAuD2XV0neQRDmXMh1NtNt/al3c8GlN6ANMjW2XT7
 71g90vSFNsDUS6Kxut8iS9jYf99aJIKabbPa5pDqosQ1+fi3ZMw0YUWmj3+X11mdt2UipSAcx
 rPFfg2E8LyWhEW/M9oMWYCrOJFUL/u0ZhExySK2XKfDHw0B+2MSegDc1ld0pTSto7jEPYDdYe
 F+quV+XjkAIfPrfPsztbvKERIeAiXK4z6zlS5EkvWbhI/fpUBo4stT996aObIb/+xgOm2Zi4p
 /10ZcNopYcZ3o7xhE4bfM0XbUXcmhUHEn41eKUEUH3ujIhikN6xVuaZEavbp3K7NJj9uf2eIn
 MkKv6fb5IckkZYmkBcP+T6jczoFLA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595349196944875278?=
X-GMAIL-MSGID: =?utf-8?q?1595349196944875278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/usb/musb/musb_gadget_ep0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 18da4873e52e..482e7c2f8dc7 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -88,6 +88,11 @@ static int service_tx_status_request(
 			break;
 		}
 
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
 		is_in = epnum & USB_DIR_IN;
 		if (is_in) {
 			epnum &= 0x0f;
@@ -97,7 +102,7 @@ static int service_tx_status_request(
 		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
-- 
2.16.2
