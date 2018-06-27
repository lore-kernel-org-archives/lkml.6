Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E523C4B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF1G64PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E523C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966128AbeF0ROA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:14:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40155 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966020AbeF0RMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so2119108lfc.7;
        Wed, 27 Jun 2018 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xlg3CMol+45yAujAZJgFfoqU0dqLQprdbimxfVlW74g=;
        b=KF1G64PQIbJ21YFQ4MLonLRW/9JAjc7UPGr3PfheJCVYJYyBwVUKfcQIN4089LOM8A
         sWeBxUQ+2MG/1JVyoCiFot0+JNwGnrOfEX4nxz76Hz6hcZe6s9U9luUzs0qpPxds3tk7
         UsQ4pzdY5QPUIfuu1GEIXO1vFh4Hqd/THTxH/DpHZqg+RXSW7HxmJaID1LlaFuqEHkVA
         89idM2rFMiMqRkWzZ5jX8RxGqYhbjs3+KlZLTTPDIVVAm8fJ16ePMYi6LG9RDBZE4QZm
         GTdczwyC4xFLumjp/iaj0L9E6BZ7vqdgp2XFxu/QWhfA6QqTAJuHIw5xFt9TXf5Eim77
         whOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xlg3CMol+45yAujAZJgFfoqU0dqLQprdbimxfVlW74g=;
        b=HSI8awBkwnlbdA8w7VIZVvmRBAu+t97RMq7MeRhJwoJNxunSf94tvapZZrmJNS82Oj
         nc3vAMxjm01YBWj6VPMbWC9gL9I9AfhEh0mHRnlT9O51b/BRsnSu8+D8KpxVcet2FucY
         nvsUyQtR+hx5DN6Z8LYg1Vxk87G1xj5h3PGNEZnHgXzMH9FfEKf0MdMvSkew4WIxhdR1
         wJG7sZDrEy7WN4IpvT/qzlXDXmnwBAsiXoR2Sjc/X4cBhW646RX9ggUjb+nLDWDlMaoI
         IZnOof6BMkMjhdD9wW6ArgBsB6f8Bf771h7p6gGzPs+nUCsbBY6aNeGVA92Ml/B6pZ+S
         97hw==
X-Gm-Message-State: APt69E3pv8M3AdQ1kZbTN7MDEMW/BGHc/mULOVwdwe65FkHS+CsnzLQ7
        GlFtuGpxbgELD9t3tOenei8=
X-Google-Smtp-Source: AAOMgpfDJmuGr/z5PjrnrXr3zbFqNEjMDkt9AoeTL3xo+PeAgRU+nW/FRmOetT2NEaNkG2e5AZQcOg==
X-Received: by 2002:a19:2bc8:: with SMTP id r191-v6mr4563701lfr.61.1530119567159;
        Wed, 27 Jun 2018 10:12:47 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:46 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 07/10] dt-bindings: samsung: Document bindings for SGH-T959P board
Date:   Wed, 27 Jun 2018 19:12:21 +0200
Message-Id: <1530119544-30023-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
--

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 3fa287a86300..37e96e48c48c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -3,6 +3,7 @@
 Required root node properties:
     - compatible = should be one or more of the following.
 	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,fascinate4g"	- for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
 	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
-- 
2.7.4

