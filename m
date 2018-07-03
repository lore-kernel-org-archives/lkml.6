Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5064247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5064247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeGCXse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:48:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44021 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeGCXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id v13-v6so1640857pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrc0sl6nZD35tMvsnVKDApuQUIkWrYvTwYl0VnNJJig=;
        b=Qi1d9KHTSReQW/oXbUWKL5G5S0H8Z6wFqc0Lh+1kn36BPJVlM38waxPISuSjlWSgjZ
         BODOdnu8sohZKjLHt6+u3AHZefiHakWoK2L7eYAQuEwKeYHUuWFxGSNEaKr2H4GfNV9T
         ERaxyxdtM3wDFRQNB/To6ls/yliw8SFQC9oU8n/iQ3H73/DFk0u+VVDP2UvmgW85sqbD
         VkIm7kzH8KPQoplq+2xLvZHS26W6jMl1U6sYQBVSVfnqB3H/FUfrZCFIdEaT9kvPDzD/
         KPWfSFm5hT6HXB0lHY2M+mR4fLgdYQ9yXxRSU1TnvgrNhPaNUqN2e174VK+YFvtPPjBr
         LUtQ==
X-Gm-Message-State: APt69E1Y2772ziu/BbMew1gUEqdv6GKzCf+uTfRaFFlRQSMmgQAI29SA
        xIFKrbmzx1x5/1xnAPPLZC5uYw==
X-Google-Smtp-Source: AAOMgpeHrexmdDb4kvkD+NCJUszBVH8ECf4liihlj5j3cYaBhPoTbw3emueOWy+YrnnLPjUCuTq04g==
X-Received: by 2002:aa7:8645:: with SMTP id a5-v6mr9522871pfo.247.1530661655892;
        Tue, 03 Jul 2018 16:47:35 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:35 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Date:   Tue,  3 Jul 2018 16:47:02 -0700
Message-Id: <20180703234705.227473-10-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Throttler is used for non-thermal throttling of system components
like CPUs or devfreq devices.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v5:
- patch added to the series (replacing "dt-bindings: PM / OPP: add
  opp-throttlers property")
---
 .../devicetree/bindings/misc/throttler.txt          | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt

diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
new file mode 100644
index 000000000000..2ea80c62dbe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/throttler.txt
@@ -0,0 +1,13 @@
+Throttler driver
+
+The Throttler is used for non-thermal throttling of system components like
+CPUs or devfreq devices.
+
+Required properties:
+- throttler-opps	Array of OPP-v2 phandles with the OPPs used for
+			throttling.
+
+Example:
+	throttler {
+		 throttler-opps = <&cpu0_opp03, &cpu1_opp02, &gpu_opp03>;
+	};
-- 
2.18.0.203.gfac676dfb9-goog

