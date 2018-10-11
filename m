Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B9DC6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF33420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFnctPF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF33420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJLD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36053 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJLD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so9427373edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHgBZZb2f4P6wK98O4mtX93dP8NF1UV8EAdgTYagCU8=;
        b=SFnctPF3V6m2iw6fPIwCxtB4ZbbwUfatTgG9nKGia3K+kGYbzcJ3P70YVw515pl0vj
         TcQrn7nl9d/3c7VBUvXjr3kGjnfoYHX/4CMRCCAdcD6Nk1q9d1MReowCl0K1YELngR7I
         Ux30ksk+NnP/Qtk5cvJl4r5krtKMUMeL1T6q4fH675N+/CQKR3LesNil9bxtEIZUlkJw
         hVDYaHXkN0SdIzUdDFcEJ/6VkpswsSonlrfaCUECkLuER6O58+coI+0kFph8V9SNyQvR
         o86mY8X1vB4SQdJxUbj778OdGLpRaepM46drbQP2e1IPlJYTz8gT9rpd57UOHDpCXcSj
         aX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHgBZZb2f4P6wK98O4mtX93dP8NF1UV8EAdgTYagCU8=;
        b=Ln5jMFcH9lVwinZigYucTJiBl3uq1R71pVUHa6VgypINFRfrq3CMbPJaHppWGS7Ww1
         pcxiKF0i+9PoXBzufBmgsnGJPeqTzY21FXWJZtTaqVe7pkzEi0v2zqe8oGsvd3TxuGa8
         ot7z9Wnprc5a1XW/SuCTJNp0zijEH3ps26xzVsrCeN1N7cA2zeFiYDvKiw8r1cms0FWM
         GP31fblQwV/ld768eClqQ0ObF8FUuPwkGvDt9rPC3Kukm67WBUZ2BU9PimLcnHCiQAa4
         k7E0W8Sw+OFRD2ZN5btT+CRQ5jCinsjtv2JbCXXDP2KGBuRg6ePIu6pVk7AINYz7ZNhg
         29qQ==
X-Gm-Message-State: ABuFfohdUsYtjaWdVVXOcIgpULqvR8SvBbfWGLZ+mqUboo4vGm5ggVeF
        kcDimI9w8aJCptXgjjYJ2/k=
X-Google-Smtp-Source: ACcGV629taGogp9cftKZ6MkxrNWpYMhZ4wWiIr7wYBFBrYftGQKdaol1tHAZaSv8Mb1eyQgYn1/x9g==
X-Received: by 2002:a17:906:40cd:: with SMTP id a13-v6mr3976534ejk.14.1539287849134;
        Thu, 11 Oct 2018 12:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: remove commented code
Date:   Thu, 11 Oct 2018 21:57:08 +0200
Message-Id: <20181011195712.1472-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused commented code in the file core/rte_xmit.c.
Clears 'please, no space before tabs' and 'line over 80
characters' checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 4a2921d8c862..9413cd21e201 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -77,8 +77,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		goto exit;
 	}
 	pxmitpriv->pxmit_frame_buf = PTR_ALIGN(pxmitpriv->pallocated_frame_buf, 4);
-	/* pxmitpriv->pxmit_frame_buf = pxmitpriv->pallocated_frame_buf + 4 - */
-	/* 						((size_t) (pxmitpriv->pallocated_frame_buf) &3); */
 
 	pxframe = (struct xmit_frame *)pxmitpriv->pxmit_frame_buf;
 
@@ -115,8 +113,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	}
 
 	pxmitpriv->pxmitbuf = PTR_ALIGN(pxmitpriv->pallocated_xmitbuf, 4);
-	/* pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 - */
-	/* 						((size_t) (pxmitpriv->pallocated_xmitbuf) &3); */
 
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 
@@ -321,13 +317,6 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 
 static void update_attrib_phy_info(struct pkt_attrib *pattrib, struct sta_info *psta)
 {
-	/*if (psta->rtsen)
-		pattrib->vcs_mode = RTS_CTS;
-	else if (psta->cts2self)
-		pattrib->vcs_mode = CTS_TO_SELF;
-	else
-		pattrib->vcs_mode = NONE_VCS;*/
-
 	pattrib->mdata = 0;
 	pattrib->eosp = 0;
 	pattrib->triggered = 0;
@@ -606,7 +595,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 	hw_hdr_offset = TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);
 
-	if (pattrib->encrypt == _TKIP_) {/* if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_PRIVACY_) */
+	if (pattrib->encrypt == _TKIP_) {
 		/* encode mic code */
 		if (stainfo) {
 			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
@@ -621,11 +610,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				/* start to calculate the mic code */
 				rtw_secmicsetkey(&micdata, psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey);
 			} else {
-				if (!memcmp(&stainfo->dot11tkiptxmickey.skey[0], null_key, 16)) {
-					/* DbgPrint("\nxmitframe_addmic:stainfo->dot11tkiptxmickey == 0\n"); */
-					/* msleep(10); */
+				if (!memcmp(&stainfo->dot11tkiptxmickey.skey[0], null_key, 16))
 					return _FAIL;
-				}
 				/* start to calculate the mic code */
 				rtw_secmicsetkey(&micdata, &stainfo->dot11tkiptxmickey.skey[0]);
 			}
@@ -1157,7 +1143,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		list_del_init(&pxmitbuf->list);
 		pxmitpriv->free_xmit_extbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
-		/* pxmitbuf->ext_tag = true; */
 		if (pxmitbuf->sctx) {
 			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
@@ -1194,8 +1179,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	struct xmit_buf *pxmitbuf;
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 
-	/* DBG_88E("+rtw_alloc_xmitbuf\n"); */
-
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irql);
 	pxmitbuf = list_first_entry_or_null(&pfree_xmitbuf_queue->queue,
 					    struct xmit_buf, list);
@@ -1286,7 +1269,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)
 		pxframe->pxmitbuf = NULL;
 
 		memset(&pxframe->attrib, 0, sizeof(struct pkt_attrib));
-		/* pxframe->attrib.psta = NULL; */
 
 		pxframe->frame_tag = DATA_FRAMETAG;
 
@@ -1360,7 +1342,6 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
 			 ("%s: drop xmit pkt for classifier fail\n", __func__));
-/* 		pxmitframe->pkt = NULL; */
 		return _FAIL;
 	}
 
-- 
2.19.1

