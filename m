Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBF1ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809B20838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckPFmVEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3809B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeJVCrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so17962134pgq.4;
        Sun, 21 Oct 2018 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzcnMm5MEDydMbEx+W+DWRryKWN59HFO0vTKe29ydcc=;
        b=ckPFmVEipcNvxUMxLDexDjUEmV85TPhMYIBI3QzXNkEb5kG1UF+FHfgBwLBbVHxxYN
         uHGTg6H0Opg31TK3+AJKKRcYASczHZzaoV9Pfy8l7r5kS4M55SelkCKsqXMT1VX34etz
         tqkJBa9J9JgWXTo/zmsfHCNJAK0AY/yh2FiSTzoUmKsrEG8zbZDw5I4GaPQKx/ptNAuM
         2SsESpdzxPXdbhrbrX3ZZrnA6v9eEk/hNb+acqMiYknhVidB2bA/I3JcXroDsLKXdcBy
         l6/+1NflnEvx9SYadDv1hFwpRgpfKc6u/agsgsq8KLllHxzgHJZnIHDGpdv3N+RKDhwb
         bf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzcnMm5MEDydMbEx+W+DWRryKWN59HFO0vTKe29ydcc=;
        b=XUpinZQosdrHKj7hNshm5ChO/Fx29Kg2ACH7j1hqpEoTh9wejuG7y6kgJq+ZiVEYAv
         P1IoiLglKDJp9sUT/ncnY0IdeiSi3KPPCJj/IOCATcS/jNUv6mTsbEjgUeWRqvDplUJF
         UiyTRIknfY7Gf22YeF1a3QTGiDZgpetiirtACguuWeG9UbJIdCbYm3CNe5grbwOPmYbE
         1+fd9xR7q/iMX+0/EseDWCKL6snMyp5sUUo25/P8wR3gvnVLLr6GerGEm9mBkuF11Sp4
         poMlqsML9dmmVqNjEf0xzvNA7Ljf2a5YMaccQwp8CPttde9kR50P9i6pHYynxY4KMggR
         peZQ==
X-Gm-Message-State: ABuFfog+Bm23oHDxXZLldJYkBkmf8mdK3Y324qeEuSqJIAug/vdIEfSE
        EG2sJQCA1SgDPm8Vu+6OrKA=
X-Google-Smtp-Source: ACcGV63/vOg2C2WqBLnnCNnJLfkmif9DKNcImeJJ3SI4tIm77yx3OSInxQuRJn9Wxr4Mg8FvQA0cFQ==
X-Received: by 2002:aa7:8643:: with SMTP id a3-v6mr42625722pfo.247.1540146727945;
        Sun, 21 Oct 2018 11:32:07 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:32:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] ARM: dts: tegra20: Add clock entry to External Memory Controller
Date:   Sun, 21 Oct 2018 21:30:49 +0300
Message-Id: <20181021183052.32023-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 526f623f201a..dcad6d6128cf 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -633,6 +633,7 @@
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.19.0

