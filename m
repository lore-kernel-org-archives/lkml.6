Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79CD20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/eDLUfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfAVPV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:21:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40718 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfAVPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:21:26 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so19380483iog.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=p/eDLUfrzb+f02T9fMm+BBzoXphjL824oPKK0bE7Je7L7WANI2z3L1LBy7DsumZN4g
         2v5iyYMSf2kJy+oHJ7OawOBtMi+7/USGt2zlyfMePy1/gbbFZJJw86hiwgy/g9WcTyyO
         bALLo7I1mHKYAZKodXX26KLBs3HSzm0YkEHHpLr6KuA0a3d3hxBBqCXRu+2nYfGK7cz0
         bQKwgCHhFoMNB53yYJxKa1NGcZOpMqXRW37iIGVXQoIrvONbWbNyKjB096S36zSZJk+R
         jAn3nVCwqRSE1XRfDILOD2SLkaPcot1uF9CsNDEaZ2cBf4o4KGhJNsH0orAC/qwW9EMk
         jCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KYL3KgsRyzdlXJO6mH+gF6GpkUdrPdEmyA4kTW54chE=;
        b=CjfuapEyDZeKVRtetVNfl+h1HBJ7ARb0lrSg4SJTFuzn/rSVBl+UTI6l9MDn3kUnV/
         A2cl/W2o7heBY6TVz43+N3ztf9EaMHF2N6Te3lMv4EI/nqLOeo+f/pYPyWk8LeeWy1hy
         LLgB3YWtWk4YG8JWv99ffBVLa95hrX2gPuXqwBmpJzizO2mcEWWqprhIIMEYz5AHo8R4
         5GBHjth/OKPE1otGEYsD+ePwQ+243Qk6JaSEn4XPITmiI8719poRg8DPGh6ujqquo3o2
         1DHpbW4lw7JmIjZ6YcwYYHe4SEZrScRZUPvAjpSAFzqGeIEVG/6TclIiE0Omn2GfWsfM
         BUgA==
X-Gm-Message-State: AHQUAuaqSpA+UM1JoWCMhXJ8CjYyZxV/BhGsktDGMwwb2cm+rbG+rd2I
        G5BPpD7pBZmbbN2yY2THnXo=
X-Google-Smtp-Source: AHgI3IbaLYT9MtBsWaRbFsjOzKGgNPmXn/3bIdzPW0PGFupJOCnJm/clOLC2GCVlvtRldooKm4ccog==
X-Received: by 2002:a5e:d910:: with SMTP id n16mr936715iop.58.1548170485959;
        Tue, 22 Jan 2019 07:21:25 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id b192sm7658509itb.12.2019.01.22.07.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 07:21:25 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] dt-bindings: anybus-controller: document devicetree binding
Date:   Tue, 22 Jan 2019 10:21:07 -0500
Message-Id: <20190122152109.30488-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122152109.30488-1-TheSven73@googlemail.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch adds devicetree binding documentation for the
Arcx anybus controller.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../fieldbus/arcx,anybus-controller.txt       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
new file mode 100644
index 000000000000..b1f9474f36d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
@@ -0,0 +1,71 @@
+* Arcx Anybus-S controller
+
+This chip communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+--------------------
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-controller"
+
+  - reg : three areas:
+	index 0: bus memory area where the cpld registers are located.
+	index 1: bus memory area of the first  host's dual-port ram.
+	index 2: bus memory area of the second host's dual-port ram.
+
+  - reset-gpios : the GPIO pin connected to the reset line of the controller.
+
+  - interrupts : two interrupts:
+		index 0: interrupt connected to the first  host
+		index 1: interrupt connected to the second host
+	Generic interrupt client node bindings are described in
+	interrupt-controller/interrupts.txt
+
+Optional: use of subnodes
+-------------------------
+
+The card connected to a host may need additional properties. These can be
+specified in subnodes to the controller node.
+
+The subnodes are identified by the standard 'reg' property. Which information
+exactly can be specified depends on the bindings for the function driver
+for the subnode.
+
+Required controller node properties when using subnodes:
+- #address-cells: should be one.
+- #size-cells: should be zero.
+
+Required subnode properties:
+- reg: Must contain the host index of the card this subnode describes:
+		<0>	for the first  host on the controller
+		<1>	for the second host on the controller
+	Note that only a single card can be plugged into a host, so the host
+	index uniquely describes the card location.
+
+Example of usage:
+-----------------
+
+This example places the bridge on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	controller@0,0 {
+		compatible = "arcx,anybus-controller";
+		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>, <5 IRQ_TYPE_LEVEL_LOW>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		/* optional subnode for a card plugged into the first host */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		card@0 {
+			reg = <0>;
+			/* card specific properties go here */
+		};
+	};
+};
-- 
2.17.1

