Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5420C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ShXQ+qF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A5420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbeHWPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:30:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbeHWPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:30:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so4403290wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=g1mfP/sOo/HQjJ7c7Fb0EYo8huXwFK/AM/SI3qAjqoU=;
        b=ShXQ+qF+cO44SQLJkTkZyvmZwCKIEiyLgCYDL5oIAxZ3jvStRMbCudlZwZe/Pnv3jp
         7XvaddEnUrgfOsYAVtF6lJv/qG/p93CePArRxGUMM3v1prWDDK/LckLsFxPLr+2gbeHg
         wK2W3T2F7WgMtvNPRNv/qacCJ4wAULCdLz3YTc22e6b0zDnMrk55nWbR9+bQsXKMylb3
         jv92OnAhPvxCnPmim1Lp9FXHMaekGNnNqRiPOCn5TM5TDYYlOkZxL2wI2QSB6vujmAc2
         gzneUzecmIFnKumXyNWdZ8dpwbUX7K117pmkyoFUj67sMQWUDivtsSm5lDvewrAjt3s/
         /6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g1mfP/sOo/HQjJ7c7Fb0EYo8huXwFK/AM/SI3qAjqoU=;
        b=EGgzhy9/sMDYwOp42rPrdVZ5TnbNp1qUj4pyN1eH8TcRI5jYQZcNvxUqSYi+rmE5P5
         VaMsFxeDZ7jxHMW4nukPU7AAVARsPIieEi/fZynZhrXMOe0mzjL65pZ4Xz6Cd5B3RJwK
         NPeTQ97FeySzpF/TzAbK1LKB8VVtFFeAn1jKyqSxCO+qsajPiEC9siX5DTfNJFaOXKzy
         VxnzgO3UOsdsn2fVb9MYPGabx7YhxzFYsTxYpf+9c0+IFi4uAvfTtZB7ECBSCpqoLFaE
         SRnkSpI5T9hz/0w1Ueq/Oz+Ruld1knoJ3piwsyTPwtWm0yTXZdTUHaGtseAl5oTaQtuL
         gG/Q==
X-Gm-Message-State: APzg51AiKOpL/2BmnNZZK3l8X7IPKzYgCfg62R76kVcSJ6ioZyFsqOWz
        6bTbCnJCw7vCBUsv5zBfweHoYQ==
X-Google-Smtp-Source: ANB0VdZ1eQ867GNMeKV7jfPEvgyYzZLk9x5cwA86rRtVQDs2+8pd3AiPCKOLO5I43bw9+VjmLS7tFw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4-v6mr2337085wrn.190.1535025643617;
        Thu, 23 Aug 2018 05:00:43 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id y10-v6sm2830419wrl.87.2018.08.23.05.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 05:00:42 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     linux-amlogic@lists.infradead.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] soc: amlogic: add meson-canvas
Date:   Thu, 23 Aug 2018 13:49:51 +0200
Message-Id: <20180823114954.30704-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SoCs feature a set of 256 canvas that act as pixel buffer
descriptors. Some IPs like the display and video decoders access those
pixels by using canvas IDs rather than direct phy addresses.

As such, allocating/manipulating canvases can be done concurrently and
there is a need for a standalone, lock-aware canvas provider module.

Currently, canvas code lies in the drm/meson module as it is the sole
user.

This patchset adds such canvas provider module.

Changes since v2: [1]
 - Don't include the drm changes in the serie.
 - Remove the syscon node in the dts and doc
 - Rename meson_canvas_setup to meson_canvas_config

Changes since v1: [0]
 - Convert ops struct to a public API
 - Added comments
 - Hid the of-node probe code behind meson_canvas_get
 - Changed device lock to a spinlock with irqsave

[0]: https://lkml.org/lkml/2018/8/1/1512
[1]: https://lkml.org/lkml/2018/8/7/894

Maxime Jourdan (3):
  dt-bindings: soc: amlogic: add meson-canvas documentation
  soc: amlogic: add meson-canvas driver
  ARM64: dts: meson-gx: add dmcbus and canvas nodes.

 .../bindings/soc/amlogic/amlogic,canvas.txt   |  29 +++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  13 ++
 drivers/soc/amlogic/Kconfig                   |   7 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-canvas.c            | 185 ++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h      |  65 ++++++
 6 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

-- 
2.18.0

