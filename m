Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018CAECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B778920665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT+X5+5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B778920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJZTxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34199 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJZTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so3976304wmg.1;
        Fri, 26 Oct 2018 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGIL//nMYgHHZ4GYaDWliMktQ6b/Y8DmGZjHhB9Vabs=;
        b=aT+X5+5n+Khef+VodO4SNQNxSz1lZ1cCq8xACFcpM/UNyM1170cbq7vSve6aHR2iYv
         NuJFGQ/kmuDTt8TUePTHfjPMriDBageC/dh8yAo9voZs9nU6J+EPqScXuKw1FXIiQosp
         ErjjGk6wMm2TiSUzsc1UmM3KQskuV2MMnuQcWbzObPLUNuQrBmjhL2Ib8IZ+lL+okXPD
         X/LkyqJjtKlAsGgaCkn0yAwVE0nXRw3EddQR1uuNSYrxO4HH8GgwIy1wu2tbetXVBY9x
         dOe7hOlh6DXkfIOpM4ri0R2YvMhtLz+CCaz4LEQ5b4gNPLBWqaKBlZ2151SFVkTaqi8N
         vn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGIL//nMYgHHZ4GYaDWliMktQ6b/Y8DmGZjHhB9Vabs=;
        b=Y8yCk2o8hfE0fCrv5CMJfBuB1l3+QRNU5DMY1tqHwUnBPUhzr/hCVVZWLYf9L6q9da
         EhppJD/YmU/VjXq10I7Otj/66yMWp3p5aD7J+VqRcXynFklpg0EHs7nNuvnu530cSTTx
         Xxd02lsuA912pqufKaTvCsYvONYsnnyz2Q6unFGhJrp/lFFaH+ZVkxTbBks/sxiGKZk8
         Zlbgy84GiQhj1fs6f7et6TNtkvAUnvUuWecXtYOEEXBCmMJ+7x9DmExElaNlam9swWYI
         RNgHnKxdzpSGQjIkdpIYEFyOixtXvrPbUxbPjS+7osYUGStvD2Tr4B9Q4EQCskCiVaFF
         dxXg==
X-Gm-Message-State: AGRZ1gLaOb9q7vI2g5jJsD4uWDqgr7bH2pjFBAjLSpFoZFh0XqgF8Pov
        gHPXS+fYC5xvd8GP3ibPTXU=
X-Google-Smtp-Source: AJdET5eUk5FWj/86ftupZB1zWrF/f79b3bdaiBZplckhB5viEx5odnwOl8Z2rPmv8lC07wOxxrdwkg==
X-Received: by 2002:a1c:890b:: with SMTP id l11-v6mr2855358wmd.151.1540552616866;
        Fri, 26 Oct 2018 04:16:56 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8553896wrt.77.2018.10.26.04.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:56 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888
Date:   Fri, 26 Oct 2018 13:16:38 +0200
Message-Id: <20181026111638.10759-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

The Tegra Combined UART is the proper primary serial port on P2888,
so use it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 57d3f00464ce..fcbe2a88f8db 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -10,7 +10,7 @@
 	aliases {
 		sdhci0 = "/cbb/sdhci@3460000";
 		sdhci1 = "/cbb/sdhci@3400000";
-		serial0 = &uartb;
+		serial0 = &tcu;
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/cbb/i2c@3160000";
 		i2c2 = "/cbb/i2c@c240000";
-- 
2.19.1

