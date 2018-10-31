Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79783ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3648C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USIXAcFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3648C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeKAEoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:44:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55733 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbeKAEoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:44:06 -0400
Received: by mail-it1-f196.google.com with SMTP id e17so18429204itk.5;
        Wed, 31 Oct 2018 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyio36wz5hszQFvEyZR37dBZBE7UvBO+czl9CHI2wY0=;
        b=USIXAcFCoRbRkHsXjPe4k+eg9hZ/brs/DSl8CN73Dm4KDcIdPNyxPSiHy426/72FrH
         HtWPiymT+2MSsL0fuHIxJjtcFZXUiIkufu7jtEdD5ovnUSqIJ6FfuE6M2i85iKfNPwPM
         qfA+OV4oGlVJT/8bL7wkiMaxsmuubzi0/oA0NX0LwAa0DdYy9xQkqw7PaySGhRMPE2B4
         gLxgdO3eU1EojM1rMb9dWGhii2bzoXASCd9QvPkZrvl/hipaaPXm8UM9NDC8XE8wY+vI
         XwwXimikbqwKkrPQR6s3uoV/6IEXx7faKQF8GRxLBlh4NVM2F/Y+lFC/Y5ZG52s7kb2S
         0owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wyio36wz5hszQFvEyZR37dBZBE7UvBO+czl9CHI2wY0=;
        b=AQxjPQttNrNaESU+SpIlIfopTszprMbpsC3TLaIYQ1ih6UsKU2MJZf7bXV/6dpT2oV
         nDDqjE4WouIwoikO1oqsD0YexAsrp+mRqp8jdauXr98s25C75gmObYWHgiovCZxzjYkG
         dIYqOhuxm9oV+yZwP0ogs8Mdpgs78M7+GEenNRTHkxKa4Hgynfr0B3c9XAlwyIbBXdbH
         BsgYI47IOx+Vw3X5CyWDOd/L5RVRGP+5Y0lSXPR/gZ1wzkUsx9e+tcXjiLrHa0dxruaq
         jHurQNuiEE5BNKYbEEXv5nERSmD2OfrMkUS3rZv5BpZv0hGYETPk6oNvZS3Xy+Cvxqke
         u2SA==
X-Gm-Message-State: AGRZ1gIVYaXejjFXDA+TLIzM5xVcOk7jNrUq1gvEZsaK9lVPdrGcbRgF
        C7GIEdCWb/cXMYXc2qpklyzuH+tw
X-Google-Smtp-Source: AJdET5dmoWzIrHZxiORy66lKEkfE7bGZlbvGkC9r2hWkuj48xMdqpnyffArKdtRTvzdSL2T2naeD0w==
X-Received: by 2002:a24:1cc7:: with SMTP id c190-v6mr3504015itc.30.1541015075745;
        Wed, 31 Oct 2018 12:44:35 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u142-v6sm7136606itb.13.2018.10.31.12.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:44:35 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v2 4/5] dt-bindings: anybuss-host: document devicetree binding.
Date:   Wed, 31 Oct 2018 15:44:24 -0400
Message-Id: <20181031194425.32132-5-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031194425.32132-1-TheSven73@googlemail.com>
References: <20181031194425.32132-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch adds devicetree binding documentation for the
Arcx Anybus-S host.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/bus/arcx,anybuss-host.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt

diff --git a/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt b/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
new file mode 100644
index 000000000000..5c28e4e09bb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
@@ -0,0 +1,36 @@
+* Arcx Anybus-S host
+
+This host communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
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
+Example of usage:
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
+	};
+};
-- 
2.17.1

