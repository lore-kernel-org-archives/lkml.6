Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031236AbeEXRum (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:50:42 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41479 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031150AbeEXRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:36 -0400
X-Google-Smtp-Source: AB8JxZqlbREOEOJRxXH2sa/RZVRqrN4m8EsV7N9dIO6GtZG+Cr6zKREtCdQkwGZR/F3ZqP25YJjonA==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/8] dt-bindings: pinctrl: add a 'pinctrl-use-default' property
Date: Thu, 24 May 2018 12:50:19 -0500
Message-Id: <20180524175024.19874-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin setup may be optional in some cases such as the reset default works
or the pin setup is done by the bootloader. In these cases, it is optional
for the OS to support managing the pin controller and pin setup. In order
to support this scenario, add a property 'pinctrl-use-default' to indicate
that the pin configuration is optional.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-bindings.txt        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index ad9bbbba36e9..cef2b5855d60 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -103,6 +103,12 @@ Optional properties:
 #pinctrl-cells:	Number of pin control cells in addition to the index within the
 		pin controller device instance
 
+pinctrl-use-default: Boolean. Indicates that the OS can use the boot default
+		pin configuration. This allows using an OS that does not have a
+		driver for the pin controller. This property can be set either
+		globally for the pin controller or in child nodes for individual
+		pin group control.
+
 Pin controller devices should contain the pin configuration nodes that client
 devices reference.
 
-- 
2.17.0
