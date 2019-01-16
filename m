Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AE720651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Km3LyK5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392834AbfAPMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:40:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54444 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfAPMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:40:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so1810010wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3ctveX0yWygzcxgKPeX/rPTPfS2ytDwLMdFgByqGos=;
        b=Km3LyK5NjOX362Qpy6+cvlf7OnAZOXjTDm2xugUJ8/5DUMvr2xOWU1eys2WSnog1sR
         OG+rsYIJSkE5K2w2aZUtUzZopl1fbsriXgMQSpWMIPomFpews3ZtgQWPCp1G7Bu88c/j
         eho6UQStjTKALEVg0tA6Sz1QiRFG4GU0iXllKs84P6yR/JQB+yy8xMq/JfmTwn0Mr5ky
         ypROj8Z2zvwgicKnfiz1PJCMBjs+Sx0HEFH/mlsrU8p2bXm8BmsRmUnDMaSkAfet+iiT
         j2KgrnJiSnLjS4fAI+vc3vvRrMQ0daiEV0L/6QTSCyJKBVm9zUn+xv52eMGeJWkdZxBh
         f9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3ctveX0yWygzcxgKPeX/rPTPfS2ytDwLMdFgByqGos=;
        b=i+aBpQrhS7yxUKN9ofU4CukZIvJUSFsMYw5nCvubWPbMsN/9PkVQthPYQNLMvUrv/X
         RK/UVdU3lhMOWbCCK2176qIM89X9e1e6ZCgPRCecjSvJ8wgNoiM/IUEFs1nBwx7cWln7
         eozLHR4ptjr0hYmbEgQuY2w+ET6txaaqTCQIiAmclYZIdSFSiXHtjmx7sRC5blSe2iZB
         koasGZ4XtgFp7eMNWMdVTX/v+CdT+Qj7NN10i9mSoJk/VWl/4lT1QOZoKEE3o1boIRgq
         OQyd2oB0EPm6ih8bwTBdR6NilZGEqfyvmRu/ZKnwlSHs2ERIdk1Qlz70EfL1scMj24c9
         DlYg==
X-Gm-Message-State: AJcUukfh2V+anGcQs5NqjTgVQxBtZvbaY2hjUyqAUiUaZe1PRqT/EFK3
        ixeIZ1gBUAC4UQVbvys1Pelovg==
X-Google-Smtp-Source: ALg8bN7J40CvfTlW5wHn9BtzAYKbaaiVZhG+KXeyvruUo17EGI87Bi7yWe+MVU13n0bJF9foIHOM2Q==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr7179564wme.132.1547642448960;
        Wed, 16 Jan 2019 04:40:48 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 04:40:48 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v3 0/2] arm64: dts: meson: add simple-framebuffer nodes
Date:   Wed, 16 Jan 2019 13:40:28 +0100
Message-Id: <20190116124030.16882-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for simplefb for the GXBB and GXL chips.

simple-framebuffer allows sharing a framebuffer already setup by the
firmware to the kernel for a seamless boot transition.

It goes along with a u-boot patch series adding display support to
GXBB & GXL [3].

Changes since v2 [2]:
 - Renamed bindings file to "amlogic,simple-framebuffer.txt"

Changes since v1 [1]:
 - added cover letter
 - added simple-framebuffer compatible fallback to the bindings
 - Updated node names and removed the unit-address
 - Consolidated base nodes in meson-gx.dtsi
 
[1] https://patchwork.kernel.org/patch/10720879/
[2] https://patchwork.kernel.org/cover/10750205/
[3] https://patchwork.ozlabs.org/project/uboot/list/?series=86214

Maxime Jourdan (2):
  dt-bindings: meson: add specific simplefb bindings
  arm64: dts: meson-gx: add support for simplefb

 .../display/amlogic,simple-framebuffer.txt    | 33 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 22 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  6 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  6 ++++
 4 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt

-- 
2.20.1

