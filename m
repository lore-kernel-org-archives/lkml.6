Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79929ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3220B208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ErP289wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3220B208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGMLRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40039 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbeGMLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so24699725wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4TpKBaS2ugdYpSDNlm0h8GAUBpeuptdpOY+hPQ9gHg=;
        b=ErP289wmUH5WtBnDnezB7i0g7cCcS1k0KerUsFhhsgd4FZ3SfQhnp6L1FTLaFgN/Qk
         Pr4tRH27MQwJelESICOdsGvTc45rGndwUHj+kltfRMpyfErktOC8mga27GdTqT/1F4lB
         zwjIh1BZoFRzaDoezS5OqtfAmzHuLDaFESV5ydVQP44SZnlCexQWjR0aG9+uRkMJde3t
         OTVNCcyKLZU/+qbuag4pxn3Jj8hHXYkVflRg3vDZG2/pmyV4uCmsOQKO+MXSCHV8Mx++
         XLoUcEVYXq3A8nEhsVqysTSM0kEQqCjQaGFbB1BJo6S3SAKcG1LmnnM1ClIi30Zp4LVc
         OpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4TpKBaS2ugdYpSDNlm0h8GAUBpeuptdpOY+hPQ9gHg=;
        b=qdyIPFc6er2QpDnHMprt8zJmZRuYgNsz49dL0MF8uaYWcaIaTTYPc2Ltd+z51nDrs3
         PLMUmL6+aXp8WyvKxAC0XCUajGKejxaHoLJJQ9Eqf3s4yD1ufX6Xhc6Ws07Ldj0TW7rE
         kQAYwE1HuSsZTlu6BKypiw6vZ5L3L8lEvfDvl/28uiQmqOSxqH4SKazge9GxtifSKDMo
         9Pbxc+tMRQ4Pxm2yrs1RjrsbyprzD1+6Nw2PDQFwMcC6Ijs95N59U4Tk2YofPl6Id2r2
         rI1Q280zyX3xSMusSJ8POLmm5cCkLdxfnTM42A4WZ+ydlzeN9myFvjN9jRdGYV4msz8g
         LdwQ==
X-Gm-Message-State: AOUpUlHoA6ptjoEiJt0gncmidvJLJR8obWRRYsFubRdKddZbJv2ty0Jy
        NlDQ/J25oKKgmHWngaLJXmiFNw==
X-Google-Smtp-Source: AAOMgpc0jHdaC2RAD5ieWdvMg3FVswuvKliIBnRI+Soe7gcDfcXk0tx6EYc5y/A8yDaA6Mo2B3T8xQ==
X-Received: by 2002:adf:f74d:: with SMTP id z13-v6mr4839691wrp.85.1531479800852;
        Fri, 13 Jul 2018 04:03:20 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 7/9] dt-bindings: ata: ahci-platform: document port-supply
Date:   Fri, 13 Jul 2018 11:03:04 +0000
Message-Id: <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional port-supply

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 47652521a6ed..40a636b9851e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -31,6 +31,7 @@ Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- port-supply       : regulator for SATA port
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
 - ahci-supply       : regulator for AHCI controller
@@ -51,6 +52,7 @@ Sub-nodes required properties:
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
 - target-supply     : regulator for SATA target power
+- port-supply       : regulator for SATA port
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4

