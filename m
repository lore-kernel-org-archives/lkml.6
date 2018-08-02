Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6435FC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1191F214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkhuKczP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191F214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeHBKd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43014 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbeHBKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so888005pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnogcxiN/xocxeCQncF+qzndWxKUqsxwngLucgmExa8=;
        b=CkhuKczPq0DgtjkF2xx9WCOsELxFeDG7NdcQdsixuYyumrVTn0CUdFrZmRsS4jkg5v
         9vkB6sN5upnRhjKZuVBqV1vRiEWZgCt8WopAdxFFT/TW/bGDRa/Q55kZltjV5+l5WqL7
         ulyG1HVuX1OT3/8ew29Bk4XYdvHiK/bds3bDrS3608yVvNZAKQ8tyj4gKj488Uas66y1
         AI5/NfSWmm/cDykNoU6YRyMa/s0Wd/Hl3bDCpgRNwFRVxFT9awxv2ELVauklOyDgtlv6
         oTFiamv+rE9tkFp4wyY+4mDGDcyR4v5dRN1yAXXlCRLqetFqw6tqWdd5WYH4rS9JB3YI
         33Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnogcxiN/xocxeCQncF+qzndWxKUqsxwngLucgmExa8=;
        b=VR7A5HRms2rR5IBvEeOq6ZlGpV67jFOeW5yEeKt9IxE+q6Qqag73O26q6BrAZdbNry
         97XrEs0DyLrg0wOeRxuea/B5CS5WEzHQz/P+FdYXEB03o9Wc//kECbBx76h1iV+DHB2m
         L1oW3EhSCdhPkzc8kTIJ/kP+4JWw3fblMHAjOsSbwDSZ3TaRIhzmWY5ulZvd5Vv6KXeW
         iOK6aZgyD3vSm/wAdisuLov99zuyQhP3/zJ7Y5G3tOLvR6cUyxjxs5ecGpj1SATg7h7/
         x3204wl+9ADdqsl6hpCoouAjlMuoCESaT+xsEL4V2YNymUYXMYMNJ6xcCmJxzVnljfNO
         UUgw==
X-Gm-Message-State: AOUpUlE50l991ZwVkUDUxVK6OvarQJFlXRm4mZRV0nRuxLJ18hUuvLpt
        Hdc+eGGJJYova3R2TM2K4y0=
X-Google-Smtp-Source: AAOMgpd2Z4Hn7+OeT86WMELWNcDYtbEwXovcE4Pxxi2K0VvGNKbg5YWRsAUc4CCM17jhaqXs74KL9Q==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr1819426pgh.28.1533199387738;
        Thu, 02 Aug 2018 01:43:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:07 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 7/8] staging: gasket: apex: drop reset type param
Date:   Thu,  2 Aug 2018 01:42:44 -0700
Message-Id: <20180802084245.239689-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Apex doesn't implement different types of resets based on the reset type
param passed through the gasket layer or from userspace via the
gasket_reset ioctl.  The reset type is dropped from the gasket framework
in a previous patch due to a lack of present need and non-conforming use
of this parameter by the framework.  Drop the parameter from the apex
driver as well.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 7fd0dd609d037..42cef68eb4c19 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -56,10 +56,6 @@
 
 #define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
 
-enum apex_reset_types {
-	APEX_CHIP_REINIT_RESET = 3,
-};
-
 /* Check reset 120 times */
 #define APEX_RESET_RETRY 120
 /* Wait 100 ms between checks. Total 12 sec wait maximum. */
@@ -258,7 +254,7 @@ static int apex_get_status(struct gasket_dev *gasket_dev)
 }
 
 /* Enter GCB reset state. */
-static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
+static int apex_enter_reset(struct gasket_dev *gasket_dev)
 {
 	if (bypass_top_level)
 		return 0;
@@ -313,7 +309,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 }
 
 /* Quit GCB reset state. */
-static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
+static int apex_quit_reset(struct gasket_dev *gasket_dev)
 {
 	u32 val0, val1;
 
@@ -413,7 +409,7 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 		__func__, gasket_dev, hib_error, scalar_error);
 
 	if (allow_power_save)
-		ret = apex_enter_reset(gasket_dev, APEX_CHIP_REINIT_RESET);
+		ret = apex_enter_reset(gasket_dev);
 
 	return ret;
 }
@@ -429,7 +425,7 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 }
 
 /* Reset the hardware, then quit reset.  Called on device open. */
-static int apex_reset(struct gasket_dev *gasket_dev, uint type)
+static int apex_reset(struct gasket_dev *gasket_dev)
 {
 	int ret;
 
@@ -442,11 +438,11 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 		 */
 		dev_dbg(gasket_dev->dev, "%s: toggle reset\n", __func__);
 
-		ret = apex_enter_reset(gasket_dev, type);
+		ret = apex_enter_reset(gasket_dev);
 		if (ret)
 			return ret;
 	}
-	ret = apex_quit_reset(gasket_dev, type);
+	ret = apex_quit_reset(gasket_dev);
 
 	return ret;
 }
@@ -456,7 +452,7 @@ static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
 	ulong page_table_ready, msix_table_ready;
 	int retries = 0;
 
-	apex_reset(gasket_dev, 0);
+	apex_reset(gasket_dev);
 
 	while (retries < APEX_RESET_RETRY) {
 		page_table_ready =
@@ -611,7 +607,7 @@ static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
 /* On device open, perform a core reinit reset. */
 static int apex_device_open_cb(struct gasket_dev *gasket_dev)
 {
-	return gasket_reset_nolock(gasket_dev, APEX_CHIP_REINIT_RESET);
+	return gasket_reset_nolock(gasket_dev);
 }
 
 static const struct pci_device_id apex_pci_ids[] = {
-- 
2.18.0.597.ga71716f1ad-goog

