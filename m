Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7559F20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STVkav8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfAPSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:46:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41880 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfAPSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:46:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so3199708pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnFz/AG+HRuZACi2rZk82YB8mLxedD5PZQoVniGXyfQ=;
        b=STVkav8DfilZnOzHiehqxmSejo1v0eOj0mNIY35HUu5gLp0znTn/MZKXBN+xvoj6sU
         ZT7r7GPo5/yS+Co1J6S2YZrgPd+RY0qyI4/mWhG/R/idJX1Q/B6FCW0xyjklHJfQ1oQf
         35/WwMB1WQlTIStVt44NjsDpsCj0de2H2ffuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnFz/AG+HRuZACi2rZk82YB8mLxedD5PZQoVniGXyfQ=;
        b=pJLGeC11NPpOvMlZ/Linw1EuXHwElPZxvRlkiz+HGtX3YnmaIXDlVl9K2lsvsUxHL+
         RW686LYwx0ezcPjTPGfCf6W0V+A4Co2kCcevQ2cBo4sc+340PX1XR4Ines+LnwAXG/7g
         LTg3yFqqh5wkYLobJr6J2Mpy/cLlrzn7g36qfjNbuVOAsXVxLp2zl/F2lm+xuxkNJrHS
         Z4FQMU1svFVkzAj4OYG/ePZZdpIIlKq6jiQ1Sxyn4lQBBKTnDbKEyLOexhqUwSrqHvd+
         E//fmbZVKZdmPq59yIUo8116XcE0tTlF8bCVhC0+WlBYeepN9z6p7zfibF8aY0bViRx6
         b7Eg==
X-Gm-Message-State: AJcUukfCp463oQz9pPBjzWafA44QfEJt8f8C5egaMHfZDo4LZAZhMzf/
        vdJJLGNOuoqSoDQD8lEEf59YkA==
X-Google-Smtp-Source: ALg8bN6sk5vEhpdPSkL5GIHaDDxV74Y2fGlWV8HtFkHeIwjDzuKGA9g7AvvUpzvHS4DHPKc1nEBELg==
X-Received: by 2002:a63:f444:: with SMTP id p4mr10122599pgk.124.1547664392958;
        Wed, 16 Jan 2019 10:46:32 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id k186sm8138902pge.13.2019.01.16.10.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:46:32 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] drm/msm: Fix A6XX support for opp-level
Date:   Wed, 16 Jan 2019 10:46:21 -0800
Message-Id: <20190116184623.77136-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for Qualcomm opp levels changed after being Acked but
before landing.  Thus the code in the GPU driver that was relying on
the old bindings is now broken.

Let's change the code to match the new bindings by adjusting the old
string 'qcom,level' to the new string 'opp-level'.  See the patch
("dt-bindings: opp: Introduce opp-level bindings").

NOTE: we will do additional cleanup to totally remove the string from
the code and use the new dev_pm_opp_get_level() but we'll do it in a
future patch.  This will facilitate getting the important code fix in
sooner without having to deal with cross-maintainer dependencies.

This patch needs to land before the patch ("arm64: dts: sdm845: Add
gpu and gmu device nodes") since if a tree contains the device tree
patch but not this one you'll get a crash at bootup.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split into two patches to facilitate landing.

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 5beb83d1cf87..ce1b3cc4bf6d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -944,7 +944,7 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
 	np = dev_pm_opp_get_of_node(opp);
 
 	if (np) {
-		of_property_read_u32(np, "qcom,level", &val);
+		of_property_read_u32(np, "opp-level", &val);
 		of_node_put(np);
 	}
 
-- 
2.20.1.97.g81188d93c3-goog

