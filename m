Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE1C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1512084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTOFD26R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1512084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeJ2Say (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:30:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbeJ2Sax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:30:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so218980pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OZP8Inh49iXIb0437lQ+4o3hyTQZdb+CFCCyilHmvkA=;
        b=TTOFD26RuZniRvsjRVyvUxVislQP+1vhMTpOV7SzVLeBI9s46CWaqAHxDEi/iM6Cj1
         Wcsqxe2v8MzVEUxoJyQELfRR46immRCuxORz0eCDr1T+VU1OSvMhWLK5Wd0WpTszJ941
         gyBBZKEL623GKcwviZUyxprVEoojFqQTDp4CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OZP8Inh49iXIb0437lQ+4o3hyTQZdb+CFCCyilHmvkA=;
        b=UQVVw/rGW+y6IkOFtbo6MdBIa2KnL4uxDCJsO9z1/cRJagBqE2nNqTJ5d/K760PPlq
         L/xHiFnHSkc/m+Wz7PC8gdvzkaVcC6yvPFfXZzIJ+/Piw0+ZK4rg49tRvkLJphZYbU/W
         Y8a7s7W3FrN4IhARKaacCiO27a6qN7Wf6JPyBZP+g9yF2xZwKioDdWNWfP2+UIBqp9MB
         yb9BlUT97xK30eInoNX23rHj50aelAXMTFfvv8/Uqe0m59H99Sjt3Ok7ILz1kKmK3hqY
         cmJrhHcgTWAvK9U9tPiqtu9dYpXma++IFHkGTDGk7wwhc7CU4qHS3JP/zOocobEPc3xz
         xUbQ==
X-Gm-Message-State: AGRZ1gK0Js3i+vWw9Urvumsw+5N05SDbr2LpbOvbBfm+CygO8R1zmKJV
        cnv5JcHTitfPQ871cx+IqRUf
X-Google-Smtp-Source: AJdET5eoL7cH6BScLxi+SsHWX+Do0uTl/cX+hhur9XePoMU1nEeYwZq28usjxmhr+CFCKjhKR0912Q==
X-Received: by 2002:a63:5308:: with SMTP id h8-v6mr12856165pgb.358.1540806180500;
        Mon, 29 Oct 2018 02:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:42:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com, pavel@ucw.cz,
        andy.gross@linaro.org
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org, nicolas.dechesne@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
Date:   Mon, 29 Oct 2018 15:12:38 +0530
Message-Id: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset standardizes the onboard LEDs on 96Boards by maintaining
common labels and triggers as below:

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
green:user3  default-trigger: mmc1 (SD card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

This standardization is required to provide a common behaviour of LEDs
across all mainline supported 96Boards and also making it easier to
control it using an userspace library like MRAA.

For Rock960 and Ficus boards, the LED support is added in this patchset.
Rest of the boards are converted to adopt the standard.

Note: Since there is no UFS trigger available for now, user2 LED trigger
is set to none on HiKey960.

Thanks,
Mani

Changes in v3:

* Added missing Signed-off-by tag for APQ8016 patch
* Added Acked-by from Amit
* Fixed user LED node names for HiKey board

Changes in v2:

* Removed device-name from LED labels as per the suggestion from Simon
  and Pavel
* Adopted APQ8016 SBC (Dragonboard410c)
* Tested the Ficus patch on Ficus V1.1 board
* CCed LED mailing list

Manivannan Sadhasivam (7):
  arm64: dts: rockchip: ficus: Add on-board LED support
  arm64: dts: rockchip: rock960: Add on-board LED support
  arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
  arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
  arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
  arm64: dts: xilinx: ultra96: Standardize LED labels and triggers
  arm64: dts: qcom: apq8016-sbc: Standardize LED labels

 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 18 ++---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts | 13 +--
 .../arm64/boot/dts/hisilicon/hi6220-hikey.dts | 25 +++---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi     | 12 +--
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 ++++++++++++++++++
 .../boot/dts/rockchip/rk3399-rock960.dts      | 79 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 15 ++--
 7 files changed, 200 insertions(+), 40 deletions(-)

-- 
2.17.1

