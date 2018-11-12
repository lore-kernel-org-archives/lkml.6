Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E85C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1561C2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPBSqUzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1561C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeKLWUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:20:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35998 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeKLWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:20:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2-v6so7228586edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVFQHQKwJWclm9eD07zuiBHdhuKOYMmHPa/AOdWQ654=;
        b=QPBSqUzwOghjSCXd6ePIPl/Sz6utjR/GeGPYkX2JIN4Kusqs5UxS+Edj3mwPmh0J5D
         6aW+M8l96InS4SJ2FANCLxE0sdQ/+1UFlvGSfTdjP5DxJyCyZ4gZRq8xs77pl5BCGGnv
         C+bW6fcW2vHMgdLhCKTQBQx7BnhgoX2XY5dUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVFQHQKwJWclm9eD07zuiBHdhuKOYMmHPa/AOdWQ654=;
        b=PsU7+CIcsWLeNdEwmQz1ARJYQlApU3qYphFrWUc2gzWdcgNb4pdsejqnI8ooWXUTLM
         MdwzwCJ+O7KcibIquuBSsOcsGs6nVbZ3DBt0zWgP9l/U7+id7Z2lK7AIlgsBIm4EYUdv
         RMlIQ7EmTXpAb40aPy5ranLS9AR0myIz4BqNcp71fqRThZktLxe9hYu6niX+TfRbh4OD
         24t7Dh9zU3CQhKMimZWEela3lDcnYiCrtKdhlAdHk/OaEa7zY6a1oGWZ2oqnWcAMGTkY
         sDWCVZnkKR2Cq0dzlW8arERyfAfl3IAg+wHZqT0eLikw0ovtdrs3dBD8Lszo8c6xqmoh
         0cUg==
X-Gm-Message-State: AGRZ1gKGTRW0xFikU0eafVUv61UFpmwNXogq1hE8b0rek17BP+KaQp2C
        cc562X1HhRjdKMrPiigVq90IzQ==
X-Google-Smtp-Source: AJdET5cm/DZPHlgt1Z52tkjnrjuaev32vaAi4zxkef0+WrNnGvc2YyzTj1GiEgDUi2YUr8n8VKn3ZQ==
X-Received: by 2002:a50:ba3d:: with SMTP id g58-v6mr12294375edc.214.1542025652248;
        Mon, 12 Nov 2018 04:27:32 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f11-v6sm4358545eds.23.2018.11.12.04.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 04:27:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     niklas.cassel@linaro.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Date:   Mon, 12 Nov 2018 12:25:26 +0000
Message-Id: <20181112122526.10337-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112122526.10337-1-srinivas.kandagatla@linaro.org>
References: <20181112122526.10337-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
to select it, not depend upon it.

Because of this change, we now also need to depend on the same
Kconfigs as QCOM_QMI_HELPERS depends on.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 9d73ad806698..8cd595148d17 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,8 +22,9 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on QCOM_QMI_HELPERS
-	depends on HAS_IOMEM && DMA_ENGINE
+	depends on HAS_IOMEM && DMA_ENGINE && NET
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_QMI_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
-- 
2.19.1

