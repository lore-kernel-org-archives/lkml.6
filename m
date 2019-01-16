Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F58DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2520651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QA8zw9++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbfAPRLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:11:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39393 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405694AbfAPRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so3354677pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
        b=QA8zw9++8TaSkJyOW1+1y02JDAdzqu0K+B7mT7N+0Ct1Rt+8j+7NPvxiy+7Q/e5C5g
         IGNE6QHPW8is1aNGtcopNzRrWUsIeKkCB2OftthzCuf3eM4LRDyLMrdlW4dzHFcEhvgI
         JlgIpAGv4xtOWdySiMiyjPUYbdRXp9aHgRVqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zv1p7S/mFrTg6FG0oPOD5Dt1Uya0EvieWRYCNbiH1Ds=;
        b=ubhsPmOWN6SssOsgsncM/pTb2iUqXUu3N2nA3roaLTTB+jOpJLc2OTOhQYVybOrEkd
         Nb/8PoEluCWaYzpiodvkARoL6wi3s9XF94tggDRwIYv8stvI+PcMygPhXRJF4jjLIrKZ
         en96oI7njAu0+DLUbu4RZpMpSvV8pxVUAasYWbqJMHhxdFR55O2SKZF3fhu4wUaqxsSt
         9SpZDuOMJmUDzrclOJqltuTb2GXi0SF7310hGhZ95mwyDg/wc7Iq9TLi5fuBrYda2MN9
         u/vl9Y3H74sqqMFWQZQBECCxSSmBykBLhS5tvKsRCriBc7X3s1o8SmctYjHOPJUcZ2p9
         In+w==
X-Gm-Message-State: AJcUukf4a82Y/Q8tAUimU4xIIhb2Zvh7VI4AmnFGoY1s89PBSzpcs03H
        ng4UGMM2L7c4sa0XfpXAlYqUVM0hF8P7gg==
X-Google-Smtp-Source: ALg8bN6yZzVWGRK5hPXdskoOAhCVDv/SGYjZR1jxNnlHFv0GS046diATiQm+voyIP4EEX8oRjCsjfQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr9843070pgq.58.1547658656302;
        Wed, 16 Jan 2019 09:10:56 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:55 -0800 (PST)
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
Subject: [PATCH 8/8 v4] arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask
Date:   Wed, 16 Jan 2019 09:10:29 -0800
Message-Id: <1547658629-25378-9-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
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

