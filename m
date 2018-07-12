Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DCC468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A4A2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljIMPfy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A4A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeGLES1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43449 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLES1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so23040886qtp.10;
        Wed, 11 Jul 2018 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zbkleu/xH89k34lcqIE0q3ag3U1a73+lszHYYNpy0ys=;
        b=ljIMPfy0GolxCl/pjh2Ft032sgheqfLmT2cRRPe1zpUSAHzU0cF9jLZvBwosFM8eJm
         5Q7KQ4ih+Y5Eg9ENuLTZRfNzwWmMtDMtZN5o7t5cVUuTaFzV5jiIPKhgKQkkvvnCadEX
         ePdYTKzV5qC3sQhXAFhQ/GxrVacG/NSi+vOLrg1w8CxJyZ4dTtOzOfcQFygCtzmtLMM9
         89GVH4mSiACOGywL0oh/koDPyBz+VKlokawWod4pFGLWZtDIz/9XWZUlY6etuEfUtL5O
         uJdR64ESoXUyIPB6a6AHMZ8mfkw5fO7NE3lLg5FUYo++9SFD8x6j2lIAHM6E1MULR5jc
         vAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zbkleu/xH89k34lcqIE0q3ag3U1a73+lszHYYNpy0ys=;
        b=qyJJi5AGdFATuHm/mUe53uRBBKtdJvNB6oVq/WM0C8niu7A2YF+EDmVRrJCY4NWn/D
         YCa1iK+i+98KhpEgFj6Vh7L/WNVnCBfIZojlAcvmqsS1fLWN/Si9vVholl+bO2acvFUI
         iFrcfQ+JYULffTTXF/bVNOaDyQEe8P53lM+o3SZ5nwPKNl5j5okPRnVWXcnA0dQFjnYG
         QPJnI6gbNmEwrZ22tmc/UaVENfu1RfDpfqoTvg+S76kkJ9dS2tFxLfCd+a4EZOsriQWy
         tVbAejRB/iIy3imAr2nNTG1zsK9BkBlJaEjXUg6I39kidxpjt1VeLHcVV1mjKmKIru1i
         abcw==
X-Gm-Message-State: AOUpUlGbjHUci5G9sPN0YvC+OLeZJ2yqneBW9+kSeN7y5NeDxP0yk/+s
        EgESH9WM6djcOWeS/91ai1U=
X-Google-Smtp-Source: AAOMgpdtVIiAx3eoLarsUR1VilN1O5VMZDr5xPHReOMe46zKLRu2z4n8H7mE60zezmkAbromkblbUw==
X-Received: by 2002:ac8:2b46:: with SMTP id 6-v6mr489511qtv.302.1531368647163;
        Wed, 11 Jul 2018 21:10:47 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:46 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 0/6] arm: dts: zynq: improvements and cleanup
Date:   Thu, 12 Jul 2018 00:10:18 -0400
Message-Id: <20180712041024.20583-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to standardize device naming and improve
its information for better identification

The values of the "compatible" and "model" device-tree properties
are corrected for some devices, adding complementary information
when necessary

Changes since v2:
- Split dt-bindings patch (too many changes)
- Apply dts patches first (reorder)

Changes since v1 (RFC):
- Add values to compatible property instead of replacing them
- Don't remove "internal" word from Xilinx boards on dt-bindings
- Migrate content of adapteva dt-binding file into Xilinx's
- Sort additional compatible strings alphabetically
  by manufacturer
- Dropped patch that renamed the zedboard development board
  (no apparent benefit)
- Dropped the patch that removed the "zynq" value from the
  compatible strings (breaks the ABI)

Luis Araneda (6):
  arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
    boards
  arm: dts: zynq: correct and improve the model property of dt files
  dt-bindings: xilinx: zynq: Improve boards description
  dt-bindings: xilinx: zynq: Sort entries alphabetically
  dt-bindings: Move Paralella board to Xilinx
  dt-bindings: xilinx: zynq: Add missing boards

 .../devicetree/bindings/arm/adapteva.txt      |  7 -----
 .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
 arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
 arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
 arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
 arch/arm/boot/dts/zynq-zed.dts                |  4 +--
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
 14 files changed, 39 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

-- 
2.18.0

