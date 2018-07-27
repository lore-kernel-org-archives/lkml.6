Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CBFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CF220894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzcgoxzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CF220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeG0E1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36317 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0E1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so1684085plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwF7OBw+uCRO59fL/hzWXrE791y0Ep0b9CoPOz2BjEk=;
        b=gzcgoxzBgUb3Gl0XYSIFdIZGUZsO27jaWKMPdPwHHK/tKBbvXjiQW1hWxdn5S4gTGs
         aL0NncgU/am/Uz2if2qDo0c3VyAxU+hMXWVxUmBKeU45pIa8YGum9XBs1Ox0Em4QTV87
         Z8Xfp6Qosrw0CDJKgwVwYONp3MaCVaei482BRU/cadBf9okWUsu7KbfLMvGlPIsWtPVl
         5kUopUFG3n37lg4QM7xxdWS3BNy2sVOrCYue0RyGCniuRxpt/Oz3uIlnZeZSnZ0mXvsN
         kfAJd0iqVSlHoiZyMfNH2uUzjk1abEwauX9XeKR0sauztWM/xea7GNpJqQT2Ib4IQ//2
         fVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwF7OBw+uCRO59fL/hzWXrE791y0Ep0b9CoPOz2BjEk=;
        b=DEiCZwRsh4zEQ4JlPoGCIzEagCC2LHgJqKUkYcZI25uwIJ9uVihAloxuyUFIl44RmZ
         YHAlcE54Ep+Fdt8FtLveO2Al1Ea0lHrfHgnJba/HfqDdp3khkIDP/KI+6o2SyeNZPhDC
         mVhBXk2KrNLbGEWV7c8/ZK9OdmSR+ioDeqvEyr9cnQCVIU51vGVGujA07xshNzSWayOa
         9ws3epC7c1kgvO0e93Dg/hro9nZTr/yrOgX5oonzz/o9cyJf0wxmXwqT6lIZlhiPuzkl
         XCDMXE/SC08Lvw+moKHAR+r304BDsHUg0NP+FvCNVQrnaRepndW1GnLEuJZd2mZb0vx+
         ViGQ==
X-Gm-Message-State: AOUpUlGMaPncwQQdmRGceQ6xYYyHYcXbDkuN6hqGiBkUnOr88YQEz5IA
        rfS1rpdXk8G3qIm7C9tt4DQ=
X-Google-Smtp-Source: AAOMgpe9Q1Rg1aTnFcT1UKG/EGMblyRafA+cDgAL02ggJB0zlvz0TWS+GoTS9URoPdZp6rXxP1yLHg==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr4289063pls.238.1532660883676;
        Thu, 26 Jul 2018 20:08:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/10] staging: gasket: save struct device for a gasket device
Date:   Thu, 26 Jul 2018 20:07:28 -0700
Message-Id: <20180727030737.231268-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Save the struct device pointer to a gasket device in gasket's metadata,
to facilitate use of standard logging calls and in anticipation of
non-PCI gasket devices in the future.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +++--
 drivers/staging/gasket/gasket_core.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 732218773c3c6..e8f3b021c20d1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -450,6 +450,7 @@ static int gasket_alloc_dev(
 	gasket_dev->internal_desc = internal_desc;
 	gasket_dev->dev_idx = dev_idx;
 	snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
+	gasket_dev->dev = parent;
 	/* gasket_bar_data is uninitialized. */
 	gasket_dev->num_page_tables = driver_desc->num_page_tables;
 	/* max_page_table_size and *page table are uninit'ed */
@@ -925,7 +926,7 @@ static int gasket_enable_dev(
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			&gasket_dev->pci_dev->dev, gasket_dev->pci_dev, true);
+			gasket_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
@@ -2028,7 +2029,7 @@ const struct gasket_driver_desc *gasket_get_driver_desc(struct gasket_dev *dev)
  */
 struct device *gasket_get_device(struct gasket_dev *dev)
 {
-	return &dev->pci_dev->dev;
+	return dev->dev;
 }
 
 /**
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index bf4ed3769efb2..8bd431ad3b58b 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -263,6 +263,9 @@ struct gasket_dev {
 	/* Pointer to the internal driver description for this device. */
 	struct gasket_internal_desc *internal_desc;
 
+	/* Device info */
+	struct device *dev;
+
 	/* PCI subsystem metadata. */
 	struct pci_dev *pci_dev;
 
-- 
2.18.0.345.g5c9ce644c3-goog

