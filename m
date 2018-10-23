Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A997EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E92204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PR1/a/u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E92204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeJXDb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:31:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46482 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeJXDbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:31:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so1125616pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PfC5L57NIZ0qNc+YO6OuwxGnj4TuvxGDGFvYK05m39M=;
        b=PR1/a/u0zl4MrwLED9zkouyLU3Mhi08lraBk5nfpe/PiL2gYP5ASOFaJy6TbIe1bzo
         X/RfQuRnZkpEK8yyTyauMogYatQW+dLPgJoC9IX9ElQijueJWbWGOS/ANRrNJ7KPmCwR
         vS7DU6FxO2RpP1mmxbOT6f8uXcxNCJqk5MF20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PfC5L57NIZ0qNc+YO6OuwxGnj4TuvxGDGFvYK05m39M=;
        b=QGo8FCK6IVRCMDng4zoR3F78jRixddoMYhNvjzvqMWN3LsffMzo3JXa1YkUHyUsohH
         Xv3Ys+jAKBhok5w7Z9OgLwzIZVhVVI7NLxe5xg8WbMjFXfBp8i7shVReUEXQESFgaMnN
         OHOug51HC7PCaFFEx1k13aWvRtoOhoK61h+TsawufXKxC4N8MtP3z94RjCBwqYPak7kk
         vQfA8FIDbFryg5ULoYQhiYkiLHNOq6dLScK0kZ90W+PNtKLAxSPdmFPGZyUO+3hYz45s
         sSjKDXbtOlIAHZ4DHNsbrCLebdSARl/QF8it6ykLY/FKL6S+7P72TJ/OaqCreFJmVWOq
         80vg==
X-Gm-Message-State: ABuFfohj6zmpEihrwKf9AZfyUR1YUgoZVTmQUoP5imZ62T26JDdBV/MQ
        j8nHRK8/NjaczNyAtsw46oTd
X-Google-Smtp-Source: ACcGV63sVWi6bwq9A1B92xcN46JyKlADiGbpr6ZQra5vZ0PbyEbIscH5LYVLdcwFeyejOmuMy+rPLQ==
X-Received: by 2002:a63:2643:: with SMTP id m64-v6mr47527712pgm.435.1540321634992;
        Tue, 23 Oct 2018 12:07:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:744c:7bc5:17c:5f65:76c4:d542])
        by smtp.gmail.com with ESMTPSA id v189-v6sm4897075pfb.54.2018.10.23.12.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:07:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
Date:   Wed, 24 Oct 2018 00:36:50 +0530
Message-Id: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
found in the HiKey970 developement board. Also, the remaining UARTs are
enabled and GPIO line names are added based on the Schematics and the
96Boards Consumer Edition spec.

Note: These patches are based on the below common clk patches pushed
earlier:

arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
arm64: dts: hisilicon: Source SoC clock for UART6

Thanks,
Mani

Manivannan Sadhasivam (5):
  arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
  arm64: dts: hisilicon: hi3760: Add GPIO controller support
  arm64: dts: hisilicon: hi3670: Add UART nodes
  arm64: boot: dts: hisilicon: hikey970: Enable on-board UARTs
  arm64: dts: hisilicon: hikey970: Add GPIO line names

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 338 +++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 451 ++++++++++++++++++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 244 ++++++++++
 3 files changed, 1033 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi

-- 
2.17.1

