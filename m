Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3191557-1519397854-2-1584333748349306810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519397853; b=PTlK+bocTGGvQe6f6k7Cs90QEoXIHek67K2uSpGWVbI/ESL
    if/FK6d2fjj8c2t4boJwMo5fBwxeZhFGlFKGsPj6Owfa62EE1u+IwwJ9hTXCS7uH
    Ukp2yWi7w9Fx2+PljM59xnl9Di+ULl/6njeBAaA44GtIQOo96JTjwf+QuJIDVzQ/
    GBQskn/FcbZJntuYNauBih4EQrfQUxr5k37m9uvif/lAOzoRNI2hOsO+Wf+wyJ02
    T48foNYWuq6FRYPumaxHabdSC2167Oi6D0HjNepAHPEvr0EgEomWVBjM1CfvohwH
    6PpjS5ZkMkcDPe/pdnbMjnGGQ9JkWe38YkUPwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519397853; bh=8
    ykly8fNp7BqoR8Xy7vDEaEsrOOnrJ5hRlLonboRtw0=; b=Ysh+eH85gcyhAzjix
    G2GOEIAnQ27oTb9+NZUGWI+6KNaEOe+8b4mIcJ7JSZoAxQcHF1jKhumFeT4LpBdO
    8uJsb71cUqAVlBk+vjjTMyo90ldT3zzbm6BsiRINCgydHIbQ3zkAF1Wtl6zh7mXn
    QwSN4vIBMocFTIJ/YKHgynT0VnMg0MKwRfeq6Yhc17T/1JwcvCtLNwK4A7poLyr9
    X75/8zbdokgkF51KUVUiSZTt6XrJr5hE+0YV80q4igGlB7FV7VjAll7tSRUag1yX
    1y0U+EMmI8sv4lhDIHZu/ZuBcLOLPqsDgg56/41bf780D9GK/0Prx2XWMzDKEmMf
    rXDng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IDSaQPTA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r5zjGx5o;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IDSaQPTA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r5zjGx5o;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuDlKq62Cq9GVr+Ka0lMpfCYjYkaX6nmuqfp8Xm/l+Q1vKFOw6QZ8xym/B6IX03v3XYZ0lUPA==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging:r8188eu: use lib80211 CCMP decrypt
Date: Fri, 23 Feb 2018 17:57:42 +0300
Message-Id: <20180223145742.25783-1-insafonov@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Hans de Goede <hdegoede@redhat.com>,
 Janani Sankara Babu <jananis37@gmail.com>, linux-kernel@vger.kernel.org,
 Ivan Safonov <insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Custom AES decrypt implementation replaced with lib80211 library.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/Kconfig             |   1 +
 drivers/staging/rtl8188eu/core/rtw_security.c | 266 +++++---------------------
 2 files changed, 51 insertions(+), 216 deletions(-)

diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index d787a091d3c1..ff7832798a77 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -6,6 +6,7 @@ config R8188EU
 	select WEXT_PRIV
 	select LIB80211
 	select LIB80211_CRYPT_WEP
+	select LIB80211_CRYPT_CCMP
 	---help---
 	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
 	If built as a module, it will be called r8188eu.
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 72da86fdd264..68e2c6790ee6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -1275,217 +1275,24 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		return res;
 }
 
