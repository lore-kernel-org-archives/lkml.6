Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BDECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EEA20857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM4+e128"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EEA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeGSOFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44091 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbeGSOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so7448618ljq.11;
        Thu, 19 Jul 2018 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVKbXczfv+RzlB+yL++j1SAXIAyX+n3XTuzqDXSqkC8=;
        b=XM4+e128G+4dnXkKsRga44iXN4XFPBPWDKXDIf7QfoZPuy6Pj6srjXyFl0321kmGyx
         9U65epQDzxQ6UosSLzx2PViJkIFVMpIm6bTAhwCezE1FVmOXj51oYCLBB1A/27hBRfkU
         CtnzS0AfwIkSd/Sc306hZv7V+feHpTLPh2iRNAeD9r080skzOrDZwB7d4jMOth9nIO+w
         YpuIT6uP3HSRZiG31mti6bK6QnEPmymCIKzBQDGVD19IHy8cV3m/YeXelsXBfWdkfsas
         YC1ZpwLeIKUKXSNpsN1PqlEi+k3j8Fn6nE+3z8pNg8e3CraYnAknMrmy/zcNCbdcdt4K
         c00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVKbXczfv+RzlB+yL++j1SAXIAyX+n3XTuzqDXSqkC8=;
        b=WUigv2dtdQC73onsbJbrDrOW8dl/AZ3KgWMhIIfUlPLRR+R8K7gwpUxVonmFVb+8wv
         qA4n4krTE0h3hV4Js6awJYrYTfGsWmiuSekpfpHoB2p/yTw7cP85br6V1/JafX8Frpns
         sK2Hkf+WTDCdbtBxXgtMbXKR+imweWtQnrVAE7y295GTq/19zMRiYqy3Frjf3pSbm7FS
         xRe940M+ZDqASLc0zWD5KV417ogEC8k6YENWLAHfXWLNALUVBH0l9BpqnDoYDxbKZlw7
         htk3rBqtOX+bFRoI22Wf4nHd+Ck/5FmqZazcOuCDYrd6Uj6YEV8z1qaB9fRhhRPLnUpZ
         qSKA==
X-Gm-Message-State: AOUpUlELzk6IDPAGFUbOwmjrXSbjZVD0Q3Go/YpTa3py0s9x9n3hLTjr
        7d1aw6TNKYEMVjGdiSPsRA4=
X-Google-Smtp-Source: AAOMgpf+kkIHPbx7aHbpOO5Vn63r7aviH0ihN99p+wVaaVh1KIWgkuTj4NCfFx9Ga7uY4uZmW9QDqQ==
X-Received: by 2002:a19:548e:: with SMTP id b14-v6mr6414020lfl.10.1532006555250;
        Thu, 19 Jul 2018 06:22:35 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] ARM: dts: tegra20: Add interrupt entry to External Memory Controller
Date:   Thu, 19 Jul 2018 16:21:28 +0300
Message-Id: <20180719132132.16153-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 15b73bd377f0..9eb4163a4390 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -632,6 +632,7 @@
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.18.0

