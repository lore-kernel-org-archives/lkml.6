Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A22219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A22219AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934326AbeGFRxK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:10 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:41277 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932895AbeGFRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0A8F5520BE8;
        Fri,  6 Jul 2018 19:53:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EBefIcTz7OHM; Fri,  6 Jul 2018 19:53:04 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6DF57520EC6;
        Fri,  6 Jul 2018 19:53:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6B0F4520BE8;
        Fri,  6 Jul 2018 19:53:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 00/17] Allwinner R40 HDMI refactoring
Date:   Fri,  6 Jul 2018 19:50:56 +0200
Message-Id: <20180706175113.26698-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes several issues found in R40 HDMI patch series after
it was applied. Conversation can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.html

One issue raised in that thread is probably not solved (conversation
still on going), but I want to send these patches for review before
I'm going on vacation.

There is also additional DW HDMI driver fix not mentioned in mails.

Patches are based on latest linux-next (next-20180706) and are ordered
in such way that they don't break R40 HDMI at any time. Because of that
I suggest that whole series goes through drm-misc to preserve that order.

I also tested those patches on H3 to make sure it doesn't break other
platforms. However, it would be nice to test for regressions also on
older SoCs (with DE1).

Best regards,
Jernej

Jernej Skrabec (17):
  dt-bindings: display: sun4i-drm: Add R40 display engine compatible
  drm/sun4i: Add R40 display engine compatible
  ARM: dts: sun8i: r40: Remove fallback display engine compatible
  drm/sun4i: tcon-top: Cleanup clock handling
  drm/sun4i: tcon: Release node when traversing of graph
  dt-bindings: display: sun4i-drm: Add R40 TV TCON description
  drm/sun4i: DW HDMI: Release nodes if error happens during CRTC search
  ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
  drm/sun4i: mixer: Read id from DT
  drm/sun4i: tcon-top: Add helpers for switching mux
  drm/sun4i: tcon: Add another way for matching mixers with tcon
  drm/sun4i: tcon: Add support for R40 TCON
  ARM: dts: sun8i: r40: Remove fallback compatible for TCON TV
  ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
  ARM: dts: sun8i: r40: Disable TCONs by default.
  drm/sun4i: tcon-top: Remove mux configuration at probe time
  dt-bindings: display: sun4i-drm: Fix order of DW HDMI PHY compatibles

 .../bindings/display/sunxi/sun4i-drm.txt      |   6 +-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  20 +-
 arch/arm/boot/dts/sun8i-r40.dtsi              |  65 ++++++-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  92 ++++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  15 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  35 +++-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 183 ++++++++----------
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h        |   4 +
 9 files changed, 278 insertions(+), 143 deletions(-)

-- 
2.18.0

