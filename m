Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F8DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CF720700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQudOtgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CF720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLFVFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:05:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33396 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLFVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:05:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so1725352ljd.0;
        Thu, 06 Dec 2018 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=gQudOtgPnk+ovQWOqW8yAo+fK1O02eOjiYcpHSE8HGAYa615Re2Rxf0RloFfoqK1U6
         MsuNrJ2v/VoomfFtM+w+EMi45yVFQokShfw194a2556q/SVgGfS4z/cOQikXfO4oUIEc
         l4DSRFONdolyn5eeIDysA6D6a9J2+RTdMENrnW1JJpB/QRXYe/p7aVvknk7T22KAhNE9
         /UOOUPXsl84nIf/OJgIv4FLZtRtfMtTJYqL9bqcwSe3cVRoV1fQAl6KgWbDiBloZ7UYy
         CRuEJYxm5ssOUOysFVq+a3PRjjH6erltF4dXtyGR32bWopXEySwN98dBFjHVDpzfDk7y
         8Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=HIJtrZS11SX5RQbKk52iVurh4uSTYnr1UJAqT5YrmwR1f+30s9ze7zmZ79Zgd4Pz9I
         +DYyoyIFxZRElUG3sPXS0u80q0qguOpoJth8BiZcqg34/bVRz9JEyMPJ7WB3HAuMJTiV
         Pk7Blw5Co6tJynhJktX9aSTz2imZqtWCJ+hG+8TX8apA8FB3IKW2RdWA3zXT5akrLU0K
         Ov6Lt/g95aGPIfHDczNAUVOBQG9n6NDBIHVPaXuVSkLROUso250eBDHNlTJnE/Y8WqmZ
         hq8lFKPYUgUkLmTahKilwZ1Umu07NRlLNgYYsyVLU+H0V30L0TCJ9wdlnXJkcNSBVmzX
         uZcQ==
X-Gm-Message-State: AA+aEWYiKQ/SMQyOrSdL12K+4NMgK8/evKNgwvluysScXNtlgW9D/BAx
        XDtvxntnWiuftmjoVPDiVdiQtPTxZVM=
X-Google-Smtp-Source: AFSGD/WpPBhgUdwNoJRphrT0yMkN/NdTOV8ft94yXAR4iEhWEwVP98UjY9in+/si+uv6yG096Iueqw==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr16760115lje.115.1544130313167;
        Thu, 06 Dec 2018 13:05:13 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id e94sm267366lfi.23.2018.12.06.13.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:05:12 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 3/3] iio: chemical: sps30: add device tree support
Date:   Thu,  6 Dec 2018 22:04:43 +0100
Message-Id: <20181206210443.21052-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206210443.21052-1-tduszyns@gmail.com>
References: <20181206210443.21052-1-tduszyns@gmail.com>
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
2.19.2

