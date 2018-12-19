Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAFCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349F92086A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeLSXzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39031 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeLSXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so10208743pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RPkl4pipXk1xl7KCOzzXlRGedEKRmNbPEbbe0d6v+o=;
        b=X0KY6/bmRQybL8Mw6X6d+C16dzvwejNENEORSCqZrzjR6XsVo/gwPYmM1q+AGHNpIF
         9VjqeCXOJtWZ10ZqcQeyIYVwSq3hSPJkkygqNxVtfApi8gM7zBIrNLAI0WLmI/H6+osc
         TKtTtxm65RpIrD/mda5lDCcA1aZvXqIZP+ru6y7sZR1GucbL58BpEtLSC2jHWbBadVQh
         nY8ppnDYeOkKWtiEQGkUnb+Wdvk9o0sJheYaurqUXOFviJXFwsHZ8JPgzUhHFDUnf92u
         OZAlO4hqO6fMMgjZWmkjaAr4I5BcgmUFdlBWd4L8jz7oyBkgU9oEUG9fmZgEOBAiEse7
         TM0Q==
X-Gm-Message-State: AA+aEWaBy5yvs+Ie9Zh/LF7iMYgsEZTxuN9RFyJZWgwcolofZVRaPtkG
        MXcRnFCLRa+EYc92Jyb85uk/vw==
X-Google-Smtp-Source: AFSGD/UKJT1Kky5I7L4k2n7TdBxZMtKEFew7iEcgcE7+cqmttR/md9vFTrG6RsWMbMoYLtmlhf7B+A==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr13392636pla.131.1545263742601;
        Wed, 19 Dec 2018 15:55:42 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:41 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
Date:   Wed, 19 Dec 2018 15:55:21 -0800
Message-Id: <20181219235528.114830-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the PHY drivers to get the ref clock from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- added "Reviewed-by: Rob Herring <robh@kernel.org>" tag

Changes in v4:
- added "Reviewed-by" tags from Stephen and Doug

Changes in v3:
- added note that the ref clock is only required for new DTS
  files/entries

Changes in v2:
- add the ref clock for all PHYs, not only the 10nm one
- updated commit message
---
 Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
index dfc743219bd88..9ae9469427207 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi.txt
+++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
@@ -106,6 +106,7 @@ Required properties:
 - clocks: Phandles to device clocks. See [1] for details on clock bindings.
 - clock-names: the following clocks are required:
   * "iface"
+  * "ref" (only required for new DTS files/entries)
   For 28nm HPM/LP, 28nm 8960 PHYs:
 - vddio-supply: phandle to vdd-io regulator device node
   For 20nm PHY:
-- 
2.20.1.415.g653613c723-goog

