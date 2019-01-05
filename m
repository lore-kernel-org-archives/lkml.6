Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E224FC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC7208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJZ0d7pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfAEH3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 02:29:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36103 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAEH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 02:29:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so18443935pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 23:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
        b=EJZ0d7pU3z4gJ3luqtxOqm0cnFR6Y/svP6seHeGrN6D5WenFUCJxOKk0VJGRiqC0bB
         p7pssvPaglrTPqs6h3o7FM6BRLrQL5yM5PbDTgzI7TjyZIi+DUdkIhUxxvHiXXiWOez0
         tmtExd9B9GDOVDttEHfFoS2oGg2IIVmEIGfFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
        b=ecQ0hqdc26FnxyePko6xUbjkS2GsqHt+zWdS7hsjhOE3JUPD69WHjBNPzFPs9RLxqe
         sFzAnTU50p59m62+hoxJjOgNCvpL75mgFMwpJ0fwRH1J48x8c7WjkUjmnguiGB+vW0ly
         dND0ETM+MiAflN7XigvlBvQi0Qs+8E9zN65IUNYmw4oAg2U823XvjRIZEFW+phTX+q7D
         GZrc543EIrttN16wd3xsf4asFD37vIx+8Ess9SszQ3bbQexLvP9isfofdhdfqk09yvxH
         u4UDGu2QdT1MDmZYiIIV0d2wHQU8mszyO00TjpHAqPHT0ci9EKWiduaO8vqpbz2hU8WM
         hB4A==
X-Gm-Message-State: AJcUukc2dcF5m3gXZdLDe5QJEm6a+pvgWNKZ/t35KUc2s7eyWZEso3uv
        yXC1wra0iZk0c0vRCg1aWNhB
X-Google-Smtp-Source: ALg8bN50gCEXbBa9oALpY2+83PONnRD9xIfyJUuHRcn8QixT5tbYVu/aCEF9gRtHJ+dXNUQY3SYgsg==
X-Received: by 2002:a63:5723:: with SMTP id l35mr22381883pgb.228.1546673370470;
        Fri, 04 Jan 2019 23:29:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 23:29:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller support
Date:   Sat,  5 Jan 2019 12:58:58 +0530
Message-Id: <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 6ccdf5040ffd..285219dd657f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -654,6 +654,24 @@
 			clock-names = "apb_pclk";
 		};
 
+		/* UFS */
+		ufs: ufs@ff3c0000 {
+			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3c0000 0x0 0x1000>,
+				<0x0 0xff3e0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
+			clock-names = "ref_clk", "phy_clk";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			resets = <&crg_rst 0x84 12>;
+			reset-names = "rst";
+		};
+
 		/* SD */
 		dwmmc1: dwmmc1@ff37f000 {
 			compatible = "hisilicon,hi3670-dw-mshc";
-- 
2.17.1

