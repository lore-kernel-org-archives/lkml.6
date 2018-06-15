Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C15C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC646208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLhc2Sy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC646208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756414AbeFOSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:43:35 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46060 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756481AbeFOSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:43:33 -0400
Received: by mail-yw0-f193.google.com with SMTP id v190-v6so3664408ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwB2JqvU35OgCpuqqpDXbBmOaJj8Quzl6zj3HmShKiQ=;
        b=tLhc2Sy134oGEnv5+n6tFAiDv0lc9b/PJ2cJFY7w1ltdOm+Trqjg7ThFP+MJI5XazM
         ngZ3tm+q/XLpAVM3S9YPgLangd1sjX14CTV+zZ+QmTzpEHdrurtTbRnfrZ91I2HMCzig
         jzccxcZkccYxD5XOp4lgdZVk1JGWbSkk78VQiTQuv/WgcL9PYpW28nSG2X0l1T+WyC4D
         3W1KvvManAVqSOjaFJxczxf3JBDc+dclwwaBSVIXTmWmUgwq5RkpD+gBtYBwzOgp83R7
         cdPaJieUR1z+kYqLNYeCEJLKVHVu7GGa8YWVk59Tz0G7fEYNH3AVKiF6z8ufAZI9AJAj
         sL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qwB2JqvU35OgCpuqqpDXbBmOaJj8Quzl6zj3HmShKiQ=;
        b=tPxszoXCew9Sy7QhY8/LQkW7aWeV+qrhlGuqSbElmsZ6sQ2x9EElq0OBDwO6VlDhQe
         2ujok+4OjydP4pGLb2Td+2s6ENjWO6bXYYTXESRGAHmxuUlRFnpYXh2Uj8dOj88KYzu2
         WOb79CsDQgrTdDlA9fxzhKxzyISQWFNHEexjDdYwbZhQ/gkymascyNg/ouqyBqyPuEM5
         ZXnaue+ZxRZourdxh9MGozoemnc/kUFct/UxuT/J4AOhH5yjM4A9d+0iQsf/sRbNfa7J
         ZuvXiWRsYVy6SLw/xw89mNc2wEPRYQglbhWxcHu+hiU1dkU3WHvxqVKlqKuj/muis85i
         klTw==
X-Gm-Message-State: APt69E14QMYrmCjrRtzwRaltUtFjM59mL15ck1BxXLn1Jc3lJNDJ9QxO
        lX8Oz1ehA0CesEX7XkujxQM=
X-Google-Smtp-Source: ADUXVKKzuX48YkP/TCIl6sTpsFngqs618f1jvR2CeWDVryIJUdekpFKbDXeDbK5wGyWfPNtnJZpXJg==
X-Received: by 2002:a81:4303:: with SMTP id q3-v6mr1470313ywa.98.1529088212686;
        Fri, 15 Jun 2018 11:43:32 -0700 (PDT)
Received: from localhost.localdomain (50-248-107-19-static.hfc.comcastbusiness.net. [50.248.107.19])
        by smtp.googlemail.com with ESMTPSA id v7-v6sm2872567ywv.91.2018.06.15.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:43:32 -0700 (PDT)
From:   ankit patel <ankit.mayurbhai.patel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ankit patel <ankit.mayurbhai.patel@gmail.com>
Subject: [PATCH 2/5] Staging: comedi: comedi_compat32.h: fixed missing or malformed SPDX-License-Identifier
Date:   Fri, 15 Jun 2018 13:42:13 -0500
Message-Id: <20180615184216.18483-2-ankit.mayurbhai.patel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
References: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed SPDX-License-Identifier comment on first line

Signed-off-by: ankit patel <ankit.mayurbhai.patel@gmail.com>
---
 drivers/staging/comedi/comedi_compat32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_compat32.h b/drivers/staging/comedi/comedi_compat32.h
index 3980e6e1bd0d..dc3e2a9442c7 100644
--- a/drivers/staging/comedi/comedi_compat32.h
+++ b/drivers/staging/comedi/comedi_compat32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * comedi/comedi_compat32.h
  * 32-bit ioctl compatibility for 64-bit comedi kernel module.
-- 
2.17.1

