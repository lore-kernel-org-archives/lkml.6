Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1962C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B658A2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hI246O9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeLODCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:02:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45948 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeLODCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:02:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3503575pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 19:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ircXPkLKlb7ZlNEJJFaa+uDJP6y5IrcHuMjbfpKiMOA=;
        b=hI246O9+rjglH+Fpwi7teN9sIiZjU7bBHZjPD0MJfbc/wztB8yiiViidzL7qK9Ruc/
         rM4u6wZmwVZ1iTckFuYIau29gF1l9SIC8U0HOMU+JGFaiktpq8/OGlxfaOBBWlUblU0W
         ulKzQqAvAQpfZ2rdpE0BrJq6iU4kZDj8d1R8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ircXPkLKlb7ZlNEJJFaa+uDJP6y5IrcHuMjbfpKiMOA=;
        b=sxr29eGzTaeKS1dQUyq2fKilxyVA6fvZkZQrIN8EL4RqSLyS02BeDeVjsYOQjWW5DF
         DL6iJv0vYmlFrR3q+1bYmWhOqOun6l6r8l4skjOjQwRoFpbvTj+WvHx5yTg2T0GlQtiy
         mTp4oD05H+wpEmPqpWvlHe+dVir2l8Ff28kMEli2mK//sa9QGRkyTYPvv8dCFe9h1VZb
         bCAbHPFEuxlM1T+2A+iZ45XKQcolxnS40P8XeuAHE8ZUtBhHujLLn8kO3CY79UuUyk7v
         cIa7CpwOQOLYEJn1lWVm4qqRowdSFQV+3BOPUELD4yxrkvW1lHmnS23IIYfK99cFsqNo
         qpdA==
X-Gm-Message-State: AA+aEWaxhSR0A3JeK1OIX4Jf90jd0I1GtL/ymi2uJW9oj+nFgwfKYQ7Q
        yz5ZGHpmDNiq0fccQtDIWn1Q
X-Google-Smtp-Source: AFSGD/WTLEHHv8GWZsDQuLb/c22diVLXIs4DHvBqscDpWO5WejTmyN6nTgQvMOE9gEPuCDKSfGaZyg==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr5204641pfb.84.1544842937540;
        Fri, 14 Dec 2018 19:02:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
        by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 19:02:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     dinguyen@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kucheria@linaro.org,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add board support for Chameleon96 Board
Date:   Sat, 15 Dec 2018 08:31:50 +0530
Message-Id: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds board support for Chameleon96 board from Novetech
based on Intel Cyclone V SoC FPGA. This board is one of the Consumer
Edition boards of the 96Boards family and has the following key features:
    
* SoC - Intel Cyclone V SoC FPGA
* GPU - Graphics based on Intel Video Suite for FPGA
* RAM - 512MB DDR3L
* USB - 2x USB2.0 Host, 1x USB2.0 OTG
* Wireless - Wifi, BT
    
More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/chameleon96/

This patchset has been tested on Chameleon96 board and the board boots
into a distro on SD card with USB ports working.

Thanks,
Mani

Manivannan Sadhasivam (2):
  dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
  ARM: dts: Add support for 96Boards Chameleon96 board

 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts

-- 
2.17.1

