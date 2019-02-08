Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB93C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE352085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="woVIpI75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBHKOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:14:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:14:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so2881552wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zn3JOSJAc4hdaP9Mkzt+bH/dcyOxwOPiRCe1msLmt8=;
        b=woVIpI75R2onKuLVvU/eh/8hQU4toisewRsIhrbW7f+Obs9bRDOyrAU3DYTZwjh9iI
         ujLtmqFD1l9J28mYZLrmD/aWlcLCydrstDcus2oiEJRzWc+LHEAr07QvkY6H2pveeXvr
         QVbGy7LjQcqzT1xeUiWZSSPgR6fVk/O+VgGor5yUZAWi6vkG4kJV5MUwUs5kEAnMb0dP
         Bodwm/EcVwI+S32DbZbpKKahnh3owE4ShC08Vzk41kyFU9u/mQBPnjZQWOtQ+gzxJjl8
         fQc2phbm47MwwKE0EsVnzW+L/mVf2Z/GZdI7QD1fATxPDvmPopI0ZyvHX1CFT5wSsDY5
         YwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zn3JOSJAc4hdaP9Mkzt+bH/dcyOxwOPiRCe1msLmt8=;
        b=rxpQmvE9Vbp8ow5NvQAOJY6nsRy3e/CwrwIBMsdrcm+2pJuBK9P9WrTF7wwYMdXRn9
         iXPHJ4aa6bB/A5nbS2HzflwLMoLhYk4Ul5RTDRiMiCht3bN4lbYR1xmEDMAjTDT1QLRl
         MVrMhZONbjtqimBa01ZFqz5GHOh0o0ntCbAaKAwAmou0SPKx3QFW0YznCEPFMCpdYawK
         coVnAxxG2k5fxoSvDxraSoQaQzaiJj+2XEerRBfs4LNJBjG3U75yNiDwrXZBVj6Fn4v0
         amTZ6ZzF/Ul9rIvK7ODif1nD913H42PZn+o6PnTy4/EwDNZcFnvCgMlllz0qpE1CkibE
         EuGA==
X-Gm-Message-State: AHQUAuZM8ltECAkT2YqlJV4DxkPwHJGn4YK0b0UTl3g6/5ZMI03CvPBS
        GYDEYw10wVk9fgJoqw6qGqWMlw==
X-Google-Smtp-Source: AHgI3IY1wm8tkmbulxHtX5Dv8fsligY44Jwu/yc66xpoVIdD0vR0Nduk84O7XAgYUnXshw+DOby0gQ==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr16299802wru.272.1549620854103;
        Fri, 08 Feb 2019 02:14:14 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e35:2e9a:6060:2ed3:c463:803b:b085])
        by smtp.googlemail.com with ESMTPSA id a62sm1901634wmf.47.2019.02.08.02.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 02:14:13 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: meson: g12a: enable peripheral clock controller
Date:   Fri,  8 Feb 2019 11:14:03 +0100
Message-Id: <20190208101405.25699-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset selects the required configuration flag and adds the
DT node of the main clock controller for g12a SoC family.

FYI, the configuration flag and DT bindings have been introduced by
this series [0].

[0]: https://lkml.kernel.org/r/20190201145345.6795-1-jbrunet@baylibre.com

Jerome Brunet (2):
  arm64: meson: enable g12a clock controller
  arm64: dts: meson: g12a: add peripheral clock controller

 arch/arm64/Kconfig.platforms                |  4 +++-
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.20.1

