Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E3C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpgcmxNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E3C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeKSVKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:10:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37476 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeKSVKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:10:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so4706741wmc.2;
        Mon, 19 Nov 2018 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9Wi44+DR02gJSRQMOWGAcOx9HQZNAkBHhyGep/e+Jc=;
        b=PpgcmxNOf+EkxxHkmWq8SKZ0Guxufv/ykp93rlvzfQyXhLbtjaBAfWUFVc1/u5VSzF
         NZi7RBxbcHaap3gEC7uqHgZSZZY3sLw2EP4eXAz91IDSheIYAfeKh1KSk8zr+4eXqjCq
         g1lCu2OrG+lKhVXuIIb3nSuaGjkAPlj+6ECcBQ/lRDNbADPZiLSR5duSN4XPAdYh3N5p
         /qKTr99mcpImtg8a7WE3sN+D2W6gqpBqe3y6Poo9gUIhp0iWttaAAW5HdPWvuzPcsX3a
         946gaATbZ1d5NFfvFPzyqIJAFe1V8+famkp6SnCGwH3Ev2N9takcbITrDSOdrbixc2kx
         Fcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9Wi44+DR02gJSRQMOWGAcOx9HQZNAkBHhyGep/e+Jc=;
        b=fNcSrgmdUdnSf5uyduXFjtTkEk8NPA2JNoxI7hGcpb0TcXjUVPEBoi/oaJvgy7O6Up
         p4HXlE8Yw1r2tmKkwpRWe0mVv4w7QIU9Wj4p5IiVoy2bDgZ9tCocwF15L+pVhvrtjx6u
         dWwjt7sRQyx4R0UuzPpUPenSuBbzDyrECqrDkJH1p5rXVJhAo5vjE3Zawjtmgnpy6HYc
         aM5zDUaMh+arYn7MUX2sTOg6G8WtaOz29bH/7S9+Tq+6ltqMQ2Xigg3DhXyCE/HZZrwZ
         DuqEpIpwm98XfvbhEwnE7OqSk2wFZbXhK3beAtbevym7QSfYM1bw/U+dGvciVUwJk/i2
         YBkQ==
X-Gm-Message-State: AGRZ1gKUuvoEDz0M0SIJKUO6gEcB2Tzyiq0Jjx1cIB92bwTmZZb01I1p
        zcA0v673eQqU6BgMtxKzEDg=
X-Google-Smtp-Source: AFSGD/XeOoXeBhbpIVV2zYLoacxaT0oBoDdqm1BIgHQNFRm8IasoBwClop6jljZGDFovMK3Cd88RBA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr5651469wmf.3.1542624447644;
        Mon, 19 Nov 2018 02:47:27 -0800 (PST)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id b7sm8066686wrs.47.2018.11.19.02.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:47:26 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        Colin Didier <colin.didier@devialet.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] ASoC: imx-audmux: complete dt-bindings for i.MX6
Date:   Mon, 19 Nov 2018 11:47:18 +0100
Message-Id: <20181119104718.18716-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

The i.MX6 audmux differs from i.MX51.

This patch adds the audmux for i.MX6 family.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v2:
	Repost with ASoC maintainer and list

 include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 15f138bebe16..a1d0741d9ed1 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -25,6 +25,14 @@
 #define MX51_AUDMUX_PORT6		5
 #define MX51_AUDMUX_PORT7		6
 
+#define MX6_AUDMUX_PORT1_SSI1		0
+#define MX6_AUDMUX_PORT2_SSI2		1
+#define MX6_AUDMUX_PORT3		2
+#define MX6_AUDMUX_PORT4		3
+#define MX6_AUDMUX_PORT5		4
+#define MX6_AUDMUX_PORT6		5
+#define MX6_AUDMUX_PORT7_SSI3		6
+
 /*
  * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
  * can be sourced from Rx/Tx.
-- 
2.19.1

