Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F235C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650524ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApSHYUuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1650524ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeF3RY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:24:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40120 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeF3RYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:24:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id a6-v6so9626899ljj.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Dgxudz0a1pzLwUtbKyQJYZ0oHiDFzvD9573v6zEkwEw=;
        b=ApSHYUuGM3YJnFoNj6N6l3XrsNRwbLXQ0bcXHy8EanCOIp4VvkZ2ihyvuBzM8wWnUa
         uIazQ5o/0LpaiLrIMNhmDbgTvUkhZ1jRXg2W2ayyCAStp/QO+07IFDFGNWFjS/XnuEfL
         hKSCmQwrHdhJt98uZ0X6JtnIJVb4/whRJY7wV/zBYtf5Kpy1pyzQuRjL/A9kRlyKck4e
         IwgrTCOrnpe0DVOJ3h6ywEjqDpBvolZaEmQguNGlFc1r2IpRdFQJcRKfPUXiiDvhv+F8
         StXnW+kB2WRFOyxBkT45q4hEg7U1jcJ5xzC6dlOKin0J+y4u0+M/1WTNUS9HiGOs3A71
         uJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Dgxudz0a1pzLwUtbKyQJYZ0oHiDFzvD9573v6zEkwEw=;
        b=Np1RLRwM5z9XcsABTGHzCk22Kd5uC2mPwzMoYCm3+O+m//oR2KOtY1ztDvO74qVhVm
         YnGJmCF6nOa0t0BDxo95iwDnQ/6ny1YKMc9nEL2cg2wgYtchotu7aLnPz3OkiUXnkjaK
         xTLhWy4qtL8abObO0plJCNS0VEHGetkx+bmYVzvQCzNeuRMBOU4gl5+tV03W1D8Sexzx
         C34qayyIAXwc4C56iWu+h+YHnKiYbqqkGBdw6GwCVg0n0GxR3cioN+3+p65CDFG4PCX6
         KwpXuvIuGSe+pbNEDVRr/kZ4t8RfpH9hkhnNSol+0khTsEdoERFoX8f6PsQYhezj9ag4
         evCg==
X-Gm-Message-State: APt69E0DB7GEt/GAJTpVwi9Rgl93VisOLN4WSPSx81oz1y6kZkJFeK78
        /HI5benP7oSoDO0rLjL+Rjc=
X-Google-Smtp-Source: AAOMgpdDXPWnaspnz7EDJnlldadUFXbxkoX4behv/Hvyvq+BAWcjKtObcAzsy7+R9U2t1q6bzYbNkA==
X-Received: by 2002:a2e:5f89:: with SMTP id x9-v6mr5696447lje.16.1530379461480;
        Sat, 30 Jun 2018 10:24:21 -0700 (PDT)
Received: from alpha (92-100-183-173.dynamic.avangarddsl.ru. [92.100.183.173])
        by smtp.gmail.com with ESMTPSA id k202-v6sm2208130lfg.15.2018.06.30.10.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 10:24:20 -0700 (PDT)
Received: (nullmailer pid 1236 invoked by uid 1000);
        Sat, 30 Jun 2018 17:25:29 -0000
Date:   Sat, 30 Jun 2018 20:25:29 +0300
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging:r8188eu: Use lib80211 to encrypt (WEP) tx frames
Message-ID: <20180630172529.GA1232@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put data to skb, decrypt with lib80211_crypt_wep, and place back to tx buffer.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
v2:
  - refactor error handling,
v3:
  - fix commit message.

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

