Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09692C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF36A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ksU7eEGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF36A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeLCRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:16:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeLCRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:16:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so6532377wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ+dFdmZ920KJ6td8EU0wjLOULXN2OwWoR7RRNraTBU=;
        b=ksU7eEGj9F54kVOlTPj5JfnrnrE8Cj0BFGftVr5u0YkZ4Vsldi/ja5RKJ5WEvgfR9f
         RJUfkgtXFsDig/MSH4ngs0UO7nUpF3yinkzDBK1pzYiQa0MM2t35U2h2hTXD1Wx3iK5y
         LBNe8HzYxn9JPExwCYbxH3aaQArwHbgi2tSD2nHHSsuDRV2tWeTduPx59e015kwbNVDg
         iYedwUOGg85tWPTDUhgUH9A2tUWm4cc8N3Th4fDW+jZ6uxhcIJe3Zgkz1z9yy72HVZvO
         /7GXNKzUm913DR+Y3pPRbm36IJf8PF/sMspB0R1rlMf7gsBnDARTJSivAVi+PBcZqvQ0
         iWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ+dFdmZ920KJ6td8EU0wjLOULXN2OwWoR7RRNraTBU=;
        b=tQWZRCNhZpjJUHvh6yhA38VnMcTPoNnq/Fvi+NedE06yraHoI/WKXySO16V3a/WeHC
         UVR5ZLRwEAzn76mjNND9oQdgXxdURHGrprFfqf3jTWFX/TMS7eI5ty5vsQDvKPKAMgsD
         cdYMb1TsEXTPzG50mRCvaxfDfYo0ckc5eWgJgErCNZLTY6TPOTYu0phaZHC/k6XM3uoJ
         H/0EiEtVDeI441KV9RtoI7RkZFMG9lgsN0lGAP+C7pwmLQkRkiPkqlJRGVxnppL8yrzy
         fmpSxHI/L3ZvJFKn3UbPf6ghpQB7AvZHyfgHm3TIJ/zKm0wj3CGUyxyDxvRP7VHzcPEf
         AsGQ==
X-Gm-Message-State: AA+aEWYn3sXpWbvYHrwzcGnEyEeufBwjzKlBZ7YLYjq7wSE4DEfzIeK9
        BesCF2fXDsCggED0c6Nea5A2o7W5w/4=
X-Google-Smtp-Source: AFSGD/XmUwpnJmmwRVcRFLbLGUxdmI3PfK3cf9zrSLDk+MhUMKvxQ3kvhYGILCEGZX6k/UHziNN+/A==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr8599633wmi.57.1543857415551;
        Mon, 03 Dec 2018 09:16:55 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id h203sm22494889wma.19.2018.12.03.09.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:16:55 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] dts: meson: add clock controllers input clocks
Date:   Mon,  3 Dec 2018 18:16:37 +0100
Message-Id: <20181203171640.12110-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the first step that needs to be done so the
amlogic clock controllers properly claim their input clocks
through DT instead of relying on fixed names.

I'll be waiting for this hit mainline before sending the related
driver changes.

Changes since v1: [0]
- add clock-names for the main clock controller

Changes since v2: [1]
- add more inputs for the gx family external 32k references

[0]: https://lkml.kernel.org/r/20181129164524.18670-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20181203131850.31388-1-jbrunet@baylibre.com

Jerome Brunet (3):
  dt-bindings: clk: meson: add ao controller clock inputs
  dt-bindings: clk: meson: add main controller clock input
  arm64: dts: meson: add clock controller clock inputs

 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt  | 10 +++++++++-
 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt    |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi             |  4 ++++
 5 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.19.1

