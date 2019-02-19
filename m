Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1505C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA32217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsdN3OZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfBSOMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:12:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51040 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfBSOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:12:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so2982755wmj.0;
        Tue, 19 Feb 2019 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alY3UE0yUboUbQt7ZobWAdAoVvLMb+dVwFIcDaOV5w8=;
        b=BsdN3OZ2QmpZxz4bgTylpMsReG+A7XnKeI1rZTO3GSE9X8JZqLgq9tDnfzqlRNEFft
         QcvtR0OCUu6i0jj+GetZFstw1PpxnKbYFrpvfk/LCI1uuOdBbYBfNyndqzmPJGpv6JrP
         sV7UKmLdJrf69eFi4MmbQ8ObIj3OEdgzaoc/9AvK8rYtegAhVJfn2tnQSynUp/BIdKKS
         vMWWttz6uMRNcnmYs3gfSMOuu/6NoWz+Ftd7UNYt1hVbNaWq4qN3XbIGI1O4HhXWISAE
         C6Orom5ZvogVgUgl908XBMDAWUrcPt4T4+xhakJ7CLIZWNmx6OHOOjzWFawGGL4+rQRc
         cStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alY3UE0yUboUbQt7ZobWAdAoVvLMb+dVwFIcDaOV5w8=;
        b=q7hgINz74PThwGz9yfFjQQJAWTrQ5k8icn0JlKXJB9gRGT1Jlo8IqooWwkqIv2VWLW
         co33iQslHDPc9Z+oAs83CylCwJT1+bJI2EgtuEqfSBev9HdsZgwq62b2TgdTFnIJv+W1
         pQ3d/MtutMyOa/5PlabvHvWikUZOdvvtQn8ekrb4JimuWIDpR7MJyoxZs5xNOLjJ9iW3
         UReflopbxlMh1fGX1lstmzXi7obg+jVqyWcTV3e68eRJx8/AbtPvhZZJCxx1MFZvHEJ7
         TOeoCQWgsXkUcO8vs/UrIw0G3n+d1DiCbiTUK/6hK59Q1pQ9e08maaFy9yFyMRyTlZg/
         T6hw==
X-Gm-Message-State: AHQUAuaoP06xa5/IBxAOm5GbI4ZsAQ0FXgLx4Qe5VEW7cfehdXv4I8sk
        qdpfp35B0Ejoz514Or9LBKQ=
X-Google-Smtp-Source: AHgI3IZZ6c536hgy1he17VMkTMjxcvSGF3OfAooDCSJ17B/0uRoz5sD9jdPqjevBZKDJSkWUi9X/IQ==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr3030287wmb.73.1550585566610;
        Tue, 19 Feb 2019 06:12:46 -0800 (PST)
Received: from localhost.localdomain ([5.2.196.146])
        by smtp.gmail.com with ESMTPSA id w4sm4510587wrk.85.2019.02.19.06.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:12:46 -0800 (PST)
From:   Bogdan Togorean <bogdan.togorean@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@gmail.com>
Subject: [PATCH 1/2] ASoC: adau1977: Add MICBIAS example in DT bindings
Date:   Tue, 19 Feb 2019 16:11:38 +0200
Message-Id: <20190219141139.24216-2-bogdan.togorean@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219141139.24216-1-bogdan.togorean@gmail.com>
References: <20190219141139.24216-1-bogdan.togorean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MICBIAS property to the optional devicetree bindings.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
---
 Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
index e79aeef73f28..87c16e6f2e7c 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -23,6 +23,12 @@ Optional properties:
  - DVDD-supply: supply voltage for the digital core, please consult
                 Documentation/devicetree/bindings/regulator/regulator.txt
 
+- adi,micbias: configures the voltage setting for the MICBIAS pin.
+		Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
+		5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
+		If not specified the default value will be "7" meaning 8.5 Volts.
+		This property is only valid for the ADAU1977
+
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -40,6 +46,7 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
+		adi,micbias = <3>;
 		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
-- 
2.20.1

