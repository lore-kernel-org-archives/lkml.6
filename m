Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354DBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98F421919
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aoHqqmsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGN0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:26:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45845 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBGN0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:26:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so11484013wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68x/n4YDg6XvhOG3QrYH78pmnPYmUGv4xBBGZW37dwU=;
        b=aoHqqmsHxLvaZVvK6pciw8h+RM2epyh5oRNkW/lYxfMtG9SHCRJ8YjI8S3M3Xt3PDC
         G0szWkwjcx4owhd5rfuF8uwaJAypAEjtqTZFIZrjOldeMcodt5cAU0p/6BM8B9Am8LW/
         vSI3zZnzhaQncChGJqELdAl0eA6+nfc/h8+ajDx8zt3SMccG4mn7uzZVTh8tMF5loobv
         IISUKF3iGP04c7Z6AptUJk+S8tyPcVVyxWXOQKnFVrmBMoKRHkoA73ywRmzdhNmjw0no
         52U2/ClvSFPnNwJCd3kLMq+PErimLHuVhJD4rVUfJ2hv/GehYpLnU/dWMOnhT3JojQC/
         KYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68x/n4YDg6XvhOG3QrYH78pmnPYmUGv4xBBGZW37dwU=;
        b=S08LutmRPZXoM6LfLmt7HCIj4tXOurTzY0WCXeC4WyyymQI9fEmFiEWIc5A0+JHQtu
         CJlkQRzAIodVLW2mSwjZYAogvreALLQ88AQ7A158SGRQR8AxK8GdZ2+M52o2XhvG3v0x
         /HbbMaUAyCechD6EwGhsoErG7bMNZIOFmcppxzb/P1ia98eKlKOz+1fU0OfCcCGm8YrD
         eEu2KTRCfFqq2xv6lSb0uSWyMCzYBHK7BwSwVzJ5TWhyA7fGLDmXg+1ciozLvAiiKTfF
         DQncJ7uIUY8ktw8fxkRGAWn0Q5pkCWkW0sWW1qV9Ddm008eywfezfuCGU3Wc0EtOrdSR
         eNXA==
X-Gm-Message-State: AHQUAuZwrYRbklCbP7qrTdUnxdWa8sdG/ERI9VS958xxmYE8E/HTz8fR
        KM3JaoOPc/4B4lY0VhcQ+/2OCg==
X-Google-Smtp-Source: AHgI3IaT7VprTeH7c5oBcCf9wqY5VxyMXvWEVPQO0fZU1WAn9MivbluAN4VHwi6oWhJrQEi64aYjgw==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr12028437wru.291.1549545983061;
        Thu, 07 Feb 2019 05:26:23 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 05:26:21 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] soc: amlogic: fixup clock measure
Date:   Thu,  7 Feb 2019 14:26:01 +0100
Message-Id: <20190207132603.694-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Here are 2 fixup for the clock measure series.
First error was due to the rebase on the v2 of the bus fixup patch
Second address some comments Martin had on the initial submission

Feel free to fold these fixups with the related changes if you wish.

Jerome Brunet (2):
  arm64: dts: meson: g12a: fix clk_msr node
  soc: amlogic: clk-measure: fix-up some clock definitions

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++----
 drivers/soc/amlogic/meson-clk-measure.c     | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.20.1

