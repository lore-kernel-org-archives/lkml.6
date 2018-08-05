Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E5C46472
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BD7218C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmPF/OTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BD7218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeHEVLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHEVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so10276438wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4wbxk/n9WK646OOk+xWHw+425xgHexLf0Sb56gT10k=;
        b=JmPF/OTYph4Akuzb5wFDJGtvf1s4CqwnVUNRUiG5pHYJ2VAPnnMRdCuR0MU7bbQuVF
         8Us9OJByp+EAEEW77LcDsVnQdl3tN+9zM1O7KOgGK10XLq9ZxsVfvI2HyY9ewUTf9+7+
         5vkWZkUukOEE/G+Wkbg453ed+QcdAIgztt3cIN1s/uN1gAqOaEi2vScZrFfwsDdkAx2N
         AQ6V+XGdAuzK6/y7F3EZRTeeHnZFp6RqKdSZXnRK0VdayJJP3sgav+/k+cxyauPyWlTl
         Xj8+ew9In2Rp6WDiNjrzhvaagvdLSGNPCDEM2fWFkSs7CKO5n4D31hhni/9v9zUGNJcL
         n6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4wbxk/n9WK646OOk+xWHw+425xgHexLf0Sb56gT10k=;
        b=YzbcWAaYn/dTNs+Dh6O4O/35tDNGdfj1vQXcrqQGvpOCW+9bgKJuEbiqYfnuVnjjGE
         XJcy2FirY4x81/P2UElXv8hAk/xHERZCjTAptzOFv4dQAEX/PrLUpKL/yVhDNprPaaeJ
         nsEcpdrdAmNSV/KSUsj3oyUVevd5DQqU6EOFEH5ZkdAL0x7R7nQel4OGaEr71r0SKeMO
         pKCA/aV894ViTLVEKOaEE5Xj6tVrRckMh3axu+t+Ixyu3wr0sjLq50NSk5WmXxRrGsZH
         2WX2Z6gMc7ynyXAjIKTAzm21xRny/3XWJWktp1a8Y0u2qJYbwP0vLQJY5jSKh+wxt0OK
         znlw==
X-Gm-Message-State: AOUpUlE0ewODK4Ha8JiE6YW3MmZONghOd94jnwCBfuwIBtGIMCZpJgEn
        CLsJ8oLyYdIHqoV3HG9lV4GPHDbO
X-Google-Smtp-Source: AAOMgpdbiHJkIYeELogorNNN8eBuyeRvOWJAtQ8KNFUC0HE4SyljvNq9egcuZ9vAyivl4+V32Rg/Sg==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr8342451wrj.212.1533495929994;
        Sun, 05 Aug 2018 12:05:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/6] staging: rtl8188eu: cleanup block comment - style
Date:   Sun,  5 Aug 2018 21:05:13 +0200
Message-Id: <20180805190516.2133-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805190516.2133-1-straube.linux@gmail.com>
References: <20180805190516.2133-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a block comment to conform with kernel coding style.
Also cleans 'line over 80 characters' checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 82fc5075e0a6..6925ec48dff1 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -43,9 +43,11 @@ static void rtl8188eu_cal_txdesc_chksum(struct tx_desc	*ptxdesc)
 	ptxdesc->txdw7 |= cpu_to_le32(0x0000ffff & checksum);
 }
 
-/*  Description: In normal chip, we should send some packet to Hw which will be used by Fw */
-/*			in FW LPS mode. The function is to fill the Tx descriptor of this packets, then */
-/*			Fw can tell Hw to send these packet derectly. */
+/*
+ * In normal chip, we should send some packet to Hw which will be used by Fw
+ * in FW LPS mode. The function is to fill the Tx descriptor of this packets,
+ * then Fw can tell Hw to send these packet derectly.
+ */
 void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u8  ispspoll, u8  is_btqosnull)
 {
 	struct tx_desc *ptxdesc;
-- 
2.18.0

