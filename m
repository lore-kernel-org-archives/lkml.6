Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62917C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B09921777
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8GrEWS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B09921777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeHDCYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:24:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46933 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDCYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:24:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14-v6so3038632pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FaIFSww3CaE2IozwieUlSDjCvRuY81Q4O0ZHg+Gpz7Q=;
        b=M8GrEWS+xPBW/gpD/kHbV4lz4dkwUqRnUkW/clOJdng7cUwWnTtYkCpBsln5R+kgus
         tBKvFU2/u54OopS6qGVhuG3Umh9u5lgFekF0RberkgURaZCEKDhbRx5J1n3XP8k/iM0u
         xZnfRGs6DpA+u1RtFMoM0H6BS7uwI1lzekdijqbGInJbsuwVkFE2pqSOsnJwy5/GH71h
         uYBoxmCX5B5iyThbgT3X7a2/PuXaffO2kpLZH/s28yE3AHh++1TCKcrTbEFY+ScTqKBM
         qhR30yy77/MPFyi9E8lCuzZ3kVyaTp9bV0AUvUr2vZ29243TwwJBLN04ysyiBB7CGovN
         RslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FaIFSww3CaE2IozwieUlSDjCvRuY81Q4O0ZHg+Gpz7Q=;
        b=mxI9WGQyrRDlNjIok4q3ijaep3vIAi2k6u7Blr/wPbxJX357YlkoiHrUdEzC25pX2u
         TUwIONL2nNhyPaqM6cnPpZ1i876Dbf2uw3GwlRu37eIvowv5onBj8YX7Lvn13tlogHTm
         cJa5/ENQKZP2ZsjaXPFjJ0QD4/3t0odnCayiNcOkjqF5h6JzhJnOXTCv54gWCYvuUd5I
         7bzneAjhQv4Tne0Ns4gEVhp8OnAGq/EowAasg3dN4BidJ/d2Ajud+ZDI9H8oJjW5hPB6
         2Fw6ZjNahzuuG0WVpTchdZCJa+OlAEWF3fqLfLfXZCcni0L4uKk6qMGvnPqodM4HH8Bv
         giiQ==
X-Gm-Message-State: AOUpUlGLSmeHkBFs6eTD84kzIN2iyeNChgjOIp/GQ/JlM0U/kwPxBnC+
        4EmppcMnl7MwPRYx6ApVrZc=
X-Google-Smtp-Source: AAOMgpc8JvkFvqKmJauALcG70qRmjjBIuA40iuobr/N4VbGtV0L2Ex6TyEGWzh2lwaKeg3lzTc/vww==
X-Received: by 2002:a62:df82:: with SMTP id d2-v6mr6802152pfl.189.1533342344818;
        Fri, 03 Aug 2018 17:25:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id p5-v6sm7902319pfn.57.2018.08.03.17.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:25:44 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: cik: Replace mdelay() with msleep() in cik_pcie_gen3_enable()
Date:   Sat,  4 Aug 2018 08:25:35 +0800
Message-Id: <20180804002535.18434-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cik_pcie_gen3_enable() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 7c73bc7e2f85..c1b4d4fbcf3a 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9598,7 +9598,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 				tmp |= LC_REDO_EQ;
 				WREG32_PCIE_PORT(PCIE_LC_CNTL4, tmp);
 
-				mdelay(100);
+				msleep(100);
 
 				/* linkctl */
 				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-- 
2.17.0

