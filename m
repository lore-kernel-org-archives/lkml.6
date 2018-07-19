Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1216ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E88C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdJEiruK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E88C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbeGSSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:30:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeGSSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:30:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so4423878pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=DdJEiruKOu80IBaZY5v8UzN+G4Kho2QABVzOkkCT/VTlCIU4Q7/BDlXzmP9Q45enoY
         SUaY69iSCa3kwQmA/qhUVtdsIdvGP5fKSqECM6+N/uczla2ocxsMhyyiSfA9z8pusQ84
         QHmmX1Dh1TAirWY9QCss/DsFVgxKmILaqaTE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=g+Guh0+KtvInheIDP31ZGsVFd469SFkxJdaHPgTUU2Ptqh74+K1SCvs/Q6ohz+El7M
         xbcYbl3Nuh6Y1iPRrkYQpGViLzZrSTeevJPLHEOuAP8Enqe1ux+VAamiTKWSu1YkBp5B
         wELbFCkcNeXbW0HB/Vsta/EUTUR5nPNcwg9LSih2Mdw+t6JrBl4PgFH16sVipKVKglWi
         1nzJXRVKfQzlo5bxcluos7I0Sb9/dBmuhF6oGOlZyoQ5237EWN3/ZUX26BEtzEnpiRB/
         jftSmjLU0BhWokXzJj1FzOFnazH//dyicHnIpvIQkawZWqLlqa4ty5fGvf6mu3OoI84X
         4TJQ==
X-Gm-Message-State: AOUpUlFt4PRNpdY3eguznRy39RTeE6H6X8zQVpUp6imgI5QTwhyNcNp6
        NyUqN0jikClsVFEAbo5Qqr19
X-Google-Smtp-Source: AAOMgpf6AItT0q4OHzpx/3jGjevpj6eAMqc/hvDAXJ+bxHWSVhidb4UeR06/c+UTROVdor9WMH3GLw==
X-Received: by 2002:a63:5e45:: with SMTP id s66-v6mr10902714pgb.151.1532022405832;
        Thu, 19 Jul 2018 10:46:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:b056:55fa:fd42:61de:739])
        by smtp.gmail.com with ESMTPSA id h2-v6sm10114639pgc.90.2018.07.19.10.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:46:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 6/6] MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
Date:   Thu, 19 Jul 2018 23:14:05 +0530
Message-Id: <20180719174405.7210-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semiconductor Owl I2C driver under ARM/ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b54e9ebc6f..5084c62712fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1145,12 +1145,14 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/i2c/busses/i2c-owl.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

