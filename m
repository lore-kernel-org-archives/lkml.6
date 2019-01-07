Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B22C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4320859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LIEitCVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfAGJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:53:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42165 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfAGJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:53:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so238606edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwNcnlR2Zn4hx3zkp8zOAgTjAGZi9ae85weLFJBkyP0=;
        b=LIEitCVzeGyNf86Fl8b2Vwm+G6NGMcmlBiGs+LsMCMl6c66/sSyIERhJbRxiuYP0DV
         jvd2cWiEqyWr+OEJQSUoj37pyx5SK7qkY0geSbCun+Mtp7Fi35MYq/sN36iLHFg/cTs2
         v+0bLqvRNTdgXblglg4JG4qbUOIBFK/DmmCxfX6IGBdMlTBMJpZcBwM4epwd4sv0luot
         FEzhXEx3kFdfnA1IrathqKohc2wLS/CMAL+QModrrApmv2EK1hMr5M9lJR0QJoUKkS9A
         ovWp3vS+6VbVtweR9c2wPvUNJWmUSBgNQjOnLIrb7qH9W2gC0u49bF2LFCf+wB92BSrA
         hdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwNcnlR2Zn4hx3zkp8zOAgTjAGZi9ae85weLFJBkyP0=;
        b=lcb36wYwhwCVgBEoXiQKrAXVXQSWbQzHcawxu3kP6Q/KMSQc4cPbW2N4olil+5LIBM
         /MOnchmrntzD3kzmVjDvupdDKjhh9zFiVLLz7/DxJIxq7v5cw6OhC1hv4og14kKSPVeN
         qTfC0hUjttCPpbY4120CoD+ynubfIWoQTh/lRPIxy/0dkjdkCUIPpcOELG1evJlIresq
         3fQEsD+RnXZf2Occ+8QtcLaUxhpbma05F3ozv0XpeSVJVRHYSel0DPffVCmKVXBL/Mdy
         jePyoddX6xBE/3UY8F1yDxgop1g3S879MrhlIH+Qa74hAUQGkwc2rtHfSjjDsf0ZI0P8
         rrqQ==
X-Gm-Message-State: AA+aEWa3bdALJKO6cdCVZ87L74zCh4k+HNuHounpW2jC+g/5lyvDfiIv
        ieEqI02HFy2OOY9fm1tPtdTMNw==
X-Google-Smtp-Source: AFSGD/XJ8bv6nFQ7jL654BoGNZYlp7hkrUW5waa2vPSjfYe3uWQgHBULUvUIEI28oqmrSyj8rtJiag==
X-Received: by 2002:a50:a642:: with SMTP id d60mr56230877edc.290.1546854796428;
        Mon, 07 Jan 2019 01:53:16 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:53:15 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: dts: meson: add simple-framebuffer nodes
Date:   Mon,  7 Jan 2019 10:53:05 +0100
Message-Id: <20190107095307.15233-1-mjourdan@baylibre.com>
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
GXBB & GXL that is not sent yet.

Changes since v1 [1]:
 - added cover letter
 - added simple-framebuffer compatible fallback to the bindings
 - Updated node names and removed the unit-address
 - Consolidated base nodes in meson-gx.dtsi
 
[1] https://patchwork.kernel.org/patch/10720879/

Maxime Jourdan (2):
  dt-bindings: meson: add specific simplefb bindings
  arm64: dts: meson-gx: add support for simplefb

 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 22 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  6 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  6 ++++
 4 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

-- 
2.20.1

