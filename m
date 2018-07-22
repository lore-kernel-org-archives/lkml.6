Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704FECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA7820858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZToEPfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbeGVXJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGVXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so16021139wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oRa7QfQJMBnK8LyLZqGD4aNRcfC46sUD6JqoJueoew=;
        b=hZToEPfqv3Cybq+80ZR3fT3XVkeExYe4xpw37vmHQkluRsRC8cvnU/4F5NTPFJh5Wp
         iMT/WO3XMBJBqGaoX6Ra6EaLzXBYLPdZHr4SR8GZ9JHfdkUDYE+cyCx0m6lEheRJ49+t
         gMW0cKudrmtGlQ3A2J32hJ7Kzov87bdoMjWE9WDERgNZEl3nDyLN7430XyYtva4cBcCW
         hstRTBarCCigD88uX0wqSjVf9CSV4uFUrX5NHDpeQfpowkPWCYxtv6zBHSWGPkDh6XSV
         L3OQXLXBOS6s2Smc53X9zMnBUJEsbE1GrQbDAqPJOEX1/DL6eo3JHj1LVmTniXgSt0aB
         pRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oRa7QfQJMBnK8LyLZqGD4aNRcfC46sUD6JqoJueoew=;
        b=TCu9AnaEcostLL3YALU4sYJ7hGtLOOTYI/BJaK1xMvsRZGfiUO3EE1g8ojUDSexogU
         XlVmJaed/Wu2MdybAoivOKHThNViYClLzfkB7vb8Exi34K0qlc8u3LFf7wdJziMayjA8
         1Z1K33bobVGWEixr4Qp5pLqrU/qrGN79Dd22EYXiwKHET9gbNQgdhsgxDa3FNawDV4JZ
         43HYeGcxKAYGZR3dSuJzy1/tYLG2Hf4lL0tCwlLpo65AjTrypI8vztCfKbec4VTB2fRG
         8uOFF4LykDp64t5G3tQf/pxlmfOO0uBnjxHNHyubBVcPX7Q6pjVDajgvDQbuAveN56qp
         oJ2g==
X-Gm-Message-State: AOUpUlGx2ez/TSShkcXLiB7LKJqYYoG7T4rDnBMwihIH9+XI4yWWy03k
        V7SKmTQyNfXNETS81QonScrQkMCpSEs=
X-Google-Smtp-Source: AAOMgpdkwMY7R7M3LQA41giU0EYAut7OFc/zRbzdltIkHEV9xJU//xA41j7G/7Be0abEu9Ha9gKKAQ==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr6559752wrh.235.1532297458231;
        Sun, 22 Jul 2018 15:10:58 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/20] staging:rtl8192u: Remove unused Zebra1 definitions - Style
Date:   Sun, 22 Jul 2018 23:10:22 +0100
Message-Id: <20180722221035.14453-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'Zebra1' definitions. These definitions fail the checkpatch
CamelCase test, rather then rename, these unused definitions have simply
been removed. This is a coding style change which should have not impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 661df18867dd..73944a9f9622 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -99,16 +99,7 @@
 /* RF
  * Zebra1
  */
-#define rZebra1_HSSIEnable		0x0
-#define rZebra1_TRxEnable1		0x1
-#define rZebra1_TRxEnable2		0x2
-#define rZebra1_AGC				0x4
-#define rZebra1_ChargePump		0x5
 #define rZebra1_Channel				0x7
-#define rZebra1_TxGain				0x8
-#define rZebra1_TxLPF				0x9
-#define rZebra1_RxLPF				0xb
-#define rZebra1_RxHPFCorner		0xc
 
 /* Zebra4 */
 #define rGlobalCtrl				0
-- 
2.18.0

