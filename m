Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D3B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8nUBgMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBKJVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40074 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so15681151wmc.5;
        Mon, 11 Feb 2019 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o9IiNvanpf6vE8Y5GsfQqbwdzxovPBJKNOW11kH1wiY=;
        b=t8nUBgMa9BeUM/qgCArntzipy+l8btF+ppGDw+x3/w5a0XpHKFtL8UajVPIgfBXOI2
         nt3psr27uI3QojHD/+sC9tMrKRFMcEyXf3QHFSzRlVNxxpvUJyll3XsXkGtiub3/AP++
         98bf3GQAgK/LzdILdQFeb7/lY6Hb7NXfDBPLNWQRnZBuWcZuPW/HFGeTJWu7vaWqQiu8
         bBpb71Lps1HKy9vM7E6CXdh6ZFsP/aV2VhRJeWjWrBYsMN3N6uW6GPYhIQ/h3CVsE0MW
         lOAEq+3ubte6kW4yWJO0VAklEaMLf66ePaQBUzXqN1YU/cIx8mIHK7a2AMkC8wGwjssG
         itPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o9IiNvanpf6vE8Y5GsfQqbwdzxovPBJKNOW11kH1wiY=;
        b=p9U0Vib1VttY7UFx2/9ypSyGvK48o05DYsNEexrucRSMhZ03gz2e8+Qg0CFtcbrlgm
         OTELsYAk9QdkwPYN629bDx0MK/d2owF3BsbCrXB7pIvWG+Ha5RthFXYPz8DlTGFKDGnJ
         KoFsgl5/81p6nVytziSIvN+El8v/jX443Cv+IZRikZI1OCv+IHLtXtbd+0nJhkiLoEfC
         sS74ax5fp52sDtFpeqRDCBUr8BXg8aq0uHyh4vOn/kMlDxidMWbJMUyyfPvAX6JGLoML
         WX8a0CIHlJtBKlgwPCTYToEyQtjr8ef/GiwWy0wx7ZUkAVVJ0dLzfLOR27oziDXlpQnv
         5bNA==
X-Gm-Message-State: AHQUAuZWTsq64mnezFyd6/Jvz9GblUW6tE+YpJvAu2bpLmlWSjnTOcFs
        qr/wOTSpIibxOz4nvtV3BtBJXT0s
X-Google-Smtp-Source: AHgI3IYZ/ShhEsA6YZXSHdipPuH9wBXZY/oPKTpENs9EdcPoog/qPMcsYyery5l78vkMzZjGmR6Naw==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr9085611wmj.105.1549876903693;
        Mon, 11 Feb 2019 01:21:43 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:43 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
Date:   Mon, 11 Feb 2019 12:21:06 +0300
Message-Id: <cover.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is followup series for F1C100s initial support patchset. 
All patches merged except patch 1 ~ 2 which is related to timer.
I am resending those since they are already have Acked tags.

Our dt-bindings for F1C100s are merged, we can now use them at our 
device tree source - patch 3.

Also this series add spi support and enables spi flash at Lichee-pi Nano
in patch 4 ~ 7. This patches are based on Icenowy's work.

Thanks!

Mesih Kilinc (7):
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  ARM: dts: suniv: Add dt-binding headers for F1C100s
  dt-bindings: spi: Add Support for Allwinner F1C100s
  ARM: dts: suniv: Add SPI device-tree nodes
  ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
  ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano

 .../devicetree/bindings/spi/spi-sun6i.txt          |  5 +-
 .../bindings/timer/allwinner,sun4i-timer.txt       |  4 +-
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  | 13 ++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 53 +++++++++++++++++++---
 drivers/clocksource/timer-sun4i.c                  |  5 +-
 5 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.7.4

