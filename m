Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A695CC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F0920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vOEFLvDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfAUIiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:38:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36926 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbfAUIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:38:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so9480992plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucO+mEyukstSZOvX/DChuy7j9sUdkEFCR7xKzTtgKxM=;
        b=vOEFLvDifGw5avCbsCCz5QvbSdVOTDHlqRwfyD0Q1kaXsSRKWzVCqVd5gSoTO1Ph0o
         YzMoo3aLurhTaVY+G7Z2RdAlZKLaWyqllQCct4kQnVsGWK5kHJAysUEjR5idEIKTN9aJ
         b/vDe+L2zL2D5Zl0vIy6N4mM2ulQK6XHPv+pJC81HP42MqGxGwIm8u6doeoKpyfduQWX
         6mBDU/gyALKpAOgPoihX4FyTLECy3P+iZCFS9wKVEczm4WSDJcAy0M8uzg2Kn1nf3l1E
         hRlRFGKLqfIaKtwgjDrVNToTEvB8jim9Sb3yd7HeZC39rOJK81qPfsvbZtl6enGa3DXt
         clKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucO+mEyukstSZOvX/DChuy7j9sUdkEFCR7xKzTtgKxM=;
        b=gK/GleCRWdy6FJkS189yFIBtIVD2cac5qgvAfLSlmVTXKcj/Oz/T3Nxj/wrY/kUaBU
         L8PEVacZn+kwixbo7HlajV1csYUEiMm3Cmyao9Xk9K3YXCJMcJG0CHcq5gkjXMoKWho7
         KUKi5dj2sYEoXfweP74xgdXK/J2T1edsPXceYA2ZwQXr9OO2isYK+PaYjFfQd2gkRLzU
         FFn4bOGkrfDWqTghhiTOqy2Qbxl2hXhO/a4enZKrd7e5xuwRZPzs8VmnLZo255Kuz6oZ
         PJrXabNcsxfscxUwJn/z4rusL7Tu6X1EgnjQYTMLDWk/+xxCm1kjtWhU0IjsntSdaGv6
         /xSg==
X-Gm-Message-State: AJcUukf+EA8qney5FAE5keK/ZW2X04qTC02+VLDpXhPMszIDZfXg+Ehs
        tvTbKAV8DxFM9pLGb83irkHCyQgSmzo=
X-Google-Smtp-Source: ALg8bN7vzbRoRjqMbTtv/6fG2CcHXyYU9hGVxqG89Xa8OkMJDc0udiZei0505/7Y5eMeu/ePKZe9Ag==
X-Received: by 2002:a17:902:be11:: with SMTP id r17mr6240646pls.308.1548033050922;
        Sun, 20 Jan 2019 17:10:50 -0800 (PST)
Received: from sspatil-glaptop2.roam.corp.google.com (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id 4sm13985132pfq.10.2019.01.20.17.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 17:10:50 -0800 (PST)
From:   Sandeep Patil <sspatil@android.com>
To:     vbabka@suse.cz, adobriyan@gmail.com, akpm@linux-foundation.org,
        avagin@openvz.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com, dancol@google.com
Subject: [PATCH] mm: proc: smaps_rollup: Fix pss_locked calculation
Date:   Sun, 20 Jan 2019 17:10:49 -0800
Message-Id: <20190121011049.160505-1-sspatil@android.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'pss_locked' field of smaps_rollup was being calculated incorrectly
as it accumulated the current pss everytime a locked VMA was found.

Fix that by making sure we record the current pss value before each VMA
is walked. So, we can only add the delta if the VMA was found to be
VM_LOCKED.

Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
Cc: stable@vger.kernel.org # 4.14.y 4.19.y
Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 fs/proc/task_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f0ec9edab2f3..51a00a2b4733 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -709,6 +709,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 #endif
 		.mm = vma->vm_mm,
 	};
+	unsigned long pss;
 
 	smaps_walk.private = mss;
 
@@ -737,11 +738,12 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 		}
 	}
 #endif
-
+	/* record current pss so we can calculate the delta after page walk */
+	pss = mss->pss;
 	/* mmap_sem is held in m_start */
 	walk_page_vma(vma, &smaps_walk);
 	if (vma->vm_flags & VM_LOCKED)
-		mss->pss_locked += mss->pss;
+		mss->pss_locked += mss->pss - pss;
 }
 
 #define SEQ_PUT_DEC(str, val) \
-- 
2.20.1.321.g9e740568ce-goog

