Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22340C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25BD217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWe9AOIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfAWAdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:33:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46644 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:33:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so194490ply.13;
        Tue, 22 Jan 2019 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqOzV70nxn1aW4YfYzttzB6N0VuBYDY1Aq/89e4xjMU=;
        b=AWe9AOIkv9l1RZqN62H7Kq/OQ3+m3b+nwSJGFdCtsD2hWxr2SH/qrS+AkJz4Q5X48j
         kVIpYm4ClBd0baxCP+wOw9GvQEdi1HK+iKa8vVoUHj9xY0c7p8w8xmDL0FO6QCdmfwjO
         Xo3D6m/1OWdZ/fEU1BWBzPdW2i0iM0b8wh1uwFSLmMgPZc9p2+ksaYTKDgJaB3iqZyf5
         WTPgNC7ihnCSo5gW0O57jCsOMEuxfJyLg/s4kUgT0S0Hey9d2w2vUeKrRLkGBOLA2bnu
         zya8z2Pg9ckp9IVknWH3+da40NVWIjNB1kDhh3QlUuVLlz4pcVjuYLZItkusWxnn0ZHO
         lGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqOzV70nxn1aW4YfYzttzB6N0VuBYDY1Aq/89e4xjMU=;
        b=T7XEtLFCqN/wQgYY3MUqPGfT1jKv+hwfKo/FK4X0SdsSl7k9nNtsTVus5KPcHrcCYd
         pPYTAEXwkewJxifOExEgF+btcuSEgfUWat7UzkgV/p5KTUQ8llg6b2KVMuNd2OoRWu9o
         Wt/Pq424DIhZixpvdpV9Jh3u1ZXeSxaTBQVUAy4zmsM9NzyCD9kc/KqWOU9GWBfnCQRg
         7GfL5ZLeX/tvNBSLNy/nOszCXcjGxtPR7SxzJRKJSd2ccfqZcbFDRULI3henkYcoqm93
         059BKibWMIKXZlAm3A7vIY8ADbQSFSqLlUe4U96Jrh6y1BQO0eXgG+riF3bowAep+O82
         pP1g==
X-Gm-Message-State: AJcUukd3wNTeNasr3z+hdpFpJGryBq+/Jq6V2r2q92BEm3At+mp+kp0z
        PkE/srL9Z4BfwMuUwJCUc8VfrOYd
X-Google-Smtp-Source: ALg8bN6l8JdqmLtMFRJekrpeUWsbzJiGZHxNvPvvu5yMskwWQ2j3uRemVufdSEJs3e7/B3mrCwryCw==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr92596plq.117.1548203630540;
        Tue, 22 Jan 2019 16:33:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:33:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), rdunlap@infradead.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        paul.gortmaker@windriver.com
Subject: [PATCH reset-next 1/2] reset: brcmstb: Make it tristate
Date:   Tue, 22 Jan 2019 16:33:44 -0800
Message-Id: <20190123003345.13750-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123003345.13750-1-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be built as a module just fine, so let's make it
selectable as such.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1ca03c57e049..d9a02b7f90cf 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -41,7 +41,8 @@ config RESET_BERLIN
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
 config RESET_BRCMSTB
-	bool "Broadcom STB reset controller" if COMPILE_TEST
+	tristate "Broadcom STB reset controller"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
 	default ARCH_BRCMSTB
 	help
 	  This enables the reset controller driver for Broadcom STB SoCs using
-- 
2.17.1

