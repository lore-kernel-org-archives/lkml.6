Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF71C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FE82089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQzRo2KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FE82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeJARHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbeJARHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so13281689wrr.4;
        Mon, 01 Oct 2018 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=jQzRo2KHWcNRoA+X+HVmuECNfdRYfVugr0gKcwkMPpGEA5uoJUREszXZLnu1aaUZCn
         LIbsSkW4WJDFRtAY5abf4ypyxMBPQgl1vyK6U8+xxhBrtBxlgMzEd5PHbaChC8WGuEdY
         mIqr9JT5ibMB43CGx1jwgkAdM3a4Aepz2liJn/bAmH8VZ2ks/O+0sTTsUNMwfxS5/SDG
         sM0ENDb4FmnQUMa5XMqDdLnXQlK53rgL+z2tyTLPR7HWbL2qodAhQq7NbHsOnw+mgb79
         WZJUHN8+LHgyVKKFwpo89g5c7q81tZT33qjdX2TktQ2Xd4h2Kf3jTt/6jTZkeXeAG+RU
         xxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=S94L6k6dbMZXZp9oaHXGkqBGrRO6/hRfowJESHMwoDTCbqu8JAu13xdSHQQBHlgFgX
         fxOk/W2vD+R9ZDCtXl9XK9Cjn8ttDsMgHgsmOrnniEHRL3gJCR2CCfWZCF86mRpS8afS
         hNCIDGoRlkqizJZmupR0WtpANm49puR18HaddFKaU5i3MwqHt3dve4H8/3rBj4azg9KO
         91DDk2kiLji0U0wPT57qgZsqKVE9FVTNaX28wXIILJ34ekeez+siifS60dMHJGZ/NMiR
         3TqKKDiNszqyDvYqxOjxIq8t4qBgXhXwFyEsCyO2p2RQqOaocUQZ7y3dQm4qmQV9oMvn
         RFUA==
X-Gm-Message-State: ABuFfoh4UBd673Ir9W5oQ1gSDGyW6BQT9IAUek+XZsSeOwX6NR3pXM4T
        XHrits9Hij8kV2Sv+AqBscs=
X-Google-Smtp-Source: ACcGV61tQRjXUoTkVVUVGK+YsNanbdFoGlaxVtvZnH5YsbZnDvMqVAf3xqv/XD0AClgnGgipzOmobQ==
X-Received: by 2002:adf:a969:: with SMTP id u96-v6mr6369707wrc.222.1538389826589;
        Mon, 01 Oct 2018 03:30:26 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:26 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 6/7] dt-binding: mips: Document Realtek SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:51 +0300
Message-Id: <20181001102952.7913-7-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
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

