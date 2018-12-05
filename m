Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FA2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3FA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeLEHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:48:17 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41786 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:48:17 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gURul-0005cZ-J2 from Jiada_Wang@mentor.com ; Tue, 04 Dec 2018 23:48:11 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 4 Dec 2018 23:48:08 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <vladimir_zapolskiy@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 0/7] clk: renesas: adg: add AVB Clock
Date:   Wed, 5 Dec 2018 16:48:12 +0900
Message-ID: <20181205074819.27944-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on R-Car SoCs there are AVB Counter Clocks, each clock has 12bits integral
and 8 bits fractional dividers which operates with S0D1ϕ clock.

This patch-set adds 'adg' clock to R-Car Soc, and changes adg driver to
register avb clocks when clock-cells of rcar_sound node is 2.

---
v3:
- Removed clock id header file, added device tree bindings documentation
  instead to describe clock id
- Instead of hardcode parent clock name in adg driver,
  refer to parent clock via clock specifier in device tree with 'adg' name
- Added patch to add ADG in r8a77965
- Some other fixes

v2:
- expends adg register size and register avb clocks instead of
  add new clk-avb driver
- Add adg clock 

v1: initial version

Jiada Wang (2):
  ASoC: rsnd: add avb clocks
  clk: renesas: Add binding document for ADG

Takeshi Kihara (5):
  clk: renesas: r8a7795: Add ADG clock
  clk: renesas: r8a7796: Add ADG clock
  clk: renesas: r8a77990: Add ADG clock
  clk: renesas: r8a77995: Add ADG clock
  clk: renesas: r8a77965: Add ADG clock

 .../clock/renesas,rcar-adg-clocks.txt         |  24 ++
 drivers/clk/renesas/r8a7795-cpg-mssr.c        |   1 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c        |   1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c       |   1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c       |   1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c       |   1 +
 sound/soc/sh/rcar/adg.c                       | 316 +++++++++++++++++-
 sound/soc/sh/rcar/gen.c                       |   9 +
 sound/soc/sh/rcar/rsnd.h                      |   9 +
 9 files changed, 354 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt

-- 
2.19.2

