Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1239C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690B520BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BB1i8tAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690B520BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeGLLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:50:53 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53477 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeGLLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:50:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id b188-v6so5376551wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=u8KY4VIQZVk3G8+vvTNUVu/H/Cb9wml99l4j/QN3L3o=;
        b=BB1i8tAIx9neBP+Dod73MSynFpL/V3vvAiXP+D0Z5AQomq1RRW0BLrgccVPmA1V8c0
         OcqXaPMV+3HwjKYL2cbAFedusrBrMn/LEPC3+5SHQv5cq/FdfUSbLYo8laTwzrO4+0uY
         JNyqh8W7sVbvNY7ErMzqSIC4Z0M9SUClCIzXIIlP7NVq81vxdHnoxNxnb4yKsRm1bUzW
         tdpVmfE6xaiFab6KdUbdQZPl6Ef+rae1nc20/s9yrDEg+KQYkC6VRaFCskR8jghPT66Y
         9TzO9SLkioYSFi73LN+6vzDVRvtKEJS72Px/1nLwYSP0NcE20geDi2tEaPciX/aeZeTv
         Yvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8KY4VIQZVk3G8+vvTNUVu/H/Cb9wml99l4j/QN3L3o=;
        b=qyTu1tJD1Kk8vP6Wp8ynYyuvJ3vxVx9uN8GYcb8x/N3xDLQAtQqwtQXiRhpsXk5UqR
         cd/R05jBKVhwHyFuusPrJ+quRYEn2XVvcNg8Qc+TldKmStJAnsUJt9FzOpaCoNT0ao/5
         O+Pr8a3JqJuuuF5EIcaqqtwGflfYvhYIFqt86KUIOitOsiae+CDzaFmTpcNTOqtYEJ8C
         5q0Ubj+FP/KNptihHYu6cgeExXcUUjk60Zikn+m5Zr4+JzvgwH2cLgxSPBkBHMYzteJu
         KwVLZW/39xrnsBz5p7uOioKy/siCwst6WKDL/JiDRMeQ40OOGi1QNaKCO3oL90IzjdeE
         kHhQ==
X-Gm-Message-State: AOUpUlEAB/iwH1ZTBe4kPKtzfHSuNynOAPmrpGrxroSTybqLYT3bqVm8
        POfFAipO21SXw+V+WqhOZ54a0Q/t
X-Google-Smtp-Source: AAOMgpdlmENKYEmyQF0PK1Fcbkj8H3nibc0k/TsNHQsndyLJgBdLhDQgQwRmdLJqnqxy4/hJZxJNdw==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr1102461wmc.48.1531395701935;
        Thu, 12 Jul 2018 04:41:41 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm7716939wrb.34.2018.07.12.04.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 04:41:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/3] ata: ahci_platform: minor fixes
Date:   Thu, 12 Jul 2018 11:41:28 +0000
Message-Id: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes some minor problem found when working on supporting
allwinner R40 AHCI.

Regards

Corentin Labbe (3):
  ata: ahci_platform: correct parameter documentation for
    ahci_platform_shutdown
  ata: ahci_platform: convert kzallloc to kcalloc
  ata: ahci_platform: convert kcalloc to devm_kcalloc

 drivers/ata/libahci_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.16.4

