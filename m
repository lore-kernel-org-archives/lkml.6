Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E54C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3366021906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef58j82E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfBAR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:29:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38198 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:29:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so6477829lja.5;
        Fri, 01 Feb 2019 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxLhzGYwH6iCkIpFvsbVMsVL7rqrkLHnqOAjKH+gy/g=;
        b=ef58j82EI5EKx0a3ZVDxC8zZfwtbPoyPUZxb1iaZT+0wF2+IEQpZqXxVvvwPfcH3gG
         NiZL8r5wj0/U9ylgVkWwCd3yeOSOvDzsUtRQZyW4y4JiWROw7BNzaUYotKzxJa0plD6p
         abTfSFsJnzRjuo3ftsG1Pjg631fg0mQsSybRr0GsI8yuPlmeDkIzUF4RrTNbonFy/80o
         onKt/nEFFxDU88LHw0ZHTPdzMT/ftkhvYX+MZVJ9RSUx3gcZOHgV7B7JZNVDDS9pMwTc
         jCNbj2p0YHesgOx/z3oKATCh4N8Alaa0VP0fTZAuarbiDQ7sfhSwUPofR6JaFTBpEXXz
         SWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxLhzGYwH6iCkIpFvsbVMsVL7rqrkLHnqOAjKH+gy/g=;
        b=j3lJ6iUDwiyizd80/QBXdltKw7Z78I6JOVDx70EIIrcaw2zrWI4ehr4HijKqmf8ATj
         rfS0Y2shNAxO7MF6oKiE01iolzRRp0OdnK5gju2eCMgnJ98NpPrtK4poPWoRjGIBShvS
         AhdwdlSl9IfP/xmsPIKriQMcY3lX0GA5QeYb4lYKPvVFlu16PS4UV9yKdHoHLeChYPhY
         Y9qAY3ISTjZz4EpNiJk09Y5u1Dfsk/R7Qbftfn8JWrx9CT4w/JfUyG38nwz6LlsYedkS
         BxobdogmPUq3B0evYh/P+olHbCGtz6cbakE5jZSNQZi7QLXAYrXMUVPZm/ySgatm+Gcp
         8H5g==
X-Gm-Message-State: AJcUukdfD7TbhewH/V5LIvPLvDQRUX3mruiAKk19urwDYkP0jJthp60U
        ulUfAqoiTBD47UuA9IIUqoCWB8UHqJw=
X-Google-Smtp-Source: AHgI3IaOENda8+/Kg4OybHkKQPXjlK1ABygIIBgN32PRI14s+7pRljLk55Sr/8U8R1ngbNMSrSI6UQ==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr25411768ljg.64.1549042139569;
        Fri, 01 Feb 2019 09:28:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:b0fa:39a8:9559:1b76])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm1388796lju.46.2019.02.01.09.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:28:58 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: drm: panel: Add Samsung s6e63m0 panel documentation
Date:   Fri,  1 Feb 2019 18:28:51 +0100
Message-Id: <20190201172852.4944-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
driver.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Add missing subject prefix
  - Rename reset-gpio to reset-gpios
  - Add link to spi properites documentation. They're required
    for driver to work
  - Removed delay properties, which are now hardcoded in driver
  - Removed display timings, which are now hardcoded in driver
---
 .../display/panel/samsung,s6e63m0.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
new file mode 100644
index 000000000000..9fb9ebeef8e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
@@ -0,0 +1,33 @@
+Samsung s6e63m0 AMOLED LCD panel
+
+Required properties:
+  - compatible: "samsung,s6e63m0"
+  - reset-gpios: GPIO spec for reset pin
+  - vdd3-supply: VDD regulator
+  - vci-supply: VCI regulator
+
+The panel must obey rules for SPI slave device specified in document [1].
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in [2]. This
+node should describe panel's video bus.
+
+[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
+[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+		s6e63m0: display@0 {
+			compatible = "samsung,s6e63m0";
+			reg = <0>;
+			reset-gpio = <&mp05 5 1>;
+			vdd3-supply = <&ldo12_reg>;
+			vci-supply = <&ldo11_reg>;
+			spi-max-frequency = <1200000>;
+
+			port {
+				lcd_ep: endpoint {
+					remote-endpoint = <&fimd_ep>;
+				};
+			};
+		};
-- 
2.17.1

