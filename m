Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EC12244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnLN5ITV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EC12244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeGCHVM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37458 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id c11-v6so705979lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTDxugtZeyy+P8tfJ0xzeSLjoTQx+5c0GjmgeObjrYc=;
        b=fnLN5ITVuG/lobcONvxC9fGoAwBonf3xWF8MEZOFHZiqDjhme/edgjdcMxZh9p7Ov+
         5IDXMjWQypE+xGWfD3vcWFD8eYm6lbqD2UBgyLY54HAyANpFS55+8O47N385ipnCmZ0U
         Dhde4pE2iGTui1+DaGhK0yM5pfPWHij3OANFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTDxugtZeyy+P8tfJ0xzeSLjoTQx+5c0GjmgeObjrYc=;
        b=fNBy9yH4k+scfjNTcp0rOzIDPskWXJ8QZu1A9perz4utLyVNORrRZonRSEZnFOtiFZ
         +3ub/LrDyJ8wqRFjL3ybYeO0LtGpdivZeIHZW14W8s+9ddmtzkZP25vuXXWyPHCO2dcs
         b2ENVj64+4OU7UJPx+V1d2X+Ms8LMpod+uxebfTEsJLGtv5AdIZk+7ycUvHC6fppnwoR
         lYQzFr0QkYfdeGm49V7460noKHvWWl+pB04BLpBlupNrnx5iDUT5zy/P7kUBQCp8T0Pu
         4iJR2+eaj9ModRiWNmb+1gx2hzb1ak3vcFv23N5CUh6+JeTxC7fBlVZdv1uEWZ+xHPVA
         hIvw==
X-Gm-Message-State: APt69E38sNA/KPHuoOvYpDGtUNkvli07VKlSbRz745UMRMH4lJlr/SLi
        PkUqvnYfBtCdXlaiBeP2nhtYFA==
X-Google-Smtp-Source: AAOMgpdRong3bDfARZURwpuHEyPBBHlx1uBbfdTqF1/FEEuOsThCJqUqswYpEOo3XB/VXmqCG6pidA==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14-v6mr17604745lja.20.1530602467463;
        Tue, 03 Jul 2018 00:21:07 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id k10-v6sm70519ljh.5.2018.07.03.00.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:21:06 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] soc: qcom: smp2p: Add select IRQ_DOMAIN
Date:   Tue,  3 Jul 2018 09:20:30 +0200
Message-Id: <20180703072034.20213-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smp2p.c: In function ‘qcom_smp2p_inbound_entry’:
drivers/soc/qcom/smp2p.c:317:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba79b609aca2..6e063202ad0b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -134,6 +134,7 @@ config QCOM_SMP2P
 	depends on MAILBOX
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory Point to Point
 	  protocol.
-- 
2.17.1

