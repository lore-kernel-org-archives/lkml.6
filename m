Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CF7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F8214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS8NPJxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232F8214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJQMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:01:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41801 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJQMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:01:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so12511932pfi.8;
        Tue, 16 Oct 2018 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cUOhpGDTDUwI4Gwca0nawc0skJzNCmnwFtM5hGQtloE=;
        b=WS8NPJxTebPyjnetlGOi1Pn1aFUKlimrehTV7H2Hv5u6f+hc+lmbMY2VBMjX8rz1up
         qJAYPlGalnqpndS47uJx4/7ex8hNJw294SrHGEYFGmlAw9RgR1fyWrM4k8cYb3NRwUds
         ICNRf3X7h67XHI1QoQS/np2txcmrYj9yPvGTcdXcKC30ow8ttIweQslWx0GvDFFAW1EQ
         oG2s450YM1j6tKmIxRbu3INbIfivaqvFidYm3p+jAf1D4LLsp0dVjaB/e7y8JXs7wSEd
         SXjQ+MAxWs5BbEIN+C8RPKsPgAnwbXE8FTVbsm3pVnic9AcnjDdEIqVl9NVnR9sHFkPS
         +yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cUOhpGDTDUwI4Gwca0nawc0skJzNCmnwFtM5hGQtloE=;
        b=OTWSj8CVC2wjoxYFUw0CbsufjXk6ZXi0sCXf7B1Ak257NyjP9SXM1ljyBQRTEwwK0r
         zuC7mcAXoINk6241iyoUH+v6OatwIX8sLzXtrdU/XpQQGGD2TOaP1QvdrsYuVICbNQrN
         aRJPWnJnDZjgUV5825KnS9o1Iamax7FCtiQ0iqBnCGoh7dupm835IhAicmClkjz2DThA
         z4Dm/oo26oYKHdZq2umjzI7Y09j02otAHuFnentUrA0elfagdfobWtBDq5i7ox9lqg31
         7wZkuXA4wV6fqmcRe/94u4ZfQ9787IsQtPvD7eFtvTt7InqzqQk1jXVLktnr9smLtXs0
         1kWw==
X-Gm-Message-State: ABuFfoi3Dr1Y3EKtMMQynH9v/VGqs4DLKJrpgzSfSpmSdfP3rimqL9AE
        mX6Dl393xPICnGQ/BpPod0A=
X-Google-Smtp-Source: ACcGV62G/TMutAEg7nYzhq+HMdghHmhE0N6Rq4zARQFnpCKsmitkuXq6WryefMnbcOqx9FhaynUUMg==
X-Received: by 2002:a62:2683:: with SMTP id m125-v6mr929266pfm.74.1539749285467;
        Tue, 16 Oct 2018 21:08:05 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm20998554pgj.55.2018.10.16.21.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 21:08:04 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: [[PATCH] 2/9] Defconfig-changes-for-DMA-UART-of-AST2500
Date:   Wed, 17 Oct 2018 09:40:59 +0530
Message-Id: <1539749466-3912-3-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 arch/arm/configs/aspeed_g5_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index b7f8fa1..25813b5 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -132,8 +132,8 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=6
-CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
@@ -211,6 +211,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_RV8803=y
+CONFIG_DMADEVICES=y
+CONFIG_AST_UART_SDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
-- 
1.9.1

