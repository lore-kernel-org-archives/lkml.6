Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F74C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22C524267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKcGoFYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22C524267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGCJZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:25:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34770 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753973AbeGCJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:25:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so9893707wmc.1;
        Tue, 03 Jul 2018 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MV2tf7Cos/ugmcs4fcvYnhqynJC/6b6iyfl3G5AyvXE=;
        b=BKcGoFYrhQ4hBI3WY9NGHaz4OKD5uNldTnSGbpsaY1p0QyUSCXd5zyPcItECFLSRtK
         2LN0pTfVlkdfMcct1FvxhcUKbvt8DwQEoF7we+0w9ZJFbgrjmPp06yjVXGlErAQjzG1v
         CCUa8ietBjsscIqxmg0/sIQPjDDI+GAzDb5fXi7NJJnOcJIKE+lZxVBGOsjlADSWNfwG
         J2sFwJYbUf5TjPch6A4Epl58L9aw1GUK5i364dyGBoQgM71LXDIflbWbMhLZLR67qvTw
         46veCobqpOQh5+CPMa1Asf6XYu0RFc3yhDT5ra/L8EvWv1WNPk6HdqXZCKkC2yhvVTUL
         XKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MV2tf7Cos/ugmcs4fcvYnhqynJC/6b6iyfl3G5AyvXE=;
        b=MGS9nxt7HQuwgGgm+8JTgvWi88x8aVQxgdWEoYNG6rXPa1GrI8XfTVTvaNpKnkcnkl
         lHY3ZRiWnab+DLvNEd2lRWxYsa6f3h4/XxipsBLhovc9ICdT7rz8nFanM214+sXIjHPD
         XXWlHPuQ2t1CYvT7c8YUTS6AFiSNHu0IQ+FXq+Cuz7Rdhw5jE8snnsIHcAJFY9eIoY93
         OfaDNLnoDhG02vD/YKUbE+e1nop+zqFlTaT84qwN1/U9lZXqINXv44DXnwqfbZraocsM
         tic/drp8hDpDkyEH32zf4G51rxad4HzvDxFnAjVoGTQDRz2Ym1VWzDWdcZDc0tW+IRsV
         aYlQ==
X-Gm-Message-State: APt69E32FaSRZq+sWoaeW1DosKczpLjqCNb3Hr2PFWz7ApfekIs8amU6
        4NjtIabiN+nYjA1FpcXunSQ=
X-Google-Smtp-Source: AAOMgpfn/F4CHflMu0+ZNqINBpO0lBCOHSMhp/I5dHmllUcSjxu6kLq/J94kpzMiUkS+8LQV+hecrg==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr10513191wmh.63.1530609952355;
        Tue, 03 Jul 2018 02:25:52 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id r194-v6sm1819280wmd.36.2018.07.03.02.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:25:51 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        support@cubietech.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, linux@cubietech.com,
        darren@cubietech.com, mp-cs@actions-semi.com, pn@denx.de,
        sravanhome@gmail.com
Subject: [PATCH v3 0/5] Add clock driver for Actions S700 SoC
Date:   Tue,  3 Jul 2018 11:25:19 +0200
Message-Id: <20180703092524.1697111-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Saravanan Sekar (5):
  dt-bindings: clock: Rename document generic to Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  clk: actions: Add REGMAP as dependency
  arm64: dts: actions: Enable clock controller for S700
  arm64: dts: actions: Set UART clock reference from CMU

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi              |  14 +
 drivers/clk/actions/Kconfig                        |  14 +
 drivers/clk/actions/Makefile                       |   1 +
 drivers/clk/actions/owl-s700.c                     | 610 +++++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h       | 128 +++++
 7 files changed, 779 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.14.4

