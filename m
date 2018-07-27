Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEBB208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea2BrteD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEBB208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeG0RaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:30:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43345 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388156AbeG0RaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:30:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so2497450plv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GovrtAOVCB7hdXVG2gd1tnYGWA0NS17fl1VKLdAxx7g=;
        b=ea2BrteDsRBh89DbaRwlbMuexlfhhqqfHC/h/s//9gwHzRUUJRjQ0fwy0Cw1OzNeyO
         3nWlwkcuy+1gHKG07FwTXEBaPalOGiERHMSyP953cocvEBUYYdTu+59KLUTBmXcDoM3g
         QzxYdeDltBagCYSBrHZGwanscpV0x07QuptgY2ucOREzhT4o07956i+oSVcafhZcjRiO
         KSuC6U1plk7s5UOlk+sRyGEtrulkNnvDQ81R48msLmb0t3IDtWLVQJnkDsS7sL16owl2
         X0NfklCEiE/H20AycjjPQH0asOcLhdy3V2hVgEMFbTDFI8BEaeXyQSPxQI7GbY5ucID2
         bSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GovrtAOVCB7hdXVG2gd1tnYGWA0NS17fl1VKLdAxx7g=;
        b=CBWwTPnzZcUQIsdf79OHQtFsUgIyZFqgaj66q4GOdb/kIBBd9GeJiwOzIE0GUKIPNL
         xGEaOjyyKf3vHSaHozBJxJpJRd0Jj7My/MFCEJkEDVTG1bHXakfNBr1whqaGg7YYysia
         b5CHOHW+V+Ixn/kNIC4Fw/rtxlIYP1qJnFgzHDedGH1WQhP0Xob2EmB9Wv0qYLSvY8RP
         8sDK0GyX+hosDBGGvuLmXG+hoJ0fV2wPxeA92o2OmdQv/Rxw5rbZHNVTmEdmxdr7W3LX
         pnbQcAJJumElwK0INxULJBDq3jGfX+6+NIEDTOXV7Q+GOOWD8XHRRARIvKSiJKLwvbpR
         Lfaw==
X-Gm-Message-State: AOUpUlHqXy+1jBF9mGX8inoHh+BLxUKgkv9Qoh9I44mOQFCnlgM1kG5u
        h3a16ps63+rsLaI85NpOMjA=
X-Google-Smtp-Source: AAOMgpdiLWn6zlg9z3RHfCKzqpfW1LngK0SehwVnobemr8gQti8tsIfce9TXd9qyEHT3jqaeDgKxvw==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr1134870plz.30.1532707663711;
        Fri, 27 Jul 2018 09:07:43 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 137-v6sm2761055pfu.121.2018.07.27.09.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:07:43 -0700 (PDT)
Date:   Fri, 27 Jul 2018 21:37:37 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-mmc: Use BIT macro instead of explicit
 shifting in board.h
Message-ID: <20180727160733.GA10467@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit shifting with BIT macro in board.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/board.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/board.h b/drivers/staging/mt7621-mmc/board.h
index a7d82f321b00..983791ee308d 100644
--- a/drivers/staging/mt7621-mmc/board.h
+++ b/drivers/staging/mt7621-mmc/board.h
@@ -36,10 +36,10 @@
 #ifndef __ARCH_ARM_MACH_BOARD_H
 #define __ARCH_ARM_MACH_BOARD_H
 
-#define MSDC_CD_PIN_EN      (1 << 0)  /* card detection pin is wired   */
-#define MSDC_WP_PIN_EN      (1 << 1)  /* write protection pin is wired */
-#define MSDC_RST_PIN_EN     (1 << 2)  /* emmc reset pin is wired       */
-#define MSDC_REMOVABLE      (1 << 5)  /* removable slot                */
+#define MSDC_CD_PIN_EN      BIT(0)  /* card detection pin is wired   */
+#define MSDC_WP_PIN_EN      BIT(1)  /* write protection pin is wired */
+#define MSDC_RST_PIN_EN     BIT(2)  /* emmc reset pin is wired       */
+#define MSDC_REMOVABLE      BIT(5)  /* removable slot                */
 
 #define MSDC_SMPL_RISING    (0)
 #define MSDC_SMPL_FALLING   (1)
-- 
2.17.1

