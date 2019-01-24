Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D5218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGm2Ozq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfAXUYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfAXUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3139713pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
        b=dGm2Ozq5crp8+eZBR16Xeq//kci+lmx85Knj9jwZD4b+AHP0VpEYFz0Takk7S5Iaqy
         Wfq+Kpf2etqcgQ16ATmrRPKcvbtm3KUm88Gvh3qP9JL+N7OeSefxoPObqKJziK+HvHoT
         qhcVqvcIfwfAAdLAO1uHUSBFmdIEQAEXYuYNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
        b=kaU2k/emcMGMP7aqRLwobB4nWJX48VkS8v1CNpTVjiPqEUb+fnhisKJeN6rkD5ulJy
         HhFxiBdKigHiaO92hM0K9TyDpvKBEP+kFFxoOya/pCDYG/epSLzJXc+MXu5ggMzpmtTI
         WwibT4cxnj/OgDSQMDKkpfydq4Efm9p7wfs2spa3g7NBE0O4c8YX+5OSx2kfTw44OdWg
         t0V7g2yNCOnzkC0mv4nRBbRtQcUpz+d1FVwhi8EhBUNX64p4TCqDGZwBJQtIw1PpSaLi
         yHYt3h/Ici1YO503yVciC2OERlNu8xlSfArr0shDniYm3LgwWoUxoTKy7Wb0CVK/mGBh
         u//Q==
X-Gm-Message-State: AJcUukcDqU5ZUNafjTIVAD8cFjadWXG+oFvMH/WhXpGjoqZ/6Gjmdwlz
        i6sP2XkFEoDG/nTkrqfjNQgfYbddkHh2oQ==
X-Google-Smtp-Source: ALg8bN4BK6Qul4gBOxPwsPa1bw2asGXGLk8N0wxFWhdu3ikDvvh2cqu12xyZ67ramgXwQ6tNjk7GZg==
X-Received: by 2002:a63:63c2:: with SMTP id x185mr7236745pgb.374.1548361480562;
        Thu, 24 Jan 2019 12:24:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:39 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 8/8 v5] arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask
Date:   Thu, 24 Jan 2019 12:24:23 -0800
Message-Id: <1548361463-28372-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A undocumented and unimplemented binding got into the hi3660
dtsi, and this switches that binding to the now documented one.

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
v4: Renamed to dma-channel-mask
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 77a7135..8e48f42 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -560,7 +560,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			dma-channel-mask = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4

