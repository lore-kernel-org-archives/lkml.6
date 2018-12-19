Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5384218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="e+AENvv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeLSKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:44:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36503 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeLSKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:44:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so16550724edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GGQPRc/iUFjEn8hOXkye/tvUgI/oUxIe3ZwtGYx3dQ4=;
        b=e+AENvv3Dnjk1FVSmks4/HljSvw4jorr3lW3NZFP3syeuBIAWs0bdjXArxKz1EXqJy
         SK3yI46mTU9VOqDEwb5GP3ltRkRU1bET27ck2qdb8QfujEEX2dH8xZY/nx3tQA/5IsDG
         upxdRwG2GkTAoL/sRDmeKWq8XBOB13r4aVpQ6oyh5LKeIo7k6bq5B1bsuVcqJWuohQsr
         5kmawddbLe4Us2dcnvaJk1NNzHgTJ2oFN6XqOPD+cse0voMdNp5B77cyjwFOIhBwDHzm
         1Ps2LLUemDmw7OkhPsid/pftz50HWt0TJeJYlpas0YcxNfGmiFKmkmCOVVfrJvnQi0PN
         mhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GGQPRc/iUFjEn8hOXkye/tvUgI/oUxIe3ZwtGYx3dQ4=;
        b=Y/bWVSQs2ls4QdISljudtgeJl3MdIQPZUvXoF9vj63ch3KRPHz0BRtB8DeMz9A4MQp
         ABHSNmAzKYCNzU7i2LXEROnrhIx4OAL+T+99XgYsdN00zCYch2rt3pXRIUsSxhmLamqp
         l3OlehGVOLDxDt5lj67VtaHNVedMmNT85+dXEeXctzhKCWZkqPy9WHBXDv132SnK0SyJ
         uuu8Ghy9RyJK4SkpCsATpckNcb+B1dPW/CAFvueahhV/kT4rKn9H72ox7r90nVIy5obQ
         FVDJt/r98NKhHB49cG9TBQdQuRlyZ/zgQAv5DGtLnrSoK7P7b3VQzPiykA/UNVY9cQ7e
         aYrA==
X-Gm-Message-State: AA+aEWaBU6qMmnNyVtlsrPk6wLB+6EvkTwkXIA9YvEsdkAyC+HTjWHHM
        pLSDXSGCqbKuf6Fl1uqgULCeDA==
X-Google-Smtp-Source: AFSGD/WS61rd7+gchhnpFwxv1TO5KXcmNeaI9iWxECwpfwpBVE/Fpn/5vrAda5+AEY4vKD2Nud0V7A==
X-Received: by 2002:a17:906:30d5:: with SMTP id b21-v6mr16334648ejb.42.1545216250672;
        Wed, 19 Dec 2018 02:44:10 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id i46sm5271125eda.37.2018.12.19.02.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 02:44:09 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     patrick.havelange@essensium.com,
        arnout.vandecappelle@essensium.com,
        matthew.weber@rockwellcollins.com
Subject: [PATCH] EDAC: Add mention of LS1021A inside comments of fsl_ddr_edac driver
Date:   Wed, 19 Dec 2018 11:43:23 +0100
Message-Id: <20181219104323.10324-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale ddr driver also works on the LS1021A board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/edac/fsl_ddr_edac.c | 4 ++--
 drivers/edac/fsl_ddr_edac.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index efc8276d1d9c..5c11f3637651 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -2,8 +2,8 @@
  * Freescale Memory Controller kernel module
  *
  * Support Power-based SoCs including MPC85xx, MPC86xx, MPC83xx and
- * ARM-based Layerscape SoCs including LS2xxx. Originally split
- * out from mpc85xx_edac EDAC driver.
+ * ARM-based Layerscape SoCs including LS2xxx and LS1021A. Originally
+ * split out from mpc85xx_edac EDAC driver.
  *
  * Parts Copyrighted (c) 2013 by Freescale Semiconductor, Inc.
  *
diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
index 4ccee292eff1..589b9b4a5e8a 100644
--- a/drivers/edac/fsl_ddr_edac.h
+++ b/drivers/edac/fsl_ddr_edac.h
@@ -2,8 +2,8 @@
  * Freescale Memory Controller kernel module
  *
  * Support  Power-based SoCs including MPC85xx, MPC86xx, MPC83xx and
- * ARM-based Layerscape SoCs including LS2xxx. Originally split
- * out from mpc85xx_edac EDAC driver.
+ * ARM-based Layerscape SoCs including LS2xxx and LS1021A. Originally
+ * split out from mpc85xx_edac EDAC driver.
  *
  * Author: Dave Jiang <djiang@mvista.com>
  *
-- 
2.17.1

