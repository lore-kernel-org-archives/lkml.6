Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CAEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFD1214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX+6v719"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFD1214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeKVBmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:42:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51803 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbeKVBmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:42:19 -0500
Received: by mail-it1-f193.google.com with SMTP id x19so9276131itl.1;
        Wed, 21 Nov 2018 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1RCEjD7slQd0dEtJSfgyXZCEPRipHnrh9WPjXsaPm0=;
        b=fX+6v719VR84M5M8cMlWEcHRPwewf78ZsfSzzP50inuwy1CFTv7KXJDbmbLA9q2Xwj
         BZ3138HSjmaR4/EiIk6THzrQuGJWv6wNRKdm6IpW3vB61nzKW49gtcpraBTxiYjupdkz
         AJ505MgeZSnHYO67gfWzywoT8FqR8/1PRKgSnb8D7S2OLeMSOtT8IXSAFj3vgqn3qL+q
         z7lapCT/G47zJqHbaeOs6Jvwkp64q2jECejr8aKQ4TXtbuajZOiKHUqIfK40wRX6H5pl
         3nAaANNskFZQ1dVV/KvOZr2QKEHATJm1vDR0nzH+XMafK16GiH+lIlq+SOiYx5nhskeL
         j1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1RCEjD7slQd0dEtJSfgyXZCEPRipHnrh9WPjXsaPm0=;
        b=MrkCYucdCkR/klNRrtcxQ1KI5pZVHboEEGE4bET1zHORcgl3Gm5RdE6RVYRDMQ5ugz
         O3kKkEc+xGmjvI/BzrPyAEQm9dRlPByrDvzzsv0MoeN8InUlr9Pnx3aEhKc0eZe8lctO
         PKEx39b2cHaTcmtMk4zO8sjYU8Vmqwoi6ymq77n+MI1rB7a1jjA/e8mgysUqBxwYKGjq
         C3ep/P8X/MXWttMARDCEsDCA+vbZ41RlT0Gnk3rzbMPxPuPMIiGjj60VBLqHA6gqx75W
         EphpNMfeBHMHs00JDUigdP6V6q0//gWUm67P3RrcWfzr5LU30rE9uQthqqxctRF0ZlJl
         z33Q==
X-Gm-Message-State: AGRZ1gKwJmzxqzt8HxhPk9CXawmNCptrUmsvDJk2hh6fZRp0BLlWsnLq
        HYsB7vADgnnr0Fg1CSYdeyMFMahg
X-Google-Smtp-Source: AFSGD/V3TDsI/96MsQpGwzFZBMc5svlsdXrZnNqY6su1iCueoHhEYTyiBHJ4CIdw9pjLZ5qLgyGwIA==
X-Received: by 2002:a24:784a:: with SMTP id p71mr6882405itc.158.1542812850610;
        Wed, 21 Nov 2018 07:07:30 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c3sm5113119ioi.2.2018.11.21.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:07:29 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document devicetree binding
Date:   Wed, 21 Nov 2018 10:07:08 -0500
Message-Id: <20181121150709.6030-7-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121150709.6030-1-TheSven73@googlemail.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree binding documentation for the
Arcx Anybus-S host.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/fieldbus/arcx,anybuss-host.txt   | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
new file mode 100644
index 000000000000..456587f288c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
@@ -0,0 +1,66 @@
+* Arcx Anybus-S host
+
+This host communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+--------------------
+
+  - compatible : The following string:
+        "arcx,anybuss-host"
+
+  - reg : bus memory area where the Anybus-S host dpram is located.
+
+  - interrupts : interrupt connected to the Anybus-S host interrupt line.
+	Generic interrupt client node bindings are described in
+		interrupt-controller/interrupts.txt
+
+  - resets : the reset line associated with the Anybus-S host.
+
+Optional: use of subnodes
+-------------------------
+
+The card connected to a host may need additional properties. These can be
+specified in subnodes to the host node.
+
+The subnodes are identified by the standard 'reg' property. Which information
+exactly can be specified depends on the bindings for the function driver
+for the subnode.
+
+Required host node properties when using subnodes:
+- #address-cells: should be one.
+- #size-cells: should be zero.
+
+Required subnode properties:
+- reg: Must contain the fieldbus type of the card this subnode describes.
+
+Example of usage:
+-----------------
+
+This example places the Anybus-S host on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	anybus-host@0 {
+		compatible = "arcx,anybuss-host";
+		reg = <0 0x400000 0x800>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		resets = <&anybus_bridge 0>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		/*
+		 * optional subnode for a profinet card
+		 * (fieldbus type = 0x0089)
+		 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		profinet@0 {
+			reg = <0x0089>;
+			/* profinet specific properties go here */
+		};
+	};
+
+};
-- 
2.17.1

