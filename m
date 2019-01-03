Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A296C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44559208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vct3TbRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfACTYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:24:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45446 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfACTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:24:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so17106562pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WE0zw+tXRmMImNTsNS2inSEnAMFg2bLezjCGkdLaiFc=;
        b=Vct3TbRDFdQzVGvvFQkqoY496Jue38ZwHLQjzVcoMrkwNr2JMRXDGoJaETa6wpipoE
         8Nghcw920M2cy0589otpMSAtMbWpTj2Ki6c9c+73dq3KqcGvud+0xXT8O+DyCNbZF57Q
         QkNYevHr4Ml6iqG/3l+J2NZOvwkCzQNJG+3sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WE0zw+tXRmMImNTsNS2inSEnAMFg2bLezjCGkdLaiFc=;
        b=irv8hJyir2SG+GwFio/qEYllq4HMCmDWht961p9OXsX4d0xu9d3MEq4aasxcOp48Xz
         /YmNelzpcrD0A3DVjF0Slfs9HyCZdjf+AlA6IZUc8NxOen5alURSxBejgbavqSd+cT7K
         qTENL3kul+5klo4BNxkM1kTjkeT0bqpmdZqQDGpSFhaU/NcL9fiRWC4UqLnOSEH5wZn5
         JE4/QKp3JsuFUhrXpplZhU0wVvDwqypgWNwPHgdis27uj70odwjhly3Iovu+YpMoieNL
         iue5cnWVnBQGbRcg+F+gV+GzrEoAKrGw2L1Fg+EnKM+ysUm2b8OSsmi9MKnkSkZUzw9Y
         7l1g==
X-Gm-Message-State: AA+aEWYJyQOzZVnhFzxsBu5QnnlGzbBxa8t5plpje9tVX/HgOykvIvN9
        LwdEtZV6Fg8bMOrUxV3pgMrs/BLGK14=
X-Google-Smtp-Source: AFSGD/XV25lmWKp7kPG1wmCi4JG+1Fn2BhvKl7appWWVNWLBtGxLytDETjHThSZkhkXgr4VpVI5Vfg==
X-Received: by 2002:a62:1289:: with SMTP id 9mr50013199pfs.102.1546543451758;
        Thu, 03 Jan 2019 11:24:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id n21sm80807415pfg.84.2019.01.03.11.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 11:24:10 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date:   Thu,  3 Jan 2019 11:24:07 -0800
Message-Id: <1546543447-825-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma0 references for bluetooth uart to enable dma
for bt transfers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I85d36cc492a5f392cde214b144b19469e951585a
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index aec9e37..fa15a08 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -319,6 +319,8 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
+			dmas = <&dma0 8 &dma0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

