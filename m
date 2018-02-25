Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeBYNuA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:50:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33010 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:49:57 -0500
X-Google-Smtp-Source: AH8x224pJ09T3f1Rnu3UCVB0XreYanateLhwFn6UvT2bMlWDMRDujZBV+yQlpXvQxe7f5zSzsKvdqA==
Date: Sun, 25 Feb 2018 21:49:46 +0800
From: hao_zhang <hao5781286@gmail.com>
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, maxime.ripard@free-electrons.com,
        Claudiu.Beznea@microchip.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v2 0/4] pwm support for allwinner sun8i SOCs.
Message-ID: <20180225134946.GA14015@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWM support for allwinner sun8i SOCs.

This patchset adds pwm support for allwinner sun8i SOCs.


v2 Changes:
1. change sun8i-r40 symbol to sun8i.
2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm->regmap).




hao_zhang (4):
  dt-bindings: pwm: binding allwinner sun8i.
  ARM: dtsi: add pwm node for sun8i.
  ARM: dts: add pwm status for r40.
  ARM: PWM: add allwinner sun8i pwm support.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i.c                            | 401 +++++++++++++++++++++
 6 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.7.4
