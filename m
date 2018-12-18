Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6722CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39026218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8mqS271"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeLRSfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54958 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeLRSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so3667223wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxON8zptKXOMqcempXrIyV3qLHyCYl6Rvijz81oD1gE=;
        b=C8mqS271h4JYqhCE/zNS50qkBt3Apq+6aWFI+ok+8wxPc3dgw7/eFrgjEHrzmw6lsT
         RVYmXPt0tdqudnD+3AC0Owc95sQATlRlZDQSmGXpEbG33YPLT8bIbJcip8sP0OS9/NRu
         esgAaWzqCYbUxKirbahCJsV7QVbFHRVzKT4NgUZl6dxADkmyf/bSKXsYIEUf41+1p20Q
         WrHHAjprd1IoqZtV6p1Tl1uL4DYHWHGLbj7daX8HRzpojpWeqMTrv1yp+q6Ez5wsInQA
         eFhKeYwyJ1Wr3/DvRryGFXCq4qL4Y8uelAP59P8nWdIVDvVc3MuM/HFtxPCaMo4taDfh
         cFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxON8zptKXOMqcempXrIyV3qLHyCYl6Rvijz81oD1gE=;
        b=rCHKkbbpFbs07WECTWHnGBJqR6gclEZG6uVhk8czKP6wId1xeutZk2nXYwPzEj6ExR
         xgTBTvWFBJ/IcH6UKv6YaVg/TZHWcxIlEww/5OSe4xuAX4OTMEbcqtxyCr8vhwRBr0Rn
         8YzFmQFv5zFHzsHf2NQF9jiandqAx1zsufYRpJxFyg2PNZutvEwK4nNCbsXvgCM8k5em
         L0THRJzlCnxH23RdgS6ReoS5MEVnzWZd1rnVv5AbmKQpnPw9AFfOayQVvQgVNBZmqDYe
         NSK6JTmmxRPitQds6DNsEq+c7RWurgc99OhRzcIT5r2IXHFiswtlgaw9S0ZG0Le8VH2A
         9tng==
X-Gm-Message-State: AA+aEWbpO/DyrgVbvpbc8H8Rqge+v++8K24j8k8sAIgmtyK625yu/QSm
        GYRf8SiW5jFR4Nf89Y7UR1g=
X-Google-Smtp-Source: AFSGD/VynTb1OmBok5hNBqwY3FuRI7y8ikCtv4H7tldUjbD6qRx2tQ22RMdLI0AAIrH1fd/NYFaIxg==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr4153581wme.32.1545158112452;
        Tue, 18 Dec 2018 10:35:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:11 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 05/17] staging: rtl8188eu: add blank line after declarations
Date:   Tue, 18 Dec 2018 19:34:39 +0100
Message-Id: <20181218183451.18692-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line after declarations in rtw_mlme_ext.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 813f5d9e550d..beac6e9ee5dd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3592,6 +3592,7 @@ static unsigned int OnAction_back(struct adapter *padapter,
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+
 	/* check RA matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe),
 		   ETH_ALEN))/* for if1, sta/ap mode */
-- 
2.20.1

