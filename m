Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LD3UE4whGltiUQAAmS7hNA
	; Fri, 08 Jun 2018 06:26:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 35D676089E; Fri,  8 Jun 2018 06:26:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF30D606FA;
	Fri,  8 Jun 2018 06:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF30D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeFHG0S (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:26:18 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:55195 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeFHG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:26:17 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.157])
        by regular1.263xmail.com (Postfix) with ESMTP id 63DADDAC4;
        Fri,  8 Jun 2018 14:26:09 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id E993F41C;
        Fri,  8 Jun 2018 14:25:59 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <8ee1fac2bc2035f79d91e92d28e54486>
X-ATTACHMENT-NUM: 0
X-SENDER: zhangqing@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 19679YAFH17;
        Fri, 08 Jun 2018 14:26:04 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de
Cc: sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 0/4] clk: rockchip: support clock controller for px30 SoC
Date: Fri,  8 Jun 2018 14:31:55 +0800
Message-Id: <1528439519-30135-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in V2:
[PATCH v2 2/4]: modify the Author name
[PATCH v2 3/4]: provide a bit more explanation for commit message

Elaine Zhang (4):
  dt-bindings: add bindings for px30 clock controller
  clk: rockchip: add dt-binding header for px30
  clk: rockchip: add support for half divider
  clk: rockchip: add clock controller for px30

 .../bindings/clock/rockchip,px30-cru.txt           |   67 ++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  235 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1080 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |   86 +-
 include/dt-bindings/clock/px30-cru.h               |  402 ++++++++
 7 files changed, 1881 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 include/dt-bindings/clock/px30-cru.h

-- 
1.9.1