-static int aes_decipher(u8 *key, uint	hdrlen,
-			u8 *pframe, uint plen)
+u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 {
-	static u8	message[MAX_MSG_SIZE];
-	uint	qc_exists, a4_exists, i, j, payload_remainder,
-			num_blocks, payload_index;
-	int res = _SUCCESS;
-
-	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
-
-	/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
-	u8 mic[8];
-
-/*	uint	offset = 0; */
-	uint	frtype  = GetFrameType(pframe);
-	uint	frsubtype  = GetFrameSubType(pframe);
-	frsubtype >>= 4;
-
-	memset(mic_iv, 0, 16);
-	memset(mic_header1, 0, 16);
-	memset(mic_header2, 0, 16);
-	memset(ctr_preload, 0, 16);
-	memset(chain_buffer, 0, 16);
-	memset(aes_out, 0, 16);
-	memset(padded_buffer, 0, 16);
-
-	/* start to decrypt the payload */
-
-	num_blocks = (plen-8) / 16; /* plen including llc, payload_length and mic) */
-
-	payload_remainder = (plen-8) % 16;
-
-	pn_vector[0]  = pframe[hdrlen];
-	pn_vector[1]  = pframe[hdrlen+1];
-	pn_vector[2]  = pframe[hdrlen+4];
-	pn_vector[3]  = pframe[hdrlen+5];
-	pn_vector[4]  = pframe[hdrlen+6];
-	pn_vector[5]  = pframe[hdrlen+7];
-
-	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
-		a4_exists = 0;
-	else
-		a4_exists = 1;
-
-	if ((frtype == WIFI_DATA_CFACK) || (frtype == WIFI_DATA_CFPOLL) ||
-	    (frtype == WIFI_DATA_CFACKPOLL)) {
-			qc_exists = 1;
-			if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
-				hdrlen += 2;
-	} else if ((frsubtype == 0x08) || (frsubtype == 0x09) ||
-		   (frsubtype == 0x0a) || (frsubtype == 0x0b)) {
-		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
-			hdrlen += 2;
-		qc_exists = 1;
-	} else {
-		qc_exists = 0;
-	}
-
-	/*  now, decrypt pframe with hdrlen offset and plen long */
-
-	payload_index = hdrlen + 8; /*  8 is for extiv */
-
-	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i+1);
-
-		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
-
-		for (j = 0; j < 16; j++)
-			pframe[payload_index++] = chain_buffer[j];
-	}
-
-	if (payload_remainder > 0) {    /* If there is a short final block, then pad it,*/
-					/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks+1);
-
-		for (j = 0; j < 16; j++)
-			padded_buffer[j] = 0x00;
-		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = pframe[payload_index+j];
-		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
-		for (j = 0; j < payload_remainder; j++)
-			pframe[payload_index++] = chain_buffer[j];
-	}
-
-	/* start to calculate the mic */
-	if ((hdrlen+plen+8) <= MAX_MSG_SIZE)
-		memcpy(message, pframe, (hdrlen + plen+8)); /* 8 is for ext iv len */
-
-	pn_vector[0] = pframe[hdrlen];
-	pn_vector[1] = pframe[hdrlen+1];
-	pn_vector[2] = pframe[hdrlen+4];
-	pn_vector[3] = pframe[hdrlen+5];
-	pn_vector[4] = pframe[hdrlen+6];
-	pn_vector[5] = pframe[hdrlen+7];
-	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen-8, pn_vector);
-
-	construct_mic_header1(mic_header1, hdrlen, message);
-	construct_mic_header2(mic_header2, message, a4_exists, qc_exists);
-
-	payload_remainder = (plen-8) % 16;
-	num_blocks = (plen-8) / 16;
-
-	/* Find start of payload */
-	payload_index = hdrlen + 8;
-
-	/* Calculate MIC */
-	aes128k128d(key, mic_iv, aes_out);
-	bitwise_xor(aes_out, mic_header1, chain_buffer);
-	aes128k128d(key, chain_buffer, aes_out);
-	bitwise_xor(aes_out, mic_header2, chain_buffer);
-	aes128k128d(key, chain_buffer, aes_out);
-
-	for (i = 0; i < num_blocks; i++) {
-		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
-
-		payload_index += 16;
-		aes128k128d(key, chain_buffer, aes_out);
-	}
-
-	/* Add on the final payload block if it needs padding */
-	if (payload_remainder > 0) {
-		for (j = 0; j < 16; j++)
-			padded_buffer[j] = 0x00;
-		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = message[payload_index++];
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
-		aes128k128d(key, chain_buffer, aes_out);
-	}
-
-	for (j = 0 ; j < 8; j++)
-		mic[j] = aes_out[j];
-
-	/* Insert MIC into payload */
-	for (j = 0; j < 8; j++)
-		message[payload_index+j] = mic[j];
-
-	payload_index = hdrlen + 8;
-	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i+1);
-		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
-		for (j = 0; j < 16; j++)
-			message[payload_index++] = chain_buffer[j];
-	}
-
-	if (payload_remainder > 0) { /* If there is a short final block, then pad it,*/
-		/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, num_blocks+1);
-
-		for (j = 0; j < 16; j++)
-			padded_buffer[j] = 0x00;
-		for (j = 0; j < payload_remainder; j++)
-			padded_buffer[j] = message[payload_index+j];
-		aes128k128d(key, ctr_preload, aes_out);
-		bitwise_xor(aes_out, padded_buffer, chain_buffer);
-		for (j = 0; j < payload_remainder; j++)
-			message[payload_index++] = chain_buffer[j];
-	}
-
-	/* Encrypt the MIC */
-	construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, 0);
-
-	for (j = 0; j < 16; j++)
-		padded_buffer[j] = 0x00;
-	for (j = 0; j < 8; j++)
-		padded_buffer[j] = message[j+hdrlen+8+plen-8];
-
-	aes128k128d(key, ctr_preload, aes_out);
-	bitwise_xor(aes_out, padded_buffer, chain_buffer);
-	for (j = 0; j < 8; j++)
-		message[payload_index++] = chain_buffer[j];
-
-	/* compare the mic */
-	for (i = 0; i < 8; i++) {
-		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
-				 ("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				 i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]));
-			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
-				i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]);
-			res = _FAIL;
-		}
-	}
-	return res;
-}
-
-u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
-{	/*  exclude ICV */
-	/* Intermediate Buffers */
-	int		length;
-	u8	*pframe, *prwskey;	/*  *payload,*iv */
-	struct	sta_info		*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((struct recv_frame *)precvframe)->attrib;
-	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
-	u32	res = _SUCCESS;
+	struct rx_pkt_attrib *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	u32 res = _SUCCESS;
 
-	pframe = (unsigned char *)((struct recv_frame *)precvframe)->pkt->data;
 	/* 4 start to encrypt each fragment */
 	if (prxattrib->encrypt == _AES_) {
-		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
+		struct sta_info *stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
+
 		if (stainfo != NULL) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
+			int key_idx;
+			const int key_length = 16, iv_len = 8, icv_len = 8;
+			struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
+			void *crypto_private = NULL;
+			u8 *key, *pframe = skb->data;
+			struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("CCMP"), "lib80211_crypt_ccmp");
+			struct security_priv *psecuritypriv = &padapter->securitypriv;
+			char iv[8], icv[8];
 
 			if (IS_MCAST(prxattrib->ra)) {
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
@@ -1494,18 +1301,45 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 					DBG_88E("%s:rx bc/mc packets, but didn't install group key!!!!!!!!!!\n", __func__);
 					goto exit;
 				}
-				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
-				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
-					DBG_88E("not match packet_index=%d, install_index=%d\n",
-						prxattrib->key_index, psecuritypriv->dot118021XGrpKeyid);
-					res = _FAIL;
-					goto exit;
-				}
+				key_idx = psecuritypriv->dot118021XGrpKeyid;
+				key = psecuritypriv->dot118021XGrpKey[key_idx].skey;
 			} else {
-				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
+				key_idx = 0;
+				key = stainfo->dot118021x_UncstKey.skey;
 			}
