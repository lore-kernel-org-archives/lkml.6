Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB5D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUo/q3lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB5D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeH3XFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeH3XFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so9031559wrc.0;
        Thu, 30 Aug 2018 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nCUvOR+CglPRSFcIRVKkyPtD7xDCE0J9tFyuoHtZ2Wc=;
        b=jUo/q3lBYvtwb49VFJf1fEWD56fDG6pi1fggtWxF1H58WqXQiec8vqxqK6EwpY2JRM
         naXFPqVAn+bu9OzpsJLzZxGYVHEI0JTtI1I+eSD7stUSFTlEhkhvVEddbKmDZ3IMFuf9
         Ig/IxeWOmJWnHyXhv6jZdhqEmp+xb25kaGn+PqOLu5U8rvURudZDclAQ1SUQjGy069D0
         Y0F9p14WxKq5qKwtV8dNDbfo8hZv5sK5qQ9rGQYlUVq7cYoxoxzp8AKmQ2SWslMzA31M
         hZojWGvS01Kvum0aAVVLoabiFzbqNqbbudJf28IRqqG2AW4ReUQ6KKcOza+YRKhxM8la
         8lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nCUvOR+CglPRSFcIRVKkyPtD7xDCE0J9tFyuoHtZ2Wc=;
        b=BsMWyBMV40fEqkuhuUaOWTCsYiQqiCxaOk3hQs4vnG0hgYtIXU19wLEsKWKkOyGvBy
         1P3PUyjk+gT7+tzXZU0Sv5ENRyByGtgLfo5NsDNt3FQT9/zJOQ60VAQ22ENzynLgCSo/
         s14IDx1i910VTNppdkrbSAuHfO+ZdTiySQFwwqFGqyxU4kJkTSwjALBfmIbughSAOqaM
         1sgEJNPeunsNFRSS23nefvdiFPkIY8cBt84sqvBfHdS4KNfyyhGTGZvE4QBN038/mcl4
         O675yH821mcpA8QcJyeYfUwyE/oLCjqBrPZFCDkZ6oKap6UOLULVTKf9GfRFfdcGsCBO
         unxQ==
X-Gm-Message-State: APzg51CdtCONEX5T06cWJiQlhTD6+Jz5Q7a1TSgoyHr4cMzeOe4u63Aa
        aNkzawbGFOEWnnL1LaQEDJQ=
X-Google-Smtp-Source: ANB0VdZVFBQIDF4PNrNuD2s4+/LohiAX78RgmjttsDQ8W0DLQUYufhjzOI2rIWuKQbgjhe5fJCUoHg==
X-Received: by 2002:a5d:488c:: with SMTP id g12-v6mr8636307wrq.0.1535655698019;
        Thu, 30 Aug 2018 12:01:38 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:37 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 06/13] dt-bindings: ata: update ahci_sunxi bindings
Date:   Thu, 30 Aug 2018 21:01:13 +0200
Message-Id: <20180830190120.722-7-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since phy code is moved from ahci_sunxi to a dedicated driver, the
binding need to be updated with the new phy node requirement.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index f495774c8af9..aa6f4c745097 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -50,6 +50,14 @@ And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
 - target-supply     : regulator for SATA target power
 
+Required properties for:
+* allwinner,sun4i-a10-ahci
+* allwinner,sun8i-r40-ahci
+A port sub-node must be present and linked to a sata_phy.
+
+Required properties for allwinner,sun8i-r40-ahci
+The reset and ahci-supply properties must be present.
+
 Examples:
         sata@ffe08000 {
 		compatible = "snps,spear-ahci";
-- 
2.16.4

