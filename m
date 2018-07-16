Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98101208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b7NO99/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98101208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeGPKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54709 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeGPKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so4249687wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0W+SGp39jUTDdnKGSK29HVkK602riYY2JV4k0VDsS/4=;
        b=b7NO99/z+NE1MUzkFzxe2/sXLK4Vdp3pHN3I4nPOtTC2G7Wx+R2rlTRbw95XFE+sfE
         Bs/65n9ArzwEHDBBLxBCd3j/IGvWV09YhCSDDIxwuErOh4B7zTsD3+AVO6FU6xcrdzSy
         Z/LhQOHGMEBQhEySdhI3ScaFHKGuKCzm9UqGTu+9oc4UrMONOQjyeK0wIopc7CY3B1y6
         s+56GK5r3/ezu/SLoex0A1OWS4mWznojF3MhlQdky/wCQE3JdAQvD7+PjR22hmaN8/f7
         7VFFyt1ebVnZ5MqS61cv67mPU1k9b69m7GG+jEDqgihlFv7CQDhwbUZz2UrO3Ajj0TFo
         LBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0W+SGp39jUTDdnKGSK29HVkK602riYY2JV4k0VDsS/4=;
        b=K9eZz5YjwRjy8C6sh+UtOh8js5zDB55pfaQ08Z/+6fjD1K+GFeIe3+x+ShTEge1yvS
         CxBwXfyoPQntrizfRZrZgd0R8bRQP7ElNlwptkY1FjhZ9hcR6nvAW7K1l8NZzaWNdPGm
         X/l2oCfYvFs+4rsL94hliJdmGzHPzAwzRCVICIqpN+NkW3FmWIEkiivMHtuUK72DFIhO
         RkvnbxSltGsZUP020C15a/fv95vlf6U8AkMiMCWZ6GNbsSQoSezeBxUNOhxt+lh00QeM
         Ay0YwE9RXGhV6pgbp7Z66ayywptpJQDWMoE097UozNufDGOpZmNvrTkm8s5qHID01At6
         pqpA==
X-Gm-Message-State: AOUpUlHl2/nXy4uTn3UURqywoVwqeAtfpE9cR2a1UK5YB/TI4T/Cwihr
        01j/wCUQ8dQP/6O1gZxyGkSJqA==
X-Google-Smtp-Source: AAOMgpcxopY/+un66MMBTcKoZuqoNmQBLQzxlK5xgeOl2DeWR/D28yfvoNMxetLvPTB9ADOqQWeFjA==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr8952490wme.109.1531735914608;
        Mon, 16 Jul 2018 03:11:54 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:11:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/6] ARM64: dts: meson-axg: updates
Date:   Mon, 16 Jul 2018 12:11:45 +0200
Message-Id: <20180716101151.31109-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset groups several updates targeted on amlogic's AXG
device tree. Patch 1, 2 and 6 had been posted previously but I thought
it would be more convenient for Kevin to get them as a single series.

Jerome Brunet (6):
  ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
  ARM64: dts: meson-axg: add adc buttons the S400
  ARM64: dts: meson-axg: remove spdif out from gpio a7
  ARM64: dts: meson-axg: add spdif input pins
  ARM64: dts: meson-axg: add pdm pins
  ARM64: dts: meson-axg: add the audio clock controller

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  44 +++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 127 ++++++++++++++++++++++---
 2 files changed, 157 insertions(+), 14 deletions(-)

-- 
2.14.4

