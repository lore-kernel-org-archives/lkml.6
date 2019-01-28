Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EA4214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nN/k7Fbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfA1ONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:13:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfA1ONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:13:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so14133156wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i34Wa4ADtzVgCnN+6BAW5HuYsfawNRONPMGoZ75cMs4=;
        b=nN/k7FbpAUE64ZJ4WR6w9uRIWEkLkPoZ+cVxUdGEEuOmK94KEmUGLC84+KILKRJPOb
         HRBp4DT7CjxeTrk7isZqx2BxmpcppcUHhHOsXZ3/YYL168nJCUUcU5A1ZyVGzU6eGC09
         Yq6QN1mgdUeYHLQ/xoGF0n0TeRh17I+zodvtbvK1VEs6pWxDQiC716qgs4katlAPZQvp
         z65Lu1sU+jqc7VF9cuhvXp7vMuLPWmKZcwgbpK5QmifC8cgcW5tZmVY3mewtdr4TQjzz
         nmEQLVVvnEnEfkkW/xbOfi0Kmm6bBahqaa5xlYPECTpVWJhRmxFvPwVquAJ5ztd0n2aZ
         jSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i34Wa4ADtzVgCnN+6BAW5HuYsfawNRONPMGoZ75cMs4=;
        b=lF2zwdVT/oaVK86osjzM9PLR/4Y0mhMTq9WmSP6fV+zTqwr0WGntJmfZNq7HTvz7DK
         mEyspkgowu4xgrZ1oh3tXObS3aiMXrNCkQvazKyDZbM6eIkHyx4/IS1A8GbF5Qsph/FY
         OVtcBePkOatA3S3mMskbr/7X3J8z4EwDqQJW296/X70cz6Nyhpzb5aKTvJ0Uj2neTmjP
         YkwXfPfLeOTbV3KnbrxpVAKFup1AWRCUr66KFd5h2qkX0xkDf5mH4VFFEBJD9jNZdp05
         a/xTvhhfCu/iYgenm6PDJx4vQgm9DA+UXtF8zRi7aa0aCtLStg8j4r++9DrsbWSQ3+5O
         Sz3w==
X-Gm-Message-State: AJcUukfUGdCNlzhpVp4BKPipgwsIWAOdhnZdgFbqkh0l5xbtZzQmxJlq
        KWx+OsMJeX9xVCMHJ0k99yLpTQ==
X-Google-Smtp-Source: ALg8bN4tpAILmud2M1w3bNvNLvOKtgMuuj4xC5W/XQizrhj0boUG9X/8cHDti63hP7KY/pygefsRxw==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr17348894wmb.23.1548684825650;
        Mon, 28 Jan 2019 06:13:45 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id o9sm44131913wmh.3.2019.01.28.06.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 06:13:45 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] reset: meson: add g12a and generic compatible string
Date:   Mon, 28 Jan 2019 15:13:30 +0100
Message-Id: <20190128141330.21927-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128141330.21927-1-jbrunet@baylibre.com>
References: <20190128141330.21927-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the new g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5242e0679df7..a8f6549b3af4 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -134,6 +134,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson8b-reset" },
 	 { .compatible = "amlogic,meson-gxbb-reset" },
 	 { .compatible = "amlogic,meson-axg-reset" },
+	 { .compatible = "amlogic,meson-g12a-reset" },
 	 { /* sentinel */ },
 };
 
-- 
2.20.1

