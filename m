Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB02ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1D20838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaHoBLau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F1D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJVCq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:46:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:46:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id o14-v6so2243013pgv.7;
        Sun, 21 Oct 2018 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35rNHoeo4VYeNYoLdpst+BGGcOblA3dvN0XNHdaurVk=;
        b=LaHoBLaubLA8ZBDwbBp8LLUfttMiVKhvS148L5vH3bgHEkt0Bh50GsvQ3HLQMZJ/R8
         Qi83Qn3bUn/UD/O7oET672l8ak8I2JJPmBl7T4Alm1CopXy26q+Etpm/REMG6f63nPpQ
         bvU7SBDt2eCuVLWEaX2DmfERxhPKz//9G4RghUZwgwS7ClvKbBALiuteoMaCVBlEY9wy
         qExVBgx7OGn1xP8s+yml3pkhShMqA0Q5lRY/9w6QjaOEsG4Z+YDQMt4iolum5Sd7Iwod
         UmxCyl6g115gyaNNTl/cVMxqPadxNotfYUHH5BAjRPjHPUZ2Q7kolG49/+QNiJomTms8
         bZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35rNHoeo4VYeNYoLdpst+BGGcOblA3dvN0XNHdaurVk=;
        b=F/jEL4AFfdO6zPpVtw1TyWETgf0G08hM1YriZTW6MB3ocmjWoCzPN+GAIeOGJFM6fW
         UF/fBflRDYVYxayqR+CYSo7fUpCHy7Mb0twIvynH67WMMElB4Wt5J+oZMcYcRCkckxCn
         Vdy34B6LCJIyijC6vO7V09X8pKtt+xSUFTD4JUKDgIGV8OhXSaYvC9TwJRupqypwM92b
         hi6CyigWoyIxbZ6g58yHH4aIhSL2akJ6Tek0cttB7ZIhvZkJsY3doUsMnBRSml5wWPgU
         WvXUx6wWHNWqqWrGg6eETbDTNf3ikYEEK99cwdoDk9rrGTJ8NmjBeOg9gI5rKa9VSqft
         ZDuA==
X-Gm-Message-State: ABuFfojl1ZCxNjeM7iWTlNamtD62I1rrhmrmYjd7ZLduq3JGWrR6qQEc
        QhGumm9T9dxII18eFazS8rk=
X-Google-Smtp-Source: ACcGV62HMDVtNARBcws5TXKZu2bcIOnVwEvZWyl7lCdftt3wqZPJdzBL3aEO1n3MPHWlPDBUZL/UpQ==
X-Received: by 2002:a63:d502:: with SMTP id c2-v6mr40309929pgg.324.1540146703381;
        Sun, 21 Oct 2018 11:31:43 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:31:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] dt: bindings: tegra20-emc: Document interrupt property
Date:   Sun, 21 Oct 2018 21:30:45 +0300
Message-Id: <20181021183052.32023-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.0

