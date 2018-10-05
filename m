Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EDEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E070A206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRUMqaP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E070A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeJEVfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33108 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeJEVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so13835359wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpC2myP4enAh1elLwx8oabXUJ3NuAsB2wIpuUzakzrk=;
        b=GRUMqaP6BranVlbpd9aI4wJsS75eQLDDywUx/fay4BniJCoJuJhmy8ZYkcc5gP5TXq
         grXQz7tLPuELOoM2oK+tnL+IfQRcwVVs7wYeZJscXvJua6il2iMU3Kdp6HQAoKmvA23V
         Mpy0qqN+AJ6FyM7Trmr6v4M6EU+qME0Becb3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpC2myP4enAh1elLwx8oabXUJ3NuAsB2wIpuUzakzrk=;
        b=O7NfqxEZF7gX9ClYv918AI9JUIME3Ot3k4uug0vs+LX5eUKZ3tHdO8xOEkoG0N2ECT
         9e7h+VwjgSjykTcp3W21LQsCwby0u/smrkIG4hAlETpWo3hbyAEhO1ybtzyOJJV8C6v5
         DwATvjsZZf8lIrPqk1Hu5ZZAFj0Bn7vLg40bxRwwN9SHc7e+b+IA7QFwk6BH0ppXbkvr
         LNJTxoyUfOnfxp4muek8niLxeDXmAdesRt8wfuHf9XJ+PbPLwzqDMt/V70fkxJlFa/dg
         o6W5gbDAoOwXGyWngm6z7WzI6TcqsV16tZS4o2jYPit603DUnywJK4QSMesIIaY9Eyzb
         mkVw==
X-Gm-Message-State: ABuFfojzcMsxYEGrScaCgLN91hw4FbyxrAdY7UtdauuD3sUi2rVHxO68
        DF9qqa2Mty/O2D2yTdWYT2dd3eYAcoI=
X-Google-Smtp-Source: ACcGV61babgT/hFMOSXx0rrmxqgFil/wHF0yipJVcKoTc9h/3kLjCle5e4BirY1oFp6trqYNcNHUXQ==
X-Received: by 2002:adf:c594:: with SMTP id m20-v6mr8556616wrg.30.1538750168175;
        Fri, 05 Oct 2018 07:36:08 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/13] clocksource/drivers/sh_cmt: Convert to SPDX identifiers
Date:   Fri,  5 Oct 2018 16:35:32 +0200
Message-Id: <1538750143-4282-3-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/sh_cmt.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index bbbf37c..6f65cf8 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - CMT
  *
  *  Copyright (C) 2008 Magnus Damm
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

