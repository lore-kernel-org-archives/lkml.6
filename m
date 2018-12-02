Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAABC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EE20645
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9EE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbeLBVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:18:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeLBVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:18:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so11663353qtc.2;
        Sun, 02 Dec 2018 13:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=szIh8gw70n+F9+dWRHbfAXM24tY8O25KZb7v6Yad9WY=;
        b=uAoIzUmSmJsf08MWkxM73ahzw7LhouNHWNvIjP5tnSMpVTzPlxabOqRVFE9xJIaniS
         eSVpHNcJrOFedWrE0b1gJsXas1c0bSAJCT9xhhYBifXw2T0ZxsI0XgObbT5hyGfP4vYi
         elT4PHoiwVUFeRf9TaUXMLePyAHYg4O/u0SL6pvYKKDV5pyr2DXYyPg+ubsik6JKxN7y
         NNJ41Bs4oIvqGtMhbNpSeps/xltXAwRdzOzA4bHpNH34+/3LTJP96LC7+UKV/+SNkQhZ
         NFkeVgR0k39Dpgr2IqDCbxgqYK6qexgu78Ft1yqZ9l78OcJZ9sq9hMO7FNDfobDqNQh0
         TSLQ==
X-Gm-Message-State: AA+aEWbl2u+fJdtrPE4X0aKL3VR5B/s+IXx7PAvfz7xMNv06N2itwePJ
        8lghn2rBo3e6bPUg+Gza+ZU=
X-Google-Smtp-Source: AFSGD/V3bn2oANDsOARPFEl+JNLjktupR/5Ymo9kB3o+nSbo0dmj5mTR+o8EZ593JSp1h4idRm6Z9A==
X-Received: by 2002:a0c:ec50:: with SMTP id n16mr13733662qvq.105.1543785501110;
        Sun, 02 Dec 2018 13:18:21 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id j38sm10247135qtj.72.2018.12.02.13.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:18:20 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:18:13 -0200
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
Subject: [PATCH 0/5] Improvements for i.MX6UL PICO SoM and its baseboards
Date:   Sun,  2 Dec 2018 19:18:04 -0200
Message-Id: <20181202211809.11621-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset rework the imx6ul-pico SoM, its Hobbit baseboard
and add the Pi baseboard support as well.


Fabio Estevam (5):
  ARM: dts: imx6ul-pico-hobbit: Switch to SPDX identifier
  ARM: dts: imx6ul-pico-hobbit: Move SoM related part to
    imx6ul-pico.dtsi
  ARM: dts: imx6ul-pico-hobbit: Make the child led nodes standard
  ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
  ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 535 ++---------------------
 arch/arm/boot/dts/imx6ul-pico-pi.dts     |  97 ++++
 arch/arm/boot/dts/imx6ul-pico.dtsi       | 461 +++++++++++++++++++
 4 files changed, 601 insertions(+), 493 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico.dtsi

-- 
2.19.2

