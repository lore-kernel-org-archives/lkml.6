Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E876CC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2220892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZrreNgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC2220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeG2VIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43810 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2VIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17-v6so1592334pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVj1a9aoqq+jMPjxXfqU1FR7aZDkjTxC3929c002Pbk=;
        b=KZrreNgkXBUaMTxlX21CIqhjNL9lPT4QS+j9M8qLm4MUgjXTwkJZksm+bEZZzDdfYL
         03TH+2+Sa101QgfJfVFSkEWIW/FIbm8zUvlnZCB1vctYltWhCy36YD+mfq5o+/kEBtkm
         fPatbbHSfGuAgNwGVgxCqw6R+5KKouYV62d+sNBMem5T3TbiwkV8r6bv8XemHW2FN906
         cQSRu78gSssgzEjR+vPm9TOKnE1PSLBR92a2/xHWdgvLgmCoaLP7d9SI6AHYsvRhScLL
         gVN6J0r/Ydg+tS1FJhNY4+0DvgfSWqWFkGSFAvBkbotL9nOxkPVVaEMJbprUUaqqlv2G
         7lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVj1a9aoqq+jMPjxXfqU1FR7aZDkjTxC3929c002Pbk=;
        b=EsuU7hCfKwibJYJRIpWjH49szgC8sKy2BkSPFtLrp2txghwYNAFHMVsUHfDhlAiJnL
         0gWQm/zxxkTfGv8RRdDy5h8xo0mro8U9ZPEl7TNyM5Kk1DgSV9+fzAxrHYPlaYIxKXPx
         hV8OWUX/vtIe3MKE3n4QcNAOEKzPEHK6ik80rAbVX6gxD3qfqiKgrzsscNtjwmvs/hcn
         Tfolc/OZbF0PkIs5u/TKr241TtEHwU4WfiH2xF/rU1PELS/FZ/U13ixTYRmrI6qYmjOY
         m5geI3DBFJVCTiB55PATbrR8q98z6EJiC1ccS6uDngRzs22UwrW5EjK+AqgWI91TSF3l
         gQmQ==
X-Gm-Message-State: AOUpUlF3yKZuiWVDoBONTmX63VHkGwobr86L7nt/hf1bvdP7+mRttarC
        oTVrVLmq3ODi6MhL67cDm0M=
X-Google-Smtp-Source: AAOMgpcEjmrj3PQy/rKPnlma+M/Itq8i4MzdXs38TXts4+cRUJg3nSxj2TupGhLtuLMz6cFymAhm3w==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr13719096pgv.245.1532893019150;
        Sun, 29 Jul 2018 12:36:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:36:58 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/13] staging: gasket: core: hold reference to pci_dev while used
Date:   Sun, 29 Jul 2018 12:36:34 -0700
Message-Id: <20180729193646.201721-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Hold a reference on the struct pci_dev while a pointer to it is held in
the gasket data structures.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2b484d067c38a..b832a4f529f27 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -488,6 +488,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 	internal_desc->devs[gasket_dev->dev_idx] = NULL;
 	mutex_unlock(&internal_desc->mutex);
 	put_device(gasket_dev->dev);
+	pci_dev_put(gasket_dev->pci_dev);
 	kfree(gasket_dev);
 }
 
@@ -565,6 +566,7 @@ static int gasket_pci_probe(
 	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
 	if (ret)
 		return ret;
+	gasket_dev->pci_dev = pci_dev_get(pci_dev);
 	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
 		pr_err("Cannot create %s device %s [ret = %ld]\n",
 		       driver_desc->name, gasket_dev->dev_info.name,
@@ -572,7 +574,6 @@ static int gasket_pci_probe(
 		ret = -ENODEV;
 		goto fail1;
 	}
-	gasket_dev->pci_dev = pci_dev;
 
 	ret = gasket_setup_pci(pci_dev, gasket_dev);
 	if (ret)
@@ -703,7 +704,6 @@ static int gasket_setup_pci(
 {
 	int i, mapped_bars, ret;
 
-	gasket_dev->pci_dev = pci_dev;
 	ret = pci_enable_device(pci_dev);
 	if (ret) {
 		dev_err(gasket_dev->dev, "cannot enable PCI device\n");
-- 
2.18.0.345.g5c9ce644c3-goog

