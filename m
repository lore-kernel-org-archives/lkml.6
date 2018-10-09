Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7582075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoK+/us5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7582075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeJIXGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:06:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45422 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJIXGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:06:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so2361830wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7maWNprg9ZjyvWxIvMkADROmPJXaHaFcsq5hp43Lqo=;
        b=AoK+/us5i/STArSRvFCjkiWdufJvLzMs65Ng0Cn/GykgY9I4tXh16mw74mC7TmG+FL
         EX0r4kLYfbNyLDV7N7YBoQrCwUSQpB//u47re5H6TC5v43ow/DUvnlgTZiXFd1hVkuIj
         ljO2a7pTBfR8t0Bg9ek3R53JO4RDUUZbfE0L+N9a4WaUqOR1grAtFCIWfN6/XFwtRFOQ
         H+jItbgifxJdIS43qv5uHuZGXJM3V+Zovv1xED666E2jdbhr0i0sksuOzhqZW2RKykAj
         uI4qZrDDeE4VYbwaMO2QWiWQIXpvJOinoAtaoPPXAbC88QuxO3o1+1dEovDsWjYfYFz9
         Gk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7maWNprg9ZjyvWxIvMkADROmPJXaHaFcsq5hp43Lqo=;
        b=fYpvSK1P/cZfPEA93ZPsOh6xgRLOQ2GBF3OsfbQ6T28LWMmZNerSKWxMzIVgeI7ao3
         DOYU39nPyUYyWh6guuA5N+F4D6BYNVEcZ22irOEgn6VXSdt6rv6WN0B3T++BGqT9UP8w
         +MaKywqyxt5PGjbNoEjvKXbLwCA5g8SJqHpuSNlRzJMRA/Ez+nbdn7oHSYrkrQNFK+60
         /BrldTy3/bjE3pA0WMFewSBzZvIC4ibzJqqYSb+aAhlEQGQZVMcNF8gZyULeK+t4YqJq
         hKmfRaC8cXZOIf/ZO1GdTZ81iiJUR6hXAR4kTYcZiurhxrs4EYs3zvrpM1jEwBXLWcc3
         Iadw==
X-Gm-Message-State: ABuFfogyuvpOhe42wk5mbXUAZMOIfcVXP1LhvREYKRFUHwlOpkjIo3lY
        dFHsPrIYTWR8jkdWYEQ0xtJypLay
X-Google-Smtp-Source: ACcGV63X6HwFdkyUnLJ2c/iiCUJmO6RmuZ6L3OdVWdruN5ErctqxHEE4r6Q267glAp2gKwbuEO5/Pg==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr19761226wro.39.1539100149721;
        Tue, 09 Oct 2018 08:49:09 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa83.dynamic.kabel-deutschland.de. [31.18.250.131])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10907338wmd.11.2018.10.09.08.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:49:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove whitespace - style
Date:   Tue,  9 Oct 2018 17:48:54 +0200
Message-Id: <20181009154854.9054-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009154854.9054-1-straube.linux@gmail.com>
References: <20181009154854.9054-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove extra spaces where
appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index f5041e642bd2..d93be3ca2960 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -50,7 +50,7 @@ void rtw_os_xmit_resource_free(struct xmit_buf *pxmitbuf)
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
-	u16	queue;
+	u16 queue;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	queue = skb_get_queue_mapping(pkt);
@@ -94,7 +94,7 @@ static void rtw_check_xmit_resource(struct adapter *padapter,
 				    struct sk_buff *pkt)
 {
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	u16	queue;
+	u16 queue;
 
 	queue = skb_get_queue_mapping(pkt);
 	if (padapter->registrypriv.wifi_spec) {
@@ -111,12 +111,12 @@ static void rtw_check_xmit_resource(struct adapter *padapter,
 
 static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 {
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct list_head *phead, *plist;
 	struct sk_buff *newskb;
 	struct sta_info *psta = NULL;
-	s32	res;
+	s32 res;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -128,7 +128,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 
 		plist = plist->next;
 
-		/* avoid   come from STA1 and send back STA1 */
+		/* avoid come from STA1 and send back STA1 */
 		if (!memcmp(psta->hwaddr, &skb->data[6], 6))
 			continue;
 
@@ -164,11 +164,11 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	return true;
 }
 
-int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
+int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	s32 res = 0;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
-- 
2.19.1

