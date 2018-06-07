Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id msJZKbF1GVutCwAAmS7hNA
	; Thu, 07 Jun 2018 18:13:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6D88C606DD; Thu,  7 Jun 2018 18:13:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D02A9605A2;
	Thu,  7 Jun 2018 18:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D02A9605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936132AbeFGSNP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43797 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934260AbeFGSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so6624566plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c7fdvWNKOBcgQ2lK4SZ+rZRb6VpIbvrFe2W/scHJXOA=;
        b=jpmsBuiVGn4difTCeYXBfHOhJILCyoR5nLSqlI0951RbjR7lR6A81HCy9/e08rXEJu
         3ps4frxPMVgHqkgesblvhvfry2yFeILaKi3UOdpVdldGC59ues5o0uISa0JhqL1UEazj
         iDCaAF5BqV7jr0F5UcuB/puS4AQ9mDOP1pFM/rxmcILvG6bgO0Bc0ivPjF3KUft7b6f8
         h61buNLBnwP2YMzPPW/3+WN0bHFqx7q4uRp6G7/4G/rERN6XAhjUDfb5QfysMSV57xaD
         AuKawz7YHwHBnYkzJKdp9AYJ7iQvFbxKRyTp7F/ihfGNIWpZFdsHyD1I+lHJ7Sho4U6w
         5M6g==
X-Gm-Message-State: APt69E0M6THcLH+qxtL56mtPbBoHCYrGcknY4gmJRR9/wjDvb4V1TBPu
        JTJjLKLhyRJ1zWeU2tI5QnNK6A==
X-Google-Smtp-Source: ADUXVKLPksZrLQrC0En40lTvE2Og5NXWgD0bEw/S/zSCxRv5Z5ThMCRubpbD8MUhbK1dfPP2wIwe8Q==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr3112838pll.243.1528395187214;
        Thu, 07 Jun 2018 11:13:07 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:06 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 10/11] dt-bindings: misc: add bindings for cros_ec_throttler
Date: Thu,  7 Jun 2018 11:12:13 -0700
Message-Id: <20180607181214.30338-11-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros_ec_throttler monitors events from the Chrome OS Embedded
Controller to throttle the system if needed, using the mechanisms
provided by the throttler core.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to series

 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt

diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
new file mode 100644
index 000000000000..7316dcc0ef75
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
@@ -0,0 +1,4 @@
+* cros_ec_throttler driver
+
+Required properties:
+- compatible: "google,cros-ec-throttler"
-- 
2.18.0.rc1.242.g61856ae69a-goog
