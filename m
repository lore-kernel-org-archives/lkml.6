Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D66C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFECF20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2/ZIJCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFECF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeICOVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52354 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeICOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so536542wmc.2;
        Mon, 03 Sep 2018 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sz99Ed4cFqHyXgEVj3BM7faY7Awz0qAK84Sc1hbiz1k=;
        b=S2/ZIJCiEXJjhxXnVeHi+pLSw3LwTTWpDMaaNjklWtYTVm10+efVbe3sykAGxVbuQP
         gAaQ48ck4Rrqr1UW7OKRa967JWbD49cFo68ykrQqdtfsmRzV7tZJocaoENvFH9Ab+wGJ
         chuI3cCXIDznKsrmTZL0jKArWuOFHM8/euRo7yXtDF6lVM/J2YEjprSNIwSuporMrpnV
         765qGuaQX6PKlRgRD8Ns07+z1z3UamALBztNeJbmY7Cn9IWlr3mK/9iq3TOobGpwqamj
         C6IQwa1Gt2h0nFKW6rGW/k7aw7qJarrJgTZqOrd6QMxWW9thgY7lPRgQDlQjfmQCYR61
         s2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sz99Ed4cFqHyXgEVj3BM7faY7Awz0qAK84Sc1hbiz1k=;
        b=hY5859sVTZ8tdNk60m25D0gi4Mx9eMtef0viaNENNQHUU38ndH0/Habpz5C0AH0gaZ
         yFBSKbPruThJruZMgQxiIPrxPinXNW9vrRrBiCHEE7uxdjrVPtyBRpzba/8Td0nmY4ld
         aJh8YFgPVzJegABNjpaDT/HqITX6BfGJWt6M/zu9nPQQWZF8oyfglyb+I3758J6NDxmo
         koo/vlJrJlxUaG2RCUiKADArgoDjlKTb/YFZbDTOVckqHQpd/cDCQRxyUseAFn0kbJMZ
         8JQeVctZQz3yOvbmjOGpW8plPuvZdqjSL4v1z8LMLnllehtoCKsBcX6VFhv4gl8WGVLr
         xIgQ==
X-Gm-Message-State: APzg51Dl9yK9PAufZk9TebUCxMjVRzB2fRGRxcQhsfI6iJ3pXWN2diXT
        xnkRxPA60QcyzkXBb24J09k=
X-Google-Smtp-Source: ANB0VdbnQ4DGqks37mn1q9DRTmofyTEpSofTDMg1HggzCg2Xp6sbNUIYPT285kUa1RnATH0fOvj9aw==
X-Received: by 2002:a1c:1805:: with SMTP id 5-v6mr4397863wmy.25.1535968935782;
        Mon, 03 Sep 2018 03:02:15 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:15 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 7/9] dt-bindings: ata: update ahci_sunxi bindings
Date:   Mon,  3 Sep 2018 12:01:59 +0200
Message-Id: <20180903100201.23131-8-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch update binding with the new R40 compatible.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 45b451961612..e30fd106df4f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,7 @@ PHYs.
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
+  - "allwinner,sun8i-r40-ahci"
   - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
@@ -44,6 +45,7 @@ Required properties when using sub-nodes:
 - #address-cells    : number of cells to encode an address
 - #size-cells       : number of cells representing the size of an address
 
+For allwinner,sun8i-r40-ahci, the reset propertie must be present.
 
 Sub-nodes required properties:
 - reg		    : the port number
-- 
2.16.4

