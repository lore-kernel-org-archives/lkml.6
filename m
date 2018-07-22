Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC85FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1FF20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKN1kqJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1FF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeGVXJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGVXJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so16014901wrn.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jRBymh3rB1oDz3qaI8qwpEh814xSk5mSZQ7nUhsjJfs=;
        b=AKN1kqJtRNFgPZX3TZCbSQ43J8vPMolIQ6jM+gdabtgECuuDlPkdK9O73Lz1PFa+9F
         LtjNGuTKydr77xCCgtEHL/16R+/7J2MZH+Ztnri1AqJ44vBdyBPoMA+6ZlpeIPFkabU7
         YpzBdDZyQxcOb1blvvKTTp06PqWAr5pICb+rKQ2/BjqdWP7QxLv+hYaoTeMYKfidojrp
         ufoED205NsowBj7TKRZZ0ZtYyoy9weNJJRp7mjfC/sWwFXfxpnoqyHSdDdbKNXUqm06O
         NGhRcOszfuakN0PrKQPREbuIcEpXvbpb5rWikGVKg8/wnOLSa2XCWXWHMS2txym/1/QA
         s7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jRBymh3rB1oDz3qaI8qwpEh814xSk5mSZQ7nUhsjJfs=;
        b=d0t2nUy/R1MBT6WTBkROcq4/uaZPjEr/DGsx5bPYzwfjw1+c3JuFAZSxNcL+19GjUb
         t1nKtCwRs4IOpTwe7xW+ZL9wdEnrooOs4vkvEZRUFRfkcOmdJJkc2GYlUm3glJrIItp3
         vsjaMFagF/hivuVIeIG+9ZrqlBlHNqFSRHgNjyt1MiAQS34Uts45gxHnUv9bqRPEmhXh
         tR9K55HHJzLBpEfBTj9Q3/MEN5xFrx1WxoB0B3fIcL3mHuw9/RzK9EL4gFT0HEVbvscu
         2qcJULBGlljM2beNaimeUrTbbAnIImTxM+RZ8yKStf43wkXhnv8uuGkbwKoqKehLOdfk
         hwUw==
X-Gm-Message-State: AOUpUlHzb5Wxp+G3fI43GHeGi+n8fIdhfpMKSNSj6nKaYYxsPfsdYt8m
        hSVQzcG7zTb4Gi+S6GeQqrfDnnuS7vI=
X-Google-Smtp-Source: AAOMgpdRwI5dMd9Yal8WQ1mgFel2hJqgU1p9ubLGgIEF9N1kNgUDhTQGqwA4ZFNCI7aSZ3bAFpWguQ==
X-Received: by 2002:adf:e34d:: with SMTP id n13-v6mr7150143wrj.158.1532297454966;
        Sun, 22 Jul 2018 15:10:54 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/20] staging:rtl8192u: Remove unused page c definitions - Style
Date:   Sun, 22 Jul 2018 23:10:20 +0100
Message-Id: <20180722221035.14453-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'page c' definitions. These definitions fail the checkpatch
CamelCase test, to save renaming, these unused definitions have simply
been removed. This is a coding style change which should not have an
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 6be63aef33f7..26d18a494fb4 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -51,10 +51,7 @@
 #define rCCK0_DebugPort				0xa28  /* debug port and Tx filter3 */
 
 /* page c */
-#define rOFDM0_LSTF				0xc00
 #define rOFDM0_TRxPathEnable		0xc04
-#define rOFDM0_TRMuxPar				0xc08
-#define rOFDM0_TRSWIsolation			0xc0c
 #define rOFDM0_XARxAFE				0xc10  /* RxIQ DC offset, Rx digital filter, DC notch filter */
 #define rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
 #define rOFDM0_XBRxAFE				0xc18
@@ -66,10 +63,6 @@
 #define rOFDM0_RxDetector1			0xc30  /* PD,BW & SBD */
 #define rOFDM0_RxDetector2			0xc34  /* SBD & Fame Sync.*/
 #define rOFDM0_RxDetector3			0xc38  /* Frame Sync.*/
-#define rOFDM0_RxDetector4			0xc3c  /* PD, SBD, Frame Sync & Short-GI */
-#define rOFDM0_RxDSP				0xc40  /* Rx Sync Path */
-#define rOFDM0_CFOandDAGC		0xc44  /* CFO & DAGC */
-#define rOFDM0_CCADropThreshold		0xc48 /* CCA Drop threshold */
 #define rOFDM0_ECCAThreshold		0xc4c /* energy CCA */
 #define rOFDM0_XAAGCCore1		0xc50
 #define rOFDM0_XAAGCCore2		0xc54
@@ -79,10 +72,6 @@
 #define rOFDM0_XCAGCCore2		0xc64
 #define rOFDM0_XDAGCCore1		0xc68
 #define rOFDM0_XDAGCCore2		0xc6c
-#define rOFDM0_AGCParameter1		0xc70
-#define rOFDM0_AGCParameter2		0xc74
-#define rOFDM0_AGCRSSITable		0xc78
-#define rOFDM0_HTSTFAGC				0xc7c
 #define rOFDM0_XATxIQImbalance		0xc80
 #define rOFDM0_XATxAFE				0xc84
 #define rOFDM0_XBTxIQImbalance		0xc88
@@ -91,16 +80,6 @@
 #define rOFDM0_XCTxAFE				0xc94
 #define rOFDM0_XDTxIQImbalance		0xc98
 #define rOFDM0_XDTxAFE				0xc9c
-#define rOFDM0_RxHPParameter		0xce0
-#define rOFDM0_TxPseudoNoiseWgt		0xce4
-#define rOFDM0_FrameSync			0xcf0
-#define rOFDM0_DFSReport			0xcf4
-#define rOFDM0_TxCoeff1				0xca4
-#define rOFDM0_TxCoeff2				0xca8
-#define rOFDM0_TxCoeff3				0xcac
-#define rOFDM0_TxCoeff4				0xcb0
-#define rOFDM0_TxCoeff5				0xcb4
-#define rOFDM0_TxCoeff6				0xcb8
 
 
 /* page d */
-- 
2.18.0

