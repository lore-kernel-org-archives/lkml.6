Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CD7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B017208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uccKfe4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B017208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeH0Xwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:52:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37970 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeH0Xwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:52:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so81395pgv.5;
        Mon, 27 Aug 2018 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kp4evUltoBqieY7M4Vu6/pYXWKfkGOFsqIZplVj17zU=;
        b=uccKfe4iL/kx5+NdUsNhBxo4ZZCWf9Yejuv35h8CrAO48+Q0T+rsZbVar4x7oHYbMk
         oOAMnYHSdCF5sXmYSQuSNJwMnAc+UAy9kBRAw2VfHD1vSXkLHCTXVs+ZgCNUme0OIvq8
         MfV+OtYtXByVKrffoVBviZRh0yk+E51GquB3om8ag0AM//D8OuhkvSg7ovtIhruiPXIA
         KA5f3s07xqcSLmScth5GS4m1psYtGrDUPOyee8YfmOx8I/j+YkNwuYb6zP0JyfqgCxZ+
         X5GfyfKbMh7hsB9z9MdnbOg5OTZo8ZBx50PRq7UbQC4AKI2mmAfLGrQUaCBEFmWOayGy
         bHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kp4evUltoBqieY7M4Vu6/pYXWKfkGOFsqIZplVj17zU=;
        b=ApBwSXollykVcVfeC3JTULMSb0npD14bRK3MJJq1/AB+rP4qKQy4Pk+aJzRymYhi1w
         HSszOEyjbtrVqTyY3dhtfFlGwIHoX0YByaaUZlnQShjOkBoxK//d/my8kFv7/43Sxdsd
         pKbwmWbetvP85/KaHUjZTLOMi4Y5Ym51RHqO353oN3WNlHd8kJUTlhYdq6hHTPtndrrn
         iGv3iDN+Sf6k/ekZsSIePEon91/V0FBKt8eNEXrLNuXbKT1xl0aC6A1By37x+3tllJ54
         6Ak1T6D3xClSlLEd2xZukcEF8lxPvlCSJ9spr05yLkPhYFG8Mh5B+AfjeQtAwHUQyeIX
         ngww==
X-Gm-Message-State: APzg51AJVZ/4Urf3O+nFSe9wqe07oZk9I57P88CkXx8Uorpy0GMEmy2t
        BkUKpa4XJgFWyJ9I4cN0T/4=
X-Google-Smtp-Source: ANB0VdY4hV8E5tH1sG72KizOw6W/YRp6hFwlk/ZsRakcw8H/306ZOym92N/Cu7iYof6WRV+r64M+2w==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr15786557pfi.66.1535400278480;
        Mon, 27 Aug 2018 13:04:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o21-v6sm148611pfa.54.2018.08.27.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:04:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH 2/3] dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
Date:   Mon, 27 Aug 2018 13:03:43 -0700
Message-Id: <20180827200344.16158-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827200344.16158-1-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom roboswitch Switch Register Access Block interrupt
lines and additional register base addresses for port mux configuration
and SGMII status/configuration registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/dsa/b53.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
index 1811e1972a7a..5f1029e853b8 100644
--- a/Documentation/devicetree/bindings/net/dsa/b53.txt
+++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
@@ -46,6 +46,29 @@ Required properties:
       "brcm,bcm6328-switch"
       "brcm,bcm6368-switch" and the mandatory "brcm,bcm63xx-switch"
 
+Required properties for BCM585xx/586xx/88312 SoCs:
+
+ - reg: a total of 3 register base addresses, the first one must be the
+   Switch Register Access block base, the second is the port 5/4 mux
+   configuration register and the third one is the SGMII configuration
+   and status register base address.
+
+ - interrupts: a total of 13 interrupts must be specified, in the following
+   order: port 0-5, 7-8 link status change, then the integrated PHY interrupt,
+   then the timestamping interrupt and the sleep timer interrupts for ports
+   5,7,8.
+
+Optional properties for BCM585xx/586xx/88312 SoCs:
+
+  - reg-names: a total of 3 names matching the 3 base register address, must
+    be "srab", "mux_config" and "sgmii_config";
+
+  - interrupt-names: a total of 13 names matching the 13 interrupts specified
+    must be: "link_state_p0", "link_state_p1", "link_state_p2",
+    "link_state_p3", "link_state_p4", "link_state_p5", "link_state_p7",
+    "link_state_p8", "phy", "ts", "imp_sleep_timer_p5", "imp_sleep_timer_p7",
+    "imp_sleep_timer_p8"
+
 See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
 required and optional properties.
 
-- 
2.17.1

