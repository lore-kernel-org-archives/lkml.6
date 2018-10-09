Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB172064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRT1fb/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB172064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJIVW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:22:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36837 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeJIVWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:22:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so909299pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lCKWAfy1hQ1ZDniKX3lW7odf293Q6JjmEA+5zPOdh04=;
        b=ZRT1fb/+AyasXSQ2cjs6XXslhqaUi6FAkjlB7Acd7Rtb6D4g5RMoy4ckWH0OKsIc/2
         L9wKD4bSo/wMcKYeF9efcAjybaWJmYCmo6O8Ej885LtmmiEC9GZse2YyQ8/YG2gHll99
         F5FddPdO7n5u7HQWG7M2UaHiAO2Qz4F93nid0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lCKWAfy1hQ1ZDniKX3lW7odf293Q6JjmEA+5zPOdh04=;
        b=MmAaoGvqUtmA7MwCmh9tBJo20+4vTXRxDsGUfAcxoJQWIcndBRzzvSZiU4sfmm7smp
         g8mLOcUQPeX6557cVH8AoSSG+hfijWgeDUwflQ18EG424u9PyVnlk+ig0yZWkrelJ+Jv
         WBIzgY8KbArEoNn/M/Fkfv4QpVVuaLXY+Xf5XS6n5J4GVbP0sEo0Q0khQM1xux4AfKqY
         lrdyg+jmXxhretS3ov4PSPoFY3zv3dmB9aP/K59NnVMHWszNPLKsQsVL/3b+qX4XO/o1
         FMhlhvS2jj/YZeuZXPb9wl7M38BA+CuCawhunHALiuPxIOymhax133XXQRkFPBOhJPPD
         f4iQ==
X-Gm-Message-State: ABuFfoiz85T5FFzflnQIjIGg25SyFVHMdi0e1FT8ci0AI3kYOEgwQt5t
        bBM9dILfssBAvJ6fbjHuQ3xO
X-Google-Smtp-Source: ACcGV62NXwfa6dZTUGCBNJY+h0lLeoZYQwovqNK5BfOMBkIYv2snVWWYrdgMNTb5g5U+IIAiv3uRvQ==
X-Received: by 2002:a63:1066:: with SMTP id 38-v6mr22352161pgq.254.1539093948077;
        Tue, 09 Oct 2018 07:05:48 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:05:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/6] Standardize onboard LED support for 96Boards
Date:   Tue,  9 Oct 2018 19:35:16 +0530
Message-Id: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset standardizes the onboard LEDs on 96Boards by maintaining
common labels and triggers as below:

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

This standardization is required to provide a common behaviour of LEDs
across all mainline supported 96Boards and also making it easier to
control it using an userspace library like MRAA.

For Rock960 and Ficus boards, the LED support is added in this patchset.
Rest of the boards are converted to adopt the standard.

Note: Since there is no UFS trigger available for now, user2 LED trigger
is set to none on HiKey960.

Thanks,
Mani

Manivannan Sadhasivam (6):
  arm64: dts: rockchip: ficus: Add on-board LED support
  arm64: dts: rockchip: rock960: Add on-board LED support
  arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
  arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
  arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
  arm64: dts: xilinx: ultra96: Standardize LED labels and triggers

 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 18 ++---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts | 13 +--
 .../arm64/boot/dts/hisilicon/hi6220-hikey.dts | 17 ++--
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 ++++++++++++++++++
 .../boot/dts/rockchip/rk3399-rock960.dts      | 79 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 15 ++--
 6 files changed, 190 insertions(+), 30 deletions(-)

-- 
2.17.1

