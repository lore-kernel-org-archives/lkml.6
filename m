Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D093C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AE8257C7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOLEZ1F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AE8257C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeF3PBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:01:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35723 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF3PA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:00:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so8855306lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MgmXZd4CSrMx6QIOZN8cqiOdW928jtMDMWvjOA25NsQ=;
        b=YOLEZ1F87uXhQ37+6ngcbv0VgVeh7oHH80fUcmiLma7ouSJEIz4bLhxN9RmlH5vfHc
         GrO1fHHjmAYZKlJYXi/8dzK6zKTb5+z0CI4+QkHoQqqA4N3M8vKyS9NNLNtlTpPdwbGz
         3A0aia6Z00JFLxJpp8Gz3OP+17kcUVdkek49a8KJS0LXhOcsa32lvPnOX399ojfLBiqH
         Omd5ZcfO+JunYWfRpxCI2XOwmRIbcyElScUTrOJ0VrfZqN2rpR/vGGv+S6Gkl3R5Ral3
         /wnviiaJedgiO7vVIcaigVo71Uj0fQ//eu8lkVt23NhFXfMVpMzZLwLDJyDLIyvNpV7P
         3+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MgmXZd4CSrMx6QIOZN8cqiOdW928jtMDMWvjOA25NsQ=;
        b=nU2mWjXSs0fJSdKS65kA4ZnJyTexC932zftYt6vB0CBqKZkma7/de+AhcT6a7nkrgz
         j5B6+I6sNpDgvn9HJ2YlN0NJdG5Vr7dH74xrtiwTagJO+3YSnqtfqh3qMFB4V7AqVOoz
         N9PUHtas9eLEVWNRBeu1sGO09Lwkf38o1aP99Hgqs2YM8QwiKAiktBOjAeyCTB/5wZ/W
         oF6rIVFv+oytxF8P/PcxafX+EtflZjWhcK4I7k2+EYK4AdGnRfymBOHTZcblHIcD38iT
         xTgwN2pyIQqH3gGc1Gcw+PpKUENLRBGnk4dY8apkzvH63+puoLMYfqoZ4v6GzZYhsisY
         wssQ==
X-Gm-Message-State: APt69E0f4U6ukvPOR412BaLuRQud0VF7TyHeddeooB94dD5ezJN/LSwc
        jajG3JFJGMe07Suw2CifeJI=
X-Google-Smtp-Source: AAOMgpcDbpXrNKMHlaVv8fP79y4WZcrd3xPZz+IhUT0Tn3oXba6D8gARoBsr/YFM7SbNv53aEBud2w==
X-Received: by 2002:a19:2194:: with SMTP id h142-v6mr12799760lfh.75.1530370856450;
        Sat, 30 Jun 2018 08:00:56 -0700 (PDT)
Received: from alpha (92-100-183-173.dynamic.avangarddsl.ru. [92.100.183.173])
        by smtp.gmail.com with ESMTPSA id q63-v6sm2224296lfe.97.2018.06.30.08.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 08:00:55 -0700 (PDT)
Received: (nullmailer pid 32584 invoked by uid 1000);
        Sat, 30 Jun 2018 15:02:04 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH v2] staging:r8188eu: Use lib80211 to encrypt (WEP) tx frames
Date:   Sat, 30 Jun 2018 18:01:23 +0300
Message-Id: <20180630150123.32539-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put data to skb, decrypt with lib80211_crypt_wep, and place back to tx buffer.

---
v2:
  - refactor error handling.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 82 +++++++++++++++------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 5b8d7288a4e7..a01290467c64 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -131,60 +131,72 @@ static __le32 getcrc32(u8 *buf, int len)
 	Need to consider the fragment  situation
 */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
-{	/*  exclude ICV */
-
-	unsigned char	crc[4];
-	struct arc4context	 mycontext;
-
+{
 	int	curfragnum, length;
-	u32	keylength;
-
-	u8	*pframe, *payload, *iv;    /* wepkey */
-	u8	wepkey[16];
-	u8   hw_hdr_offset = 0;
+	u8 *pframe;
+	u8 hw_hdr_offset = 0;
 	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
-
+	const int keyindex = psecuritypriv->dot11PrivacyKeyIndex;
+	void *crypto_private;
+	struct sk_buff *skb;
+	struct lib80211_crypto_ops *crypto_ops;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
 		return;
 
+	if ((pattrib->encrypt != _WEP40_) && (pattrib->encrypt != _WEP104_))
+		return;
+
 	hw_hdr_offset = TXDESC_SIZE +
 		 (((struct xmit_frame *)pxmitframe)->pkt_offset * PACKET_OFFSET_SZ);
 
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 
-	/* start to encrypt each fragment */
-	if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
-		keylength = psecuritypriv->dot11DefKeylen[psecuritypriv->dot11PrivacyKeyIndex];
+	crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
 
-		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-			iv = pframe+pattrib->hdrlen;
-			memcpy(&wepkey[0], iv, 3);
-			memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength);
-			payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+	if (!crypto_ops)
+		return;
 
-			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
-				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
+	crypto_private = crypto_ops->init(keyindex);
+	if (!crypto_private)
+		return;
 
-				*((__le32 *)crc) = getcrc32(payload, length);
+	if (crypto_ops->set_key(psecuritypriv->dot11DefKey[keyindex].skey,
+				psecuritypriv->dot11DefKeylen[keyindex], NULL, crypto_private) < 0)
+		goto free_crypto_private;
 
-				arcfour_init(&mycontext, wepkey, 3+keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
-			} else {
-				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = getcrc32(payload, length);
-				arcfour_init(&mycontext, wepkey, 3+keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
-
-				pframe += pxmitpriv->frag_len;
-				pframe = (u8 *)round_up((size_t)(pframe), 4);
-			}
+	for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
+		if (curfragnum + 1 == pattrib->nr_frags)
+			length = pattrib->last_txcmdsz;
+		else
+			length = pxmitpriv->frag_len;
+		skb = dev_alloc_skb(length);
+		if (!skb)
+			goto free_crypto_private;
+
+		skb_put_data(skb, pframe, length);
+
+		memmove(skb->data + 4, skb->data, pattrib->hdrlen);
+		skb_pull(skb, 4);
+		skb_trim(skb, skb->len - 4);
+
+		if (crypto_ops->encrypt_mpdu(skb, pattrib->hdrlen, crypto_private)) {
+			kfree_skb(skb);
+			goto free_crypto_private;
 		}
+
+		memcpy(pframe, skb->data, skb->len);
+
+		pframe += skb->len;
+		pframe = (u8 *)round_up((size_t)(pframe), 4);
+
+		kfree_skb(skb);
 	}
+
+free_crypto_private:
+	crypto_ops->deinit(crypto_private);
 }
 
 int rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
-- 
2.16.4

