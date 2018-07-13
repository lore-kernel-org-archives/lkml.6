Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A8AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40063208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W3COUF8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40063208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGMMEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:04:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40742 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeGMMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:04:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so9130664wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dL3fbHEYEis3CL3i6kGUL4wtxq8vbcVis/zwlNTlqk0=;
        b=W3COUF8IBI/pwE/gjBTI03QmhLQ7spjL9+N0ikGetrDdt7HH+249U/nc2eAqwt0y34
         vrN3Dnv3QeIg9gHV9Rbc7K3TGOBkY9V6ucKDLi3Arzn2AiXELet61yehcVUimPhXIPYj
         Cs/4SkeSkkVaDxx+9oIZqvZ1YaVSn2maE4+qU5m0mH7pCe4qjQZ/D+e4UDiOkPopoJnX
         jpKd0oMm8xO8tL1taKz4yCVg0EOwpa9YLpASJSkjZpAz2S9oXy6sjfEAPAMeJxQt4d9Z
         qTcK2Myog3QZV9/I+yO9yXiTXhQ3/Oy3qsMVWFBOc7iWd9QPVCUe7dPvWxoEdd69QEHr
         EGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dL3fbHEYEis3CL3i6kGUL4wtxq8vbcVis/zwlNTlqk0=;
        b=eGapkex5/BmAS+aTthsS3mfx/ruAC5ncxXSw67pa0WG42CYA49EdsNONe3DWvs5qTz
         MoXhcXD0gxDGRxxdLTbOWfuE/h+LK6gs56Vk/CGV5ZaB8d+E8ZecoeWJo7iAyW5tj0Yk
         SnD57VuMh7YQ4fclFyvKUF5UGHR8hxvaczA11lyk/apPR2Pm9gNIcyncBjE/3z6yX0uA
         4/Jm5ZCer4o/A1ctTn8azZMwRxtrZzaxLHpTpr64fZvCvD3AmwePQKoMrLRN6xsa4X5B
         htdlmRmNIi3HL8nkzCmEz6LLkHWTw98rd82/GYKOhaqKwRUl3UVpnhSOFXeUaMYgLsF+
         AHgA==
X-Gm-Message-State: AOUpUlEVlgVcOH9tCEbPBLaub9sftSmSzkjA7Bp6JFgOBXU43azn9bQg
        WQ+DE/tJYrH6nB7yWKWTi5P/lw==
X-Google-Smtp-Source: AAOMgpc3xtmI5EYCJbkeiOrDP0GI3PSMUZn9Qa2PlhOmjJiUgyj/KyOvb0ndvEGhszJDP9ad4ZSniA==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr3771049wmb.14.1531482620407;
        Fri, 13 Jul 2018 04:50:20 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm52280310wrv.23.2018.07.13.04.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:50:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.torgue@st.com, peppe.cavallaro@st.com,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: ethernet: stmmac: fix documentation warning
Date:   Fri, 13 Jul 2018 11:50:15 +0000
Message-Id: <1531482615-12905-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the following documentation warning
drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:103: warning: Excess function parameter 'priv' description in 'stmmac_axi_setup'
It was introduced in commit afea03656add7 ("stmmac: rework DMA bus setting and introduce new platform AXI structure")

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6d141f3931eb..72da77b94ecd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -94,7 +94,6 @@ static int dwmac1000_validate_ucast_entries(int ucast_entries)
 /**
  * stmmac_axi_setup - parse DT parameters for programming the AXI register
  * @pdev: platform device
- * @priv: driver private struct.
  * Description:
  * if required, from device-tree the AXI internal register can be tuned
  * by using platform parameters.
-- 
2.16.4

