Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DDBECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B42A2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiGlb9uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B42A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeGTEgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46239 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeGTEgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so2008745ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+b4GBpUhCwwdfz79rhlZIwoXvD/yAsDVw/JaGwhQAA8=;
        b=IiGlb9uoOZr9e3LuN8g6uozSNw0E77jrBkjFGTj2n3GYAFBoBGxrlEMJP7mjoeBA0X
         tzIgWruUc/OjLdF2M3XlNQRxCdleRjxAOVkNY1bCIVbteE28Jge0MjsWy1GbRkhyKJWh
         dRPyivvBxPluk1wD0wvNOHeKs9Uo2N4I/xOrRr2rNCBiSTDbzscaHPpkss0gIBEso9U3
         nAtb3U8Zgl90E9RYQYfOzn0o7XY9AacSCX6Ggl1IqwMjUo0SkAVTE+Fw6fY/QdP1GAx3
         AkNJBa9BP1II4YyhTOBYJE0RqGY/ntxKdUmr5L3ALpRARx/EqfSaex5iOpUac3G6FTY5
         5UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+b4GBpUhCwwdfz79rhlZIwoXvD/yAsDVw/JaGwhQAA8=;
        b=Mh79xvg92sP28ZtkaFhUtrLvHW4Qn9d6p+u6n83O6GwUSTdDLK6G6IYlmmIO6UihYj
         NCRZD1+TvvttjgnCzyIE7kVHe+4RXUVFicOkvzMS6qJH8KycSGW6PLhS8jV9Ptfs4W+n
         QPZnqnsArrdNCyuPmb2p88Vx+weXQvAkc3OJOB51Rb9EqhEcoEF2g9AaMXoRfS1+dupT
         RFA3HvMEhgcFPzPOA/nG2MOv0Q15e6wkkAcOmSVYvs281wtEAouYGzIG8Hj0et5Ffi5Y
         tfSVNbVqHtA6Uas3KWXbc3/QBYJNIiQUHsCoF2HYS5U6JIR8rhbH9ZfkzFX0cg/9yCZz
         q+ww==
X-Gm-Message-State: AOUpUlGjSinD9VbUkNeo0nLfmFsFTYYXt+gG+cqkijDlo4I5A/43yA6k
        g1Nmkv9qFcOsJI5DVlT95YA=
X-Google-Smtp-Source: AAOMgpfUSsVP37vlPHL30pVom+InscDL6oghfoLds92efhheRWB+yUWIMKL4P4VcoADU7QlWk8zSbA==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr436981plz.282.1532058591397;
        Thu, 19 Jul 2018 20:49:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:50 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/20] staging: gasket: gasket_enable_dev remove unnecessary variable
Date:   Thu, 19 Jul 2018 20:49:02 -0700
Message-Id: <20180720034920.77320-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unnecessary variable, pass constant param instead.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0d5ba7359af73..f327c9d7f90a3 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -898,7 +898,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	bool has_dma_ops;
 	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
@@ -917,8 +916,6 @@ static int gasket_enable_dev(
 		return ret;
 	}
 
-	has_dma_ops = true;
-
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
@@ -936,7 +933,7 @@ static int gasket_enable_dev(
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, has_dma_ops);
+			ddev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.233.g985f88cf7e-goog

