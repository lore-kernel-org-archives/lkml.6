Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE07C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081021479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ni0OnpsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeGLLuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:50:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40490 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGLLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:50:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so21363586wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dKalKy9nRpZw0y9Gc8KXLb5U1dRAx6/yiCC24q7ZOE=;
        b=Ni0OnpsGRcw79GLDic7QqY1ZUIJxmgY3Wk3gYn355tuSbAO3+Fd8Ijr1hhSLMrUceW
         gA1jWb33+LhcRjuOm70GJr+A2UVLhc66PW8CAI+pHoigni3jk0ZiUhWwg2j7PzJ6Q6sQ
         TwPXFiynJszUD33EBP/GshOr1ijDnU7Onk66Qt/imBu9oY5Efgx3t9UEHeS1UUvTQAHd
         YVwky3DQqY4KZNUQ2++Ssykv/XLFCBwUHJeFn5Gw3hKf6YzLZeJrZAwrdHGJDeoGkO2l
         2wC9+zfBsmPikAcjmzzYpeDYbWj+EewgZRjpwsLhnGNf5f1zhZ/PzGvT17ve9nTZSf6X
         IOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dKalKy9nRpZw0y9Gc8KXLb5U1dRAx6/yiCC24q7ZOE=;
        b=U63fvD/bWtgcSj85EWS+jCKM/YMlPUPmzNkacftMhTnVxdl6hwMI1nVA9fuF9PYvt2
         qf1M3GyAvdSoCrwU5b9NJRMCaf3RD0FwixqIuUyddh5Pljtl7tC1rqTzm6fWqbJBC469
         GpWGl1OPNN4VT077+4z5Obg+maH/I1tND9BVYXzf75LfIJIdRFdzjkOTLuGsOLuzQjxt
         2+s1WMyZOEXzzqY91JoRd4tgMMlLT4ami3zEGkDhH/51/nIJx1Hb8Kht3jBDtdOKeK66
         Lgj5+MyKVy/py014ov0z6KBjQfj2cKpETPwcoKjX6sfIo2fGcq92JUtW680eyRqpY1W7
         JI0g==
X-Gm-Message-State: AOUpUlE2DOwMSMDdMtxlv8GUDcPYSv2txi+wCvYqG5LoFbZ9nbbwfNbH
        UEiN8zGYnoHdzKFmnDOO3Y0ufQ==
X-Google-Smtp-Source: AAOMgpftwaMhaKF6pGu1ohPidtXQSPwnfxBJPAryy95QgjIq+UqO+sbu+ulbyeZ3vqzVVhZWD2ClCg==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr1453343wrd.218.1531395702984;
        Thu, 12 Jul 2018 04:41:42 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm7716939wrb.34.2018.07.12.04.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 04:41:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/3] ata: ahci_platform: correct parameter documentation for ahci_platform_shutdown
Date:   Thu, 12 Jul 2018 11:41:29 +0000
Message-Id: <1531395691-4653-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation about parameter for ahci_platform_shutdown has a typo.

This fix the following build warning:
drivers/ata/libahci_platform.c:693: warning: Function parameter or member 'pdev' not described in 'ahci_platform_shutdown'
drivers/ata/libahci_platform.c:693: warning: Excess function parameter 'dev' description in 'ahci_platform_shutdow

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index feee2e11fb33..70052c046559 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -607,7 +607,7 @@ static void ahci_host_stop(struct ata_host *host)
 
 /**
  * ahci_platform_shutdown - Disable interrupts and stop DMA for host ports
- * @dev: platform device pointer for the host
+ * @pdev: platform device pointer for the host
  *
  * This function is called during system shutdown and performs the minimal
  * deconfiguration required to ensure that an ahci_platform host cannot
-- 
2.16.4

