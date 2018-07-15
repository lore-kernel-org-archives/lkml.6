Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CBFECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83E020870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auCr2+ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83E020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeGOMyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:54:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54022 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeGOMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:54:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so5244613wmh.3;
        Sun, 15 Jul 2018 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WhIGC0cyc/6o5nW9u3jPoOhSjcz6CZxRNAU+o1T+BrE=;
        b=auCr2+ekqOGG35T9QXpr/sduBnmI3Me/NM/CvSuywhtKmN+FoTWFWjI4b2f/ajoeJA
         X1ZUXi9btBrYyF0r41sa6zHgck0UGo3NFU7KEFisu43MY5mTgrcRjOf4DDrq/5y6RPD8
         n2WMAnGuNGk/g2/ESt0vs2iDp9cgJ2eT6ton5h4Df6fkS+dIqgmG1AK+tcq7y57l0D+C
         5FiZJeBl9/L17dimGtzAM07mfD7E7S5bPrbbQ7FBS1u68XEiMAJTqJ5Har27ga1zuFcx
         dmMd7iwBVjJzOl5qlMRsjYfVJXxPCFyDLwXRu+iBUWPRgIwu/wUMQZdfD9hwSUPfdB9Q
         eDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WhIGC0cyc/6o5nW9u3jPoOhSjcz6CZxRNAU+o1T+BrE=;
        b=j+gfrUXCTYd69MEAZ8u59AYk+KfZeJX5Qk4Nrl3khynCmerclnQgAbFBWtCCjnIOHO
         XIoD++SZHSkOPNPZJs1Ze4XdkILoif/EIm9f1fniZGvradaZRMEfBi+ocCRarpv5pH0H
         sk/CJTG1CA88/3Z1SMS0+brcVzoAGm34MU7jSce2AKgaeambnhOIFIvdd0dgHk6kMnpD
         LsbD9o3RLZfSdhCwxKAGh8x5wg9NSfqi9N0OArYL9m7ie29aikWCe9+WnRserHBooQFj
         cTyGOugZKskb5S+Att+hGw+qJd53y/WdbgsXPiE1pp8P1Pfq4/oSikON6+EqhESVWZGS
         r5Sg==
X-Gm-Message-State: AOUpUlGOOJQDVzlaxNmr11SBvDdwYgCVjlZ9x6AC+WccoI3jZyu3rRIc
        LS4ws7WgdMuc83TXwdGJ+3w=
X-Google-Smtp-Source: AAOMgpc0XckuyDcamuK8GF6W0SDH19E6zQQxm6Xrq9DOf2tGdfBP+T4L8q32UUhVXGtM6ebGqvmHuQ==
X-Received: by 2002:a1c:400a:: with SMTP id n10-v6mr7305378wma.32.1531657909130;
        Sun, 15 Jul 2018 05:31:49 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm16358688wmb.12.2018.07.15.05.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:31:48 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v4 0/5] Add clock driver for Actions S700 SoC
Date:   Sun, 15 Jul 2018 14:31:40 +0200
Message-Id: <20180715123145.16975-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog v4:
- dt-bindings use absolute numbering for clocks
- Patch re-oredering

Changelog v3:
- Splitted uart clock DTS changes into separate patch
- Splitted REGMAP Kconfig selection into separate patch
- General naming convention as "Actions Semi" in dt-binding documentation
- Patch re-oredering
- Cleanup and fixed review findings

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family

This patchset adds clock support for Actions Semi OWL series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Thanks and regards,
Saravanan,
Parthiban

*** BLURB HERE ***

Saravanan Sekar (5):
  clk: actions: Add REGMAP as dependency
  dt-bindings: clock: Add S700 support for Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  arm64: dts: actions: Enable clock controller for S700
  arm64: dts: actions: Set UART clock reference from CMU

 ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
 drivers/clk/actions/Kconfig                   |  14 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 610 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
 7 files changed, 769 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0

