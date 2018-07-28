Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC610C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DB720862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4dRyfCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DB720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeG1P4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:56:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51642 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbeG1P4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:56:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so8300598wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AkKzCwAJCXEloxNAxxp52pseDpk+FbAr4AIGLAmRvKs=;
        b=i4dRyfCY7y0wqsbAyN5mL+c54UMovRXwOzGtEJ0Dz1Y13/9YmeCSWfsCJT7avtdwV9
         uBXsXu/z+I33MTH72mcvhpAOv4HOcewGk86HLHfRKF9R+wLusEZR95GYJmRkDdERzS/b
         jEaWd6J89C5aRUr7/BNQHslqG2AGVxBnPSGMKe75Qbttt8sIs49+U5PZM9b4DeoBkdSY
         sjjMyHz3nnKJpGKnmjWBFuoUlBe077O4MovhlUEtS3T4O5I2RTQonG9Mwd+Ltw2HFKLc
         AB15eEkP9iCiyUmfOtMnq1cIMExoSsQj94w0YBzOQEiRUyEuxxtkjuDZA2e7oz0y8kCp
         6ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AkKzCwAJCXEloxNAxxp52pseDpk+FbAr4AIGLAmRvKs=;
        b=N8DMcgZg5uUXCRfqR8gi6QhQ8zZOfQxpdi9Q3A6MTbcbqLGefWeeExIsPyw18+LG5w
         hc4epoB6DOvEWBhnVSXHZ+hhpV/tzdaDa3fM8D0J+toz+XNxEnrS0PsnZyPK2fJhpfvZ
         ZKUavvG5UKE0suMAW21CmuqqF/dWHlNco2/O2mM5t4XFzj+rxHjGeNTE5IYvtcGTUJqa
         9t8HF/MuGl1yBvol8rgXWk8DvPzUYDdt+EkzTaWu0Cwda54Pn7qzbgofvzmSacu7tNoX
         WIKLmi3E9e4rtWoC11bhcMQKX6zqCjp0NIYuBE+vz/2vS2xt/pyfEP+4Sg6yBo+Lfd62
         lXCw==
X-Gm-Message-State: AOUpUlGyvl0z7cl7uhc4N9dCbR9gx6FCkrvZrlS/iYPyGubRyuvUz7yg
        3dSvhC+kf4H9BLKj54C4mv8n+lL6
X-Google-Smtp-Source: AAOMgpdkgK40Mr76VvJT4iwVme1FSK1Y9GhGnRdcpSEFJKdvffv90tLrVhtjdJHwqOtjMa8NqKpGfw==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr8060462wma.128.1532788170988;
        Sat, 28 Jul 2018 07:29:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z8-v6sm13187019wrp.54.2018.07.28.07.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 07:29:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: fix comparsions to NULL - coding style
Date:   Sat, 28 Jul 2018 16:29:15 +0200
Message-Id: <20180728142917.1439-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use !x instead of x == NULL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 89843201a338..03b65e9b067a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -70,7 +70,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
-	if (pxmitpriv->pallocated_frame_buf  == NULL) {
+	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
 		res = _FAIL;
@@ -108,7 +108,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
-	if (pxmitpriv->pallocated_xmitbuf  == NULL) {
+	if (!pxmitpriv->pallocated_xmitbuf) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
 		res = _FAIL;
 		goto exit;
@@ -149,7 +149,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
-	if (pxmitpriv->pallocated_xmit_extbuf  == NULL) {
+	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
@@ -210,7 +210,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-	if (pxmitpriv->pxmit_frame_buf == NULL)
+	if (!pxmitpriv->pxmit_frame_buf)
 		return;
 
 	for (i = 0; i < NR_XMITFRAME; i++) {
@@ -941,7 +941,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	if (!psta)
 		return _FAIL;
 
-	if (pxmitframe->buf_addr == NULL) {
+	if (!pxmitframe->buf_addr) {
 		DBG_88E("==> %s buf_addr == NULL\n", __func__);
 		return _FAIL;
 	}
-- 
2.18.0

