Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B9927528
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iHcZoemN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9927528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966849AbeF1OfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:35:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41646 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966738AbeF1Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so5752534wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=iHcZoemNxABaDdrirMzA9SJEhvs4fvs/wwXwtXQqLGl0mJE3SIgiQu7NJbmdLum2lE
         qBVWVY6j2X3DCOvw6K/aByD/S7vKFFzU9wDDl/tfnP/d9dqgkL91k3HXwYe/IUoyYCSD
         Bk/EzgKlY/26pfWT9bBog3UYAT50/MjGMl9+EFoNraNcsjJ/hEtQlpgnLjwX9MLvVbHC
         rpFG2Jr2KQk+3TJI6uWJD1A1W+jidvemt9XCiHqAV+Ya5xcZE1CRZ4IwITTRBbwkx0I0
         +U/rxVAJyQ/pLQbzMEyR4vJWDsjCEaIMxVN2WmMA432Zg0GXeFMAEgnNCcbZu3FrEtDM
         XOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=qjfZfbuKbbB6yojn8JmHMrsdqSuB1c5ZxAD3RHDgtmJU8QYEoBy9tWSAMSqcf7g6KK
         Qdgp7TSpNnbSsLbfXlr6qj0LhBIlKbe6otWhOU7y2LPztsoELvbJMcZgXgwt+EwR1fr/
         CkNV4k1eaP/vd3kop07+gZ0hrgZsLqCy6nmD/4jQRegQV0ZZz0TCn1/6kIMD+4oAJxOd
         zQCombJLhLXqD3A00ygNduOoVBFOzn0D+e1UMMGbD5ACBA13norVE4iGwT+lAydOaOOD
         W0Agh//8+Dgj3kYogJ6DpzSSP6seVtseJeHQUeMBs6dTBho6OygOjV97j3e96HkJR/Pj
         Gx3w==
X-Gm-Message-State: APt69E2xeOLblKwGeQcfawR8vLp141mERFmhn/vc2rBWh+g74zzX+oUJ
        9NLgMBzCwt0U9dba5P1Yleq18A==
X-Google-Smtp-Source: AAOMgpfpIzl1Vl7bfRpMaeN0P9q0pBIqIMbDTM+PnQV06R64PjvSIReyaZJcX9DYvuC9MGElikCNaA==
X-Received: by 2002:adf:ef85:: with SMTP id d5-v6mr9446969wro.195.1530196409580;
        Thu, 28 Jun 2018 07:33:29 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:28 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 16/18] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Thu, 28 Jun 2018 16:32:42 +0200
Message-Id: <20180628143244.4561-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The currently used 24lc64 i2c device name doesn't match against any
of the devices supported by the at24 driver. Change it to the closest
compatible chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-sffsdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index e7c1728b0833..f6a4d094cbc3 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -100,7 +100,7 @@ static struct at24_platform_data eeprom_info = {
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
-		I2C_BOARD_INFO("24lc64", 0x50),
+		I2C_BOARD_INFO("24c64", 0x50),
 		.platform_data	= &eeprom_info,
 	},
 	/* Other I2C devices:
-- 
2.17.1

