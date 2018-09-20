Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C30221525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3kTwf2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C30221525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeIUBCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43966 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so4014606pgn.10;
        Thu, 20 Sep 2018 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEi3hvzlw9wn5R/yYyCCSr/TBE+Jfloi1f/y0XzlJGU=;
        b=Y3kTwf2Yfqp4AEB6rPw9TB820rUpBpVwdcGoLRXQeB0LXbn3KGj4G0ay743B0XdspB
         a7wPEDfddweJ9v6sbCch+LVplAuYzwCwJg27DsXADD4M2AXyxIYRaPigcpj1Ul0ipP5j
         Lk/Y1uXLxV5Ewj39hLc/77KbqvcV9g5ikUWa6SDpm5HfTUY9fNGtYFpNHdLGjX7CMUI3
         d+nfLNl1gtzmVzHiDWwgouwBS2gbAUvEWYAwS3Mgh+GpgO7JwkeMkhQxptTCryUFYz/w
         qiZzSNmKDQlTs7VyNLP745yikiq+6Bq5ZEIOxe36wT1+kZStBu5wqZC7XfGM3SkyjY+c
         SF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEi3hvzlw9wn5R/yYyCCSr/TBE+Jfloi1f/y0XzlJGU=;
        b=dZu1d+dWOKZ6+0kqIi2MtTlyFtJWpp8yg9a9msmo0/fLZVhhSpmlezmVz4aG/+XX5o
         7V3LnyRnjOKB36op1HFvF407MMXdgZMXXFo6P4KoUb22ZiYyTzpvVmXIhmSzXtAldgPa
         qWDm6p4EBO5JVbWA2eZeBNcFWguWOPbwoVD8wVwdzZn0DzCQWdTVNkgmoWi0abuh8MA+
         va6GmHA39C2/8RoKnBAuyHXDTnxpNYNDzprwFLNcj/Ohjcs2CAVcC0oeCJXIgGo4OEVf
         d9ADWenEdhuu5qcZAUQp35yjK1RmRg8nbmSBuuTUHx4I3y6DkFseqg30N6Ww8rcTyunG
         scgg==
X-Gm-Message-State: APzg51A6b8etzqEgWIgY7j0P+xzi04UefVNbaFQjT63YYG1QlcxjLzTP
        2xhypHrzEjxoDCT9kxaiqTqPMpQc
X-Google-Smtp-Source: ANB0VdakgLgGkZu4g3KWeN44RFRl3mrgQuFdrXbFCE1BTzmEnrkcm7WAFHuUw04esurLfngp1KAyNg==
X-Received: by 2002:a63:8f08:: with SMTP id n8-v6mr1460170pgd.131.1537471043592;
        Thu, 20 Sep 2018 12:17:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 4/9] dt-bindings: ata: Document BCM63138 compatible string
Date:   Thu, 20 Sep 2018 12:16:39 -0700
Message-Id: <20180920191646.18198-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string "brcm,bcm63138-ahci" as a valid
compatible string for the standard Broadcom AHCI controller.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 0a5b3b47f217..7713a413c6a7 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -9,6 +9,7 @@ Required properties:
 			"brcm,bcm7445-ahci"
 			"brcm,bcm-nsp-ahci"
 			"brcm,sata3-ahci"
+			"brcm,bcm63138-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
-- 
2.17.1

