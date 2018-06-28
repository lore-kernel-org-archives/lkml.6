Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D939B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="avxoCEE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D939B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966786AbeF1Odi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35910 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966751AbeF1Odd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id u18-v6so9346038wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=avxoCEE4QJ/1RiiO71By+2CyB3Mkle0FZa4lUddlodouvRIrICFb2EMU2RDQnSv5GP
         dL9SWq7WzTZBDsHwqpxxD06sNk4nFI8zLbom+l97Im5vbgGUeBaP3n0U8oF8cJ4qwQDo
         7lD8hEL5badTFuOeURDvRC8Umt8n/hwSr+Qe4L4uO1E/2mlz/aGtFRR6vK5p2XA2MW67
         ynkv9T3hxwFcYntO2r6J9lLaslAEgYp038rq4mFr7UV6Na6ArIYbfsy6kDVp0pV/bmNG
         ZnH962fw7LVZs1sTm2npL9zKwEOPeEX0iGJn/9SyOhkg0XFJ8MfVFQSUxPEID2t05jGR
         RbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5DqzgH5fpoGJX2DCfyjILWRGPoFwgDmrRb4Q1YR2bg=;
        b=mujVG9moHVP+wr5g6u6vb09cwJB5AsJjWaJXJvyQG/vJ/ApqjucwKh6XT5GdaGL8Uv
         yZkPgyQdvZ8ev5op7wfwlyIWmcJWRqxPAUYveqUi/s/iadBG+FEcYk1nF1nzBgvzHFYp
         dFiXPR80dC1h81C2lQ1DTNyuY836ddoQeCMKsA9p1eVjCcaFjnxiGjmzsl/Nc4WEx0sA
         Ba+YBevRgWtsvWGbiAXwsYcJgAy9GEfZIzhdRMXiGTCVCTYKBV9s+uz6Y5ZqTuUlZegk
         0rxWIJkID37YmxcmscGT9VyuTmZjjosTw5Mw9RLmXwifpde7mg3GVnyTeDF7qdLNTaWH
         oRAw==
X-Gm-Message-State: APt69E1w6rMa+kJwb7YD24RLYSt5S7A70AAg55sE7ZdeIzRiJzbegIga
        Mb9Fn3KqmmIcBh53Mmdl0sEnjg==
X-Google-Smtp-Source: AAOMgpfQmNHKoYe8AnwffT/isojpj6bGzeqK19Zy+LdthNqxjEprTQ5NJKML95B0xOFzr9MpEUYydQ==
X-Received: by 2002:a1c:2442:: with SMTP id k63-v6mr6223242wmk.7.1530196412122;
        Thu, 28 Jun 2018 07:33:32 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:31 -0700 (PDT)
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
Subject: [PATCH v3 18/18] ARM: davinci: remove dead code related to MAC address reading
Date:   Thu, 28 Jun 2018 16:32:44 +0200
Message-Id: <20180628143244.4561-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it. Also
remove the mac_addr field from the emac platform data struct.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7ba84e9..0c6cc354a4aa 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -28,21 +28,6 @@ EXPORT_SYMBOL(davinci_soc_info);
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
index 05b97144d342..19888b27706d 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -19,7 +19,6 @@ struct mdio_platform_data {
 };
 
 struct emac_platform_data {
-	char mac_addr[ETH_ALEN];
 	u32 ctrl_reg_offset;
 	u32 ctrl_mod_reg_offset;
 	u32 ctrl_ram_offset;
@@ -46,5 +45,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.17.1

