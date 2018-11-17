Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65CC04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E1520815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z4WYq5UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E1520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKREhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:37:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so1121892wmd.3;
        Sat, 17 Nov 2018 10:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUfrNq8LnI3h9vSQVIMRntpzREcOJn1MkvWLXibLYQg=;
        b=Z4WYq5UCtz/35i+mvRgtl1UPG5lzvWc7bWMTiL1Qtcha9xo8IPPe6IkMMo0jOAGznz
         uCE0eBrSHFlFLCXRl4GzXsbeo85OS/VXjTn8m811O8MJRHAgTmWIkMHesTGPkfTJTbx+
         ZvUYeNdWu/VdgmkZzYza6U3rhZrOwftH9Fp9IxTsjqv/oD9FuB7yNZgw/MovKGfRGw7D
         nO3nB1n9Uq4dTJZNQ8iSxSYhDH7K8aXt2l2eILVqCF8w7reYA6kUVi1XuIXHVGxaG+4t
         x2xT6aL3MSYWQ1UplmDtsMYtBc2s77vexYCjZWUVwfd3QwdQ7b2KXsD3+ZYZYWkLG+UK
         SXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUfrNq8LnI3h9vSQVIMRntpzREcOJn1MkvWLXibLYQg=;
        b=SodDnPBuyXl8zUwTmRzZoQi7IboJfLiNIqTGkYIwpMlsykZA1zXeQwFWdTtYI3bQqT
         aYfUC3ye0gm6KcCtig6gmrBiNf9O8nohPtR51t10DnZKeO9mJiLzzM0faMSETeGsuCIm
         m0LKpbNmqR0gGwcSab6epi2px7nNF1k7JUVHeGSbyXRfHKCeA3ItkUP6QF+6a77NCuNb
         j4RWVVJvDfKtJkWy035SbjXl3epgoAYwRmFNA6hYcBZ9u3y55YgyV+jukIC92Mm3gzOn
         0LJDHgAcpZySwyDIB6zXmhU6deNdCKkSSLgQzBLGnkrioDAk3IDu12uFcFOQaxX9281o
         Xfmw==
X-Gm-Message-State: AGRZ1gJ/7y6GM1VwSieIhhDzXceA07f1hpFpAwAYPK94CRK4tdHbNUb3
        7d4lMWlpt/C5pyk2CT6FdOyUXw7hjpI=
X-Google-Smtp-Source: AJdET5e2n18tYtVlSpMKvcsInVpgMEUNifUnd532EI/3DhUByFp0tOLRljm/4zbFcrIfyfx8E+15gA==
X-Received: by 2002:a1c:a6cd:: with SMTP id p196mr2237332wme.142.1542478822150;
        Sat, 17 Nov 2018 10:20:22 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:21 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/7] dt-bindings: net: phy: add bindings for the IC Plus Corp. IP101A/G PHYs
Date:   Sat, 17 Nov 2018 19:20:02 +0100
Message-Id: <20181117182007.14791-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP101A and IP101G series both have various models. Depending on the
board implementation we need a special property for the IP101GR (32-pin
LQFP package) PHY:
pin 21 ("RXER/INTR_32") outputs the "receive error" signal by default
(LOW means "normal operation", HIGH means that there's either a decoding
error of the received signal or that the PHY is receiving LPI). This pin
can also be switched to INTR32 mode, where the interrupt signal is
routed to this pin. The other PHYs don't need this special handling
because they have more pins available so the interrupt function gets a
dedicated pin.

This adds two properties to either select the "receive error" or
"interrupt" function of pin 21. Not specifying any function means that
the default set by the bootloader is used. This is required because the
IP101GR cannot be differentiated between other IP101 PHYs as the PHY
identification registers on all of these is 0x02430c54.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/net/icplus-ip101ag.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/icplus-ip101ag.txt

diff --git a/Documentation/devicetree/bindings/net/icplus-ip101ag.txt b/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
new file mode 100644
index 000000000000..a784592bbb15
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
@@ -0,0 +1,19 @@
+IC Plus Corp. IP101A / IP101G Ethernet PHYs
+
+There are different models of the IP101G Ethernet PHY:
+- IP101GR (32-pin QFN package)
+- IP101G (die only, no package)
+- IP101GA (48-pin LQFP package)
+
+There are different models of the IP101A Ethernet PHY (which is the
+predecessor of the IP101G):
+- IP101A (48-pin LQFP package)
+- IP101AH (48-pin LQFP package)
+
+Optional properties for the IP101GR (32-pin QFN package):
+
+- icplus,select-rx-error:
+  pin 21 ("RXER/INTR_32") will output the receive error status.
+  interrupts are not routed outside the PHY in this mode.
+- icplus,select-interrupt:
+  pin 21 ("RXER/INTR_32") will output the interrupt signal.
-- 
2.19.1

