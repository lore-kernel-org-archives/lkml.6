Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC66AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A214B218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmbmZr1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeLRSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40848 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeLRSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16959948wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK1dSSKvLtwmhP+hrPv7iJVqkVcP9XYmr6WlqCiEkdM=;
        b=mmbmZr1RrGbmmVBmfmQN5NL0SO81L566U6vtbiOrr9EXDWzBqGnYGRdHrwvMzEv4J/
         nHIS8JVk3rZO1HXOak8o1Y3M0lU/HGkwt8jFDirSVaqlXwXYji7c4EJSyFkenroYe2rI
         2pnKUqmzFOuvg68dMxAfs6qNsqgKJUEqgvS4Dkc65cWrrz2KstgOnzlMwBksMH+lxCWK
         8WKwbkd9B8fEfNrzViBdavfk0CgSO8h2LAfKk38FU1OP8M76Kr1mYb47l1QNaE/nERQ3
         JUyna7h5u3uNp25lWrYW19ZjhFxsJ5MUqC7NdoJB5QdBQe05uqn05JQnQjKkeqc9lOPT
         PHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK1dSSKvLtwmhP+hrPv7iJVqkVcP9XYmr6WlqCiEkdM=;
        b=gNIXGkdDQhoa+quRaUQQnzlexzfyVbnIuWFCSqRa5XEuQ8Oxm4e7RGZkH9aLVBL6ij
         1xJ5UKyCDjUt28aeneriKxQeStZpvk2VAFPOsc5j75ybLIFHNSQd1XE/+3S3c19Khmsa
         NdH82ydEx+bRf+JOyxLosqz1310W+yk+V77jOET3E7hIbQjU9eDjoGrpLRZbRaYINxxU
         KIdlCTvJgoEc4Q6BC8HDUrcC+Ldd//Td5zpf8+E3z47SCT17wy1Dw2+tMYYmiPjQD14W
         4V0m5UnxHULZ333v3Pglv3nBigmeYZM2ZNHmHouMvXt5XBQ+jcmpgTwkMJjpRrzBcWvw
         Utuw==
X-Gm-Message-State: AA+aEWY9U7fjJorichC84EeGwwzSRocrszZXmDf7QcUcBseiVCD4it8v
        +6Fw9KNnT5lP0io4DdW2ZYN9L1fS
X-Google-Smtp-Source: AFSGD/VhzTdjt7QTO67jOJZvzfd5UUSoKHu082Fac4c3apZKs4e9yygJsp5w4yW7RusX8HcEMPrnog==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr14739415wre.94.1545158115354;
        Tue, 18 Dec 2018 10:35:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:14 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/17] staging: rtl8188eu: remove unused arrays WFD_OUI and WMM_INFO_OUI
Date:   Tue, 18 Dec 2018 19:34:42 +0100
Message-Id: <20181218183451.18692-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays WFD_OUI and WMM_INFO_OUI are not used anywhere,
so remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    | 2 --
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index e7ffa782a387..ca818887cbc6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -26,9 +26,7 @@ unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
 unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
-unsigned char WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
 
-unsigned char WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 0ade33df16d2..62999bc06de5 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -84,10 +84,8 @@
 extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
 extern unsigned char WPS_OUI[];
-extern unsigned char WFD_OUI[];
 extern unsigned char P2P_OUI[];
 
-extern unsigned char WMM_INFO_OUI[];
 extern unsigned char WMM_PARA_OUI[];
 
 /*  Channel Plan Type. */
-- 
2.20.1

