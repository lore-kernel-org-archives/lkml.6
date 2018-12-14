Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812E206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+uGig00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeLNS2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:28:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46713 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbeLNS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:28:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so4938439lfc.13;
        Fri, 14 Dec 2018 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQzku6LlFX2y3XHHy0PAdDBhO1kmwTgThkP1DPTlgro=;
        b=u+uGig00RToWVZRStpG+adwo8E+wOKZZee7oCND96Iv+GksRsgcUq2xdmGBsCUrnls
         LzOZ3Tm9b/S4ADs5/YI2etKhdBYg++YwFy0eniQwbyI+IhxRPaB8d9HUeHXfbNqnsdEo
         MYeEElthppIgli3Swu4YRKn/goP7NS7EenJYU9kA/holHbXVpOuuPy22Mujpz+89Xagy
         MB06/2OUeIjmnhxHae1qKFmaVerR4ovAvnR2aNmI413ioRGaY0E49OD1Sbhi7yHExUmC
         CqXx4eR7Rby1xsmbcRHs2DHJhZsSwvQ5gb7TYlROaipmJjPgEPRxNOkLvhUC0heAvMaJ
         OiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQzku6LlFX2y3XHHy0PAdDBhO1kmwTgThkP1DPTlgro=;
        b=TxBC+0avj8fO+0WAgGKLMy+kfYcrLkklKMrZA+O7Bj0rkLMuB27K/7VcS8Jprv89bb
         BHxhAHC7GohmkDk4w6f+2whQbqtjFL+yyz2MzAk8wTVBvGFrukYZb0xauDQvxnfe/4UN
         RsPTOjDDsxPwm/pKm6+gxEouIZHZLiu25auzDxxcGsZ7E5oQEjIJd2Y6Gd3y+1LtUXNi
         /SFqF+D8TNUDjeQjT91axH3j9D4jM+Rn3vuyfOt/3uh/4x+DdfsFK5SgiMmsorTrFjmG
         AYWLUITTuqHhf5ENjSL01Dih5Cow4KJ77iQqoAaCsjjeUSYNbQnGRotx+rZbv6UZTdrk
         jYxQ==
X-Gm-Message-State: AA+aEWamt0tY5ViU4oW21mJxuv3A58d3kKvH2cfrpuoGjrW6h40A/rKu
        lDQnBW9loFjZbMEYzMxaqTyc3Uuj50k=
X-Google-Smtp-Source: AFSGD/XU6rX1fRQcc7pQTcJqlnTudmFp0sn4YPI9jHxhK4AdXDL4rWQdd2q8gMuw7TxPk46f6MV02A==
X-Received: by 2002:a19:945b:: with SMTP id w88mr2299148lfd.15.1544812113370;
        Fri, 14 Dec 2018 10:28:33 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id e14-v6sm947961ljb.31.2018.12.14.10.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:28:32 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 3/3] iio: chemical: sps30: add device tree support
Date:   Fri, 14 Dec 2018 19:28:03 +0100
Message-Id: <20181214182803.9006-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214182803.9006-1-tduszyns@gmail.com>
References: <20181214182803.9006-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Sensirion SPS30 particulate
matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
new file mode 100644
index 000000000000..6eee2709b5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
@@ -0,0 +1,12 @@
+* Sensirion SPS30 particulate matter sensor
+
+Required properties:
+- compatible: must be "sensirion,sps30"
+- reg: the I2C address of the sensor
+
+Example:
+
+sps30@69 {
+	compatible = "sensirion,sps30";
+	reg = <0x69>;
+};
-- 
2.20.0

