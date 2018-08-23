Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B60C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C75A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHWQhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:37:25 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:4030 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727655AbeHWQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:37:25 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 23 Aug 2018 22:07:45 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 26C9985542;
        Thu, 23 Aug 2018 22:07:45 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,278,1531753200"; 
   d="scan'208";a="288866722"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 23 Aug 2018 22:07:41 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add CAN support to rcar_can driver
Date:   Thu, 23 Aug 2018 14:07:30 +0100
Message-Id: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

RZ/G2 is slightly different from other R-Car and RZ/G1 SoCs as clkp2
isn't available on RZ/G2 devices. Changes to driver and documentation
are therefore necessary and taken care of here.

Thanks,
Fab

Fabrizio Castro (3):
  can: rcar_can: Fix erroneous registration
  can: rcar_can: Add RZ/G2 support
  dt-bindings: can: rcar_can: Add r8a774a1 support

 .../devicetree/bindings/net/can/rcar_can.txt       | 11 +++--
 drivers/net/can/rcar/rcar_can.c                    | 48 ++++++++++++++++++----
 2 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.7.4

