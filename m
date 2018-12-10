Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20119C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7742082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdL6VWlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7742082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeLJQww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:52:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLJQwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:52:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so11195857wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ortts1jeLglmGDZSNPMXJ+Gydp1wITIqzfWnCQEmT+Q=;
        b=ZdL6VWlIaRzBlDirSPgsbx9b8VyEEoZ0ByyVO5RwlTcr/MiDu5W/v6d+a78Mr8quT/
         YopcL2uC0YXbDMuYXmPEhrHYK9Qy5VOfC10jlsbti/DyPLj7yN1P5Uj7YPN2EUVG6Imf
         X+6yLEh0tTAhGGRreRfptIBV5/9SRJ+U9+IeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ortts1jeLglmGDZSNPMXJ+Gydp1wITIqzfWnCQEmT+Q=;
        b=qY324ZssKgtdz/ENJ0WgDVnVtIfgATZixQH9cOS6GGQuLaWrJQZKYngwdAw2Zkae5H
         NAzMlQ+l4O3OZTA05WzZt6LA5b4NBtY7Q5/mR3uwMkgozSo0XHXO7Oc+FWU8a7ruSgpv
         vq2/GOLAPPREhDaifF1KiDhe0ciOq6AucdhWS/sDRbdBUxtPktlTgRih1XHSo1gMl3Cv
         sMG0Rcjn1V1uywimAGO7omeHeYuX0hyoPyxQFc/otglikN4quXH0kWrVrcafekG+FlRM
         1t/2Aq5DI3GMkGB4EIVp5zKynElbv13nwQD4Fx7CStI4CLPlwaD0Xh92yNp75fFNhlWq
         h4qg==
X-Gm-Message-State: AA+aEWaA8BHCyIEKaTpXvDiFwAtIJd02gYwMCFKXhA1/q2yN8K8fMaxa
        2vtrOABQ1NTN0+H2WxzujDveGQ==
X-Google-Smtp-Source: AFSGD/VMz6en/fWV2xm4uJ+NnIgY9N+dLv2nrjtIJZZix0t4rwrheJHYYMEmFHRygdJNkeB42xL44A==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr10163031wrw.150.1544460768824;
        Mon, 10 Dec 2018 08:52:48 -0800 (PST)
Received: from localhost.localdomain (73.59.88.92.rev.sfr.net. [92.88.59.73])
        by smtp.gmail.com with ESMTPSA id c77sm12877833wmh.12.2018.12.10.08.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:52:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 2/5] clocksource/drivers/rockchip: Change name rockchip_timer to timer-rockchip
Date:   Mon, 10 Dec 2018 17:52:39 +0100
Message-Id: <20181210165243.5625-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210165243.5625-1-daniel.lezcano@linaro.org>
References: <20181210165243.5625-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to unify the names in this directory, let's rename the driver to be
prefixed with timer-*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                               | 2 +-
 drivers/clocksource/{rockchip_timer.c => timer-rockchip.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{rockchip_timer.c => timer-rockchip.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ddf697b29df9..9d0c0fa0d69b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
-obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
+obj-$(CONFIG_ROCKCHIP_TIMER)      += timer-rockchip.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/timer-rockchip.c
similarity index 100%
rename from drivers/clocksource/rockchip_timer.c
rename to drivers/clocksource/timer-rockchip.c
-- 
2.17.1

