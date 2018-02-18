Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-990319-1518953858-2-1430508196313707962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518953858; b=s+VRulhxi9iop1QN5CZ8jA8o44RevbIvM/Axw/8rm1fIOxe
    Mn7R6BcONy8uFVw1pgJOF3K2fn2S2vH0BXU7S2ssw1x7fqkIpxcD8oteCuztUm+7
    moRCP/BxeF8Lj9Gh8TERq4tE2QNXYc7361bQ6tnxuOGbrmFDGFxO4j3zWgPxbX0/
    dtye87Vb9WJXBvNdiepONz87ESl9MCY0yL8z1w58kViBiDFYW53O+ATyjFA8Qs7j
    IOw9E5To/LNxNcANc+gP0h78YvYRUcsZJcKx8NZuYclcWqwIlXIaIUAf8C9RiyIU
    Pnh/bVK3C4/R252Vp27RxP7zyop5WouaepyxCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518953858; bh=d
    oe+PdVtImcbqVPU3c9x9ZZdnutSz6GG7ROrLXD1174=; b=W5viO3pmIRdDwlp0z
    lyV7VEZnzWefz4aNCOChcpF5TAGRKrnmUz9xHvJMoB8+TCgDelDVIxScn+5sG4Rr
    JN6GN8Qzkknj6bW+1aLT7IgHVZjsshM/GbYZRoQTJ66QzChtDY8qTL2A8pweWE4o
    zJ7wk1kPBO+WMCwaaA1Nky7j8B9bVbgXox5F2uAHfxRbOlLMRs6dkTbRCYls/OUQ
    rws1Smu8XRYyWyHbe79aYRSZ33LhWF9GENR+N4CBcD0IuLjMSmkKrrSqLyIwOsih
    c+COnx15ieww+N4XusS8ogcTAw68Pprq1bkqB/gI1ljR1Jz0Mz0WTpExcKrqA5uP
    U+D0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EG0JHeXX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ooFRyVw/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EG0JHeXX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ooFRyVw/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2258YqOCZKs/qLzY6YoKKQy9VeLKpEhTFYDHHyCrtmJ4x6xreDUr5zLObKoo4EH1QwIOZL2frw==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging:r8188eu: Use lib80211 to decrypt WEP-frames
Date: Sun, 18 Feb 2018 14:37:38 +0300
Message-Id: <20180218113738.32689-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.16.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Aastha Gupta <aastha.gupta4104@gmail.com>,
 Georgiana Chelu <georgiana.chelu93@gmail.com>,
 Ivan Safonov <insafonov@gmail.com>, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Janani Sankara Babu <jananis37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use native lib80211 WEP decrypt instead of custom implementation.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/Kconfig                |  2 +
 drivers/staging/rtl8188eu/core/rtw_recv.c        |  2 +-
 drivers/staging/rtl8188eu/core/rtw_security.c    | 80 +++++++++++++-----------
 drivers/staging/rtl8188eu/include/rtw_security.h |  2 +-
 4 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index cb836c59d564..d787a091d3c1 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -4,6 +4,8 @@ config R8188EU
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
+	select LIB80211
+	select LIB80211_CRYPT_WEP
 	---help---
 	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
 	If built as a module, it will be called r8188eu.
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 6506a1587df0..fe31ebbf36fb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -404,7 +404,7 @@ static struct recv_frame *decryptor(struct adapter *padapter,
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
-			rtw_wep_decrypt(padapter, (u8 *)precv_frame);
+			res = rtw_wep_decrypt(padapter, (u8 *)precv_frame);
 			break;
 		case _TKIP_:
 			res = rtw_tkip_decrypt(padapter, (u8 *)precv_frame);
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 5b1ef229df2a..72da86fdd264 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -18,6 +18,7 @@
 #include <drv_types.h>
 #include <wifi.h>
 #include <osdep_intf.h>
+#include <net/lib80211.h>
 
 /* WEP related ===== */
 
@@ -195,48 +196,57 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 }
 
-void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
+int rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
-	/*  exclude ICV */
-	u8	crc[4];
-	struct arc4context	 mycontext;
-	int	length;
-	u32	keylength;
-	u8	*pframe, *payload, *iv, wepkey[16];
-	u8	 keyindex;
 	struct	rx_pkt_attrib	 *prxattrib = &(((struct recv_frame *)precvframe)->attrib);
-	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 
+	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
+		struct	security_priv	*psecuritypriv = &padapter->securitypriv;
+		struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
+		u8 *pframe = skb->data;
+		void *crypto_private = NULL;
+		int status = _SUCCESS;
+		const int keyindex = prxattrib->key_index;
+		struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
+		char iv[4], icv[4];
+
+		if (!crypto_ops) {
+			status = _FAIL;
+			goto exit;
+		}
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->pkt->data;
+		memcpy(iv, pframe + prxattrib->hdrlen, 4);
+		memcpy(icv, pframe + skb->len - 4, 4);
 
-	/* start to decrypt recvframe */
-	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt == _WEP104_)) {
-		iv = pframe+prxattrib->hdrlen;
-		keyindex = prxattrib->key_index;
-		keylength = psecuritypriv->dot11DefKeylen[keyindex];
-		memcpy(&wepkey[0], iv, 3);
-		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
-		length = ((struct recv_frame *)precvframe)->pkt->len-prxattrib->hdrlen-prxattrib->iv_len;
-
-		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
-
-		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3+keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
-
-		/* calculate icv and compare the icv */
-		*((__le32 *)crc) = getcrc32(payload, length - 4);
-
-		if (crc[3] != payload[length-1] ||
-		    crc[2] != payload[length-2] ||
-		    crc[1] != payload[length-3] ||
-		    crc[0] != payload[length-4]) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-				 ("rtw_wep_decrypt:icv error crc (%4ph)!=payload (%4ph)\n",
-				 &crc, &payload[length-4]));
+		crypto_private = crypto_ops->init(keyindex);
+		if (!crypto_private) {
+			status = _FAIL;
+			goto exit;
+		}
+		if (crypto_ops->set_key(psecuritypriv->dot11DefKey[keyindex].skey,
+					psecuritypriv->dot11DefKeylen[keyindex], NULL, crypto_private) < 0) {
+			status = _FAIL;
+			goto exit;
 		}
+		if (crypto_ops->decrypt_mpdu(skb, prxattrib->hdrlen, crypto_private)) {
+			status = _FAIL;
+			goto exit;
+		}
+
+		memmove(pframe, pframe + 4, prxattrib->hdrlen);
+		skb_push(skb, 4);
+		skb_put(skb, 4);
+
+		memcpy(pframe + prxattrib->hdrlen, iv, 4);
+		memcpy(pframe + skb->len - 4, icv, 4);
+
+exit:
+		if (crypto_ops && crypto_private)
+			crypto_ops->deinit(crypto_private);
+		return status;
 	}
+
+	return _FAIL;
 }
 
 /* 3		===== TKIP related ===== */
diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index a0c6cf706218..b1883ca852af 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -308,6 +308,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe);
 void rtw_wep_encrypt(struct adapter *padapter, u8  *pxmitframe);
 u32 rtw_aes_decrypt(struct adapter *padapter, u8  *precvframe);
 u32 rtw_tkip_decrypt(struct adapter *padapter, u8  *precvframe);
-void rtw_wep_decrypt(struct adapter *padapter, u8  *precvframe);
+int rtw_wep_decrypt(struct adapter *padapter, u8  *precvframe);
 
 #endif	/* __RTL871X_SECURITY_H_ */
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
