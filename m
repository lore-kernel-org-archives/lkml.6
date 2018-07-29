Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CBBC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08FE20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5nizbc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeG2U0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeG2U0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so10363684wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSF8o3Id0Zgpcd/q6+maD80rTPHuqgWeaMtipuETFzg=;
        b=b5nizbc8SkjEFwq2h3pDryXfqCSF112DLl5XYth7JL+9Sisu1ri3t3bIf6tA4Gh50f
         +Z7bflCfbxvKFvpz+ItTeLIjBvfN0eA1QM7NX4qjpRFvUwoJBhY6/uBvw5DE9Ujubrvg
         lR5/pBGpoITc9GzCxJN8CN0ya+qZBZWn8JZ3i7O6iJtN88jQMVa9RX8dqfU2l6SN/AVD
         M0/s9RTYy9y0b/sOnExmiuFto2uoqoJ7qOlLvM5ZvJwojlPT59a/n707+2HNS6xzX/bn
         OUjraS8+dRBBlgTOpBZmI+uUQtIEByk69eB5HgDDo2oGpnbDTTL645ZPMQ/e9c9O3ZRD
         6HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSF8o3Id0Zgpcd/q6+maD80rTPHuqgWeaMtipuETFzg=;
        b=osJLqoz+1/V7LOKQx0pObz1Knnho7lgkefoKU9KZeCQVn8jXPYVXi8EWFn0p0RWO9T
         dOoDyOafyU644NALnRPe74rkpKJhW7M77vvndZthhp5lMhS+P1OcfZRY2nsQOWaPmly7
         KPT1T4QSZSdXOJGwrvraj1OmPELd1eo8DTPoMbAg8eE4rgnsS6qtXJAFMhzomf02bgRf
         dO/7tAbN+qdxYARk8kPqhicmXr6RoG6q4cDdxfveR52/08c7Uioqgm7RmVg/XixyuiLk
         oFgZDN632BmfOOAb5gRyuxbBAPpjtBEkesXy2O5lDMfXS6Sd5N7df3O9ziHrKPh0K9YD
         N2Hg==
X-Gm-Message-State: AOUpUlHLuAD0mg0UBRtFW1jFqwkBaZkR/Z3EGLY2X3f8u0GfVZSZtbtP
        SouBHMbcyg1c2e0bgGt/Mik=
X-Google-Smtp-Source: AAOMgpe0HxPOQFLmMY4Een1aMi0hPpVLpJDQIeDbj/VlHUQqadPHNy4dOn/J+dlLJC+KPz9V2Cg9fA==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr14371043wre.51.1532890508662;
        Sun, 29 Jul 2018 11:55:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/7] staging: rtl8188eu: remove redundant includes
Date:   Sun, 29 Jul 2018 20:54:44 +0200
Message-Id: <20180729185447.19903-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both osdep_service.h and drv_types.h are included from hal_intf.h,
so remove the redundant includes from hal_intf.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index aaa1718ca603..0baf4e616b6a 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -6,8 +6,6 @@
  ******************************************************************************/
 
 #define _HAL_INTF_C_
-#include <osdep_service.h>
-#include <drv_types.h>
 #include <hal_intf.h>
 
 uint	 rtw_hal_init(struct adapter *adapt)
-- 
2.18.0

