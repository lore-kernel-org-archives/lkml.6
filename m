Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C4CC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C92146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHYyoEHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfA0SUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:20:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33156 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfA0STv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:19:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so12345131ljd.0;
        Sun, 27 Jan 2019 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhlUzCAvM06ADAGBHQ3dulgtXj987yKS2acj/AIOnU0=;
        b=ZHYyoEHk8//rkhJKXahdN5AhfhYySnzpwt8f5LS7lODEWdKlQ73aTAtsJNLWYBXt8/
         SRmqOTzlFZoMRpPyCxw5qFmPcobSdNBomKxiXFoCkKc7L97/my804+SZTkGZKfwHPdTl
         ScwrPEvahIpNIdFUrRRHcXC9qHG+SijiNoFs8Hp0C/oqOSoCpBn+URYl2+zFIULPEf1Q
         XX/T8UZ69mtdLa76Azr2k3T3JBIjieptaq9bDFX8jm1BBsL7hYWp84/uk/u3smWBneiy
         lFjWm+qO9cmUJoTqA9lz+ZwpASOdR1Yy8VsXmLqO+kepwI/PwJLTjKDvynAnVWfet6MN
         BPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhlUzCAvM06ADAGBHQ3dulgtXj987yKS2acj/AIOnU0=;
        b=VjKbSc8vpkW4RYqKXE4PcTj6nJMIiWmO6+st00DKt9V9YaRq5znz4JL0EEYk/MwkdQ
         etRl+daDskuj/ARxIoL4QbtsDWbTzw8xUEkT/BXm3VFaLVZJk6v9/+xmgrNT/d3KX0ra
         UiE1P3aYG00q7KU/lKflknptZC9/GTKGlB0IRZRcxU0qZx7Bed+F3WjxKq6WdUvF0dGX
         I5hbR/mX4FHpkseMNdM0xLdZdxhWqYk7PSBxTp7UlQhE95F/hwlxb/namsbHGlJo+MHj
         BMjZffA8EwXf60Rbgbe6ApdrhVlUgEfNb2/Hcstd4HAWEWoIOFlLY1ufSFwyfgfcT6xt
         kMNg==
X-Gm-Message-State: AJcUukd4kbiovCvAdkm0p6GaiH2FxHY47G/iGUe9Txg+EDoiUCUHfibg
        R3Aal7w/KJ82AA9R5Qnl4hurvvyNx+w=
X-Google-Smtp-Source: ALg8bN6At6wLqtMz2yagtTXCRXKa6ozCk/CDef73N5Qq1dQS/Qa6FpdnZ3HwZtKZ2TeGuUx7CMjJyg==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr14566152ljc.147.1548613189101;
        Sun, 27 Jan 2019 10:19:49 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id c20sm2518923lfj.67.2019.01.27.10.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 10:19:48 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        johan@kernel.org, robh@kernel.org, jic23@jic23.retrosnub.co.uk,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device tree support
Date:   Sun, 27 Jan 2019 19:19:16 +0100
Message-Id: <20190127181916.19948-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127181916.19948-1-tduszyns@gmail.com>
References: <20190127181916.19948-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Plantower PMS7003 particulate matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
new file mode 100644
index 000000000000..e4c7f2fb1e30
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
@@ -0,0 +1,19 @@
+* Plantower PMS7003 particulate matter sensor
+
+Required properties:
+- compatible: must be "plantower,pms7003"
+
+Optional properties:
+- vcc-supply: phandle to the regulator that provides power to the sensor
+- set-gpios: phandle to the GPIO connected to the SET line
+- reset-gpios: phandle to the GPIO connected to the RESET line
+
+Refer to serial/slave-device.txt for generic serial attached device bindings.
+
+Example:
+
+&uart0 {
+	pms7003 {
+		compatible = "plantower,pms7003";
+	};
+};
-- 
2.20.1

