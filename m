Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40072081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv9CRRFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40072081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbeKEBKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38638 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeKEBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:47 -0500
Received: by mail-it1-f194.google.com with SMTP id k141-v6so7488961itk.3;
        Sun, 04 Nov 2018 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyio36wz5hszQFvEyZR37dBZBE7UvBO+czl9CHI2wY0=;
        b=Kv9CRRFHjMKoG5TehBmx7tGNrWNz2Y5h5PJxV9qZsz3BAbR4LEV00wjKXuIVy23mg0
         zxWveyK5tDP6CB2jY6OX3ZMuW9to6thhwQmSmmlKb1HMiVxWWypr8IP/L0tTEN15n4EU
         pTpNfx6F50Si/PeyKEO0eKMLGxOziCshuX2dp/cir81jhO8V1For/QGp9jA5ZZRDaZZ6
         RfB7/k65ZBtyygW9ms0A48tzlJPTs3iOlUv1C8viggmi+4aTUhQoEJJtfb/TwZJBDhnA
         5z54QOt8Z34ijfJO62Ijqz/nuP5aqM9dXkDh8ul0TA8ZhYxCplDvPAgkA+XjCfEzQ6IN
         uSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wyio36wz5hszQFvEyZR37dBZBE7UvBO+czl9CHI2wY0=;
        b=NzgVFwnlNhmRRyjnMODffPomDsCvbvs2t+eD3VF02SZjtc5VykqVMyNZNwYPVXSdPj
         nwrfYt7N4zefmeFdHocgxHe1POnbV6ptwI4sT4kmsT0n2fISKWdHE6brJA5pAB30xWYQ
         Li9NqkSgAYszoUikEJRdFyArgrBv9aXQw4PHjpO4/FWmSRKpb/1OmxSWiUQpUu5hijBt
         5k5cplPDEu40pw9MMaC9N0S9em8RTzpiWSOiPt31a9giA5WaOotZilCJxNRRtyUwNNhJ
         +0x/Xv+q+SveZ/WcXYH/tpNdE1EXiGxy7BxCQOfjXPjU/D1RPiXnOwhAZpMhUHfo/oIK
         TM8w==
X-Gm-Message-State: AGRZ1gLl1HZKDw7d/fLcUqdzLjEf6yyiw8ANz3kwu1QhUy3MI1mF4ahv
        KdHFXRW4UVNSgf48EGtpapg=
X-Google-Smtp-Source: AJdET5cKKxCQhj7mVPR+3ai61FLrh/UqBuASgx4vqKH4fe3AW/yR4X4lCi9nEJGLFyI/dWHfY0+y5A==
X-Received: by 2002:a02:31d:: with SMTP id y29-v6mr17636480jad.98.1541346920992;
        Sun, 04 Nov 2018 07:55:20 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:20 -0800 (PST)
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
Subject: [PATCH anybus v3 5/6] dt-bindings: anybuss-host: document devicetree binding
Date:   Sun,  4 Nov 2018 10:55:00 -0500
Message-Id: <20181104155501.14767-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
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

