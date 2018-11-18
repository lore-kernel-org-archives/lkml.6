Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7762C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD2420869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ATwXqUZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD2420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeKSHpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38750 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKSHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so2953218wmd.3;
        Sun, 18 Nov 2018 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJnvBvpz/ufNtyJ8t6A3Sh3pwE0gkfKUtjv/jFC16cs=;
        b=ATwXqUZxmE7uDmnHfPDmdQtj1SeszElA2kOnv1yLLSBffAKeVRYiXtzE7A/mk36Os0
         XiMdVi6CmL4Dn4J/bbvaF0SDIuPBxKbgoPfQtYTCYyapLwdPlOjKs8XMSbIaHlZ1oFkR
         r1Ab02FyK7WRT3qnX9Ahrp/aPTZH0049I7jCtf8/NHbsgzpLCJSLzcbyyq/MqcqgfYVD
         jjgNSU9K9xnStkLWnJHCokDXwTLysvfG2Y88xDTiNNhIipd89zFlwSfIIrgzhErfBGHS
         u7InBvN1hCrMBClHJ4TcfbnP/ZoqA3mN7I+vQVOzkOjHtKuxJ8kKAgshmzRoH6siBbd5
         U7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJnvBvpz/ufNtyJ8t6A3Sh3pwE0gkfKUtjv/jFC16cs=;
        b=eem1c/ninbAApBJJKMDXuV+J8xsj7M/OSKwd1nS7fRGRAhhY4JEvjwo1FwYLsGYq6M
         gX2+hl3HBz2ZnFuL0xEZgLrvvoeU+yBZdvaG8VpWmEks1M18PKpdvJBULuJ+nU7tUUYc
         SZ8hiaD9C+0oZp6PzyhKVsz1xc71wqxFZ3qfwoq3G891SKwrmYWxj1mLZnmlOpLjrYoF
         da8IUAwdigpj2gcasL7iphAeY0peuODLoSc9JXSaxgY24CcEDy+P81hSOypH8CnJIP/F
         woQX+Wjy0/4Ow5dOlITHL6aYJOAvzkXT0mFqclBytlpmUlXRyARZ8XYoJRv0o86pL1pB
         XIeg==
X-Gm-Message-State: AGRZ1gItbbg/jzZeQqMNKft+xCUQNtyF057yEoO5BbqYt0+tLQrTzavb
        bGzgEe/Y/q3mP31GLoC05z8A2oViqrU=
X-Google-Smtp-Source: AJdET5di2YMRoMgWU6Ab6EPSQcJDCMR6rU3Esv+OZwJvLe7tuXeLi+39zem/a4CdB3x2qJ5Vg0wAuA==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr4998975wmd.103.1542576254442;
        Sun, 18 Nov 2018 13:24:14 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/7] dt-bindings: net: phy: add bindings for the IC Plus Corp. IP101A/G PHYs
Date:   Sun, 18 Nov 2018 22:23:54 +0100
Message-Id: <20181118212359.32414-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
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

The IP101G (sold as die only, without package) may suffer from the same
issue depending on how it's integrated into a multi chip package by
another manufacturer. If only the RXER/INTR_32 pin is routed then the
users of the die-only variant may also have to explicitly configure the
mode of hte RXER/INTR_32 pin. This is the reason why no "is-ip101gr"
property was added. I have no evidence though which would confirm this
theory - so the binding itself is independent of that.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

