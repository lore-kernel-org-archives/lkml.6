Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A592089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vL1UmvsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfAHJQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35938 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfAHJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so3468083edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
        b=vL1UmvsIz4oOviOGu+y+fZ41BRFcWkeVgw9i9KziXEqHwOil6iPVYRonWegCiwd+DN
         ggp5Yl4L2DeT0q/ObFz5IXAfU8oaOaUcUouHk7h8AKxnZwimoYHKMDf2tgDMvqiKgeua
         eszgwAtSq7jr148OK9Aq39mMTNgIzfzrnNWXaag5g93ov+7s9SQCtIClM+SL4X9Mgast
         KrLIH7CEnEbrPE+ZFfRXiu6I6C/FjCMRclkUdoNLyDs4XKIgwo9l7WqUjN7DpKBHV+I0
         N4CMvD1OxojhZG1GzkfQn+ofpUZF5bkMK7Ae8yBMjXkjF9hBikyiKtVnzeELun3TPDkZ
         nzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
        b=U4KVEMspEmSAkJ+MDbXcZ/l1SDsbT2EbbpRev3fc/jZciMTLOy0hvUbVyjOh/ddcIP
         DiYt1/7689O4YZ7wvKzurozYIAGpTgKdjTNXnotiy96T7+RAmJKbzjk885aXXS6014hp
         Zpu+8KCpR2UCCV6/xD4YtHaLdxpwz7JzjpX2eVhRV91R2qtiiM1FfLQmef0nhff1MEvd
         vyr3mhza/ZhIylC7zpIMQ/Am5x1k9DyQI459hL97RhuAVrQ+GphqukyutORz8yQTQSv0
         5AEoQVRjdrmvaWoegndO++V5uDnpWmfm1fly6+8TQBX6Pv6Gplhg6oeKiMnq6cDrVgS7
         iXWA==
X-Gm-Message-State: AJcUukdSFh25yQAwex5Jnvv7twBv4iL0gGcrm17gnGpGvUk3I591EObz
        XRrQZya0uNV/dSVR5QsgBKOG6A==
X-Google-Smtp-Source: ALg8bN7pp63gp0stxuU86/Ef5iHXUkzmZWnGk4PKZKPUyEmf6QzJY8UES63OULT/yDjVEWpIiz4QKA==
X-Received: by 2002:a17:906:32c6:: with SMTP id k6-v6mr1199646ejk.48.1546938960756;
        Tue, 08 Jan 2019 01:16:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:16:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 09/12] ARM: davinci: remove dead code related to MAC address reading
Date:   Tue,  8 Jan 2019 10:15:36 +0100
Message-Id: <20190108091539.16674-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  1 -
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e1d0f0d841ff..0c638fe15dcb 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -26,21 +26,6 @@ EXPORT_SYMBOL(davinci_soc_info);
 void __iomem *davinci_intc_base;
 int davinci_intc_type;
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	off_t offset = (off_t)context;
-
-	if (!IS_BUILTIN(CONFIG_NVMEM)) {
-		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
-		return;
-	}
-
-	/* Read MAC addr from EEPROM */
-	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
-		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-}
-
 static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 {
 	int			i;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 05b97144d342..28e6cf1356da 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -46,5 +46,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.19.1

