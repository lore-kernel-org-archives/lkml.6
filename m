Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F261C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5420645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SFB8pJer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeLOFWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46842 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbeLOFWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so3789561pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDoLfpjNAyWtuhe4HUukg8qR7sDpr9z0VGObQaPKKr8=;
        b=SFB8pJerFjTU6W1IOA/VbZktGqFt2HD6oDX90xn2OfFS7l+mURXkiQL1c6vlu+69zm
         Q02tdM68UJp6IrkQdkLv1O2fInzGt6RTm7eb8hNXNGacPZ/HUqDcPXhpjffAKYF+alIg
         5ehbu7We76pgZFE+e31+8vtjgS7qJV++J8YWLn+JmiXIps1+4TqpC0mxxw3gnicYsyZH
         A+ZLb2wCmwEY51764F3wVZ4OywCyCdXMdXSJhEoKAYxTEbmKn6apJbETKpiDuLAOMD2V
         Ci73R5gLKKdvjPlr4d3cm1yofJBP4WpJsjUnx0/FZL7NyInhXCbwKLCRYqGj57X4hF06
         dLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDoLfpjNAyWtuhe4HUukg8qR7sDpr9z0VGObQaPKKr8=;
        b=SL+ft11Zegmiz2Qmr1WcMUSxidAaQXUkJTlNRqEYhHpfwK9GrZ1Cy0NX4y+md2Wen+
         9FboRa7wcTfHyPhohJ7LvF5+cgrRKTxoBElolL9pDU0AJOt9Gq542wcY9z8J+E+bLGSp
         RqEpXvkn1xqEt6NA3iE0rnKxnrqhIDH9sGKRvJV5l6gGcK438zycWg8UwTY4DwjS8cKs
         mrfASgbeVWVJ0yzq+hh4gbNJm1J5NSVUvL4Nb1VbzjrClBRzgV1EzmJK4HtviBzu2Hp2
         eIS5tzd6Iynjx3RZD2s6k4h7CA9mFSEd5m6ijH4MmuA2ZfrpyvQGd6cKAOubOm6Xxl+5
         vvOw==
X-Gm-Message-State: AA+aEWaFuIh2FFXamdqP+xyCMJLAO9K6yXdeA49ChBs4IMG87XxrNXJh
        F5TBf3fH85kqcsBkyU5GdhQIKbIA2JQ=
X-Google-Smtp-Source: AFSGD/WmSoDpeWsCDldCHmktUFbAD8An63NaaFWgBGSAUc0/+vPeUlXAUj5//UgEv7FfwORXRS/PRA==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr5181688pgk.190.1544851354751;
        Fri, 14 Dec 2018 21:22:34 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:34 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] dt-binding: riscv: sifive: add documentation for FU540-based boards
Date:   Fri, 14 Dec 2018 21:21:53 -0800
Message-Id: <20181215052154.24347-7-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for boards based on the SiFive FU540 SoC.
The first board, the HiFive Unleashed A00 (FU540), is described here:

https://static.dev.sifive.com/HiFive-Unleashed-Getting-Started-Guide-v1p1.pdf

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../devicetree/bindings/riscv/sifive/fu540.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sifive/fu540.txt b/Documentation/devicetree/bindings/riscv/sifive/fu540.txt
index b5cf2b9f9a75..20119cc54964 100644
--- a/Documentation/devicetree/bindings/riscv/sifive/fu540.txt
+++ b/Documentation/devicetree/bindings/riscv/sifive/fu540.txt
@@ -12,3 +12,13 @@ compatible-string values:
 
 - Freedom Unleashed 540 rev. C000, or "FU540"
   compatible = "sifive,fu540-c000", "sifive,fu540"
+
+Boards
+------
+
+Boards based on the FU540 SoC should specify the following
+compatible-string values:
+
+- HiFive-Unleashed rev. A00 board
+  compatible = "sifive,hifive-unleashed-a00-fu540",
+	       "sifive,hifive-unleashed-fu540"
-- 
2.20.0

