Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F21C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735EE20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCBLA9yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735EE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLACKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:10:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39995 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:10:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so6173392qtf.7;
        Fri, 30 Nov 2018 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yi3QxUDrTuf8SJj23ZTRflIxXEj4e3uKqUxXVSvJuzU=;
        b=mCBLA9yJbcz0GD//e/LQzG5Qb98Oc69epSVqbbyoPFJu5/49Zv6B3v9Jy8W+xM5r2E
         UVIL5VVN3UF6+7cXLe5hwQuMHfDKQOAkpPG2mJ8QD9V7YM8gR7qNveyHfd+I1Lwu6vDA
         JvbmOmjmKTPjFP9b5M3Y5Wgx0TZDcuBZkBtEd5v0xcoBJJ/Sgd0x5szbX0wWuWzOVhZz
         E0mGG6rQHn6nPqbAKGQkEZ8c04UpD8CQSCZaZCcnuqxDYeiw77B11UoaxcephO4X8wdd
         T4M/AJdIBlShAMdmJTgagwx0A7gZZUJnYRdBiavIRuI7OQX8VeVQL/qyroAyPvmrqO3N
         41iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yi3QxUDrTuf8SJj23ZTRflIxXEj4e3uKqUxXVSvJuzU=;
        b=lAwyOzYJMKjLfPMEWKP+KwYxwFeB0iPB2OPd8dUfSK2uEh4Se35v7/5SQMCyqGqNyQ
         A72bet/kF5/KkS2YxJXO7jQZ4FdrrfpsFYVD8A7sFChIQAlsFd9Wwqd4iXlem3hni049
         skJsMrMsQjXYiesT3ojq/KLewC0RjVr+IMrUVhqD1OQPaXFiU1w4t+jSWMJuZThx11E2
         iom0PdrLtBlvJ8ArbwFZuaAtWp5FJzrCsTY4lhnGFUVUU6NE5zl/YMHXKpx+4my8cTrQ
         ow9ySG04LNHGfIgFIk5r/WW/QdgiEm6McZCBoDnoeN6/vqN4/49q3cqnBch0cfABLPug
         SWpA==
X-Gm-Message-State: AA+aEWZ7AvfCaH0os2ibdfK+uHDOuqqsmuWro0SWvl446f7sfoJ70wNB
        emuupwFhgxJofMPD2KK1yj8=
X-Google-Smtp-Source: AFSGD/XneYnsdpJDQ4UwdEsfqUPSe+qWevU8uynMC8lRrCQA3lW8FTuLIRott0SuZJqHXcmpUOIr6w==
X-Received: by 2002:aed:2fc4:: with SMTP id m62mr5508622qtd.8.1543590070766;
        Fri, 30 Nov 2018 07:01:10 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id n8sm2986525qtk.91.2018.11.30.07.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:01:10 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/msm: bump UAPI version
Date:   Fri, 30 Nov 2018 10:00:42 -0500
Message-Id: <20181130150050.13762-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130150050.13762-1-robdclark@gmail.com>
References: <20181130150050.13762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 6ebbd5010722..782cc33916d6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -36,9 +36,11 @@
  * - 1.3.0 - adds GMEM_BASE + NR_RINGS params, SUBMITQUEUE_NEW +
  *           SUBMITQUEUE_CLOSE ioctls, and MSM_INFO_IOVA flag for
  *           MSM_GEM_INFO ioctl.
+ * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
+ *           GEM object's debug name
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	3
+#define MSM_VERSION_MINOR	4
 #define MSM_VERSION_PATCHLEVEL	0
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
-- 
2.19.2

