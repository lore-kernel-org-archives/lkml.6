Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC55ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz2kTLyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeGZUni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38826 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbeGZUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so2253278edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uv9mf5e5Y0DRn10HzQPmfp3MIjJY/Nl1Y23mfEH6Tz4=;
        b=fz2kTLyla/yCwlaZeblzU0EGmF/nRMW9S80rE5Ztxwp3hzY7abEEvBdgnT0YgtFVet
         69eXOPDCsGsqv5O1yo3gD5spAiZPc8VWkFqlB17OSD+zsfQdVuN9aWebhEe7uFs5Exr4
         AHq69mv+re+55vqpix+uOSboO8mfUe0uL3M+aFrA27bSrqCJ+HszN0Zt9iDwru5GNGCl
         VJfdDR0LK4BJBuJwMi6sNIKYRHm7+Z9x5YJZfSTOENd00BMz1srOrHwvFWa/GFESYsDM
         GbNFaQ7FVIY6Ypa3eFJxqCZB3YVbgTeVhWs4txvx0cvLn0rfT1Q+CkA55lXLl/TgpBNF
         AzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uv9mf5e5Y0DRn10HzQPmfp3MIjJY/Nl1Y23mfEH6Tz4=;
        b=Pr9a/gKMIogSXGWo2QwK0xCFtHAeWPk+KKLfK2FwmXqLphlTRV77/0Z0BwX91eny3a
         lGI++XrqaZyZTcmjpeZ5Lx27q719ZcKsccwORk2yLkM2uZUvprhRykeSn7XxKK3LtTF5
         pLHmSrCFdevWYXko36EnA4x/qEg21tsFKAhkT7OPpWA7nM9dbt4DSGoEJKyt++eAfTei
         QfKRXcKjOM4jESfTQz027gOUgwQ6NnDlkysMdghg7sjOxm070Ugp3x5Q5YUPnFc2xcR1
         Wjul7ivJYsBNziVw6QbdM0c9Kjxwaahx9lnxTj8S6kBB5lDhUei5nGeFA/h/eLCPgpgp
         3Isw==
X-Gm-Message-State: AOUpUlH6PHI1CvOBpCaLxWgX5uGZ5vPwoZp/hYlH3FsfmVEXU98Rr+wR
        jGor15YycclsoNFxKtAPxpMfn3kf
X-Google-Smtp-Source: AAOMgpfarVP0XqS9doOq2VsMI7x2VZakIAUnXZsDEBw5LEmFpTcIfH3otwR5yFT09GNSv9KsUFqMPw==
X-Received: by 2002:a50:97bb:: with SMTP id e56-v6mr4167815edb.58.1532633110020;
        Thu, 26 Jul 2018 12:25:10 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/16] staging:rtl8192u: Remove repeated definitions - Style
Date:   Thu, 26 Jul 2018 20:24:25 +0100
Message-Id: <20180726192426.31913-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bit field masks which are defined in two files: r819xU_phy.h
and r819xU_phyreg.h. Or in the case of bMaskByte3 defined but never used.

The definitions have been removed from the file r819xU_phy.h.

This is a coding style change, which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 1ad459cf05ae..8ca869e8ee2f 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -41,14 +41,6 @@ enum rf90_radio_path_e {
 	RF90_PATH_MAX				/* Max RF number 92 support */
 };
 
-#define bMaskByte0                0xff
-#define bMaskByte1                0xff00
-#define bMaskByte2                0xff0000
-#define bMaskByte3                0xff000000
-#define bMaskHWord                0xffff0000
-#define bMaskLWord                0x0000ffff
-#define bMaskDWord                0xffffffff
-
 u8 rtl8192_phy_CheckIsLegalRFPath(struct net_device *dev, u32 eRFPath);
 void rtl8192_setBBreg(struct net_device *dev, u32 reg_addr,
 		      u32 bitmask, u32 data);
-- 
2.18.0

