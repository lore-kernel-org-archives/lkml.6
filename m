Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA5EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DAF2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKfKR7ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DAF2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeJJQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:22:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45803 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJJQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:22:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so4138127ljc.12;
        Wed, 10 Oct 2018 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXMcX+/SDT0au4jBbx0xqY7ueJkB5UlYtvi8TrlwjVs=;
        b=eKfKR7kukWSqon2gKaCMiCsErxEsGZuQkAeGTP1U5evHi6M/iivU5GXcLsAH7/aeds
         sBtW3I93lb07WKzoR4aZea6jl3lHcaoMLHSOzyL4vr2PMe3V+rs+No7nP9fqFe7XkBsz
         rZ+vjYsIVv0Plg3kwNumfckCmO29qYbZUp/ckIM2ArPbh1mrNRDiH3siDYpWLLcNWG62
         VLF9U+wEHQfMulSluGBHuMsqvfzKJelNYPcroqG2qk1YXqilCMULIsemVKId0+8YgMCd
         O0RIQioi52SlIJ9J4aD7CrIA7SkuPpKlHk1Uef8P4GgqLL/9xhXSovEs54mLIC2dgF6s
         Xu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bXMcX+/SDT0au4jBbx0xqY7ueJkB5UlYtvi8TrlwjVs=;
        b=k4wm8kBsdbsXefFIJAHbBxwH/+4AymUD+2/RVwJMDN+3WwmDGjHDrxoBnOWAyWj8kr
         djDYp9OwRJSpRRLXR/j4laFwf46M2eQ26xaS7hCsZlFpVHiG/VrJyx+PoTH9Q9gnOQ/E
         4EkLMj3M0Fj8sJfR+HctvE4uFRSg3YNBeyuQ4vRxdRcKHA58ykpRE+h6GCX29wtNO9Tv
         I5bhunhMetXHbyzi25DXbny8eu45VFIfKN0F+k57GhrJW2I6QnzDPFe/9gHC44fPZsya
         ajAfYJThAcCbOXIJtZhFX2SPq2VYXBI5FbNPuCc5+zDJFPSc11gjY/gvDI4PYqZki9Jf
         mwZw==
X-Gm-Message-State: ABuFfog5ssFDciy/3lTy8cbhn80TqQM0vBnMynIh8IJ8OOIOdV5nlfCi
        p0z7Z+eakyUhjFa6EiIMVKItNnpEPSc=
X-Google-Smtp-Source: ACcGV60++KjdAio0jbLShJEsbxevtqr0cVOEy51UbxelXWvFQFsgj/DrxxzZ+rmx4Nw3wnkpcSQDRQ==
X-Received: by 2002:a2e:80d2:: with SMTP id r18-v6mr21974459ljg.100.1539162104395;
        Wed, 10 Oct 2018 02:01:44 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:43 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/7] Enable spi dma on Rockchip RK3399
Date:   Wed, 10 Oct 2018 11:00:31 +0200
Message-Id: <20181010090038.20834-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The first three patches in this series enable spi dma on rk3399,
while the remaining patches are meant to be decreasingly obvious
cleanups to the rockchip spi driver.

Unfortunately I only have rk3399-gru-kevin hardware to test
this on, so it would be nice if someone would test this on
other rockchips.

/Emil

Emil Renner Berthing (5):
  arm64: dts: rockchip: add rk3399 SPI DMAs
  spi: rockchip: remove unneeded dma_caps
  spi: rockchip: mark use_dma as bool
  spi: rockchip: directly use direction constants
  spi: rockchip: simplify spi enable logic

Huibin Hong (2):
  spi: rockchip: initialize dma_slave_config properly
  spi: rockchip: adjust dma watermark and burstlen

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++
 drivers/spi/spi-rockchip.c               | 62 +++++++++---------------
 2 files changed, 32 insertions(+), 40 deletions(-)

-- 
2.19.1

