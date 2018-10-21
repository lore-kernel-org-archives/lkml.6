Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CBECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E12083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsPlYbZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E12083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeJVCrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36041 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so17974224pgv.3;
        Sun, 21 Oct 2018 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43RkB7tCNCYCKZ7WhLMuDOHdDa1VpkXWnfifk+cmylI=;
        b=MsPlYbZ/0XCygAYUdeW/bpv+EBEmdw9Q3x6W6qH0mXRSbomIiINfjyQZN2/4R98IuI
         VA6G5uKgRXgJhbA1/adD33E7/vg378VglzBWXT3FMtrp7RUKw0sWmccyOHpo0Ufgt9fF
         l/P1UPxsdMNMoC8vpdsnVOKfnU796lkIF5wW/sEP/Be1QDKK4B1yHI1cE433UKURNX59
         KhgNkplINY6ieKDRkJ91/F243RkzzgPChBsGm/H6JL5ORAfFaPiQkic70cUl7/VUui/I
         EttL85I0AINYz2gK5Txtb65PQtG47YaOouWfDbv7Kj7TdyyZfkNi7qNK6oRSEciPl3aw
         sENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43RkB7tCNCYCKZ7WhLMuDOHdDa1VpkXWnfifk+cmylI=;
        b=nJ0hby7LUsaw2Y+uOF47DzJHX4Rg6rbnJGJYGwm7pIzwuoHa4H8Quby00vhU5uXjHX
         ivSqtDakMNI9OH11htTivgWkCv6DoBOc+XMWsrNiuW+u6vgvWU885Zb1jeJcIkolWZPy
         OD1lTd2PdogzVfH6kXksWeHvdyQBPFJykzDMRj7EuisTYAWeNehQomH2JNjFr5/RZ9U3
         jhAArnxSeOpTR8Y9g2PL1xrE1cIVuDp2uPSWx8L2TicitNvEI3i+wY7IY3t6vNgW73Xx
         MjURjVRpeqOyDXGRPKXFllk8174oNpYBpDoApm5OwgnJuFlXt1wirnoKHawp5psye0hS
         tucQ==
X-Gm-Message-State: ABuFfojTxZ9jqfwC23KTxU/e54Kouq7hKwQjJ6fQAe/kxFtXDNNUz96q
        UKcaxBShFGTrCl9bsPBG5oM=
X-Google-Smtp-Source: ACcGV62YOyG5p1mRHvT0sTUnRyGawdDBYKqV/srie1LTl+8ssDeIBXxkdoxDHXyaVlAzVPSyxtaZ2g==
X-Received: by 2002:a63:fa4e:: with SMTP id g14-v6mr40245033pgk.18.1540146709566;
        Sun, 21 Oct 2018 11:31:49 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:31:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] dt: bindings: tegra20-emc: Document clock property
Date:   Sun, 21 Oct 2018 21:30:46 +0300
Message-Id: <20181021183052.32023-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embedded memory controller has a corresponding clock, document the clock
property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index a6fe401d0d48..add95367640b 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -11,6 +11,7 @@ Properties:
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
+- clocks : Should contain EMC clock.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -22,6 +23,7 @@ Example:
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 	}
 
 
-- 
2.19.0

