Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EBAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D120874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2Yef3lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70D120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbeGWHKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:10:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34588 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeGWHKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:10:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so11484040pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ydmpnNQYPJ+WI+Vy9yUwgfnF1GS46OKvKnbkAGAw+rc=;
        b=C2Yef3lhJPhCJZ03Au4XX2maTBZbkj4pUdstpxyZcARXLS1NWn4k8tU9ARLAi+Zkc/
         kKEfGoJnCOcMn5Af9gCCsXAe9/h6PXhGaV6IUelmKjoRDyA989dvXhKjt08r761OdeHR
         oOkDTzxywL8AD8b9C5c7khBd2oVp/qx3kJe7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ydmpnNQYPJ+WI+Vy9yUwgfnF1GS46OKvKnbkAGAw+rc=;
        b=VSCe2RpbSC3V2bo+5bq3t3oE4LvhEo3L6fFFz7Ll57N1tZ2INIRSUiRwVPtUn5cnqp
         YB0yxKuPDrLbz4V1eDA1WjGjPfS0xWjTJ6SkwtS74ka+EWPilAumC1hkEK3dgMxSkpXo
         Q/lBZtw0PqJOoEa4/wGoecWp6wN3nPo3Y4xkLgDk6xMlzOK2hz9PqqvBak/CERIwkqgF
         5La1K1Vaa/MhVmoIYiERa2cvekAbqNsAOdzfmBXSa1tDAtYG/96RS7vUXHQRrD63uEl3
         MssGFEoRhkKnyuRApDGCfbf4KhA+3XV8Mg2s03kYBn9QLbD94gFoemCZwEkU8MOOVCi1
         CPjg==
X-Gm-Message-State: AOUpUlH+h3hMRQ8R27s+GnHCGSPbTrC/L9juQb/hFJkO3MlVwhvP56fc
        Q+tiM5t6kCzJqj3V4Z3C/acT9A==
X-Google-Smtp-Source: AAOMgpfI2NGdBw2z/Mjg1CcYN6GhLUnkheioSwpFoyLAuAdSWT1qjBaNONo8xVSV/tb3c/ralmZE+w==
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr11272828pgh.216.1532326281553;
        Sun, 22 Jul 2018 23:11:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11972303pfk.132.2018.07.22.23.11.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:11:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/5] arm64: dts: sprd: Add SC27XX vibrator device
Date:   Mon, 23 Jul 2018 14:10:17 +0800
Message-Id: <30609aebce340ad7051323e45f989db80811e6e0.1531881619.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the vibrator device node for Spreadtrum SC27XX PMICs.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 7d53ca6..650bd68 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -57,6 +57,11 @@
 			#interrupt-cells = <2>;
 		};
 
+		vibrator@ec8 {
+			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
+			reg = <0xec8>;
+		};
+
 		regulators {
 			compatible = "sprd,sc27xx-regulator";
 
-- 
1.7.9.5

