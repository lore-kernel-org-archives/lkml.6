Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeCLP56 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:57:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42128 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeCLP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:57:57 -0400
X-Google-Smtp-Source: AG47ELsuZ4BguIZ7PB3scFuU5jtV4rvjMMuy5/V8HoJnzQOxYqsjvc+lhFowHh6IFIoaovTO0VZM0Q==
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v2 0/6] ASoC: sun4i-i2s: Updates to the driver
Date: Mon, 12 Mar 2018 16:57:47 +0100
Message-Id: <20180312155753.9478-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. The original attempt had some changes related to the slave work
but I've left them out for this release as I would still like to do some
more investigations.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and loopback so block testing can be made without an external codec.

I've also moved away from using tdm to set the slot width and now use
a dedicated property.

This has been tested on a Pine64 using the ES9023 audio POT board
(https://github.com/codekipper/linux-sunxi/commits/upstream)
and HDMI audio
(https://github.com/codekipper/linux-sunxi/commits/sunxi-wip-a64)

BR,
CK

---
v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (6):
  ASoC: sun4i-i2s: Add slot width override
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Correct divider calculations
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Add support for loopback

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  11 ++
 sound/soc/sunxi/sun4i-i2s.c                        | 199 ++++++++++++++++-----
 2 files changed, 170 insertions(+), 40 deletions(-)

-- 
2.16.2