-			length = ((struct recv_frame *)precvframe)->pkt->len-prxattrib->hdrlen-prxattrib->iv_len;
-			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
+
+			if (!crypto_ops) {
+				res = _FAIL;
+				goto exit_lib80211_ccmp;
+			}
+
+			memcpy(iv, pframe + prxattrib->hdrlen, iv_len);
+			memcpy(icv, pframe + skb->len - icv_len, icv_len);
+
+			crypto_private = crypto_ops->init(key_idx);
+			if (!crypto_private) {
+				res = _FAIL;
+				goto exit_lib80211_ccmp;
+			}
+			if (crypto_ops->set_key(key, key_length, NULL, crypto_private) < 0) {
+				res = _FAIL;
+				goto exit_lib80211_ccmp;
+			}
+			if (crypto_ops->decrypt_mpdu(skb, prxattrib->hdrlen, crypto_private)) {
+				res = _FAIL;
+				goto exit_lib80211_ccmp;
+			}
+
+			memmove(pframe, pframe + iv_len, prxattrib->hdrlen);
+			skb_push(skb, iv_len);
+			skb_put(skb, icv_len);
+
+			memcpy(pframe + prxattrib->hdrlen, iv, iv_len);
+			memcpy(pframe + skb->len - icv_len, icv, icv_len);
+
+exit_lib80211_ccmp:
+			if (crypto_ops && crypto_private)
+				crypto_ops->deinit(crypto_private);
 		} else {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
