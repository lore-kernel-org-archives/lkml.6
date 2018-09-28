Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0889C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F75D2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F75D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeI1RKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:10:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40608 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbeI1RKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:10:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so4061626pfj.7;
        Fri, 28 Sep 2018 03:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjwRQUd/3VhKOePrR1LgX3QUxoCchCvAON/SPZ2Ms7Y=;
        b=DdSAVeuuRpQYS2zUrNUDguLmOd3Mdh4voZiTrkwyV49cLvYY+LmfXNMAZq7HFFKl/X
         x2+dWlyeOqryj5DJ4DpNN7G8p5M6FDmEu6Pa+PXe3ycS+6ksUtkBRclEZ8jFyERTTOWi
         U5rECCD28TyCn+EHdK1Ojrb1jdkB70M2ZESxyTGzO5y0TTHpmLwd/VREnvg5QefR9m4t
         RzGdWyL5caAD9gKsUNhpB5RlIO3fzaHYY0dkBytXY77iEjj1Dy7jWsRRwaqA5abUBXpe
         a8Kquzc2QKhLZ6BJ/reQuksS0PJhOxAq28lJ7uB8Kme+9cExQk+wsp8dsz3msbs0XpdT
         OSKg==
X-Gm-Message-State: ABuFfogQYIKoAQ33A1Zcpdslttsoyga9CblNWswQZUhAAs7XmCgt0bZq
        o9E5lqLZ4SKwKG++0rRvpxk=
X-Google-Smtp-Source: ACcGV61zV4FJ2RAtgh5EKiewBsU8orZDzttDjLYz2Ei3DmSDmy0IWdqzBdNwmGrfulwanFMXJk+uvg==
X-Received: by 2002:a17:902:6e17:: with SMTP id u23-v6mr15776581plk.28.1538131611577;
        Fri, 28 Sep 2018 03:46:51 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id 5-v6sm12885951pgt.83.2018.09.28.03.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 03:46:50 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1g5qIL-0007yQ-Gf; Fri, 28 Sep 2018 18:46:49 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
Subject: [PATCH v2 0/3] Add support for Moxa UC-2100 series
Date:   Fri, 28 Sep 2018 18:46:14 +0800
Message-Id: <20180928104614.30601-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UC-2100 series open computing platform is designed for industrial
embedded data acquisition and processing applications. In order to
fulfill various industrial applications, there're many boards with
different peripheral devices and wireless modules in this series.

The features of UC-2100 series are:
* eMMC
* SPI flash
* {1,2}x LAN (100/1000 Mbps in option)
* {1,2}x RS-232/422/485 ports, software-selectable
* EEPROM
* TPM 2.0
* Watchdog
* RTC
* User gpio-keys
* User LEDs
* User button
* GPS (option)
* 2x CANBus (option)
* Cellular module (option)
* Mini PCIe form factor with USB signal (option)
* MicroSD slot (option)

---
Changes from v1:
- Use property phy-handle instead of phy_id
- Separate DT binding docs and dts file
- Remove am335x-moxa-uc-2102.dts

SZ Lin (林上智) (3):
  ARM: dts: am335x: add common file for UC-2100 series
  dt-bindings: arm: omap: Add binding for Moxa UC-2101 open platform
  ARM: dts: am335x: add support for Moxa UC-2101 open platform

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  | 249 ++++++++++++++++++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  69 +++++
 4 files changed, 322 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts

-- 
2.19.0

