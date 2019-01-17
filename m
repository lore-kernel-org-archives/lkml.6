Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90EC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="taU9ucdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfAQKcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:32:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfAQKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:31:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so10398433wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzTeS35Xi5XfGByr4FUaAaL7DLLfUheX6N30Odpo+mg=;
        b=taU9ucdCWHkHft20+Kl5P0JPusw8M9Hr1qddMGDs805w2f1qEDINOQw/MTUhD8+x1r
         V3KxfkJIjMCy25TJqZUl3aoS+pEvjCrQCuQwA+dgVyzI+W9doxX1wNOuLRxldk7Jl3Or
         lAwiwj12bV5fOqANAZMJa+xEzQRQ7miDu0bk/o1rFqBXGJgRgv6NiH9PLCOoDHK/BW6f
         FhM/FeyYlVYxfRUKGUpgXWAbxqVPmDydYZfBq528MrF8dQ+n+Ix0FJcEPxds2DRHM7aK
         MESlMCfSJ1oCwvS+VUVV46S0d0Dy/2mUT1/VH++FIzDqnoeHx5IuGUlb+Rl3AWh5hBaI
         ZdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzTeS35Xi5XfGByr4FUaAaL7DLLfUheX6N30Odpo+mg=;
        b=ZhVbrAXPRHGycctPUUENF0ze+qqxC06NGFXZKLlXzTVCvszZI0ttk2AntsSh+lHmzN
         kMlw8flk41qj8UTT3wrr1WJ3cgLDC0VeOEz9y7ncrKNsMNoU7GiC6P4Nyafur+g0rVtG
         DlBJH0ngVlWayCMdWhtUIvBnkD1uGL3yYIisQudPCOUfke9Xqb7W//z5sSsdSrak4tKq
         wbnd+/VkXZcpEKy5AEQ9QvIYqQrhQeLauYNa0sJ1M6tmKULZITQcwDuNkCpoznMCNdpY
         97m/VgAzwE2x8KAt6kr3zSIWEgPxWGKaazgbnVRh1TFupryqjhwvjJQk7qWdpXYskv6P
         EY8A==
X-Gm-Message-State: AJcUukerwx9jgyd6bo5WuIRUsE0F9aBiyGGSXS+7pfgpTJpziHWPcGDs
        ORsvb8tlAacx7msglMai/pZq+Q==
X-Google-Smtp-Source: ALg8bN7inE6nQd4uTWaM6jTWAqGhnRpYa+NC6cDLq50DFQQ87QBhQBk7n5igViHc6abHii7Fz1TKpQ==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr11730171wrs.272.1547721118055;
        Thu, 17 Jan 2019 02:31:58 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 143sm77658107wml.14.2019.01.17.02.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:31:57 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: g12a: enable pinctrl
Date:   Thu, 17 Jan 2019 11:31:49 +0100
Message-Id: <20190117103151.3349-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables pinctrl on the g12a and adds the necessary
pinctrl settings to the u200 uart

Kevin, please note that this patchset depends on the:
* dts bus fixup: [0]
* pinctrl region fixes [1].

[0]: https://lkml.kernel.org/r/20190116165236.8330-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20190117102315.1833-1-jbrunet@baylibre.com

Cheers.

Jerome Brunet (2):
  arm64: dts: meson: g12a: add pinctrl support controllers
  arm64: dts: meson: g12a: add uart_ao_a pinctrl

 .../boot/dts/amlogic/meson-g12a-u200.dts      |  2 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 67 +++++++++++++++++++
 2 files changed, 69 insertions(+)

-- 
2.20.1

