Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB91EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833BE208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNKBozBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833BE208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbeG0Syw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35548 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbeG0Syv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so6334566wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIl/Ibhfq9NRT2E7Vgjkv3H7UssH2g3IicLfZTPpnew=;
        b=NNKBozBxmd8cOD1DVao+ofsqNZtFP/+wZv14JL2ACt4SURz7GPtRZm/2qCDH6csL2y
         Nx6nAi1im2gs7TtNkZczb/w9j/wPVfy/kuzyy3pm5uDAAFP0v8Yfc0L5nTC4BJkxCftt
         N9JipzW36YEqNc9Ut6yRs2T6HuJZK8zaBm+Af+EJEZKrgnlJTg4gUPA+FV03CTEs7yOn
         GfpTOQI6ubWSoA/VWd3s3fGWB2Rb3WXI/AQSHA/CYZLXo+jPoVAUerfZN5XkNe1vMzfU
         XVCKf7YpnCk04hWULY5zITWH8nzqoyq0RpxQiwpWHAc5cLKNvDebJVuJSdK7R2+KW6vp
         hJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIl/Ibhfq9NRT2E7Vgjkv3H7UssH2g3IicLfZTPpnew=;
        b=HuprXg9UkCaCOT0ETYzfz1IkTGqUlolehvrbNlEtdGZN3KZzUJKhq5A3czC2hvVi0/
         T9gzhMWo9p9rywKHSvETeVi/lm/BBJv92uQt2VJsOurR+cqOqdjBCziYtIH30En+xLqx
         I5HYyLqPwUJ8jSTQP7LoW7a3GHV95IYhT8L9qWTS9+I2hxiv3FUETafMqgt3ffAnkqud
         H2XkTrd920f857vnmYK9tZWGqwY1kUgREvDP/+8Mq9E+SI0XbK7EXT8BLcBap4tnwBC6
         R1jb3kbeh4gCbV3CbqBuOl96vpvVZt7xjazHb/YTkKHBmfj2jxScILUjV8rd1HU8VTQM
         L1EQ==
X-Gm-Message-State: AOUpUlHWy7pcrLP4Z/qpIqhZPem6Ekad3z8ndM2b4+0ZaDL+x0KpKsNp
        duSK26vggfSjpmpvHiThBGR8Mho68yY=
X-Google-Smtp-Source: AAOMgpfE8HuXiICBwp6Td3B6ebEtjpaMas0xHE7Tq8hpessHqrluQiLwPsvJ9o7Zt1X37lkdBM+7rg==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr5376832wmh.39.1532712716760;
        Fri, 27 Jul 2018 10:31:56 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/20] staging:rtl8192u: Remove unused timer values - Style
Date:   Fri, 27 Jul 2018 18:31:15 +0100
Message-Id: <20180727173123.27391-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused timer constants TS_SETUP_TIMEOUT and TS_INACT_TIMEOUT
as neither are used in code.

This is a style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 2840d6e8dfda..0db0d01ec5c4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -2,8 +2,7 @@
 #ifndef _TSTYPE_H_
 #define _TSTYPE_H_
 #include "rtl819x_Qos.h"
-#define TS_SETUP_TIMEOUT	60  /*  In millisecond */
-#define TS_INACT_TIMEOUT	60
+
 #define TS_ADDBA_DELAY		60
 
 #define TOTAL_TS_NUM		16
-- 
2.18.0

