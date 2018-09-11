Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28EC46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7172086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGFkCLET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7172086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeIKH1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:27:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38028 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeIKH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:27:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so11436667pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qk2/AFdbILgUG5e4boID6f7lJW8Mo8x0myVk+54ZP84=;
        b=OGFkCLETkuMWAbCxGJ68yThZayy0RYgj5fJIMNHtkBQO+jSdSuMCJyerJntU9/WQ64
         /Mp38w9zlzXG8H8QzNbsx5W3cGwhWEzRj4znb9tfoe6ZYMXGbZU28UhY5p07+UJuePLc
         4oQsDoUC9vNQke9M5DXpSy1pb/J8wWSlSPfyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qk2/AFdbILgUG5e4boID6f7lJW8Mo8x0myVk+54ZP84=;
        b=q6mCi0gwxVHIB35Ei+qG/1loVCqevJIP5MvgUAFuI9DdJnSYAG9zBeACaEN6Vds6dO
         bZWTYHQsiLGlqN8uAcy1c7ALoLHp3RuMvgDatACPBZbZL8lGwYeqw9/RFrH8EXrWs4cb
         tVOITKQpgvcmnosJAa8j+zpvXV377SbyQMoVKuukOp/PMnpi+Tu06GTkb5Mo6+GDN8hp
         j8BHMBzrKmU6qEzCbggpxYBziBH1gLhqdNQumMCQwux3t3XoUsoR7EK9upFqfjXMUuzh
         Oc6PP0erMa0GDMOMjRlQRW5lUoNsPytR6U5ZaOlFqaSTV6HeFKWH0PMu8ryqvWd3cE/d
         PG+A==
X-Gm-Message-State: APzg51BUFaLiWPzGD6XqQQLNIdj5nx+bvXgnlwivC1qddHTKBAho9n3B
        0G/VO8GF9I3zVAZy2Baz38bY
X-Google-Smtp-Source: ANB0VdYdwMxR2iucIHxZAk3PE17KLoESxlwGpoooqlbqJE5r/3GU19AkNAvHfcq09TgkTOkrwi5MoQ==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr25199955pgh.348.1536633048177;
        Mon, 10 Sep 2018 19:30:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7200:d313:f895:c3fd:ee92:ac72])
        by smtp.gmail.com with ESMTPSA id y85-v6sm27025893pfa.170.2018.09.10.19.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 19:30:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add 96Boards Rock960 CE board support
Date:   Tue, 11 Sep 2018 08:00:27 +0530
Message-Id: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Changed the board compatible to "vamrs,rock960"

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

