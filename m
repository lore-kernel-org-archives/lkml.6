Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB1C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0A208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLBVZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:25:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45410 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:25:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so6212047qka.12;
        Sun, 02 Dec 2018 13:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=l0O5qkWlM9MQhMzGD4KnAinppepOwI5ZWCI1CSkgveU=;
        b=oAG+hlh4K4RGlM32J/CH0jYQVgMtSHjaU4PP7QSIamH1yMhZjfhKcYA1Yn9KzUNtga
         d6fS53qaKXrhu/iURYwxngX8q4rz1rVYRfk4w+2Q9s2m337ppZetvPtiAxOgmq1C7Z+r
         n4y3GPzkugpK2IuLrz/Uk4wbDK+XdyabBSD68hp31Yriv91igUcvb9gWy3s4XiBh6jV9
         uqCSaCWBK9BnGHV5knaXMh+AGadvm5qC+Yh3TyhJLVf0lYiVGbJHYMLxfIxDTtp0wvVj
         YYjyln0En1l9agYawAFga0eM6IjhjHkTVvkyOKP+aQQSYekVf8/uVS2aiIw7K+qyKOS2
         OKug==
X-Gm-Message-State: AA+aEWbfngHUmdgAJe68OizGHYzKxjqFTDXXSEGfDqXXR4bZt0zzp79R
        Su7bdVJclgKExkd3b3i5NTFPjbuf
X-Google-Smtp-Source: AFSGD/Wpzrwt/GsGAp1X9uowP3fcePi2w+s/R4paCjy3M4/mNyabObkv+3f2ENEhhrcqAPHp/6WH2Q==
X-Received: by 2002:ae9:dc43:: with SMTP id q64mr12452138qkf.223.1543785929359;
        Sun, 02 Dec 2018 13:25:29 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id c11sm6016526qtn.95.2018.12.02.13.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:25:28 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:25:22 -0200
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
Subject: [PATCH 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Date:   Sun,  2 Dec 2018 19:25:11 -0200
Message-Id: <20181202212520.16650-1-otavio@ossystems.com.br>
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

