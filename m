Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8246C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6D820820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6D820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeKBFFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:05:15 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:45890 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbeKBFFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:05:15 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id AE158BFDEA;
        Thu,  1 Nov 2018 21:00:49 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 49F8CC1062; Thu,  1 Nov 2018 21:00:49 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 342A2C101E;
        Thu,  1 Nov 2018 21:00:33 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 0/7] BL035-RGB-002 3.5" LCD sunxi DRM support
Date:   Thu,  1 Nov 2018 21:00:38 +0100
Message-Id: <20181101200045.6078-1-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the BL035-RGB-002 LCD panel and the required
device-tree bindings for using it on the BananaPi M1.

Only the changes related to the DRM driver and the panel are submitted
for merge, which does not include the two final commits.

Changes since v1:
* Used the full name of the panel for dt bindings;
* Removed helper to match flags in order to only retrieve the connector
  once, as it was already done.
* Made the bus flags checking possible without a panel;

Paul Kocialkowski (7):
  drm/sun4i: tcon: Pass encoder instead of using panel for RGB setup
  drm/sun4i: tcon: Support an active-low DE signal with RGB interface
  dt-bindings: Add vendor prefix for LeMaker
  dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
  drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
  ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888 pins
  ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD

 .../display/panel/lemaker,bl035-rgb-002.txt   |  7 ++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm/boot/dts/sun7i-a20-bananapi.dts      | 89 +++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi              | 11 +++
 drivers/gpu/drm/panel/panel-simple.c          | 27 ++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 29 +++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |  1 +
 7 files changed, 151 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt

-- 
2.19.1

