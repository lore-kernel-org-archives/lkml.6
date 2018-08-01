Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2711EC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBDD20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db15hkms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBDD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbeHAU7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:59:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35667 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHAU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:59:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so9232744plq.2;
        Wed, 01 Aug 2018 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAJbrA/YfR7XZFVIlgPNgmhmafBwE/Gcygtk7HRyCVA=;
        b=Db15hkmsBTjNalq8a1mRmC2WNBZ3eFO/cX0GSyZSkuq+cG5oXNYv18SNehAAUodHYg
         nIhbFq7NO8p5RwkXB/57MjB6TSfKmOHTsCRzKQDZnreUgrpNvqgtnlJEEtvVqs/k3dyF
         g+pO5dZbyjZPP7fCtab2HTWWlcu3y4WFdU4uK6nPjOK4jPAnKm04i/9vw6gZDsU+j2WR
         K9YB24x+LsBnynboW++jBQCtKvmBvw+2gFzhAGmjpxpO7Fq3Z2DEKTCVLXlzLXgvEzL0
         2uxc7cfjOhp48sk1gbttjQeabCH3w5a0T7WryLKBMl1u3lcKD34Rbg8Mbp0A4ed1S2aX
         wSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAJbrA/YfR7XZFVIlgPNgmhmafBwE/Gcygtk7HRyCVA=;
        b=GvtjOVy/v/LhK5MjV18gMNU8/goaqcm2//IiWu/vKDX7c7yaJGDX9G4a2M2fTPlhC1
         JADG3NVMrj1FU5pZFJdva2equUiaQJM2raHF2eNV+Dqeqv3c2nqai4dwsP53xnb43f1X
         rfC4LanDjAs2mBMgvzOft65XRvAumn/nEgRfZvZCfyoQgPIa8fpe8vwj2zpvLvKoUq3f
         3Jcbni6duRSI0RTalui+hFy6W8n3L/ejE5y6nTEaiVjFifD/3d8Zl0uAKB9p3qXI9gPP
         3Sum87Mg7k/NMMvF2hBmlKzdIwXv8JK06CSMmkYZlrFdZ7B+1ONaieANHgX47luXDKWS
         HCQA==
X-Gm-Message-State: AOUpUlEPo+X2V4fkrv+CleUouOvSYGbj0SldrHqzAuSt7TkiGN3AahNw
        iVYPI591Y2w7yaCtaQyqaMm5A1Bi
X-Google-Smtp-Source: AAOMgpdNDMNz7bN3uxK9RLcLHv+oxIpomXuwYcUoU5YAG+ob94Rx5sxtVarot8nR1UtrGeAFqrjN6A==
X-Received: by 2002:a17:902:3a5:: with SMTP id d34-v6mr2529338pld.98.1533150758942;
        Wed, 01 Aug 2018 12:12:38 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:38 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/14] gpu: ipu-csi: Check for field type alternate
Date:   Wed,  1 Aug 2018 12:12:15 -0700
Message-Id: <1533150747-30677-3-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CSI is receiving from a bt.656 bus, include a check for
field type 'alternate' when determining whether to set CSI clock
mode to CCIR656_INTERLACED or CCIR656_PROGRESSIVE.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index caa05b0..5450a2d 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -339,7 +339,8 @@ static void fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
 		break;
 	case V4L2_MBUS_BT656:
 		csicfg->ext_vsync = 0;
-		if (V4L2_FIELD_HAS_BOTH(mbus_fmt->field))
+		if (V4L2_FIELD_HAS_BOTH(mbus_fmt->field) ||
+		    mbus_fmt->field == V4L2_FIELD_ALTERNATE)
 			csicfg->clk_mode = IPU_CSI_CLK_MODE_CCIR656_INTERLACED;
 		else
 			csicfg->clk_mode = IPU_CSI_CLK_MODE_CCIR656_PROGRESSIVE;
-- 
2.7.4

