Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A037F2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxwLAIL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A037F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJBAXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:23:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38521 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJBAXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:23:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so5809765ede.5;
        Mon, 01 Oct 2018 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I0k8AcERI9DwRWgku9csGhynsacHIl8+KZI69btKlL8=;
        b=LxwLAIL+YWWIZT7bELLP2A4td1G/z9j41TBrPIR1r/VBXTH7Ep5GIS4VM3SzJX0ua9
         rKuFZLaXNpBb+3kxyBIFGWTqKuSY/xsDZ3JWKickAPfXbeI3f5Ir2vzTEwyfP+L+n2Sd
         R2Lig7JSpSlf9bqF7kavxaQYRxkVhfulJmFkbKrnX4YaP32eQNIcEos6olkNxJodHb1Y
         wJhHkNym0Rfafur77dfHqMFP0TbFmjlOGub5QF2jUO5YH70/AzX4RDpvvNtlknA3LF1H
         HkIiRSB3TrMZjqVmuxI3avSrII4jOtfwrCb3vS6ytYwsuPqkMyH/Ts2LmvX9ssTuttDq
         3xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0k8AcERI9DwRWgku9csGhynsacHIl8+KZI69btKlL8=;
        b=Aa4HjuMJPjIpCQ+TphHHptSiL82yKSaPzbxTMeVFRsMwefLoNZT/w+6CtRUe3qDG+F
         WbvOmfdFErh88BAAQxxeKxQ+7wGYs8MQ56a/WG4PSZMvC7ye1QrTBg0J0d4PsUNXcXGM
         uHdRrhiZs1dgu6oKa62GnberHrqqEhEKwLccGE5XkOsE3dWCeMtaE+PtzXHWKIxN9ocn
         UiSoD369ED8DE3LBQbiBa/vhJvvdkt4d02ao4nzCbXnYCrrygv7PBrl3mhmMO4VBrlaT
         PH8BG9ltFhT+7ucYeW70LqGUeMbsejSSxSlvHgD80SFCP5n8wS9DTDkU2O18DQ5tHGRp
         HW8g==
X-Gm-Message-State: ABuFfoiTKsUNbn7P6fxP95LU7nVnqebeLMeV+PqqJqMNluh0XxsKP7Fi
        Df54GtpjVY0+RP+LTUYMUiKv0F/l
X-Google-Smtp-Source: ACcGV62hUgli273mWecw4trXch7lRGUuUmTFHGLL0xeFN5nB/ePSwMOMUp2bLjD1g1/pc9cC/HF8Pg==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr20440231edp.228.1538415846394;
        Mon, 01 Oct 2018 10:44:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v1-v6sm4580089edf.3.2018.10.01.10.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:44:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kdasu.kdev@gmail.com, geert@linux-m68k.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
Subject: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date:   Mon,  1 Oct 2018 10:43:47 -0700
Message-Id: <20181001174349.26357-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
same controller, make it possible to select the STB driver and update
the Kconfig and help text a bit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- Make COMPILE_TEST last, as per Geert's recommendation

 drivers/i2c/busses/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 451d4ae50e66..56ccb1ea7da5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -432,12 +432,13 @@ config I2C_BCM_KONA
 	  If you do not need KONA I2C interface, say N.
 
 config I2C_BRCMSTB
-	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	tristate "BRCM Settop/DSL I2C controller"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
+		   COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Broadcom Settop SoCs.
+	  I2C interface on the Broadcom Settop/DSL SoCs.
 
 	  If you do not need I2C interface, say N.
 
-- 
2.17.1

