Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA4C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5F02089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqxFYsu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5F02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeI3Usx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:48:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43960 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeI3Usw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:48:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so834785wrt.10;
        Sun, 30 Sep 2018 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=UqxFYsu2VAYcfRo5y5FcS0y59ApqqLdQ1vZ9PGJ6gfJc7MH6SMbO1TxctOw0omEl8a
         Nn2dJmUiX3183pzvOV83pyjXjuE6ENCQQr5BrK9mTLX/5GVte+Pa2dw1MOx2GkLnKeg4
         64bIEtU5BQCOj1xlEVu53k1IYuDODWE4b/1/47BJbjKh39YaOXfg++UhzG0rFgxBXckN
         7T5+/qw3BDbrIFw4jrEepp6tSqPR2twOefgsjS1u3OKp/LjcrVQ0DQZ7H95HXY4ecivh
         APnGccXAW6MzAiasOXauRrBa5Hvr6vBEpMYRmEu9Wfj+aGu4sbQNfHB0jmDbYpnHnFFa
         Y/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=PxyU+E7L0sm8nt2MeligwUKvPTp9pkncJHnJt9Nq+U7Q2G3fGFvuAWe9V4RJmDt/n+
         bZJS5f3/RSXfCrlwU6QTchtZG9xcRSVtBDZsum4fHjTdPGvLfYMq/KorXz1SX/V4p69j
         rQaYVu13j3dIfzH5L4u2Gc8NrrufhwpWscnWqiZQOxlf1+FiiBuNj55kPd+BY4znQ7cz
         XUEt3A6GKYszaL1FBxVQW4JbGCbyqpLtTHX48bM3ZI0Vb6I/nYrz9uuNM1+3kyjDXqNi
         TshgKmqulvhWd5e+l/ut+VpcUGXcm4maPlc6BDXhkd2HOU7T4eRAHpCxH18617b3R4cn
         9XyQ==
X-Gm-Message-State: ABuFfojJphCxbkPVCMgIH8+Cyjh7LFC8Neh4vQ6ySVwKmqi5Bue0lym9
        pXCrMBKqPFuAbWJfbQXoFGE=
X-Google-Smtp-Source: ACcGV61EsWNGccevOPvtLXACP9hRtTAspuBVF+AN/e1su9FKiH5Z66vrlJqqAu5WGsZVwYSFRGBKXQ==
X-Received: by 2002:adf:9206:: with SMTP id 6-v6mr1132992wrj.275.1538316938000;
        Sun, 30 Sep 2018 07:15:38 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:37 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 4/5] dt-binding: mips: Document Realtek SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:09 +0300
Message-Id: <20180930141510.2690-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding doc for Realtek MIPS SoCs.

It includes a compatible string for the Realtek RTL8186 SoC.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mips/realtek.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt

diff --git a/Documentation/devicetree/bindings/mips/realtek.txt b/Documentation/devicetree/bindings/mips/realtek.txt
new file mode 100644
index 000000000000..09d19758168a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/realtek.txt
@@ -0,0 +1,9 @@
+Realtek MIPS SoC device tree bindings
+
+1. SoCs
+
+Each device tree must specify a compatible value for the Realtek SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  realtek,rtl8186-soc
-- 
2.19.0

