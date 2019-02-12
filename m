Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE110C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE8C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EYNMnV5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfBLQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:29:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36239 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfBLQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:29:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so3389263wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4mSsCon6GBdcpXgNWgQbQrrv5VNk+/N3Jshnb+5ts0=;
        b=EYNMnV5sNrocF3iwg2e/cigLaHz3u46sUAY2IMLd1kQVCvsVlT6E1M+TCyeRlzi1Ee
         OGPR82Olaayvqjshmjzf8ljY+Be0a8XlYfZ2ELHT8r3VXpz+Ba7WLEzi8YYoyG8rmuz2
         e+tJHdsBUwZ3b69w5lYtBDDWorao1ykUkIo0llc0QrvEzXs5fnsQ+rbD1jO7sMdLyfQa
         U1gBOpgpGerIn/P3REMsGP8CWFBFDSzH/hGtWW6Scs56p8ROIcK4ZYlLp46O3oObx8pK
         b2Zr9YbGy0iMfmor00avHsafnOTazaf7om+PG91NshuDn3x6gfr+bbwpiwKRuOA/0DCQ
         szwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4mSsCon6GBdcpXgNWgQbQrrv5VNk+/N3Jshnb+5ts0=;
        b=IrlE2FLRhXTFilciO7PDphgAuV0i6w8kCVpzuJHMEe8T0XBaOgqIABXQJPRVmjY5Ya
         iIwpZ1p2ong1+HXauIMD/mb98bEZ4jEcgmq/+T8R1IljR0h/xHsuTE+/ZtRmSYmuz+Lu
         OWEVU5k0e9Mn4zvTRFsFJV5WvAZlD+zUH81DoWYL4i1DaTqzoTD8N547VZGCg1gOqsvJ
         nsxxK+2m0zA2AyRb785rurMEeqIGNKlaxDJ3eWTLtCSU7g7Zk/+B+j2XRw1ETZNiuSDp
         5kN6E8g8uUw0EDe/hv6nyn0Y9okPc1XzGmwJfYipNP13tQd8fXaufE1j7gkpNwVXgCLE
         aM4Q==
X-Gm-Message-State: AHQUAuatpfpMvGdcPDWCXusMJ+3C7pIiOVT16LmFOIGUWsRT4KaI3O0C
        05MeNhX9Gn/w54E/vxIs5zLPFA==
X-Google-Smtp-Source: AHgI3IaQ2zjXoLynNNuxjOAdM0y1ZygLbnhTGP/eGVeg5u2m9LLrFped1p8aXSRHPDTmLhkLU8B9Jw==
X-Received: by 2002:adf:8068:: with SMTP id 95mr3563270wrk.181.1549988941394;
        Tue, 12 Feb 2019 08:29:01 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z1sm7800876wrw.28.2019.02.12.08.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 08:29:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: meson: Add G12A AO Clock + Reset Controller
Date:   Tue, 12 Feb 2019 17:28:57 +0100
Message-Id: <20190212162859.20743-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for the Amlogic G12A SoC family Always-On
clock and reset controller.

This adds support for clocks on the Always-On domain like :
- Always-On UARTS & I2C Controllers
- CEC Controllers
- SARADC source and bus clock
- Infrared Decoder/Encoder bus clock
- USB 32K reference clock

This also adds resets lines for :
- Always-On UARTS & I2C Controllers
- SARADC, Infrared Decoder/Encoder

This patchset depends on the ("clk: meson: rework drivers dependencies")
from Jerome Brunet at [1].

Changes from v1 at [2]:
- Moved unused bindings ID out of the dt-bindings header
- Added comment about CLK_IGNORE_UNUSED

[1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
[2] https://lkml.kernel.org/r/20190204091331.9298-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: clk: add G12A AO Clock and Reset Bindings
  clk: meson: Add G12A AO Clock + Reset Controller

 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
 drivers/clk/meson/Kconfig                     |   2 +
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/g12a-aoclk.c                | 454 ++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h                |  34 ++
 include/dt-bindings/clock/g12a-aoclkc.h       |  34 ++
 include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
 7 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

-- 
2.20.1

