Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CED208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdj185o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CED208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933859AbeFQO7t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:59:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44681 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933163AbeFQO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so9283130lfh.11;
        Sun, 17 Jun 2018 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0E1oKwFdB0/Kn7N4eiV+FcFKrKY1Xjxl6IUgu2EF5Aw=;
        b=cdj185o0LfO0KNpw0FXKZWzDwlCNad0QQj+DeqfstGFpbyXbMhKQzWWbRgbBQ1V/I3
         kZkQeA4aLOD44FUH63PQUaCLdbdZv+UpYPSuPHW72racJ5Ydayvbv13CBX8YeLSnGFxf
         5p/zn0jsExzfOL+uQA+rQKbAbuNkpR7bqOfTAfdBJr9/VKBbs0rYcmnlnADPYp6ku1sr
         X2+8+MSWeHZqbSxgFHuW++akc57k3HzarkwjXxn6AHIipUzht7U4u/U8+00Pqeo8X46q
         r5cK482YgDI5nj1ejVn6gDw+SPep9l9F6a+AsusNi+WmIIwzQwgg1ZCCCDHCBL/5+gJI
         B0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0E1oKwFdB0/Kn7N4eiV+FcFKrKY1Xjxl6IUgu2EF5Aw=;
        b=p/qHQ6hmLcAUcnVe098guoanAQKpz8EjlDktMuutkYAG7oXmE87clRd29+9maVY7Fb
         y9sVOgfG6lGJ3e7YPAisgR+jOzng9rS4zfI7fvjMGTbApO7bmyNNxHcwE6KHPyJCCU2e
         83v76tBHzEKny1AYdn09+XJ2/tY44jnh5RW393xJtuVWa+e8Vz75i33TVWaNyJyM3vI/
         KIwMaunaxXFne4o5eiRtGsqtabqynq7KDqQFtAVclegYZJxYnAhT3YgyLlzvyEILctXd
         MJ/HhTuN+6MmSF9UmAJT4qnpswtc9GAEuA8afs37cEWzvtNsI7pyqVWHShEOnCSozig7
         mGdA==
X-Gm-Message-State: APt69E3aFhktIrUGN9lvfiqIRhK3PTJI6d5YrI1dvQO2OXoWFEfSUUes
        WErRRQcRoyumBw19acWJUwo=
X-Google-Smtp-Source: ADUXVKLhIHC23a7+pl+1foj0LzfuIRsOD2/tr/h5YGmDPY947FLD5Jlh8u2LehOTPL1fp6DQtjHwEA==
X-Received: by 2002:a19:9c4b:: with SMTP id f72-v6mr5593378lfe.119.1529247579254;
        Sun, 17 Jun 2018 07:59:39 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] dt: bindings: tegra20-emc: Document interrupt property
Date:   Sun, 17 Jun 2018 17:55:32 +0300
Message-Id: <20180617145539.4758-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMC has a dedicated interrupt that is used to notify about completion of
HW operations. Document the interrupt property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index 4c33b29dc660..a6fe401d0d48 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -10,6 +10,7 @@ Properties:
   and chosen using the ramcode board selector. If omitted, only one
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
+- interrupts : Should contain EMC General interrupt.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 		#size-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
+		interrupts = <0 78 0x04>;
 	}
 
 
-- 
2.17.1

