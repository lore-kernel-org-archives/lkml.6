Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EC66DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADADC208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADADC208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936148AbeFOCRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:17:07 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:52101 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936073AbeFOCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:17:05 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.205])
        by regular1.263xmail.com (Postfix) with ESMTP id 647118C;
        Fri, 15 Jun 2018 10:16:57 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 4D6703B7;
        Fri, 15 Jun 2018 10:16:49 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <a8c03c41e4de02294cd176d0391b2219>
X-ATTACHMENT-NUM: 0
X-SENDER: zhangqing@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 16162B3QZV6;
        Fri, 15 Jun 2018 10:16:54 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/4] clk: rockchip: support clock controller for px30 SoC
Date:   Fri, 15 Jun 2018 10:16:47 +0800
Message-Id: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in V3:
[PATCH v3 1/4]: Correct description
[PATCH v3 2/4]: Use an SPDX tag instead.
[PATCH v3 3/4]: Use an SPDX tag instead,
		parent_rate might overflow and fix it.
		fix up the checkpatch warning.
		add more CMPOSITE_xxx_HALFdiv.

Change in V2:
[PATCH v2 2/4]: modify the Author name
[PATCH v2 3/4]: provide a bit more explanation for commit message

Elaine Zhang (4):
  dt-bindings: add bindings for px30 clock controller
  clk: rockchip: add dt-binding header for px30
  clk: rockchip: add support for half divider
  clk: rockchip: add clock controller for px30

 .../bindings/clock/rockchip,px30-cru.txt           |   66 ++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  231 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1080 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |  126 ++-
 include/dt-bindings/clock/px30-cru.h               |  389 +++++++
 7 files changed, 1903 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 include/dt-bindings/clock/px30-cru.h

-- 
1.9.1


