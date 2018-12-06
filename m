Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6007020672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6007020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeLFKJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:09:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39689 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:09:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so25618110qtl.6;
        Thu, 06 Dec 2018 02:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=S9M24MwUah86BVkxOAYyKUozjZwz97OJ3eLVtUpw1x8=;
        b=SPHKym8q9B92WXx/msNtBZQsFESRunm2V+TRjJm8BOeXesPf4O0sunISpNulJR7h0L
         Wh1iGYbzo0j77BbCcjvPmd/oD4DNvFmESOcH3UD4PaatIIz91kNLiGbl8s4821VYvggw
         DQNADd6GwpgG3vCvDbKhoZIHanXDYZ8qEI+x1Gkv/EWAslsDe0O+8ySMKeGz/C+XKZYh
         sI3qOCd4slc1xBaHb9LrKn5NiQrbw4suf30KzdecU36J9OKVpdqrIVOIA2ScQtMgxC0d
         zTV9m6FP3fPKZy9S0bFKFHHhAmLca8H5zEPInviqtz8L29mbNRSctdI/24vMiEqYC60b
         CGVA==
X-Gm-Message-State: AA+aEWZw1CX0FomGtihOxWX7mRLD44hj3JewWGXviF+9C2Nvf65jHnTj
        TTDFW76w9U3QMylQ6tfUkTU=
X-Google-Smtp-Source: AFSGD/XfRV443v+SAiHaAC5ySoZVcd6sUW5wbC+zR6YzkhyCORhaIkJvIyPmgHSSbqZRZugQeWqTUw==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr26207918qtq.259.1544090955003;
        Thu, 06 Dec 2018 02:09:15 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id c77sm21813735qkh.82.2018.12.06.02.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:09:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:09:07 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Date:   Thu,  6 Dec 2018 08:08:56 -0200
Message-Id: <20181206100905.15053-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset rework the imx7d-pico SoM, its Pi baseboard
and add the Hobbit baseboard support as well.

Changes in v2:
- replace fsl,uart-has-rtscts with uart-has-rtscts

Fabio Estevam (8):
  ARM: dts: imx7d-pico: Do not harcode the memory size
  ARM: dts: imx7d-pico: Switch to SPDX identifier
  ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
  ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
  ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
  ARM: dts: imx7d-pico: Extend peripherals support
  ARM: dts: imx7d-pico-pi: Extend peripherals support
  ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant

Otavio Salvador (1):
  ARM: dts: imx7d-pico: Improve WiFi regulator name

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 +++++++
 arch/arm/boot/dts/imx7d-pico-pi.dts     | 180 +++---------
 arch/arm/boot/dts/imx7d-pico.dtsi       | 355 ++++++++++++++++++++----
 4 files changed, 457 insertions(+), 184 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

-- 
2.19.2

