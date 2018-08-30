Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359020645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3359020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeH3IKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:10:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeH3IKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:10:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so3286273pgp.9;
        Wed, 29 Aug 2018 21:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XYIxWRPDKSuHlQU3oG6e23v6Dyho8yOWVpcpZM6w6Y=;
        b=iIVE/E6y0sjqQ0ZLVk4NmNppb8lf/xGSnVlDEpi7foCXxvh9D4jqgT/v3+1lzWHTQ4
         UA2XoUBbjJa1v8OUMaiNJfty8Xc9s3UALXSuy5qM8L2MZeglL6d6+jebWXlUmMcss8qK
         bCG81ZyOaozSVNsu6zFnRGQqG2C3Ntm0FIun/KrhNtbfqslrSvNfjM2PqJQZxp02BuFn
         j7J47lLbnHtiNsYeYnoTxVrPaZOijp1F4/QfQ23LWKukgaj0QrzbE1dLpvbiMgXURZQD
         8RmA6ZzimcdU4LdmXnC+Zm2bOaRHY3fh/svTpZuvGAQktqK33P+gORoBh2/lyLAht4C6
         bkMw==
X-Gm-Message-State: APzg51AI0ku3hoPo/w+h5RHFlBYAHzTYpth7Pzpt615P3Uopy4lvA1ia
        UyBcSTAmIff9+ZajEdnz+/j+Ao7R5gckIlCo
X-Google-Smtp-Source: ANB0VdZSJxylp2bn/P+ninpMtEqGOkhukRi5EPbdan3jxwYR7reE/Je48+cjuib8XfuVHCG3EfNNCQ==
X-Received: by 2002:a62:5b85:: with SMTP id p127-v6mr8738152pfb.33.1535602199226;
        Wed, 29 Aug 2018 21:09:59 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id 143-v6sm7855131pfy.156.2018.08.29.21.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 21:09:58 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1fvEHN-00065b-08; Thu, 30 Aug 2018 12:09:57 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
Subject: [PATCH 0/3] ARM: dts: am335x: add support for Moxa UC-2100 series
Date:   Thu, 30 Aug 2018 12:09:26 +0800
Message-Id: <20180830040929.23357-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UC-2100 series open computing platform is designed for industrial embedded 
data acquisition and processing applications. In order to fulfill various 
industrial applications, there're many boards with different peripheral
devices and wireless modules in this series.

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

SZ Lin (林上智) (3):
  ARM: dts: am335x: add common file for UC-2100 series
  ARM: dts: am335x: add support for Moxa UC-2101 open platform
  ARM: dts: am335x: add support for Moxa UC-2102 open platform

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  | 249 ++++++++++++++++++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  63 +++++
 arch/arm/boot/dts/am335x-moxa-uc-2102.dts     | 200 ++++++++++++++
 5 files changed, 517 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2102.dts

-- 
2.19.0.rc1

