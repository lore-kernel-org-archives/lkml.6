Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD45C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7B320868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4aZ/Twm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7B320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeKZDJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:09:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38474 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeKZDJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:09:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so5008393pgc.5;
        Sun, 25 Nov 2018 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bqFB9z1r4+W+w8gEVuXxo+VEgJQthnE5nDZEOlSd+/E=;
        b=q4aZ/TwmeucGPoE0fKBKobpOcyYGOM4jpdCyogZUP1pC4FJVT+j6aolAT81juDv1Pe
         fsC/BtWnThLxF6prSEP4RrH0Oad1Veh6ZD3A40Si8D4HLOMGSQ5UlYlhKvLLUhuN5Pf2
         ciIDtsskBsM9omnupJJmVom73X1SfzyVv4k7OW2xTX/OuHV7C4JBguKdpHuPOznarfmw
         yr0x7UgF4EFDgF9OPVBElAWrS42ue16/oYQ68mLRMG/VWjBSHfBCFiEekd1O27bQvKIT
         GYZSLBRIKlCUxzPOkbRcz2MsCROdzrNOCiDXgziHsFxLa6SAwyMq+OxpHTbZSpFFXSYg
         h7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bqFB9z1r4+W+w8gEVuXxo+VEgJQthnE5nDZEOlSd+/E=;
        b=s0I7afg8UpXWcR2oNbuijsOQEH8e75OtDJNc7Gh7WbaSjLGORTxx7JFfKcVsTck7EZ
         LkhFVtsWBALEdOhfzEQb4SVq3+NEwJ6rooJFodOclrBrJ1f+HuYgHvWtGzW9caGMqlF0
         dYOzEGjPxiN89VqDIXvDt+1MckFHNmzO1j4kdvJoulvKUOzp+2/e89erQJKHeLqVNA6f
         AJ4Xs6Nk8xCpNJo8Cef875Qrp8X5aIGPuYQuvei54ZSy1+/ikN/rcOB/4CCW1zboHoqq
         YS6laxmJqB1MaFHNktebCJE4oqo0sXWfXmi+KvebYI56j/wTp4nf50GCpdSfxuKQ7CrE
         YHtg==
X-Gm-Message-State: AA+aEWZKZPeNQ8xmfJyAQ/VSnn4WkMeJG+YCcejzskP22F9HfjHWIqkj
        a/MtfB9OaBfPGAxIE/UvkU8=
X-Google-Smtp-Source: AFSGD/WCfFIk6VQYF7ykpwfppeDjsGomwK0b28ZJu5du/EIA5Id6ItrsPc1n5jQsur1vprvf+CAZGw==
X-Received: by 2002:a63:da45:: with SMTP id l5mr21732128pgj.111.1543162690582;
        Sun, 25 Nov 2018 08:18:10 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id 85sm79882900pfw.17.2018.11.25.08.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:18:09 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:18:02 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 0/6] PWM support for allwinner sun8i R40/T3/V40 SOCs.
Message-ID: <20181125161534.GA4481@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWM support for allwinner sun8i R40/T3/V40 SOCs.

The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
each PWM pair built-in 1 clock module, 2 timer logic module and 1
programmable dead-time generator, it also support waveform capture.
It has 2 clock sources OSC24M and APB1, it is different with the
sun4i-pwm driver, Therefore add a new driver for it.

Some test method:
cd /sys/class/pwm/pwmchip0
echo 0 > export
cd pwm0
echo 1000 > period
echo 500 > duty_cycle
echo 1 > enable
then check the PB2 pin with oscilloscope.

v3 Changes:
1. fix coding format.
2. use 2/ilog2 instead of divide table
3. remove spinlock.
4. remove sun8i_pwm_data structure and use DT to parse pwm-channals  
5. remove inline because complier knows it better.
6. don't hardcode clock source and parse two clock source from dt "mux-0"
   and "mux-1"
7. remove bypass method.
8. add a method to change clock source when mux-0 is not support the
   input period it can change to mux-1.
9. add cycle range check.
10. add some variable to make it more readability.
11. add clk_disable_unprepare when some false accur.

v2 Changes:
1. change sun8i-r40 symbol to sun8i.
2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm->regmap).

Hao Zhang (6):
  Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
  ARM: dtsi: add pwm node for sun8i R40.
  ARM: dts: add PWM for Bananapi M2 Ultrar board.
  DEV: CLK: add function to check the using clock name of driver.
  DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40 soc pwm.
  ARM: PWM: add allwinner sun8i R40/T3/V40 PWM support.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  24 ++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  17 +
 drivers/clk/clk.c                                  |   6 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |   4 +-
 drivers/pwm/Kconfig                                |  12 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i.c                            | 418 +++++++++++++++++++++
 include/dt-bindings/clock/sun8i-r40-ccu.h          |   2 +
 include/linux/clk-provider.h                       |   1 +
 10 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.7.4

