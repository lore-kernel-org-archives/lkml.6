Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC60920685
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR1cKltE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC60920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeHEWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33850 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeHEWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so4724914plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v1fbKG86doSCL9jxZMYCCgUZUCHBnTDlqgINKqDAYA=;
        b=qR1cKltEnKNm3BiG23TLtM6LJwGEJshIVpLOZA/jba848TJjLRYccPv/tV1v1ykMhI
         ct1NFukjyeUxUMQbcA/dQKdfjtrRLiXVWrxCJo0eovbqkIsTUYEHt8oF5KEgxyGpnMhT
         79iKXF88yKKFuLjGUsVExSWBIBusbNNc7eo2EwxYsGUR/5+wZ563KkrarRKLYw02jV14
         TwpaLKDts/+VEewumyG4u/W8z+tjuCZ5SBpEgdjwK/YwixTNDJ6H6s68Jcd4HMZpxtWV
         ZAN799cSURODpZlMrcb7L75FavEnlut7dQQnDzsFxCqw3xc8K8IEarcdLxFkD+tm2MIC
         hnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v1fbKG86doSCL9jxZMYCCgUZUCHBnTDlqgINKqDAYA=;
        b=HHQWkpsnb4d2tbPQ0xX+BKBQVmlValAv0rjs9/eG/Js6qGHPT7n+r+evNqGIPsmQq/
         D2DVLUKqpa3xz9ZW/Vg/CAw2H1ULm0BmVYfZvupGyXBNEzv0USra5JDH8sYFo71yIQ07
         DmP4crHrj7wYT80+xX74F2YHMSqaQowBkT5kabvxFfBJJ0gt//I+Ad+D02L5j9GyWkfC
         aGUSRCLNtzhCHBVCpQgEDNuoUAt+GFls4qa3KOm1bB6u4spoAbOckbQ5NYbjvD83uziN
         BRTTCfdiGm/6JYjD5PIdxE+kes41HzvaqWerlQpmpaz/NcZAWPD4DzPNVaqqQ6EKbiKj
         9oiw==
X-Gm-Message-State: AOUpUlE2+Lfsl5cphpF4NELlbYkXH7mdemHV5pJH00s22oCxRGRzPHGw
        e09XorVgQOCtBNFff6To00q7VgQP
X-Google-Smtp-Source: AAOMgpdA7BVqIv11NayVkZF4+axW/whqeYnRgSZCYSnPwm7qtmKeY/YY+qJPN0YuvPglcaEuKvmNkw==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr11462371plf.286.1533499713612;
        Sun, 05 Aug 2018 13:08:33 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:33 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/15] staging: gasket: apex: move sysfs setup code to probe function
Date:   Sun,  5 Aug 2018 13:07:46 -0700
Message-Id: <20180805200749.116693-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket framework no longer provides callbacks to the device driver
for sysfs setup and teardown.  Move the sysfs setup code to the device
probe function.  Apex does not implement sysfs cleanup code.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 69ca7fb10eddc..55319619b2e66 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -568,12 +568,6 @@ static struct gasket_sysfs_attribute apex_sysfs_attrs[] = {
 	GASKET_END_OF_ATTR_ARRAY
 };
 
-static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
-{
-	return gasket_sysfs_create_entries(gasket_dev->dev_info.device,
-					   apex_sysfs_attrs);
-}
-
 /* On device open, perform a core reinit reset. */
 static int apex_device_open_cb(struct gasket_dev *gasket_dev)
 {
@@ -639,6 +633,11 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 		goto remove_device;
 	}
 
+	ret = gasket_sysfs_create_entries(gasket_dev->dev_info.device,
+					  apex_sysfs_attrs);
+	if (ret)
+		dev_err(&pci_dev->dev, "error creating device sysfs entries\n");
+
 	ret = gasket_enable_device(gasket_dev);
 	if (ret) {
 		dev_err(&pci_dev->dev, "error enabling gasket device\n");
@@ -695,9 +694,6 @@ static struct gasket_driver_desc apex_desc = {
 	.interrupts = apex_interrupts,
 	.interrupt_pack_width = 7,
 
-	.sysfs_setup_cb = apex_sysfs_setup_cb,
-	.sysfs_cleanup_cb = NULL,
-
 	.device_open_cb = apex_device_open_cb,
 	.device_close_cb = apex_device_cleanup,
 
-- 
2.18.0.597.ga71716f1ad-goog

