Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ABA20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an2949Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfAHUFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40959 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbfAHUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so3891556lfe.7;
        Tue, 08 Jan 2019 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
        b=an2949SnqLLfU9Rs8eDpBYidaG72QIHQzb2Ogy6sXdZ+kOrIYpD8CNdBAwAd6sdQIJ
         4t4Xnw8T56Y5w03EzA4iuaOYaLQ65QgHyIw3gKOmeifjc9XwchaEqtTbumVGgMyy/jr4
         H3Vm8UPEV3QxdwS3LnsWHD8lmbOd2TMuFbXtFyha3N2aVXCKBtLJhPIgNSdZy69uret6
         VMzD24DhRQUgua0SNZ6Esruu2ykCyI0OlupqV0jqC6I2Gp4rNeeZuqQDI44Uc1lqZ6CG
         Fl4xIWU+Y0ESq6R+TaQTZwUwuUJH2ZZTNO2hG6JQt+12KA/SUjX0zyhxC0vfWAT/OXV+
         AKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
        b=tn5yJVuRCRLftmM1kKKoMFT1cNJMJnXmsDp9IJj0IzcWPYBIfaFlCePlvjZ4aygH8j
         niONiR6DN46rFr9Yoggvu15D80m9dJjfnVpKFSqLxcKGMYREUrQYgyRJyYag99gXiBw6
         IaZHtuBNGoSJ0NcbVNr5nxl2agIzGhEPE3hxgg8yWmigoylClIskCsgTTm0L2W7VM4wZ
         IRx4y1DyP6l0zCJcEZi9TVHZl4vVD+O0n+uN4AIscJcaj8oGTkncJ4h/vmFVhrTnzOog
         8eJ4McB3dZHAg+15HNCIzcauqIDQJM1o1Fs+d/dat7uu+yHEc3kEhOub4nXoxV8CP7Cm
         UoDw==
X-Gm-Message-State: AJcUukd5DwM21iqetKqWRIbcVJnAT7Iucgm8pdq2LSlyw5Tbb0ebUhFK
        RlF8TEFsUoviwpFnd6JC5Uw=
X-Google-Smtp-Source: ALg8bN46YCS0ZU8VbXtL9n20S6AqiEI4hOlXxP6D+RREGvAHL54MhaFThRMF+As/6EnUqsBWpGg7AQ==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr1823599lff.88.1546977923517;
        Tue, 08 Jan 2019 12:05:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id y23-v6sm14486768ljk.95.2019.01.08.12.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:05:22 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/4] ARM: dts: s5pv210: Add dmc nodes
Date:   Tue,  8 Jan 2019 21:05:06 +0100
Message-Id: <20190108200509.30494-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
to work.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index e9613418228d..2d55a3a6e79e 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -25,6 +25,8 @@
 
 	aliases {
 		csis0 = &csis0;
+		dmc0 = &dmc0;
+		dmc1 = &dmc1;
 		fimc0 = &fimc0;
 		fimc1 = &fimc1;
 		fimc2 = &fimc2;
@@ -521,6 +523,16 @@
 			status = "disabled";
 		};
 
+		dmc0: dmc@f0000000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf0000000 0x1000>;
+		};
+
+		dmc1: dmc@f1400000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf1400000 0x1000>;
+		};
+
 		g2d: g2d@fa000000 {
 			compatible = "samsung,s5pv210-g2d";
 			reg = <0xfa000000 0x1000>;
-- 
2.17.1

