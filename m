Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E7C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151EA20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151EA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLCLWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:22:34 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:40789 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLCLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:22:34 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gTmIQ-0004Zj-Vy from Jiada_Wang@mentor.com ; Mon, 03 Dec 2018 03:21:51 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 3 Dec 2018 03:21:47 -0800
From:   <jiada_wang@mentor.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <vladimir_zapolskiy@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v2 0/6] clk: renesas: adg: add AVB Clock
Date:   Mon, 3 Dec 2018 20:21:54 +0900
Message-ID: <20181203112200.18220-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
and 8 bits fractional dividers which operates with S0D1ϕ clock.

This patch-set adds 'adg' clock to R-Car Soc, and changes adg driver to
register avb clocks when clock-cells of rcar_sound node is 2.

---
v2:
- expends adg register size and register avb clocks instead of
  add new clk-avb driver
- Add adg clock 

v1: initial version

Jiada Wang (2):
  dt-bindings: clock: add clock id for renesas adg clocks
  ASoC: rsnd: add avb clocks

Takeshi Kihara (4):
  clk: renesas: r8a7795: Add ADG clock
  clk: renesas: r8a7796: Add ADG clock
  clk: renesas: r8a77990: Add ADG clocks
  clk: renesas: r8a77995: Add ADG clock

 drivers/clk/renesas/r8a7795-cpg-mssr.c  |   1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c  |   1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c |   1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c |   1 +
 include/dt-bindings/clock/renesas-adg.h |  11 +
 sound/soc/sh/rcar/adg.c                 | 306 +++++++++++++++++++++++-
 sound/soc/sh/rcar/gen.c                 |   9 +
 sound/soc/sh/rcar/rsnd.h                |   9 +
 8 files changed, 330 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/clock/renesas-adg.h

-- 
2.17.0

