Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0615EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD49320854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6t2H+Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD49320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbeGVXJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbeGVXJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so15997331wra.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r+FFY6MSf/QC0vqJIkXI/rueCKwtuMtzGJvUwv2JeBY=;
        b=p6t2H+Cp5WrBE4/mnY901d8a2uTtweMN+3xuusBULb5IIpWNEJipvHrVAyhMearNCb
         nGY+ZHk6V19wistx/n/Pi4gHlh4S0ulfg65ICl8gNqQRWM6/puCEU/YoD0/3a4AHRbCv
         yJyXtoVJ/jwvmi9obuQOKyD8CK3GzMPfb9sv7WapVN+hWXoy1F8fjkJBbWDw9kRkSl4s
         5a7uPkt7X5uejxGRJUKbUKZfIqaD0pX7uYJMQMBWf04VHlKiTpP72GeoWBNkpxjHNUwd
         zyzIkRF/HZDbu3mrbOlFmKmUfKyIYvojAKuTxuMIA3nYV34tYPrAKZj4MLOshvUPk7ZO
         EzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r+FFY6MSf/QC0vqJIkXI/rueCKwtuMtzGJvUwv2JeBY=;
        b=CbX2aAm4CIdD/5CZVciv57Yh1y4tkXv65g+fROja8mHodb52SKjWsBcuY0xOaD2wuH
         GcTRRz3o3tGgZpnxxhh/ON7SXjGTpDJ5SDcQpDhUK7IQgLqXEundb1fw6DeYB6Pr+qzK
         SekxVgiGuBiXrg2k4orC2d1pdLMJ/Tx5qpTqTW7Tzei8YGW7xkI/3sUQkO0gpKdbqsP5
         yyd3SZlIfF+e2+FtSdkASO6oFwS+4ZcXIbC9t7IsSm21qFRIsquIGFaJcNBtuXZ6IF9F
         X9NuLtg09ruw/+r4PLtltMU5HGOihILbBW0KGm0RnII98qk1P7nSN+Yab99ygPClFnFV
         +QOw==
X-Gm-Message-State: AOUpUlEmFDcFrugsDBugf6l41ruEjRmUg9i9qIwE4sQJT1v3z9icZfwm
        RWdOBBNk8CINjd/8wPBsQTZvPmKA8wc=
X-Google-Smtp-Source: AAOMgpfEVqleG5XCmN75XRmMPhyj05y46vNVI76GHjzmZlyXevxT53qF7hmJGrtxsjjjK9mEacJGow==
X-Received: by 2002:adf:9c91:: with SMTP id d17-v6mr6600493wre.11.1532297450188;
        Sun, 22 Jul 2018 15:10:50 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/20] staging:rtl8192u: Remove unused page 8 definitions - Style
Date:   Sun, 22 Jul 2018 23:10:17 +0100
Message-Id: <20180722221035.14453-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove page 8 definitions which are never used in code.

Many of these definitions, if not all, fail the checkpatch CamelCase
checks. To avoid the effort of renaming unused definitions they have
been removed. This is a style change which should have no impact on
runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 437f3bfcc399..b8e5fc003a5a 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -7,14 +7,7 @@
 
 /* page8 */
 #define rFPGA0_RFMOD				0x800  /* RF mode & CCK TxSC */
-#define rFPGA0_TxInfo				0x804
-#define rFPGA0_PSDFunction			0x808
 #define rFPGA0_TxGainStage			0x80c
-#define rFPGA0_RFTiming1			0x810
-#define rFPGA0_RFTiming2			0x814
-/* #define rFPGA0_XC_RFTiming			0x818
- * #define rFPGA0_XD_RFTiming			0x81c
- */
 #define rFPGA0_XA_HSSIParameter1	0x820
 #define rFPGA0_XA_HSSIParameter2	0x824
 #define rFPGA0_XB_HSSIParameter1	0x828
@@ -27,8 +20,6 @@
 #define rFPGA0_XB_LSSIParameter		0x844
 #define rFPGA0_XC_LSSIParameter		0x848
 #define rFPGA0_XD_LSSIParameter		0x84c
-#define rFPGA0_RFWakeUpParameter	0x850
-#define rFPGA0_RFSleepUpParameter	0x854
 #define rFPGA0_XAB_SwitchControl	0x858
 #define rFPGA0_XCD_SwitchControl	0x85c
 #define rFPGA0_XA_RFInterfaceOE		0x860
@@ -40,14 +31,11 @@
 #define rFPGA0_XAB_RFParameter		0x878
 #define rFPGA0_XCD_RFParameter		0x87c
 #define rFPGA0_AnalogParameter1		0x880
-#define rFPGA0_AnalogParameter2		0x884
-#define rFPGA0_AnalogParameter3		0x888
 #define rFPGA0_AnalogParameter4		0x88c
 #define rFPGA0_XA_LSSIReadBack		0x8a0
 #define rFPGA0_XB_LSSIReadBack		0x8a4
 #define rFPGA0_XC_LSSIReadBack		0x8a8
 #define rFPGA0_XD_LSSIReadBack		0x8ac
-#define rFPGA0_PSDReport			0x8b4
 #define rFPGA0_XAB_RFInterfaceRB	0x8e0
 #define rFPGA0_XCD_RFInterfaceRB	0x8e4
 
-- 
2.18.0

