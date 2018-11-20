Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BAAC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7129920C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="hAAC1g5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7129920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeKUEWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:52 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34358 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeKUEWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id AF5E120657;
        Tue, 20 Nov 2018 18:52:26 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1542736345; x=1545328346; bh=+ET72hOoPy+htZ
        8oxRxR+M1HOtELH+9m0h7EtjNd8m0=; b=hAAC1g5+V03YV5MYRrV9o0V/Isgymd
        JWcgLRocm5SmnfH1vH49b2s/FPWQxuKiidAq1o1xHdaXRSML6TkCxxVEt+uSk1+9
        g7Pn7/XqcwdamVucVxK42Fben8MEiBcGRWGvjmVFbT/GbaxtQ3vrew6LzQX7T460
        JrAaPfXHQlQPepQypu9EOpuO1I/odKD8C+1eaFWlRA1d31fmfc/C3LSo5PDIIUS3
        5+ADg4+cPHnXiuJ/pCF3ZuTeNA/bb4RPaiAPlTUTl9z3Z743oh7RdtuTh6BZSHzi
        pfHpC8IKuiaxXtirsP8LYJYEIgge01em2ija+Vm49bs5ByVsOFlLCxgA/R5hO9Ja
        bXUVBVBWg8VodxU7qDmuFvkg1cCxnQuoq9ogYoz6bhT7KdCF979HpoKGJMPYHQ1R
        rwvrau/EYWNr7dWoepz+ojTeomv+MQlA4xtU0PBQNVi/p9yWmZbPD6X+IBfadv9e
        SQInyHKr1saFgl7t0g3UfkWFkNnIDGaoSVSDytHLQziXofE7gLC1uNODMfIT8ZBG
        VlOjfELsS/6LMQfnr8Q4COGpwWwdmcPR/UF0X9H+X50c+2GbvvEm+X6rIss/yvcX
        TqS+obaqEAm0AAa+2uwl1oQ/HF9HoJybawTWKvqzk05QLcMB+sOLEGkLdSKss7IN
        sJ4JgcEsXNhpw=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CDaniPrPNYVg; Tue, 20 Nov 2018 18:52:25 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 47FF91F99C;
        Tue, 20 Nov 2018 18:52:25 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Date:   Tue, 20 Nov 2018 19:52:03 +0200
Message-Id: <20181120175211.3913-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v6:
* Collected tags
* Rebase to master
* Dropped AXP803 compatible patches

Changes in v5:
* Return correct input current limit for values 0x6 and 0x7
* Add specific compatibles for AXP803
* Change commit messages
* Add Vasily Khoruzhick Pinebook DTS patch

Changes in v4:
* Change order of axp20x-gpio in axp20x.c
* Fix indentation and spaces to tabs in axp20x.c

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c


Oskari Lemmela (7):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: pinebook: enable power supplies

 .../bindings/power/supply/axp20x_ac_power.txt |  3 +
 arch/arm/boot/dts/axp81x.dtsi                 |  5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
 drivers/mfd/axp20x.c                          | 20 ++++
 drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 8 files changed, 172 insertions(+)

-- 
2.17.1

