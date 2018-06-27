Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3876C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416582623A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="F91Wc0wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416582623A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeF0Mkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:40:46 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41683 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeF0Mkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:40:45 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so864961pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XCwLKGSYfrvwzXamq0oRwqE/jdhzZfxZOOSDVmKqulU=;
        b=F91Wc0wzUd/ec01hERBz2cbLYnIrapVvmW7o+LTASQbDvPJIzqaYBu/ueKrmhTJFOy
         Lns3isV2zYx07iNZEZiaq2an2e6RDDq8dkYdnE7guHI7t+yvhnfaEUOtHXXzO2jjGEe8
         93WETGDA9T7nrfcIV318Iz4Bq7f4mTPFD80rPhXFOLZ0m8blB0O9ItyyouD8/VGMzaUZ
         2n1lU4JKp/el1YrqTvA9sdLN+hPdkY9gJD4t7A6lJ8yqclnN37nC9Om7vwI2Ebxhl4Qe
         zkBy/YXP7o24qqc6EbuN36EVTY0iuyoXDx5Ok3xPsEwpQSu9FXKKRzflA3Yt9YpuBBQG
         ZwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XCwLKGSYfrvwzXamq0oRwqE/jdhzZfxZOOSDVmKqulU=;
        b=DuJNMflmk/RBe78Lc6fJ9b7bNDmmhTpyXHPenvHPgUhecT1JKC0zP2YqKsSDJcRpjg
         ajFeOerbP7ULl/PtWTmwGY4dnGzurlvAYPqsj8pA9PoozH3+RlnLES5Q+qP43HhD6yLm
         gTXhJKqyh1Bw795CK7s13yTu4kpDeFxtmT50DrqYiBZsmJTNZGk3Bvul+A4rRxF4cK4S
         FbuoM+/KWmxRN2SSxIqmy+z+OLU8acyf3nUkuRSMA/ItMZL2NV6KLjxu2ES/NiISgxfR
         93Ry2TALGYiIbKUDZ0lqJH7AA90b822zIRz772BKVbSXkIlo6ZJ9B3bvdiGW/xjHCRq6
         Sf6w==
X-Gm-Message-State: APt69E0iCiB+EBBV13GpXcaZDz0IUQzgwOpsMUWJhNETPf3olLYaT+Yv
        +JjzHwhocCKZq04B6z2UbFvTqGxk
X-Google-Smtp-Source: AAOMgpe7r4XeL1DTFEHdQHYPujdlKFFMw/AMVQta++DhyXzIygVzL9RrmMvkCV+8mAPXm8pPDyuWpw==
X-Received: by 2002:a62:9945:: with SMTP id d66-v6mr5702043pfe.192.1530103244500;
        Wed, 27 Jun 2018 05:40:44 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e5-v6sm5560019pgs.59.2018.06.27.05.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 05:40:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: bd71837: Staticize ldo_2_volts
Date:   Wed, 27 Jun 2018 20:40:13 +0800
Message-Id: <20180627124014.30615-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd71837-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 6eae4d0432a2..403b45de1262 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -195,7 +195,7 @@ static const struct regulator_linear_range bd71837_ldo1_voltage_ranges[] = {
  * LDO2
  * 0.8 or 0.9V
  */
-const unsigned int ldo_2_volts[] = {
+static const unsigned int ldo_2_volts[] = {
 	900000, 800000
 };
 
-- 
2.14.1

