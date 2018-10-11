Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD70C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVlOPpEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76A420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJLD0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41617 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeJLD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so9406824edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xspxyxKTL53e9OrjNjf5VcnOjFAUYyIF7SS06WJZQCA=;
        b=YVlOPpEmJ5wNF0ObYwwOTA9YLvyWL+GnvQ4beL7qcOR1CiIKKjA7Gr1mIEw+pCRZLB
         0veK4xh+1ip8a3gtdXW8M6sIX4Q++LrsPK/mAJZJk/K5TXR2KsFS+IKcXuE8hGRRHekg
         vIImi1ExqQn1HGF5Onij9bYX6Wr8tH+zoJ5JVfij5LneAQ8iuUxP5DMdOEf7RNDDaD3d
         koIkH9ZIR7DLz84rwIJT/7DMmrAKmTZXmVFWwLsHdES4W4gktd/aHtpfgj6k9rC5rw1I
         rbdeIsHDK4I72aiduXyf2TXKlJ9ZXziVXFUoZr8NycYy/HUbyT7hzTz6BHsXaXFMCLUI
         KDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xspxyxKTL53e9OrjNjf5VcnOjFAUYyIF7SS06WJZQCA=;
        b=QPKJc5QklMr9/hMu01bjP3rFzwB1aZLIF7sNz3t/U6/nNE3bt2jvCx6AamqZZ4mCLM
         fKu9FEa8KMd0tisoopefEaDQxIins7DG89j0ZIl+I7RgHDqSm8HmsxmtBmJdU6bPGYGZ
         kSumo0YYek1gD2At7O9BV1wC7jT10snVAyPsH8JdpP5O15lcuc0IZJG5va+hBY/4pb+m
         wp6rsmkNguQpM6QI2BAqr1Bbs2tsu/fi9aOXxJyYGy2wuWwMb+HNKyCixiRvJQU9Ythy
         pp7ML+rJySvRH7+Ajlny1YI2dsVE0U5Vvaw4gTtn8UmEl7Lh1Nae+SlbbGKrtMbB0Hrw
         bocA==
X-Gm-Message-State: ABuFfoi4IUsg3p1C5Syo2G/CH9EKN4jAlDQzlgQjfvuborC6Jo+BiN7H
        1+JjSHaohE1yO21SW1kuw45qTZ/Y
X-Google-Smtp-Source: ACcGV611LoSUqab59KN7GcTgAjVdDLuDXDM3Z987D1TCcaUQ1qIIKsOOq8DXJdjorLKytp1eg2E5/w==
X-Received: by 2002:a50:9136:: with SMTP id e51-v6mr4992364eda.142.1539287850981;
        Thu, 11 Oct 2018 12:57:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: cleanup long lines in rtw_get_sta_pending()
Date:   Thu, 11 Oct 2018 21:57:10 +0200
Message-Id: <20181011195712.1472-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line break lines over 80 characters in rtw_get_sta_pending() to
clear checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 55ce9e67d1c7..53325599ed96 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1426,7 +1426,8 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 	return pxmitframe;
 }
 
-struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *psta, int up, u8 *ac)
+struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
+				     struct sta_info *psta, int up, u8 *ac)
 {
 	struct tx_servq *ptxservq;
 
@@ -1435,26 +1436,30 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	case 2:
 		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*(ac) = 3;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s : BK\n", __func__));
+		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
+			 ("%s : BK\n", __func__));
 		break;
 	case 4:
 	case 5:
 		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*(ac) = 1;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s : VI\n", __func__));
+		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
+			 ("%s : VI\n", __func__));
 		break;
 	case 6:
 	case 7:
 		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*(ac) = 0;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s : VO\n", __func__));
+		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
+			 ("%s : VO\n", __func__));
 		break;
 	case 0:
 	case 3:
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s : BE\n", __func__));
+		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
+			 ("%s : BE\n", __func__));
 	break;
 	}
 
-- 
2.19.1

