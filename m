Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cY4PIUWGHls4NAAAmS7hNA
	; Mon, 11 Jun 2018 14:26:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A8D4607BB; Mon, 11 Jun 2018 14:26:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+jEQf4Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7703D60541;
	Mon, 11 Jun 2018 14:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7703D60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeFKO0K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:26:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36121 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeFKO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:26:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so16935107wma.1;
        Mon, 11 Jun 2018 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n5qzDa8PIaJuasVV6ub2CYqA9j1l22qWGpsmbGF1F3U=;
        b=W+jEQf4Q2t/F0A6RqA3PSuMVSnAoXIm1izIpspFzzSsx7vgpsyUbwdyf11X2Ot3aeO
         WdCl9ahI3Pa36NHqA+52WO+6bXCuBbCSIQ0JdZe4S0zhBgYYZ4ernGraVPCK2PNwF7AR
         UcwkZJ6A8BOg6Jg316HMnbfRBqC/xfALjXJMo4MxiUlJXEBxniasq7X6ZpMrXvZlNm2L
         Mg275NyXVlnZ+82RKhTLq6J4p0nLe7rGGHNo4KoDznKZTfO01l+/HsOo14phjJeIlfGB
         UWplf/sFsG3GKCemzQ5gmW73YmZb8g0f4Iw9nuuaOv4uQfuS8xZhc+649QAsn/Q2fwpl
         00Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n5qzDa8PIaJuasVV6ub2CYqA9j1l22qWGpsmbGF1F3U=;
        b=bZK31v94lMsgEPWgje1Jvc4NKCiAF9Z+h52liAoXCHl3SWbiVNezYJAfT3jGi/p8PF
         +6CYTabNy3Vujn7zCJbieEmr/Xf8jv6k3FhQCwobGhmAGWsfQ/02LOBKWvpOIEQygCu4
         e0jDHq/2WBWxMQd0BgwC+1cbnmlpfNU/syWGGdbMlNP7siycePdf6Gtb3ZAwwIUCYeHW
         RySbBdmFsc0Knvz8Z0nfr2KZb/iYZ2TqbyRa/BkbeXOtNVXjQgfeWDV977tUp8JhzcN9
         NkVyMqghFpE6YHV17NqySzhHdMIu5Eb9tALNf9glA+CaqFCy7GbghNNC1B4SI82LdBap
         Zq9A==
X-Gm-Message-State: APt69E1TAU/GcMQszMmEt2cIqKYwioip23ELP+ITaSldFTqPZqJwhxgF
        5TgZYxyaRWfpbY9XqD5VpxgN8vjb
X-Google-Smtp-Source: ADUXVKL4BVj6BEzrTymRz07ty5Yb1KXO8Sn/ELeJoumZnmOZX4FPvEP6UeOmwlWCAzrPvLmQVTiJpQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128-v6mr8989704wms.9.1528727167499;
        Mon, 11 Jun 2018 07:26:07 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id c201-v6sm15492302wmh.18.2018.06.11.07.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:26:06 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arcnet: leds: Removed leds dependecy
Date: Mon, 11 Jun 2018 16:25:54 +0200
Message-Id: <20180611142555.20427-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Only PCI driver depends from leds class.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
index 39bd16f3f86d..afc5898e7a16 100644
--- a/drivers/net/arcnet/Kconfig
+++ b/drivers/net/arcnet/Kconfig
@@ -103,7 +103,6 @@ config ARCNET_RIM_I
 
 config ARCNET_COM20020
 	tristate "ARCnet COM20020 chipset driver"
-	depends on LEDS_CLASS
 	help
 	  This is the driver for the new COM20020 chipset. It supports such
 	  things as promiscuous mode, so packet sniffing is possible, and
@@ -118,6 +117,7 @@ config ARCNET_COM20020_ISA
 
 config ARCNET_COM20020_PCI
 	tristate "Support for COM20020 on PCI"
+	depends on LEDS_CLASS
 	depends on ARCNET_COM20020 && PCI
 
 config ARCNET_COM20020_CS
-- 
2.14.4
