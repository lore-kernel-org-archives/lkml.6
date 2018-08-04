Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF9C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2E22178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnBs4OBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2E22178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeHDCc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:32:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35868 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeHDCc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:32:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so3573316pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JF9iBhlRE70KaEqu6ZTLgZazp+LTn0J6LlrD0LRVg4U=;
        b=UnBs4OBlFrlsnOlxuOQbangus+JarR3+4yMCmjmX2EWqU/y1i44r3rGRYemv2mtttx
         8q46KVRT6b8I9y3b0zKMYtVcTC5OoYRj+rOeGNqe/nMG0D7Ud1El//rpNM8gtYwJsPMK
         wr/coXP2aejoBEfADvUXA+GslFRg7E/IFvgwZRDKBsjbugSP/YGPcwucomAYRX41vMLS
         s33sB0iciROVJBpkEeEwZG9B2twTJXFiIfug1dulTNkkEkG0ygN63b5GDifdJPUXI9TZ
         ZzsEtzAhpuge/WPaemTUski/uwO+DK2vbOPWOV6mxAnl7j2mb7YMUtfFmpUOU5jjCcx6
         YJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JF9iBhlRE70KaEqu6ZTLgZazp+LTn0J6LlrD0LRVg4U=;
        b=eIyHGeeoeSgtCUF7eg1/8rHHfvVQ+De8cvJTMPXpeEmY7PThoQG1W73B621Hb2m5OR
         +frORth7RdQByAgtBNcQnppZa5beTkytrcbJTkWSZX9hPQ8qTKlT7WVfu7qhuH9tfsog
         bTC4VfBUNGasgTYptXnjQdTTira80uLkMTAJATQQblJ2MSgk3oLw2LP5CI1MpMOXdUyd
         QlGnWwmVMKf88aIAqG9Py70dTZz9pem/IOE2+EoZG2WL1pGEXRqzZf2l88YHsXLRs3DW
         +Bg2hKH9xS+XofOwZE2k/bAoZA1Lhtpyn8LXNsWtKyiTpdi1EK6S6f7Fi9fRhO2Eztvk
         B2PQ==
X-Gm-Message-State: AOUpUlH87fVg8ykGTk19hwPt4OU/sStIPUHBNHEz//R2ZtWGyqpd6f47
        dYJZDWEGWKGPscWyNYHiwptAH+iC
X-Google-Smtp-Source: AAOMgpeJcLaa8NJ7hj0NR4qQWgrezEafm+VgvYZIvb0TfBrw6DOfjr1pGNZkej0jFzu7zu38b6olew==
X-Received: by 2002:a65:60cf:: with SMTP id r15-v6mr5707234pgv.41.1533342833202;
        Fri, 03 Aug 2018 17:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id z2-v6sm5376076pgv.12.2018.08.03.17.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:33:52 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: si: Replace mdelay() with msleep() in si_pcie_gen3_enable()
Date:   Sat,  4 Aug 2018 08:33:44 +0800
Message-Id: <20180804003344.18775-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

si_pcie_gen3_enable() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/si.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 1907c950d76f..c28743443970 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7181,7 +7181,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 				tmp |= LC_REDO_EQ;
 				WREG32_PCIE_PORT(PCIE_LC_CNTL4, tmp);
 
-				mdelay(100);
+				msleep(100);
 
 				/* linkctl */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-- 
2.17.0

