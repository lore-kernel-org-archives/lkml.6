Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EDCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB83208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b="HdCAqgDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB83208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kresin.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeHWAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33383 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeHWAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so463971wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=J57nBDuGXn5MkfMLUm0177RSJZQNZvRsAWiDYTsT0LI=;
        b=HdCAqgDfJ3hqOLjcElWIoYnL7Wrsrduyjh825IavLAdP/fhdb8nNpCVaUP5PFzc7kg
         qXVNYTTKwVx7dCjq9FQFRvmpge7W3eUmSb7ArAzlq5JjW3eStsxm7t9jh3IBhCtyynCV
         f6j53VkKw/sRXk8I8XrFZLccW7gkufnZVdQQ9xPbFjXLHbx/pRpbtGje+WaLCcuEuXoQ
         NRlWLvw0NCTjAOBLzWdo0eI1ix4eROz/s/879ODU8PXK4O0Yx0Bym7GJhMV9sbyEzOHS
         WRypwbjChQd6GYAFSZ22qD9bYK8ULn9ArrDhNLeG0PF/PfQgXRgcTIZAvGAI/pku+Wfx
         veDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=J57nBDuGXn5MkfMLUm0177RSJZQNZvRsAWiDYTsT0LI=;
        b=cXBWvH+YTuvmy4TWgK0L/Yu4wg92bS0nSfbEY1Vtem1XEREXQ2zOSgmORv0bLYe3RA
         HPp3qo+aiOMjxGPjD12NQVIj6r2POPs03+ls/qkumwC77p0Z59D0sD69tPBFiuSQZ/gg
         pvipI5QWr5e21VP94tDYZNd3mSQFc9kjNGKkYrbcrb9zoCYlFhsBT+otmR3mCQCEJ/wJ
         nG+vzXct97uxP6xEoEHXO29oN+Q4pWqST5FcVyXE0iJr/DS+89uGoRd7BE7tgE0Caw/F
         y2BNc8SctEuz1Pbami86uLIU+qhF3iNHBlyYC/IgcUgDzqttzN0EfNEnv7VAz2Um6cZd
         YZqQ==
X-Gm-Message-State: APzg51CRgNGebOxYZFEYrKreMIIDEbrXcpOkQ81Y9Q9ueQKwt9ckRJ+O
        cYmvFPEe2n7VIPOX2IXBSX6s9z684HOF/Q==
X-Google-Smtp-Source: ANB0VdYxLK+aviJhkdOqJXI7G4Bdo4jTq7tBqqfct3UqnWST6dsJQf21CpVUVYd7qO8ujfdp5yj/iQ==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr3125292wme.55.1534970615845;
        Wed, 22 Aug 2018 13:43:35 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p200300EC2BD836007CE5606DACB185FD.dip0.t-ipconnect.de. [2003:ec:2bd8:3600:7ce5:606d:acb1:85fd])
        by smtp.gmail.com with ESMTPSA id o81-v6sm2170144wmo.28.2018.08.22.13.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 13:43:35 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Add rt3352 SPI_CS1 pinmux
Date:   Wed, 22 Aug 2018 22:38:06 +0200
Message-Id: <1534970286-3758-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt3352 has a pin that can be used as second spi chip select,
watchdog reset or GPIO. The pinmux setup was missing the definition of
said pin.

The pin is configured via the same bit on rt5350, so reuse the existing
macro.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/ralink/rt305x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index 93d472c..0f2264e 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -49,6 +49,10 @@ static struct rt2880_pmx_func rgmii_func[] = { FUNC("rgmii", 0, 40, 12) };
 static struct rt2880_pmx_func rt3352_lna_func[] = { FUNC("lna", 0, 36, 2) };
 static struct rt2880_pmx_func rt3352_pa_func[] = { FUNC("pa", 0, 38, 2) };
 static struct rt2880_pmx_func rt3352_led_func[] = { FUNC("led", 0, 40, 5) };
+static struct rt2880_pmx_func rt3352_cs1_func[] = {
+	FUNC("spi_cs1", 0, 45, 1),
+	FUNC("wdg_cs1", 1, 45, 1),
+};
 
 static struct rt2880_pmx_group rt3050_pinmux_data[] = {
 	GRP("i2c", i2c_func, 1, RT305X_GPIO_MODE_I2C),
@@ -75,6 +79,7 @@ static struct rt2880_pmx_group rt3352_pinmux_data[] = {
 	GRP("lna", rt3352_lna_func, 1, RT3352_GPIO_MODE_LNA),
 	GRP("pa", rt3352_pa_func, 1, RT3352_GPIO_MODE_PA),
 	GRP("led", rt3352_led_func, 1, RT5350_GPIO_MODE_PHY_LED),
+	GRP("spi_cs1", rt3352_cs1_func, 2, RT5350_GPIO_MODE_SPI_CS1),
 	{ 0 }
 };
 
-- 
2.7.4

