Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F43C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D30B267BB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="caJAdTuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30B267BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeFZJ2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:28:19 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37130 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932965AbeFZJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:46 -0400
Received: by mail-wm0-f43.google.com with SMTP id n17-v6so478881wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICGfu+S5DH2vWFoyobSXWbX3OXNviUAT30/ySGDLNIM=;
        b=caJAdTuYPTY8nOFNWQbrRMHfXimec3xG973moA72/mEdddE+PkzfzTLtlAvpkXzCmx
         pUwJgqNzPFB2Zr6Ek6hTY0MGr5hk2Ii6eRN1tklHl5VDDlriohpLU5vz2H1Kc6OeoGYg
         pqD7jyA+u88F9l4jWfA8nPYg9GmezAFQV35Ex4+jDtIer1cNgx3DjVDoSupvYFVGNo/D
         bLxyZVe0AVEumYWIXGm259MsdtD4Gwj0jTuh4DBYQBR2BWWdDzKtnHpWtl/N0NwXspFr
         Kl08jgWOIo1pXuREEbSctkYIbmXt9Gz9RTNAXR55SfRpCz760fY9uTbiLR/5KcrfFGSW
         XoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICGfu+S5DH2vWFoyobSXWbX3OXNviUAT30/ySGDLNIM=;
        b=lTeqkUHkKMADGJgPCgYD85MvB/F8+89ExlG567VB2gl6J2/SH49y3M6XlaZt2hikd6
         nad6WoB+xfrPXDpFYRxat6lgol3Liow4D2BYowU52ikMLGxA9vAqjbc1gMgmokioWPLL
         auYh/SDIhoj0wXXX/0LgQRXGOezuwduzgu1YORqyBcL8qGoUurC0Qe0rG9ECnjoTGfTf
         ljOE29D2hShCm1FCmjZtJrAp9ytXNzC5R8DX9oGifJqHS9DmYUqP4FroQ/q4UFpu/YVI
         bkUbtIUWln9mew57wjIfigLUzMZff1flQsKaIUnBNs5Ikjz6PDTlBIvnbEZRu4UJB2Ov
         rLHA==
X-Gm-Message-State: APt69E2INAi6UIKRqoUKm7JaUJkqrkPHmtYYhN72/MKWz8S4hdcR7zaF
        2Zd2UTs27AW/UxXbx4JNBtg29Q==
X-Google-Smtp-Source: AAOMgpcf+nLI3hRXiDO64/pAD8DZvMD5QEM1IcCXdGEutSLQ1Gwg1rDWaOPODnzf1SjmWkbJT4w+/g==
X-Received: by 2002:a1c:bc3:: with SMTP id 186-v6mr1011161wml.39.1530005145320;
        Tue, 26 Jun 2018 02:25:45 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 03/13] clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
Date:   Tue, 26 Jun 2018 11:25:27 +0200
Message-Id: <20180626092537.6737-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-dm644x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
index fc0230e3a3d6..0cea6e0bd5f0 100644
--- a/drivers/clk/davinci/psc-dm644x.c
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -21,7 +21,8 @@ LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
 					"fck",		"davinci_mdio.0");
 LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
 LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
+					NULL,		"ti-aemif");
 LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
 LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
 LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-- 
2.17.1

