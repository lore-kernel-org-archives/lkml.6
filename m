Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C6AC67814
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FBC2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYTpKY9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FBC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJLD0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41620 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeJLD0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so9406860edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uz47QKap7fTe4B17ffo4p78Wqr2pvRLMsorQ/YGWs+U=;
        b=mYTpKY9YPGh8ezXNs1baAf2fN6qH1pZT0KD7BfvZhU4OEXjnBlq3PLAMilY0jNoWbt
         YJDNgZOB17rmd1cLxbB5+fuiMguWrrwB8EP+8OOmwrm10c8c6soCz41j6Ci069A6N2+l
         0baGTm8M0BnjzOFQ1i8u4DVSbVNnfe5F8XeUUXHtvMdfWlN3SISc3ROwgJxtjS6Q0zyR
         ACPrp72G+wQECJn2rPFVXwDInOKILcy0F2TD5CoFpqniycrw853UsjBnwLbjS9EJQyo8
         ZlWlgREEIF4ypPDLhF5v3TVov48D6lsEmgbMYeFBJHpA6uq3IYs1dyRHkDrt7ifyFjGJ
         98Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uz47QKap7fTe4B17ffo4p78Wqr2pvRLMsorQ/YGWs+U=;
        b=O9Fd3l4QNzClqnftM82G7M2ZBwJcYul7r4ymOsKwJSHHjGhnslt/r+YgQIMsLMlZNq
         zKqhNMmo6r3HsqTBD8QBZfyJvkW+qbQpCBgLbciIa6N6dNFgz334BUINsScxBoB3E0dR
         XM0UEgCKPZX0IrMMjN7TdyNxQQqvSWaYXJ0IXGg+Hd1ThmLrffDeUS9D4WHyZlgdK8FQ
         SFC17HYdvVEYcTqQ9c4N1vTkNi2VoH9GmNEyI4fqkk62si+Wp9fgL/IDjxL2exO+/jkw
         bblhcQSidH+5LDTQ22zvYRuyxf1K4LuxD33LZEi9YFfp18bd2r5vSUaQMVJLg8uZnbzp
         Ib+A==
X-Gm-Message-State: ABuFfogQ0SV+RshDT5g0ijXsFsrzp8y8GMqgzJ6d3x3T8SubKaeklAPR
        WGAq7HA54ibZ6MVBjNXn3b0=
X-Google-Smtp-Source: ACcGV63/zJfcsEaj9i6DmLnQnXByTa4eMZ1Xvu89oK+xXhtTgaTWeoSI4uNFXS4JZJs9g37/P1ZuVw==
X-Received: by 2002:a17:906:4f98:: with SMTP id o24-v6mr3945279eju.237.1539287851743;
        Thu, 11 Oct 2018 12:57:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: cleanup long lines in stop_sta_xmit()
Date:   Thu, 11 Oct 2018 21:57:11 +0200
Message-Id: <20181011195712.1472-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line break lines over 80 characters in stop_sta_xmit() to
clear checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 53325599ed96..f0dde8aa853d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1775,21 +1775,26 @@ void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	pstapriv->sta_dz_bitmap |= BIT(psta->aid);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vo_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta,
+					     &pstaxmitpriv->vo_q.sta_pending);
 	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vi_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta,
+					     &pstaxmitpriv->vi_q.sta_pending);
 	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->be_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta,
+					     &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->bk_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta,
+					     &pstaxmitpriv->bk_q.sta_pending);
 	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
 	/* for BC/MC Frames */
 	pstaxmitpriv = &psta_bmc->sta_xmitpriv;
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc, &pstaxmitpriv->be_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc,
+					     &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
-- 
2.19.1

