Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB7B23BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB7B23BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934906AbeF1IWp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:22:45 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:48916 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752709AbeF1IWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:22:42 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 28 Jun 2018 17:22:40 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id D831587A2B;
        Thu, 28 Jun 2018 17:22:40 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,282,1526310000"; 
   d="scan'208";a="285334159"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii2.idc.renesas.com with ESMTP; 28 Jun 2018 17:22:35 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Carlo Caione <carlo@endlessm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] Renesas R9A06G032 SMP enabler
Date:   Thu, 28 Jun 2018 09:17:11 +0100
Message-Id: <1530173842-56851-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*WARNING -- this requires the base R9A06G032 support patches
already posted

This patch series is for enabling the second CA7 of the R9A06G032.
It's based on a spin_table method, and it reuses the same binding
property as that driver.

v7:
 + Moved to drivers/soc/renesas, as requested.
v6:
 + Passed scriptcheck --strict on the driver.
 + Rebased on base patchset v10
v5:
  + Fixed a couple of typos
  + Added the Reviewed-by tags where appropriate
  + Rebased on base patch v9
  + Replaced the dts property with a 64 bits one.
  + Changed the driver to support 32 or 64 bits property.
v4:
  + Geert's comments adressed.
  + Renamed symbols to r9a06g032 to match the rest of patchset
  + Rebased on base patch v8
v3:
  + Removed mentions of rz/?n1d?
  + Rebased on base patch v7
v2:
  + Added suggestions from Florian Fainelli
  + Use __pa_symbol()
  + Simplified logic in prepare_cpu()
  + Reordered the patches
  + Rebased on RZN1 Base patch v5

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.
  arm: shmobile: Add the R9A06G032 SMP enabler driver
  ARM: dts: Renesas R9A06G032 SMP enable method

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 drivers/soc/renesas/Makefile                   |  1 +
 drivers/soc/renesas/r9a06g032-smp.c            | 96 ++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 drivers/soc/renesas/r9a06g032-smp.c

-- 
2.7.4

