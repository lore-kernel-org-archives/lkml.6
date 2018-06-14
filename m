Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7F167C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34025208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxBQ3F8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34025208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964846AbeFNLNq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:13:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45221 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbeFNLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id n3-v6so8763833lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6zw4wLJZVQHCaGthfXT2V4RF0fCTGlqbZ+/633hWcY=;
        b=dxBQ3F8rGOgvJmtostTUxuBrLckfbm50oyKGmxVqwIxdb296TBd6MAFRuf0unOTzyA
         vQxXtiocYqqIiciH/LHkF4TahsTciJvrCc5+z2tQdysecHYzGSUTCtzV5GSLIUp6OozW
         SBgfoNhyhjpDyJoFWpniCbbqUmhQltd1gO1B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6zw4wLJZVQHCaGthfXT2V4RF0fCTGlqbZ+/633hWcY=;
        b=Qkwf2UNj4SSADZZKEHVLNDW+F7JlQpcr3MPTTGcM2WqPzazbm6g3t/PuyO1DL68i3p
         vlozw8HUcpad/f9MI7pcPEDN2IsGy91aMP+/ffrDV3JTXMryYZ0Ngt9fLudeKzIr3uoi
         REPoWkG5Diq+WyFXQEpJ89LEaFk96tyKyBUZa4OK5Khi/uMVxN1KGqG5vNf9IdL8fed4
         UI7YeCunbBkC0xpe/r37Q/1/Xi2bhgOTPfLvOqgc/o8ij7lQQARu1Vhs+VGNRFxEHA0J
         9gjZ8sUcUf0j7shrqQxM4vfquX+EY8AMYtwKi9QRu79wjBvCu+RqgscKSpnDw+1xgStY
         HdkA==
X-Gm-Message-State: APt69E3huycU7M49FkDFTBgpuWV0+kMkXJJzNc7YA5sbvM515cPF4hfv
        Zqzv1NA7u4o/GA6PzeQWR0dlFw==
X-Google-Smtp-Source: ADUXVKL3bQuHpR/wRk3KQ2rjPrVBW9dW8QBmSa8aAIKe8P5d/W7r35dT248uHGrqnHtGPp4IDLstUA==
X-Received: by 2002:a19:de0a:: with SMTP id v10-v6mr5456124lfg.94.1528974765425;
        Thu, 14 Jun 2018 04:12:45 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id y13-v6sm1030434lfk.37.2018.06.14.04.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:44 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] soc: qcom: smsm: Add select IRQ_DOMAIN
Date:   Thu, 14 Jun 2018 13:11:35 +0200
Message-Id: <20180614111138.8923-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smsm.c: In function ‘smsm_inbound_entry’:
drivers/soc/qcom/smsm.c:411:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2f59d0a835fd..1d4a9f3ada8c 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -115,6 +115,7 @@ config QCOM_SMSM
 	tristate "Qualcomm Shared Memory State Machine"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
-- 
2.17.1

