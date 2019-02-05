Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD16C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191EC20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfBERwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:52:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32958 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfBERwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:52:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1833301plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 09:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VqdMM+w0qT/K7e9KJmdykIErjiwD51l9d/UiASd0yI=;
        b=eUTNsVyi8TFuFeoaufMRO1tmVcffMINGAhlVw81Qlvd2MnAL3VoaaJ47potceNiU7L
         /2brXoHjB+T1alb13a058OYrVrm/KjcfzkqGu1oao8RCFLvo4WLifqC2vhV8tiV6/nnu
         5J+/KlRfwaMAoC6XYNSw2ouyxQDIXs+7hZ0Rd87jo/49QdSU1pqmGMjrz1x8rgErWhq7
         ovVjv+YiDYQYFfHmZufJL2r51y4W9/U2gZuzLImEghQaf1CHhuXIUaMVNikAD4L3ZWnA
         5ZXF3hJDE6XeR7vc9QJv0lVdfaiXTN6bqfUoEyBUKEey/jaMJvMYkhgo0PCydURYKOLF
         ygMQ==
X-Gm-Message-State: AHQUAuaXyX/W0sNZQroVal9CJijwFS4VPm/6ZUD6DD/hzh1cKC/0/Hv+
        yNjTgb698y3H0tgGYruFiwyTPg==
X-Google-Smtp-Source: AHgI3Ib6RXJt5ElBZ9izg3szJBC/E9z6G3PfrBwxlRYuo4v44yqQw+q4lCZNCEb+c8BP7RerBeaqEg==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr6396409plt.106.1549389162105;
        Tue, 05 Feb 2019 09:52:42 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 85sm6030280pfw.17.2019.02.05.09.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:52:41 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Quentin Perret <quentin.perret@arm.com>,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] cpufreq: qcom-hw: Register an Energy Model
Date:   Tue,  5 Feb 2019 09:52:24 -0800
Message-Id: <20190205175225.25923-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try and register an Energy Model from qcom-cpufreq-hw to allow
interested sub-systems like the task scheduler to use the provided
information.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4c..a16b9dca7ea3b 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -205,6 +205,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	dev_pm_opp_of_register_em(policy->cpus);
+
 	policy->fast_switch_possible = true;
 
 	return 0;
-- 
2.20.1.611.gfbb209baf1-goog

