Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72C8ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7879D20824
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7879D20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJ0PDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:03:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40762
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbeJ0PDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:06 -0400
X-IronPort-AV: E=Sophos;i="5.54,430,1534802400"; 
   d="scan'208";a="283492157"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 08:22:59 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Rob Clark <robdclark@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/msm/hdmi: constify clk_ops structure
Date:   Sat, 27 Oct 2018 07:47:42 +0200
Message-Id: <1540619262-22681-9-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_ops structure is only stored in the ops field of a
clk_init_data structure.  This field is const, so the clk_ops
structure can be const as well.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index 0df504c61833..b19a520c47d5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -689,7 +689,7 @@ static int hdmi_8996_pll_is_enabled(struct clk_hw *hw)
 	return pll_locked;
 }
 
-static struct clk_ops hdmi_8996_pll_ops = {
+static const struct clk_ops hdmi_8996_pll_ops = {
 	.set_rate = hdmi_8996_pll_set_clk_rate,
 	.round_rate = hdmi_8996_pll_round_rate,
 	.recalc_rate = hdmi_8996_pll_recalc_rate,

