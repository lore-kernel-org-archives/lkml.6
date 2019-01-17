Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46458C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DFF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LQUkGwZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfAQQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:48:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfAQQsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:48:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so1812919wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znrXYk8dBPzxU9mLzuO6fFMb5fFxzkslrN+ov26/0TM=;
        b=LQUkGwZlrxn2Db0rdRATMM2jt97hWwIE5HllGD/SbMb/f1JPbPCiQS4fiyJpRj3B5y
         YC7nH0puaa/232uqIy77ejZ7gjZIHPkMZo6jc14OfvpVCo9ap5HMW9m1F5jUCM/NZ+lq
         5oandNG/41gEfiwSi6X+kErqwfseBrkP+obl2TeGEltpMumjF47oODvZDUPY53mAf3WN
         T0kFxQ4G3i2NXV0D/d94EvLhw/FB94EveuV6PGAsbaXrMPwTbLQnf2+4C2dnQ2FdlTw4
         gPmko4A1ukxmQ6VTjm91a0fs9ssTT0UXWp7hrOLzHAofOU2Qbs0qhnINwpn8yGTwWaxm
         A4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znrXYk8dBPzxU9mLzuO6fFMb5fFxzkslrN+ov26/0TM=;
        b=bWbJuq0UDuQCxi1S8V3zZ6h8gOc8SmTExFv2BzW5afhrzFwAVmiZ2dKR1k3odjXPpw
         ACUIyFIO3YXSJ0VahLeb/ifDNT46/bLdIUGIx2HkYqB+oUVPUJ54gE0OugV+NIsqnMPq
         0cUeNpDUHCoAUYV/AfkgLFtXR5VVFy/gaNbl3bJyEoeQIv6Mnh+UKhxQvOgY4g9lTE0/
         6FN6ttsuQLuwD6xFtUUCUzOdp66SJG7SK9Wt8MZSf5Ec4bARQlla/NWtZ3/H4oVlJNN1
         CMuJwbZrybdl7z2jPq+oz++bzAWhmtaVVP7jqUBueHNVCwIh/UWJU7gCx5dV6yKrLb1l
         /Yeg==
X-Gm-Message-State: AJcUukdYC/6vfnMiICfmCpeAPKVH0l1MgXvfTRmrQ6beVGoeBLOeg05R
        uS4Fxyg1/2lA6sCSBjpBQiyikQ==
X-Google-Smtp-Source: ALg8bN4QLWzdGhKeSAzAVzFQCji7fLjIm6x6AhEzwUwBfsYnqeWzpEuQJ2U2fbN4qie6YruSqwEYaQ==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr6165373wmf.97.1547743725769;
        Thu, 17 Jan 2019 08:48:45 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j8sm99263199wmd.0.2019.01.17.08.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:48:44 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 0/4] soc: amlogic: clk-measure: add axg and g12a support
Date:   Thu, 17 Jan 2019 17:48:34 +0100
Message-Id: <20190117164838.8008-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the axg and g12a SoC family in amlogic's
clock measure driver and enable it on the related devices

Jerome Brunet (4):
  dt-bindings: amlogic: add new compatible devices to clk_measure
  soc: amlogic: clk-measure: add axg and g12a support
  arm64: dts: meson: axg: add clk measure support
  arm64: dts: meson: g12a: add clk measure support

 .../bindings/soc/amlogic/clk-measure.txt      |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   5 +
 drivers/soc/amlogic/meson-clk-measure.c       | 194 ++++++++++++++++++
 4 files changed, 206 insertions(+)

-- 
2.20.1

