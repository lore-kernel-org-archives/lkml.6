Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554E2207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PRklDA9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfA1I7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:59:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1I7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:59:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so7689986pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X33IfDW79s3nOzDXxSV3lkb22+AZ3LL5pvGv198VQQk=;
        b=PRklDA9VS0uTeVg5wT18W5Ba6LAbwrQ61Ifz9LHXT2OyBnm0NHPXmN/c5YWs6/cSOq
         0IHa5/SbJY4tikE7qWOkx+/gnqGHhm5DMc4qvYp6IEuZ6DD6zYTgTQk8RJU0i9jkMWKl
         MRnYUUGw9cUpGfXRZliz3CRNRPRYfmHT9VPs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X33IfDW79s3nOzDXxSV3lkb22+AZ3LL5pvGv198VQQk=;
        b=a3OJYVxCs232p3LjyZtWbum5MBWA0JTO9QnG1XJYxDigc2NVfbgEuKzx7UxC5hwyHl
         su/7rQOXJneZIkCnP+1tUDHaIOtYHNmVSZKBBGxIkxZyd72Jdxdz+XVR5sDxJ/AXCpNR
         vuMXIr0b3UX4LUYRgiqeGVDqzaauv6Rxm37X46sgsOGKu8ox8KXkpH55yu1dDVS1AMwN
         DZEO0jlr+gINaPT750RwDmZVYr+SuGLSbCEfA4puA/+ORoW2i/8Pj4Gy0v3bMn8qmIeg
         /8ZCqqAIMuWTlxbXGfdABzEaqI62zQ5LGhIOdXoYem4G5wkynHXZw6fNUWRUvfeIwMuy
         /QZQ==
X-Gm-Message-State: AJcUukdxzn3okTk531g/QcaqkEmpJqphuEMoYAFLtYInSG3d1Hv/DD6l
        AdrRTiuqVFwCX9Dp31CR9tYFxQ==
X-Google-Smtp-Source: ALg8bN7qLtYj6nShO4Dp7E2LOO6H0YEdlvNE9AllOX1t+FDV0kH7vGHn2/+Q0os93guY7/AgQtb7PQ==
X-Received: by 2002:a62:6047:: with SMTP id u68mr20753600pfb.239.1548665944199;
        Mon, 28 Jan 2019 00:59:04 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id o189sm60746245pfg.117.2019.01.28.00.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:59:03 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 0/5] media/sun6i: Allwinner A64 CSI support
Date:   Mon, 28 Jan 2019 14:28:42 +0530
Message-Id: <20190128085847.7217-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CSI support for Allwinner A64. Here is previous series[1]

Changes for v8:
- update proper enable and disable sequnce for clk_mod
- fix warning for patch "media: sun6i: Add A64 CSI block support"
- collect Maxime Acked-by
Changes for v7:
- Drop quirk change, and add as suggusted by Maxime
- Use csi instead csi0 in pinctrl function
Changes for v6:
- set the mod rate in seett_power instead of probe
Changes for v5:
- Add mod_rate quirk for better handling clk_set code
Changes for v4:
- update the compatible string order
- add proper commit message
- included BPI-M64 patch
- skipped amarula-a64 patch
Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

[1] https://patchwork.kernel.org/cover/10779831/

Jagan Teki (5):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 CSI block support
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 11 ++++
 4 files changed, 102 insertions(+)

-- 
2.18.0.321.gffc6fa0e3

