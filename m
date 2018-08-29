Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631AAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E962086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMaZZlIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeH2LxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34464 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2LxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so3592547ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h90+3ReY06e+iLNerRK9K1XsVHAVsoADC481ssK4+Co=;
        b=eMaZZlIi8Tdxk3NSYyzVxvx4iPYAHUvG6b1xPMfFl7xEzxc2ZRSfF7b9YEHlObQySL
         6F38glQYuSH4W6Dr7+4w7c2K1st2PnG8ZfSbxUaEmHGg4N03rW4odmmHYmRaHW3Q8eZA
         ZNE0IL9va18UVzPrOdFV0AjQaro1ey8aijFA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h90+3ReY06e+iLNerRK9K1XsVHAVsoADC481ssK4+Co=;
        b=IFA4+KDxdlzJVIMjylcflebKf3D7wptaiIhqw19wQFyEZzXBjEtT4k9F35Mm2393ZX
         NFiZ1XVIdYUNScq+hwzmP1cNJSmKMD8CazVesNwyFcUjwSh3/cSXkFVYMbALt1c6RpOe
         R87TuYCO6yAKE1YAKgGtJ3ayUI9zOHpZ7MyNIazTmD4BOFDRrVfNqrmJXmU07RccmW5g
         oK1IXu4WTQRyGms109U197b5Z4mEo4n5JQxBRDCUJID7N99/QYRKJVwwmrpshmSqLeMw
         JzQsok+jWGw+Sv1EmtMCoWzawKLAzKJqItXu/IzEBbUICZR1aEp2zXfSL3sbMuE8Lmas
         i46Q==
X-Gm-Message-State: APzg51CQvt/1OFnwdjfZgagMnCuVqjCAuwYSK2Z2RpFZ9qO3q4Zn4HaW
        b899gSgeWY5Zbs4bo6XL3RWlcQ==
X-Google-Smtp-Source: ANB0VdYtsunW633RCaAnIxDP+s/JGrSkHigIiOqDLDozTOzLMsyyUwkLuy1zafLGAKH4dXuhPSXv8Q==
X-Received: by 2002:a2e:9095:: with SMTP id l21-v6mr3623796ljg.15.1535529448741;
        Wed, 29 Aug 2018 00:57:28 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u19-v6sm596232lje.51.2018.08.29.00.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:28 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/9] soc: qcom: smem: Add missing include of sizes.h
Date:   Wed, 29 Aug 2018 09:57:15 +0200
Message-Id: <20180829075724.9095-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/soc/qcom/smem.c: In function ‘qcom_smem_get_ptable’:
drivers/soc/qcom/smem.c:666:64: error: ‘SZ_4K’ undeclared
  ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
                                                                ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/smem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index bf4bd71ab53f..b77573eed596 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
-- 
2.17.1

