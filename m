Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA140C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878B420840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="UY0W8ltB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878B420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeKJQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:19:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42020 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:19:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so1780740pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 22:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0MibLC++naHT/nRB1OrMdvHIGmxvk8oHs4vr27PXwNw=;
        b=UY0W8ltBcVnAoVIMpCXatFTc1sQzXHCzbytY2zmJoFAtuGoXbD4AU2ZMb17lbDOe1z
         wnBICRd2XocwgeRaHzA5f0oaLkXmJHS7GYVuDPOhur7wDsjJ2pTt3DoaztKtFgGWikbS
         ZfrsbaTc7sL6Q+AozS++blW6+rGvjsMdDRGusFcuxYdwd3dXSR0mNzUv+4IlnIbSiz15
         tu4PfaTvB+eBq4Bqjoo3/9wl3fey2KhA8R3qf/BfVRpBHBfgeetYZbT/PwMdjr54c3Ba
         1SKVQmnmZQv3qKoAEKIXiaq5WOCf5/6osWNACYIox3RTYAWfW1dW9p+4zCy0Nsar37iT
         mD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0MibLC++naHT/nRB1OrMdvHIGmxvk8oHs4vr27PXwNw=;
        b=cBv78u7RN+Y6MIGxXfUmDLJroRdluMRUoB5cZU5Qj6RtV+YDrUdcGWS2MZGAgP59Ld
         MHz70cevOvbyJHRiyhUe27AOHx7i/wvkcRE1xzucysLeuQIGp5gO5aUdVQA89tBkQuvx
         cYXuDwraARrzRzpXJEAVsfhwjHvtWZ9n91c0LfAU/TKfLiUZSdlObU8+ftbj5ZyW1nED
         91Aa3LdIRweAJEbVCDkEa1JXRRxK7BBH9139GkJ+cRpb5B0/HNjZBrzwuf6NNMFHOVb8
         2LHezzP3VWEWN2zaHSPCpWNXGqtJf0bA4VCXZwHhqy/I+jh4s9Nl8vGZhiYCDpxyGrgs
         QxLA==
X-Gm-Message-State: AGRZ1gLn5ZC/1qrxQzeR+y+MIqQl9bkZk9c6MA9phNripOjjnuzRVlge
        nCKlYfHtwgH6e1DVZjT0hvPhqTMAKg0=
X-Google-Smtp-Source: AJdET5ed70CxVnR8Qq9Gh8Coyru16XIbZpKxOf/0oykv0LDvCjA0rSO9xWYX+wjmkGKKMyyoaIuFnA==
X-Received: by 2002:a62:93d5:: with SMTP id r82-v6mr11685608pfk.55.1541821812325;
        Fri, 09 Nov 2018 19:50:12 -0800 (PST)
Received: from localhost.localdomain (36-239-225-199.dynamic-ip.hinet.net. [36.239.225.199])
        by smtp.gmail.com with ESMTPSA id u62-v6sm10207773pfu.69.2018.11.09.19.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 19:50:11 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd718x7: Use regulator_map_voltage_ascend for buck5 and buck7
Date:   Sat, 10 Nov 2018 11:50:03 +0800
Message-Id: <20181110035003.24986-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The voltages in bd718xx_3rd_nodvs_buck_volts are in ascendant order, so use
regulator_map_voltage_ascend.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd718x7-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index f142f9ce6853..0ae3e03f5433 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -131,6 +131,7 @@ static struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = bd718xx_set_voltage_sel_restricted,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-- 
2.17.1

