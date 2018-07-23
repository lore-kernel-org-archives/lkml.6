Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6119ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DF320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDZMIFho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DF320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbeGWW5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:57:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37468 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbeGWW5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:57:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so779176plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AiMcsDISjo+rzdirtL4WDbw9pifJkrp+ppqWPXfySSE=;
        b=EDZMIFhoJana0AYDWztdQGzZqE4qvRoUal/3fv0aT1r5u5yranHNP40n75/62LEDmD
         CMmtgAkKrL6w2+f0PvrTLcf5pwHPj25rtSVliIodsEdPwoWLIS8/vXD9I1PzBUNNSIRg
         xSrcDRkYpT7lGIGrrVZ/G1BVePhldd3dLkZUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AiMcsDISjo+rzdirtL4WDbw9pifJkrp+ppqWPXfySSE=;
        b=QLcaGWLvukPsz6RzLNYrQiYZFb60x/zjLsL2KMIPXNCFy6WWWD0HXF/uUgnN0bMP5+
         5u9xwySs5gvRpODUZdHFxdwJinGoBjnLu7dl1ha0MuXyJnQiP9RM3gI/DiJfgzmH5v3p
         lbzjCkOOl1L69I6WZrR60On6KBE9/fuSpbN14nzyUKpzwydfu10XjGNuYrTBljSi/Ey/
         tE98C8htHAmiZz3WpGwcOMiQbXyX0PBeyevqVPCK5EU5PozQVzF+VEUeOX/MEX63HNZ7
         g8/JGqeRZyK7HPZLSZgT24n7kFiYmaFSLGg1MxgDYJZxX6qwMgUP9hTOzoq31gfPXDw9
         jhVQ==
X-Gm-Message-State: AOUpUlEUfgEq6UcmC6ManRoRJz3WJl+ewoKtCpqSf7iQ+HgjB0nk0aHq
        5Xv2noX3nDvrLIlTQ4EEFewRpw==
X-Google-Smtp-Source: AAOMgpdFMsN8idRc4ZUSflNDqDYkMszi4DH0Gkg6YunIVxXi+YEsq8BC/+QECR3K5YUnUbjGNni4dg==
X-Received: by 2002:a17:902:8697:: with SMTP id g23-v6mr14384628plo.292.1532382871603;
        Mon, 23 Jul 2018 14:54:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id n26-v6sm5927629pgv.78.2018.07.23.14.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:54:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, grahamr@codeaurora.org,
        girishm@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/2] clk: qcom: Quad SPI (qspi) clock support for sdm845
Date:   Mon, 23 Jul 2018 14:54:02 -0700
Message-Id: <20180723215404.74296-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This two-series patch adds the needed clock bits to use the Quad SPI
(qspi) part on sdm845.  It's expected that the bindings part of this
patch could land in the clock tree with an immutable git hash and then
be pulled into the Qualcomm tree so it could be used by dts files.

From the reply to my v1, the clock plan for this clock is:
- MinSVS@19.2
- LowSVS@75
- SVS@150
- Nominal@300
...and intermediate frequencies can be used at frequences less than
300.  I didn't see a need for 75 MHz and it was unclear from previous
replies if this should come from MAIN or EVEN so I left it out.  I
have added 100 MHz here since it is useful (/ 4 = 25 MHz is a useful
clock for SPI flash)

OTHER NOTES:
- From probing lines, it appears that the Quad SPI block has a divide
  by 4 somewhere inside it (probably so it can oversample the lines,
  or possibly so it can generate phase-offset clocks).  Thus we need
  the core to go 4 times faster than we'd expect to run the SPI bus.
- SPI devices usually specify the MAX frequency they should be clocked
  at, so it's important that we use the clk_rcg2_floor_ops here rather
  than the clk_rcg2_ops

Changes in v2:
- Only 19.2, 100, 150, and 300 MHz now.
- All clocks come from MAIN rather than EVEN.
- Use parent map 0 instead of new parent map 9.

Douglas Anderson (2):
  clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
  clk: qcom: Add qspi (Quad SPI) clocks for sdm845

 drivers/clk/qcom/gcc-sdm845.c               | 63 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h |  3 +
 2 files changed, 66 insertions(+)

-- 
2.18.0.233.g985f88cf7e-goog

