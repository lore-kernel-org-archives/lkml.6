Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17294C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77C22083B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPePWKuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBTMCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:02:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:02:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so11833565pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VGL8Ys9maOb0reE83nYZl8yDtQnil0TfQBVBt1ciO8k=;
        b=JPePWKuWZ/OQvZjbnxHavWHIu7HbhOWpbwAuzvmrFbJadvd8voGjxIKZk9q5KEfm26
         8F6hWskXuvd1yIhq3ivCvc0VIUzvWOmvbRjI/DIfTpL/1q70fLozOVra/quWtGrz1Jeq
         bNqKOUGEOsUG0Ag8oiels5KjBv/+3d4yCAgf/4NqWXL84ANPJbq+z6iySqpr9NC5+9T6
         YougV8gHVLE2zo2cYnyJBmkJqVyuNeAhCbbmE1uZoDVQP89UWHkUYa9/5OLltt20vonF
         oBk+QSOtlJjyXINJFytNrJoZOnPsBCUrVa2VnZJwkCxx1d18dqoD9jXE7cuWZ7ZuscGQ
         9BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VGL8Ys9maOb0reE83nYZl8yDtQnil0TfQBVBt1ciO8k=;
        b=P81W5UYcUbzEIu1HHMQT2yIGXjPm+2YBZjZsS/9fyPvRAQp4cXXea2BmH9G9gk+t0m
         y6frlroVF+tbhGT3t9pOolMowG4cGfkql0ieg4FBChcQsa1ufaSegll9k1tBC/bhWrH+
         aEfer/GeG2eRxFQLu7sDcwojW+dkjmOghsglVCVaRmNeRBgXOXdzccKhCfckH+9VpkEi
         w8//KBbwVL/2DjH4byIYpmmmDwCIJLzk2BTJbAmQLskV7PwzbSS5aiU48MUfP6webzXS
         UOQlueJg0yJsUpnrObSJ6hRrboJh0iGlkr4cH4ArF+6OfFd7iWZB/lMhLT6Ehi/yTBjr
         xeBQ==
X-Gm-Message-State: AHQUAubtKRcX9JpHkQT6KjLS1eWEeCoHHT1FldACTtm0lBgLhqpHH6iz
        nNLT/Wt2gIIDxFm3f2kCwzJAuYAC
X-Google-Smtp-Source: AHgI3IZlLNk9wTxJ6NMRdbChPd3Vtd2Zms/B0X4is5Jf99wIaiujfZ4mnuIZRTk4uVat1IfPbyP3vQ==
X-Received: by 2002:a62:e216:: with SMTP id a22mr34350423pfi.20.1550664132591;
        Wed, 20 Feb 2019 04:02:12 -0800 (PST)
Received: from blackpearl ([202.83.16.79])
        by smtp.gmail.com with ESMTPSA id k64sm38697636pfj.69.2019.02.20.04.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 04:02:11 -0800 (PST)
From:   Sumit Pundir <pundirsumit11@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon-usb: fix misspelled "re-enable"
Date:   Wed, 20 Feb 2019 17:32:08 +0530
Message-Id: <20190220120208.16727-1-pundirsumit11@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes misspelled "re-enable" in comment. Reported by checkpatch.pl

Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 769c36cf6614..ae7ae50071ae 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1797,7 +1797,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	This is a test signal. When the USB Core is
 	 *	powered up (not in Susned Mode), an automatic
 	 *	tester can use this to disable phy_clock and
-	 *	free_clk, then re-eanable them with an aligned
+	 *	free_clk, then re-enable them with an aligned
 	 *	phase.
 	 *	'1': The phy_clk and free_clk outputs are
 	 *	disabled. "0": The phy_clock and free_clk outputs
-- 
2.17.1

