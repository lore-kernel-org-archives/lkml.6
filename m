Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A2AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDF120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDF120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGTWmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:42:11 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48150 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbeGTWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:42:10 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id gdJffIgOiWLW2gdJgf5XFC; Fri, 20 Jul 2018 22:52:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=VP-kpNrJ8D7Mw6TV3z8A:9
 a=biiqoiEWpCWGFnDq:21 a=PkcNIt57vdPO81cB:21 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Fri, 20 Jul 2018 22:51:59 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH v1 04/10] Input: atmel_mxt_ts - remove unnecessary debug on ENOMEM
Date:   Fri, 20 Jul 2018 22:51:16 +0100
Message-Id: <20180720215122.23558-4-nick@shmanahar.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
X-CMAE-Envelope: MS4wfBA5dMsXA9VkdUdHS5scszU3hw7sui8xLLBYia4n/j0TuTkYpjXSNd03eyXeJNQBIJP+0N2Zmch7+QMThL/j3PAjszNX5zm8cZgT+jDMGHZ2gLBaLwdH
 UQIDXgmjPZ9KfS60x9X6jWLDGQqwV0r6dsHBbXb45nXO9CWB1uC0nO3w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dcafb812ee7e..92661aa910ae 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1520,10 +1520,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 			MXT_INFO_CHECKSUM_SIZE;
 	config_mem_size = data->mem_size - cfg_start_ofs;
 	config_mem = kzalloc(config_mem_size, GFP_KERNEL);
-	if (!config_mem) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!config_mem)
 		return -ENOMEM;
-	}
 
 	ret = mxt_prepare_cfg_mem(data, cfg, data_pos, cfg_start_ofs,
 				  config_mem, config_mem_size);
@@ -1982,10 +1980,8 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 
 	/* Register input device */
 	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(dev, "Failed to allocate memory\n");
+	if (!input_dev)
 		return -ENOMEM;
-	}
 
 	input_dev->name = "Atmel maXTouch Touchscreen";
 	input_dev->phys = data->phys;
-- 
2.17.1

