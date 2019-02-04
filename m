Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5BC282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EB82147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ORVIbuvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfBDJNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:13:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:13:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2476471wrv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/hN4UZA5/W8njVj2LODqL+qcn1cDZ7HkX1s6BIO7xM=;
        b=ORVIbuvcNN4weMu3n8EQCohEjHyBJlU6oJd+/6215aPa5qykD26XJlfrEyRjv19HlL
         g1YX3R3sCleOgUBpuBxcKFFD8CbQV4eiRXC1j+RFqghhPnu1m8rmdirk1i+15HaklM+B
         8I+2d9987Q6kCLo80Ne5IpgqJ4OwRxjJPu2OIhzdvq3g+m+4fC1nraIoX4vrVPh0HCIS
         xRsA8y9mj3VWxP8tbBUVWFLgqsBwQmBYiQMvJAmUDSwT1dgnoRHqIndL7p//b0V3mVlx
         6SHoOHQkFBidYf/kuTTz6HJR/o5GJogg3cQMefgVtg1ICaPzLqj68FBYFzlKcEkRzwYG
         wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/hN4UZA5/W8njVj2LODqL+qcn1cDZ7HkX1s6BIO7xM=;
        b=aYmP9lrZhBZiep296vjw5kPQDOL59pfMaGZ7Fr9MN8AQZL/EqNM1zJRXQCkiGd0BCA
         iSpDL4wizs9CH17AAGtSKY3wV9zzY4HvNzePXesVtcajGG+D2f/v4XmgRgPPFCXtHaua
         fcGa0aEOeHVNrTObh8FUnYU7pk+W40hjiwUG3F6ebBr05vl6bmoeOY3r+ZzqvrakZD9E
         3AFnZpYZETP9K17Vh+xklk3Eh+6LMLZHZ8yKeMea5+Vb37SI+wOhZVzWPNDXeHZ3EaZp
         fP5Ncd4VcZFsxsjd71RuMT5KQwLnR1FLP/3uVzWEl41MjzhefjBCx8zt2aal3BPYEdcn
         4p5A==
X-Gm-Message-State: AHQUAuZV2CLjMwihEdL2KDH4SXFieeUtjVgLFImI7kpCCPEQ/EuBUSgE
        t8+mTK4KIFBKwfBjkpKpG9lb1w==
X-Google-Smtp-Source: AHgI3IY9No/yQK4EZqRfNK0k8G8wTy4SKiWcWRM9pWkefofm9RpwzKWgcYkQgS34B5Hc+WRGg2z6DA==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr32840375wrl.137.1549271614793;
        Mon, 04 Feb 2019 01:13:34 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm9371390wmi.43.2019.02.04.01.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 01:13:34 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: Add G12A AO Clock + Reset Controller
Date:   Mon,  4 Feb 2019 10:13:28 +0100
Message-Id: <20190204091331.9298-1-narmstrong@baylibre.com>
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

[1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com

Neil Armstrong (2):
  dt-bindings: clk: add G12A AO Clock and Reset Bindings
  clk: meson: Add G12A AO Clock + Reset Controller

 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
 drivers/clk/meson/Kconfig                     |   2 +
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/g12a-aoclk.c                | 448 ++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h                |  15 +
 include/dt-bindings/clock/g12a-aoclkc.h       |  43 ++
 include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
 7 files changed, 528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

-- 
2.20.1

