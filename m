Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7050EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979521545
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS5jl6L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2979521545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbeHBTKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37699 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so3418813wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Dmlu67sax7CAqxxrePaf1+hkI+XMm++rNx/gbZNK0A=;
        b=fS5jl6L/mL94kEMuZSzgQ8ACEFOHmwhNJH/h1A+W1xU6QtOJ62Ve5cJCr92j8EJChF
         i+LA9do+Er1J3lgRfWub7/iqiMnqP80DxFkwIghINoZeTJaovAxE/7JKV4cAZTrYcq0w
         G0KrbJNSSDxBEb8nZv+a1lOHNyH45HjniNV+/PONFCjhCNfMw+Uj5awVUepcjLY83Ns/
         j0jF0VP9qWZtzjJO/cbN0UYd9Rghpvp7MgRUzCp/80Agbs4bKIX/RXtbysmt3DSBiD+s
         inlP4RCxJE3261BdTIUdh1a7d9k7ujFx/blURaaFV1JXhVeevG5iIZD7HHht1Kwi4yNk
         vjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Dmlu67sax7CAqxxrePaf1+hkI+XMm++rNx/gbZNK0A=;
        b=pp7OZ7OLE5kTMiigUt8+sphXjo0yWU9E1hnf3jfoF3ZYmU224NBOoDaWwdRrJVq7HM
         Lb/unZnk/GldgJvAxXyyPZb0R9g94R2NcoJjwt2Zn5P+JjgKqV8Xs6WCuXVEJLcf+ior
         4BVYn5iN5euycG3R3qwl++vByfCfEZ567kWXutpaey3U8JGGiGqP7SWVXh/0V4mmmrYV
         VSqySAZvaB+c7N0Cgy/lwGp6ode69dDDFbqRpnUhY2xYtyeHo1t0RtT5Kkw0AupTHjN5
         m583/pR7Wjck9pZt8hHzXt9ZS2pkaPGQVIeRGGHeey7fw5wklJestSthT51jPfcxVJLJ
         yxyw==
X-Gm-Message-State: AOUpUlEVFUmR06l/4fyPk9MsvFrb8VJ6f45kGCNoVnunXD3UULYQJ5+3
        wxcatlEsh4x7JWkIQQSI2sE=
X-Google-Smtp-Source: AAOMgpfiSBwl0QVxLTjp5XsB4YzonVAk7QtSMkwAQGQEgGQ0cY9UkkT8y6QOQUiBY50n3hs5plGRpA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr2606248wmn.131.1533230327442;
        Thu, 02 Aug 2018 10:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: remove whitespace - style
Date:   Thu,  2 Aug 2018 19:18:21 +0200
Message-Id: <20180802171823.1571-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802171823.1571-1-straube.linux@gmail.com>
References: <20180802171823.1571-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 6925ec48dff1..a11bee16d070 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -15,7 +15,7 @@
 
 s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 {
-	struct xmit_priv	*pxmitpriv = &adapt->xmitpriv;
+	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
 
 	tasklet_init(&pxmitpriv->xmit_tasklet,
 		     (void(*)(unsigned long))rtl8188eu_xmit_tasklet,
@@ -30,8 +30,8 @@ static u8 urb_zero_packet_chk(struct adapter *adapt, int sz)
 
 static void rtl8188eu_cal_txdesc_chksum(struct tx_desc	*ptxdesc)
 {
-	u16	*usptr = (u16 *)ptxdesc;
-	u32 count = 16;		/*  (32 bytes / 2 bytes per XOR) => 16 times */
+	u16 *usptr = (u16 *)ptxdesc;
+	u32 count = 16; /* (32 bytes / 2 bytes per XOR) => 16 times */
 	u32 index;
 	u16 checksum = 0;
 
@@ -160,15 +160,15 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 
 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
-	uint	qsel;
+	int pull = 0;
+	uint qsel;
 	u8 data_rate, pwr_status, offset;
-	struct adapter		*adapt = pxmitframe->padapter;
-	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct adapter *adapt = pxmitframe->padapter;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct odm_dm_struct *odmpriv = &adapt->HalData->odmpriv;
-	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
-	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct tx_desc *ptxdesc = (struct tx_desc *)pmem;
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -328,7 +328,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	return pull;
 }
 
-/* for non-agg data frame or  management frame */
+/* for non-agg data frame or management frame */
 static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 {
 	s32 ret = _SUCCESS;
-- 
2.18.0

