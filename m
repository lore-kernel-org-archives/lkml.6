Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68247C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332842085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4tpG6dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfAFRQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:16:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33676 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAFRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:16:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so28581993lfc.0;
        Sun, 06 Jan 2019 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzYtW8cYGpKWt61QW0eBJ6JQkqRtzCx7rNA4iS4RRrQ=;
        b=n4tpG6dAAQENg2cSW2mVCwOcNt93l8H0jTfn3/HKCdayaUuBFVwI67lniuYFlnNQUe
         7h3BcUq6FGWGEUYvA3faqSWmmCqs8aGhYdllQ/viL0zJZnRGjEAwz9vNiFXJcOYbT1KC
         FiZvSazqgaa1oKO0KSwP5wEL4LFeT8iEKl8+jouWib3BU/2FdwSWfkJKEn7txTf92dZJ
         sL2nm50txVpbAr0fOiLefqTJhxbncyXF18LCwqnCQVHqQQ6nCfiYG8hQ2KYYxiTcHWBa
         gyKmS2Vw48kSlpfAfvGdFvk10hPg6zzPG6qCVM0pQr+WeZEJ5ReF5nbtday4ToOgdM41
         6dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzYtW8cYGpKWt61QW0eBJ6JQkqRtzCx7rNA4iS4RRrQ=;
        b=rso5sQGfguYC7ecfjJ1Mra2YOdlvly9fmiqeTEitalDifkUrhWe16Ry3hr9Gvt+y1f
         JoDxd73uMMotcmA/iy9cvNKmoHGSWxNBlrlZ9F419kAsa8C1EylxbHLi7sBlUUKBHgVW
         ujw5Tr1Zvb1TpaCVzBRJfHlfYc5ahVxTeYXR6stOgkwIYpkMrDc68PlsokgU/9p+QD41
         fIXiLcHOyG2t0NoEh6qZHPuI7SPxvWg/sadJ1pOXPd4fshOYGQiL5GT/AuxGG1kwaZoe
         dh5DZCt4pt9dVEJSg/VnUswURcvuOz6+cc15xJ05cjNEWLGDp7ER2fx+BlqCFP7VNumR
         Ynwg==
X-Gm-Message-State: AA+aEWaeVxzuSzuD94b4IlDzsPD7s0a9hDCloy6Oq4aT5UbVPSrtt0L0
        26zbO1fbxuIdNN975nbXudR4lzu4
X-Google-Smtp-Source: AFSGD/VLQvvAWhgLlQ7/2FF1haOauXNJbe+nBlwbev+IlGbOF5Q+fxwB6K+ELwWuA924ZDXCgwlnlg==
X-Received: by 2002:a19:2584:: with SMTP id l126mr27763043lfl.69.1546795006310;
        Sun, 06 Jan 2019 09:16:46 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id b17sm12339409lfc.21.2019.01.06.09.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:16:45 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 3/3] dt-bindings: iio: chemical: pms7003: add device tree support
Date:   Sun,  6 Jan 2019 18:16:14 +0100
Message-Id: <20190106171614.12615-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190106171614.12615-1-tduszyns@gmail.com>
References: <20190106171614.12615-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Plantower PMS7003 particulate matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/plantower,pms7003.txt    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
new file mode 100644
index 000000000000..79eb538eb932
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
@@ -0,0 +1,14 @@
+* Plantower PMS7003 particulate matter sensor
+
+Required properties:
+- compatible: must be "plantower,pms7003"
+
+Refer to serial/slave-device.txt for generic serial attached device bindings.
+
+Example:
+
+&uart@0 {
+	pms7003 {
+		compatible = "plantower,pms7003";
+	};
+};
-- 
2.20.1

