Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18331C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC174217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icxHPMiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfBSHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:31:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44185 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:31:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so4964991pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SdoNCfzceGzIEn2QAjiB2FIUmmTDJWyalUqcJlv/qLo=;
        b=icxHPMiRLoe7YCvpUvDAuCNmAISq/kT+OrgD4VHTeqbErXfRRiaS2/HjEXPoL1VsJt
         gDqND8Q9R7vz50o43QH/HSDZ0cigWo+lxTn0RkXkSI/XVYuBSCObKMOsoNsl4qG7PR/o
         +0twUTP4LizV1d2aYeIIBuJDjdNCQ+xyQf8w6Z8eU0Y3Bl+jQyEnQLjJE/f4+lf6AF68
         uMrUgzMfZRqnkSXRE5/7+rT0YAi1/Uiq2jhnHd71iUMUYVT5NwRwzFB29udkUSfOSQ5s
         3HBeIN3wwdzL6W8r+f4agWpboGJ4f0zrgawju/dPhklIBgWHkhnDVnUWxu9hOXIN7TlI
         Kyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SdoNCfzceGzIEn2QAjiB2FIUmmTDJWyalUqcJlv/qLo=;
        b=UwyQUBbDu1po9n67arBzoFHZtwsBC2kJU67i3lDeAMTMXY+FgZRbEz5c9umHK+hxr4
         N2Sl+KUxoyjq5LH5zKIThdf1Lm46UpzC2/KLJ97GOP75Y7OK2v3cP4vQ9dHz+LN+/GmA
         Fz/FcB8HSDx47yygO4uEe5L/H7EKPF2o2zdXAsP8cCCFSysjpDDE+Bv7Qy71qBmH1I4i
         yFjzrKDqSq0IIKV3hzF5u808tZt8rd8uryihEuRz9os17OQqBSVneoK38REkEl0ltLcM
         2Mu1J4hCGRSaoW8WVmSGuYf9dTqGNEQBDoW/w4xlYmIDhJST/LaKzpq1OSbDffbj5SVy
         V3IA==
X-Gm-Message-State: AHQUAuaLcLX9xNUE+Jx00Z95wj2zaNIluv0Dhw9MUgfNHormrDrdIbIS
        +s3DTj++ZZiHpgGWhRQV+UBD3w==
X-Google-Smtp-Source: AHgI3IYcZbOFca6x6KG65rOeC1Nxu2e+KRsE9vfVy20silJA6i1Ure7B/wKdbF/3SjCtYqxpj5APdw==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr29436151plo.194.1550561507074;
        Mon, 18 Feb 2019 23:31:47 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n27sm31556569pfb.8.2019.02.18.23.31.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:31:46 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/5] Add new features for the Spreadtrum serial controller
Date:   Tue, 19 Feb 2019 15:31:10 +0800
Message-Id: <cover.1550560916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the baud rate calculation formula issue, as well as
adding power management support and DMA mode support for the Spreadtrum
serial controller.

Lanqing Liu (5):
  serial: sprd: Modify the baud rate calculation formula
  dt-bindings: serial: sprd: Add clocks and clocks-names properties
  serial: sprd: Add power management for the Spreadtrum serial
    controller
  dt-bindings: serial: sprd: Add dma properties to support DMA mode
  serial: sprd: Add DMA mode support

 .../devicetree/bindings/serial/sprd-uart.txt       |   17 +-
 drivers/tty/serial/sprd_serial.c                   |  503 +++++++++++++++++++-
 2 files changed, 499 insertions(+), 21 deletions(-)

-- 
1.7.9.5

