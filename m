Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C225EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B68218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxBxJhTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfBAPjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:39:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40643 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfBAPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:39:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so3096132pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Cu6Y4NgGPq834+9r8xbAgMcrjgdAO4jdlaY8h/KB5k=;
        b=ZxBxJhTxNyLl57XCNVBfXuPnFgMe8rrcSD6px+9D5r7RLlyl5zmSi0KQ+g852QlXgI
         5ihWhRfII+GH8AGaNZEjVwOBwOZKPb4ZlYzdQ6oJcGvOgX5pB+aVJllx1XX/Iwr9bHX3
         D7fRDey5ten/CCeDMghceNHaqofUr6ubpF9ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Cu6Y4NgGPq834+9r8xbAgMcrjgdAO4jdlaY8h/KB5k=;
        b=TdDhHYY7AkG4QrgjoCm3gXXQobDZsObOD09GdSKJs3qG8W3H99xn5fgwcGdZPtpqnv
         Q6BLHSxUtjFsigjSSSUPz7dpPmfm3hyTZs0RNEZO2CqJISvccJho4B1TowkA3301z/2C
         /2OV3DirYOhSc8sSoMFC0SqaRei/Pv46DiL25wWptYH8MzbQNoTJB+vyX0uozpqHysqV
         nbjjRJeQqoNC7z+3vVfrwIqzA19ECN8BbqxBpdWMptXaKhc9XGXIOSM7Cz/kZTejUKSG
         KLQ/cpC2Vepc0cVqjwUGBLlulCCYwaIAZkkOmuXqgFSRQW16KVCv3OYXjJToNMu7iix4
         vLmQ==
X-Gm-Message-State: AJcUukd+yUKOmaX50vrzPICr70kA0B8Wvsp5puPeooUkh8Hsmgzz4fG+
        4DU4GW7dGQYFq8x99OAL8pGxhTc9Hw==
X-Google-Smtp-Source: ALg8bN6JUmLF3cJ3F+yTU63JFwBLEosCiwp4JunyZHkv7r85JovROQ8QVcsaXfwF0niyMaFadEwiCA==
X-Received: by 2002:a62:4587:: with SMTP id n7mr39482017pfi.118.1549035547340;
        Fri, 01 Feb 2019 07:39:07 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:39:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add reset controller support
Date:   Fri,  1 Feb 2019 21:08:40 +0530
Message-Id: <20190201153841.21903-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index a5bd6d80b226..83950119100e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -151,6 +151,12 @@
 			#clock-cells = <1>;
 		};
 
+		crg_rst: crg_rst_controller {
+			compatible = "hisilicon,hi3670-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&crg_ctrl>;
+		};
+
 		pctrl: pctrl@e8a09000 {
 			compatible = "hisilicon,hi3670-pctrl", "syscon";
 			reg = <0x0 0xe8a09000 0x0 0x1000>;
-- 
2.17.1

