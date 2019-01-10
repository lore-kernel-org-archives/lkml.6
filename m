Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E097B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhxFSz/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAJIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:08:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41175 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfAJIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:08:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so4960811pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bR0eeytQfv+glll7aoQHEqu8NdP2ZbsHgif8yrcXd+8=;
        b=hhxFSz/9yhJlDxwLfGoVRZRbWxzm7XPUcdTCV8qqkR291nrod6TNYNGIeOiLB76kI6
         2RcV/+FlwBIf7rPQngKDpNSieP/fe1J51pJGchptJZf5XKwaf6WCbPDdM0B7YF2XMggV
         Zj3+0j2+6Yp0QMxosahoGiHtpKntr4AfZsFRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bR0eeytQfv+glll7aoQHEqu8NdP2ZbsHgif8yrcXd+8=;
        b=PP4GC976FjxZJhrQqss0xzJQbZykVt7yHfPxyPEzUTYTrP02AsZndaprxc6dzJFrcT
         1k70BytmxAgOr17dP4CJhE+HTQiIixf7Hfhzz+WBfGfBnLea/tbS4vdf5BvFD4Km2pC1
         VcVgwv1P8PpPwMNJOMFbFms5W8xQx0l7lit3Qk/+V4Z9M7j0AejOK06oQGYVcSgB+qUM
         mZLgN5ENqR+YXsUf7BYObh45UYF0Zce5AbDAJTCIT2bNmRguuJeBUHlNXxvH61vxtoEZ
         g6SY2GWITTU9IaEv6dZSNXq9qmq2OUK1AxyGuAf6b05RROtE1meGNdqOOAHmJJ5jWzdA
         UGqw==
X-Gm-Message-State: AJcUukfHSWldHszLNGeJQbpsKaNaAgSju7N8F34wFj1eYiVIzPbdWOcB
        ZDyZiykCqvU72Ce1+McTjyZ9
X-Google-Smtp-Source: ALg8bN7KIPDQvkcInyzp4AML13melQLbzch2o/v+mWcpv1ZL+u/0DQNe3JNt8SiQ2Nkh3mWcH8M9Hg==
X-Received: by 2002:a63:e615:: with SMTP id g21mr8627413pgh.290.1547107718782;
        Thu, 10 Jan 2019 00:08:38 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
        by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 00:08:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
Date:   Thu, 10 Jan 2019 13:38:19 +0530
Message-Id: <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..27a3da1e3a54 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -383,6 +383,7 @@ SUNW	Sun Microsystems, Inc
 swir	Sierra Wireless
 syna	Synaptics Inc.
 synology	Synology, Inc.
+ebs-systart EBS-SYSTART GmbH
 tbs	TBS Technologies
 tbs-biometrics	Touchless Biometric Systems AG
 tcg	Trusted Computing Group
-- 
2.17.1

