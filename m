Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8F25D78
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iI5vob+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8F25D78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeFYP4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:56:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52403 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeFYPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so9878497wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUevR5Ixj5eTkRIhfoVHLcI/JheqdImeN8VTMJbrIx0=;
        b=iI5vob+d3DZ49qbdm43iiIqPW14jjwcKjoFWAlLO6uaf//hoD0/nYlpv6i3m2iZTfY
         CTnKfS7Fh2XxgcYbfp9ww+0iQNCtg20ZcZYCoFQol23tq98NVUog02B2i0FdY3Z4IznC
         ODBkBJqLwgt3DMRZ8wi6GYXqrLTiXH0/s1wLUQwyUMA+feFsJ7wdUXgRTazQ4oVsfbMM
         6niVKxCKCnUOEu0Q+ekI0ZsDGcXxRGM+2p5qTp1oARMVy5b+EOrVLzUMsSk0qHm4DByv
         ErMq4mx8eepJe1PMjMFbqoAZzX0zDy7sG8HtVWskNAsMibOYQgNcb9s2E5haPEnTVzlG
         9dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUevR5Ixj5eTkRIhfoVHLcI/JheqdImeN8VTMJbrIx0=;
        b=BE9IaUHRnG8y79btYGtQpe2mdItPo/NSul16P1joK6HjPu9RUqdEUYeqVWfPQGIU79
         0bnLrzYC3hrfCht/SBRJjicj5PKnESH+afeqHeGYJsJ0LNxMMKQXZUkq35lsBdSnmMKw
         lFaaRqQRikvcglJiu2OwzoEG8rRM2FO9QE7sONgkWR9d3zJT5OPQ//JSWiSSsGI9hgCj
         lK+X+D00yAk8dkfmxCzBzlskDCtgoPIfA6/XcxAjO6JosC6aj3kNzeFlKGOImzu8awhu
         mmG27lEu0ockGRPnFQAUjXHelmLlJUyePseKgh5fZRXC4k+hHopip4aMIUlvgBNCcq/t
         vsKw==
X-Gm-Message-State: APt69E2c4IRFJcVIoRdqQM0s1yRaJXKgZiP6TTzcK4m/mPO8nAwdTmrU
        EdpUSLSaNW8az4NGTeoYN19HqQ==
X-Google-Smtp-Source: AAOMgpe6NqkMzb9Kfx+00MZxZPbJ3Lu6BShfOB/R1x6ZnU1p87pJdP+lETpyefrOoi+6C/EVgYm/Vg==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr1527008wmd.77.1529941882166;
        Mon, 25 Jun 2018 08:51:22 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/14] ARM: davinci: dm644-evm: use nvmem lookup for mac address
Date:   Mon, 25 Jun 2018 17:50:14 +0200
Message-Id: <20180625155025.12567-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 48436f74fd71..adbe8630ef19 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -28,6 +28,7 @@
 #include <linux/v4l2-dv-timings.h>
 #include <linux/export.h>
 #include <linux/leds.h>
+#include <linux/nvmem-provider.h>
 
 #include <media/i2c/tvp514x.h>
 
@@ -476,6 +477,15 @@ static struct pcf857x_platform_data pcf_data_u35 = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len	= (256*1024) / 8,
 	.page_size	= 64,
@@ -828,6 +838,8 @@ static __init void davinci_evm_init(void)
 		phy_register_fixup_for_uid(LXT971_PHY_ID, LXT971_PHY_MASK,
 						davinci_phy_fixup);
 	}
+
+	nvmem_register_lookup(&dm6446evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
-- 
2.17.1

