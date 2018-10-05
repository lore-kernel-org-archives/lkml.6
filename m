Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17BAC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974022087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ct2Jcbwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974022087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeJEVfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbeJEVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so13783382wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXoDlSPIn523AVdKM/v0uZychMluY0rp5+e9GQuiKvI=;
        b=ct2Jcbwhpic+wCSSfpbBOF9c1urHOHag23UBcqm/mQbSTPkK4ZPkkwcd/+pGvKUAWZ
         NodfjNX9/oZAh1D4AzORAShnEDpDVEoP0GK4/fiWeXEu8PyYISP5GntLTs/UhZ9GxRLn
         RKInc71BmmKZwQ653tTDMTTK0y3Be1YkK7MB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXoDlSPIn523AVdKM/v0uZychMluY0rp5+e9GQuiKvI=;
        b=OAClEMQ+WE4OTkq61K54s8nhfrc3Km1k1h6WcaWF0YW9vJpUNYISZMo+SpmS5I7Jat
         ov2K5h23PLjzqH7DpXCFehS/Bfyp9h8GXrw23bboD4+bj0iCOH9X+ir5Hpzt3KoRlQ7J
         Elh11U4/p3o2JoPM6hexDRhHniTIzYBokj2IldeDpZVRWJ2JcJB5fun6kOUbLmAGaumU
         vubrfXhxeLj0j5KR55VtrfuIjI2hD1EhS5B5IKgd7/t95g4ZGinMe1MV3pPbhLLkIgJQ
         Hvpfua16SInPREtN6go9yfy4L2XlwOxlYjvtBgG3zbbLGiXFx9rbgoTcCPUdWCnMJhSa
         cOHQ==
X-Gm-Message-State: ABuFfohBOEZyzX9y87M9WNUJNlYt7PQZe0Nod8aSzZizvL1jby5yX8qq
        hSLQUB300H0jNE2AdAc8754+aRlTpKA=
X-Google-Smtp-Source: ACcGV63fLsaLiggPPBcWm4A/84W0nKk3ssaDGZesRr6W4vi5lEXSTTY+nH+gjuWpLYL7/y2TMEk2DA==
X-Received: by 2002:adf:91a4:: with SMTP id 33-v6mr8541366wri.37.1538750171476;
        Fri, 05 Oct 2018 07:36:11 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/13] clocksource/drivers/sh_tmu: Convert to SPDX identifiers
Date:   Fri,  5 Oct 2018 16:35:34 +0200
Message-Id: <1538750143-4282-5-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier instead of verbose
license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_tmu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index c74a6c54..49f1c80 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - TMU
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
-- 
2.7.4

