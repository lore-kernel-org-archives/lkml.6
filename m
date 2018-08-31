Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E720842
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgIXHfLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5E720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHaX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38814 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id x7-v6so15768119qtk.5;
        Fri, 31 Aug 2018 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Qii3n+jUAsVW01OvBpIFXuRjq40zduqyJYtvGeJEEs=;
        b=fgIXHfLUrytqNWq6sV75KcLHLDHBTy8UdGjeXGW9jy/NsITsQO5YjbAOfy+mdiMidD
         fbLnf8IQ+TxaCCClXEUQLcLhVq+QolvnqKM2DAlOsKqSojd6b0CH3yzdXb2e0CuSdgH0
         0NDAenqkHXA33NABd6Oppwn++LBZesRQi3d/O8YnZhBSCw130UCY8dN3qANSjzoB0VKN
         jaOB//vdmMcKhijqXvtd4ILxfjd/6GIfRZjvT7Grbe4V6G0dp5bW//DH8MY+7gXYBfxk
         cD7/5qLQ83LtkRw/oGFCHg0X7PFooes4ckh2LQ8QaXnNEDCHJJOpR9jjp6bMxa+Gzlgj
         x0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Qii3n+jUAsVW01OvBpIFXuRjq40zduqyJYtvGeJEEs=;
        b=eaAQ4kbrpARSp0RvzhhApQH106s37fgcGg1pTjBajHldzr8LWSJO62FqGfxWuEvE2v
         xOMvwq8RhxBdbIacwaIvOXyFIPhW2pnXSfV7neGueyOxLFwu2h3Dla909DhT25ErXEZt
         DDq8g9dj+mFx7fj8/BOHDv6JqqIVeZEF4/ZVIXoSQ6+Ok/3vApiXOLh3t/MirOPe5xQv
         ea12vQVu+42tjZmWIHtBkwMqu6jdtc5vmPCKw0u4PqYB4qZ7VWmthCJSAfIwDqU3u11V
         f+DWmcQ2RsHVF8LmevYROnXNUn8jbFqGNGIzRLVzZidCeMEUQ4dv3q/R1GVTgO3WT2S8
         NZcA==
X-Gm-Message-State: APzg51DCryYubp1i71h82RCtaYIXYgo6Wo7BBw2QAI4hwNugIlyfPhHZ
        pK8j56+uvpx44QWj0Q5maHU=
X-Google-Smtp-Source: ANB0VdZuqzo3JJVrMHfD5jxxN09gP/ABfkmLV1lh+ZpZveMl5sED5eUz56aoeKwnk+PFeGjCqj95KA==
X-Received: by 2002:a0c:b5d8:: with SMTP id o24-v6mr17074360qvf.189.1535743254301;
        Fri, 31 Aug 2018 12:20:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f53-v6sm6949160qtk.40.2018.08.31.12.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:20:53 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
Date:   Fri, 31 Aug 2018 12:20:38 -0700
Message-Id: <20180831192039.11842-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831192039.11842-1-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom roboswitch Switch Register Access Block interrupt
lines and additional register base addresses for port mux configuration
and SGMII status/configuration registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/dsa/b53.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
index 1811e1972a7a..5201bc15fdd6 100644
--- a/Documentation/devicetree/bindings/net/dsa/b53.txt
+++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
@@ -46,6 +46,42 @@ Required properties:
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
+    be in the following order:
+	"srab"
+	"mux_config"
+	"sgmii_config"
+
+  - interrupt-names: a total of 13 names matching the 13 interrupts specified
+    must be in the following order:
+	"link_state_p0"
+	"link_state_p1"
+	"link_state_p2"
+	"link_state_p3"
+	"link_state_p4"
+	"link_state_p5"
+	"link_state_p7"
+	"link_state_p8"
+	"phy"
+	"ts"
+	"imp_sleep_timer_p5"
+	"imp_sleep_timer_p7"
+	"imp_sleep_timer_p8"
+
 See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
 required and optional properties.
 
-- 
2.17.1

