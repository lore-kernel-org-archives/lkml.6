Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BCC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4928920C0E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw9rFY8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4928920C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHSWdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:33:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33390 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeHSWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:33:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id u14-v6so9340641lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MD9e6IlC0gB4zaSRGkqcrpZaimmviU2IMAsekNkAxuY=;
        b=kw9rFY8G5dg2xtNZ1XseWQlBOPthKyxmai4v+N3slaCJSo9ltzdlx7Z7Ip+2mHw3Ie
         fVFQqK1K651if7huTI/Y4j+fuLh+3pg0vrkxtMH/6vyJID4lDJSrFg6Wk7MkYiorG0E+
         YSYBeNybJfv4z4qfvVHRqI8vG0i7fomyShZwmBc3Zfiv2LVPUucOIxPY5exLB0/g+L79
         PO0TG4751fI/+ns7l4Se+J/RoPQj4lCKkXu6RVx2rMX+euBmR/tIchmnPDY7/yTacRDD
         fH0F1VIzCT7aYvFQ5xkgL897w8sC7EbVGNHL0ax5CN0vJkX5NrlvmRpKrv651QgyvlBc
         yMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=MD9e6IlC0gB4zaSRGkqcrpZaimmviU2IMAsekNkAxuY=;
        b=ehSnq09IbYyX0WdgQiFJggsIomZRcurxaNKfdtdF+79ENAnbYgHq6kX5ed/h1Zc5TN
         uriOzo3OQpsCGCNn18QFaQVGrn30xWkOCVcRDonKOALFGo+FMGONt7Y6DceApA9GoZ7v
         ZoVEmm40xJffpAvKake8lGk3xLsfHpmuMRVA3NEgqJQkTZYvhm4HLUMkJAlPsRGzaYEA
         U2twvKZld+g7TBTbEnQbab6yjc0CivhvW8dZw5bep1EMZ2nAGG1565gfXErD1/g75fuk
         Mp9sDGudTzXhm4MF0XgF4QVjC40EVLY1O66fUBYKBuBREj4hU2ffP/qGk/NWJll9wo1C
         9c7w==
X-Gm-Message-State: AOUpUlE/OSuBFJX2uyGT1eKJkArP69Lei/AYC90OELXx4Aitm9AXRRh7
        kysDITq9AmfToFD/h3Wj+uw=
X-Google-Smtp-Source: AA+uWPwqz/8lUynIZlLbwVWPEb4/zqQDaqPUKEtOCoM23mwHog9jE1s55MlLGWrIokT5RLB8dw2qdg==
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr26381802lfe.131.1534706431069;
        Sun, 19 Aug 2018 12:20:31 -0700 (PDT)
Received: from duuni.helsinki.fi (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id f14-v6sm779262lfm.29.2018.08.19.12.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 12:20:29 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
Date:   Sun, 19 Aug 2018 22:20:23 +0300
Message-Id: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting GPIO 21 high seems to be required to enable power to USB ports
on the WNDR3400v3. As there is already similar code for WNR3500L,
make the existing USB power GPIO code generic and use that.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 arch/mips/bcm47xx/workarounds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index 1a8a07e7a563..46eddbec8d9f 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -5,9 +5,8 @@
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
-static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+static void __init bcm47xx_workarounds_enable_usb_power(int usb_power)
 {
-	const int usb_power = 12;
 	int err;
 
 	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
@@ -23,7 +22,10 @@ void __init bcm47xx_workarounds(void)
 
 	switch (board) {
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
-		bcm47xx_workarounds_netgear_wnr3500l();
+		bcm47xx_workarounds_enable_usb_power(12);
+		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
+		bcm47xx_workarounds_enable_usb_power(21);
 		break;
 	default:
 		/* No workaround(s) needed */
-- 
2.16.3

