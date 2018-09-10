Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C62086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMqqFOAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0C62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeIJUIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:08:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39888 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:08:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so10633986pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xUcd32/ZeufovhewLUv7VmgLTZI+Vf4BmqIl8W0Ph1U=;
        b=HMqqFOAde+L4VU12b2OQY8lx2fcZDkpR2FcByzoduFLhX/HRajr7IzewRyU1FFci3M
         zCN7oo94FLtM23f0v078bPUQqbHeqW6bttEqDo07pDrX2eDX5noMt/6yc4+VNUP2JWRg
         rZ0FTtnBneMhEI3rCyT/F4/DTaNKL0rC6MWqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xUcd32/ZeufovhewLUv7VmgLTZI+Vf4BmqIl8W0Ph1U=;
        b=DKZoAEQnN6H9CSeew278GqPX8YgDGNf5MlD6lqdS+dIINLPFw696HuA1gFDrr1CyLo
         9vCgBQC51Xma0E/UFmZm3VXA5C04LBGw/DcQBu3S+ZGOege6qctBdn6ZO3qKqVwUsmwT
         ljmjzzoeeQCD0for3DEI2CjGONhjWoHHMemw5LIGkCV1TSoLC5KjQNBRDUlDC3kD5qwO
         iBkoWboD0OLMlNEI0IG4X04IrCXzh8NPSzuutq9efMQVXpTB2yVEGDRg8B4b/4DfoMdD
         7CShGX9mqukdJnjSvt26E3wC79urReLGDDdBAIcuJtT/5veUcoX+6xLU+DSV8O4WQiaw
         MUcw==
X-Gm-Message-State: APzg51BL/ZIDRMnqYW6pqq1muaBTmw1fkBoeQFNloXgGVGJ71xFIxX4a
        Mva5QY/gZzGfE1cxuZfj3DtY
X-Google-Smtp-Source: ANB0VdbGARGs+XTWBJx2GGLZthBmT1swY1QypNvI3R5eSGuXYb7hJA4FHQNETKhrQB1nAWb23oYyIg==
X-Received: by 2002:a63:e60c:: with SMTP id g12-v6mr23618172pgh.308.1536592459180;
        Mon, 10 Sep 2018 08:14:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:728c:6bba:60a8:6c40:2817:7ee1])
        by smtp.gmail.com with ESMTPSA id e202-v6sm26703907pfh.16.2018.09.10.08.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:14:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add 96Boards Rock960 CE board support
Date:   Mon, 10 Sep 2018 20:43:52 +0530
Message-Id: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds 96Boards Rock960 CE board support. Rock960 CE
(Consumer Edition) board is one of the member of 96Boards Consumer
Edition and AI platform and is manufactured by Vamrs Limited. Most of
the board configuration is shared with the Ficus board manufactured by
vamrs, which is an Enterprise 96Board.

For the sake of avoiding code duplication, a common rock960.dtsi file
with common DT nodes for both boards and separate board specific DTS
files has been added.

To be specific, below are some of the key differences between both
boards:

1. Different host enable GPIO for USB
2. Different power and reset GPIO for PCI-E
3. No Ethernet port on Rock960

While adding the board support, SD card Chip detection support is also
added to the common dtsi file, shared by both boards.

This series has been tested on Rock960 CE v1.2 board and expecting the
Ficus board maintainer to test the relevant Ficus part.

Thanks,
Mani

Manivannan Sadhasivam (4):
  arm64: dts: rockchip: Split out common nodes for Rock960 based boards
  dt-bindings: arm: rockchip: Add binding for Rock960 board
  arm64: boot: dts: rockchip: Add support for Rock960 board
  arm64: dts: rockchip: Enable SD card detection for Rock960 boards

 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 429 +----------------
 .../boot/dts/rockchip/rk3399-rock960.dts      | 139 ++++++
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 440 ++++++++++++++++++
 5 files changed, 585 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi

-- 
2.17.1

