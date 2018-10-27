Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EEEC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7323620824
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7323620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeJ0PDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:03:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53787
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbeJ0PDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:00 -0400
X-IronPort-AV: E=Sophos;i="5.54,430,1534802400"; 
   d="scan'208";a="283492149"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 08:22:57 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 0/8] constify clk_ops structure
Date:   Sat, 27 Oct 2018 07:47:34 +0200
Message-Id: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare as const clk_ops structures that are only stored in const fields or
passed to functions with const parameters.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

 arch/arm/mach-vexpress/spc.c             |    2 +-
 drivers/clk/clk-max77686.c               |    2 +-
 drivers/clk/clk-palmas.c                 |    2 +-
 drivers/clk/clk-s2mps11.c                |    2 +-
 drivers/clk/pistachio/clk-pll.c          |    8 ++++----
 drivers/clk/pxa/clk-pxa.c                |    4 ++--
 drivers/gpu/drm/imx/imx-tve.c            |    2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c |    2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)
