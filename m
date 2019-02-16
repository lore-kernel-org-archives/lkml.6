Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A9EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FFF222E8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZApq5ARU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfBPPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:18:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:18:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so6244466pgd.1;
        Sat, 16 Feb 2019 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+obBbYPLyLsKhLxV8PUlhQAAQv38YOeGGO7KFLMs+Qg=;
        b=ZApq5ARUqTtxqWC5/5JV0YaBezInejDyj6EGPwJygz1ZzC2fQxVkOcoYF8F+TIdMut
         HrgrjFyQ0AHXfuEsU+qjyu6NcWkzmgz63yfVTXEUwojBlNpNpFEiTI30FITHGRSn0Z7T
         BIdedU1l8EARcAFafP4QFF7SUpbTo22l2kMs3QdVZUexLrvVW1MnQu9CMS8btXdhslxo
         Ml5mIjykFDWvYelPE57opWetc4PiphyKWmMlftsONq96i/zoxUJSRQqWGzHlc/PfJBcL
         XQep5OKWKpWKrr8Z4KVTObM4ENOJ3/lQ23Z23GXLU8Kjqy7t8x/+5XOd15sLfZlfa4ZQ
         d+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+obBbYPLyLsKhLxV8PUlhQAAQv38YOeGGO7KFLMs+Qg=;
        b=cMRVFq1DbBs6Xcv3NFsBYsLO819RZvp21QMyBKdMyVYak30frpVp7Yi9s/gtRfNsuh
         Tmo7Z/yylC2buTJ7Gjv/MOdpZxXGU9RLF+r20fzls0DlzCcqLbxtNLA6UiNodw+knCwf
         a65NVFla14tuDFtqE+rbQ8OlPRoj3unVDNKh6Lbf/sHP6PEIpXji4k22rXdVSUTnPYcl
         c3tOL+n5juORoYpHq/Vh67WVKJ44yrVbSmZaNi0sNH0Tz0fOr0MpipzzHR1TP51ODGgm
         KgWoX2QkbRJ2mrHLQqHNVnWYKcaWUW76fcVGVAh5gla5uco7xdnZbZz7F2flbDX03K9K
         rIcg==
X-Gm-Message-State: AHQUAuYqtHokr+w7NJDTEgOhgD1XJe0I2c6pUD8wV52t/n5WZ+S+LIM7
        zMNnNgoR0Q4K0bYmFBkU23g=
X-Google-Smtp-Source: AHgI3IbtrZw4sGn50oUZ86X8w9u9PrweIiAeOQdwAZ1aS7aoSuX3u+JF+x08xKMnmUAgA+vk1XqjXQ==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr6363518pfa.130.1550330330158;
        Sat, 16 Feb 2019 07:18:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q28sm23926492pgl.35.2019.02.16.07.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:18:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date:   Sat, 16 Feb 2019 10:18:26 -0500
Message-Id: <20190216151826.11584-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is not used after initialization, so
remove it. And in order to unify the code style,
move the location where the dev_get_drvdata is called
by the way.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c59d2eee5d30..c89ba7b834ff 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
-	struct tegra_devfreq *tegra;
-	int ret = 0;
-
-	tegra = dev_get_drvdata(devfreq->dev.parent);
+	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
@@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
-- 
2.17.0

