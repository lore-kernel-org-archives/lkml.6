Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA07BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E57214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E57214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbeISMut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:50:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34641 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeISMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:50:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so4198717lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BPsy0V7s8M0uIavpT5G+A3HngXyz/jbcSS1I7qwNfBU=;
        b=WOsYsylS57UgN/5KRxti0VcANiFjE5g30Xgm674TYK6R6pHzBtLXcJpImtUIh/D5/7
         1UeB9EFgh98YVOw32DEObLcHT81eOb4Ql8eAM9juwxAf24dExB5kzsCIXSOBhf+rBS9S
         81pazddoVLWDWbSaZChen9Vs2FVaNWUzR16d0HS20BZ0VAHSkVCI2ykCPyS40yZxZi8h
         nURYIrLtNnaoqZAzu6rcymxoCYThvjuTmS0ZaLMIjjCIMhtiz5JK7hblVJKNzsOadENK
         KG2K79Ppp7dTAHx+WbneuAdt+RquAMGHHxwpHTXwC1MYi8qT3jAC1kWsffkiEXDXpeWk
         UWHA==
X-Gm-Message-State: APzg51CJ5lPlMwuULkSYsZ4cGZH1WZMPLUIVGK8IqgGSIufoXlrWcV9s
        uiOwzzipDsPP3hVxZbHFBNsivHVd
X-Google-Smtp-Source: ANB0VdZ0/qswSyRMRW4779dTMIabQs5cZxtvjJFUGcYGaA9i2NTS6BxncISB+VwpIhf2jD0WGwvo6g==
X-Received: by 2002:a19:6b0b:: with SMTP id d11-v6mr18945603lfa.99.1537341253866;
        Wed, 19 Sep 2018 00:14:13 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g11-v6sm3650658ljk.45.2018.09.19.00.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 00:14:13 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:14:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: add missing linux/of.h inclusion
Message-ID: <20180919071400.GA12191@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-Day tests found compilation error on x86. Driver won't
compile on x86_64 as "of_match_ptr" is not found. Add missing
include <linux/of.h>

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd71837-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 9b5e1297902f..4fe519581235 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-- 
2.14.3

