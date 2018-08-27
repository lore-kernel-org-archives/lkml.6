Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A587C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1722620858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MifOT8bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1722620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH0PWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:22:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40459 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeH0PWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:22:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so9591470lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=me8/a8IQyU0522obqv5m6glMpeNSmc8yqidyogcAdvg=;
        b=MifOT8bjJVGHMLIUsZ1CADkrB4uJ2vMd+2CrgouN/Mvl8WfWJwKwnpnYCUSTQnkgr3
         W4j3JML46U0p28u5KO2N4kasQavEAK6svfjYsZthRUmloaf11uAFi5fRrgeB5J/UwRBQ
         aXdyJ/GdSMve4GUVmRhDUJMwh39+/HvaFKq1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=me8/a8IQyU0522obqv5m6glMpeNSmc8yqidyogcAdvg=;
        b=PMJ+AAYrCjYOsKWsNjOfnB30I3/zBCMFwD544r8nwusuGYg/r7ArSm6uKim1qiVJ9D
         sJfSn2U7FWsahi+iW1qVq/bihiZV5p9Hqk0h2F6uXKR4PRz0TrnCF9NFkBSfYgKosbA/
         bptqWvOi9Nn0jQbqQJtfl+zufzpioU8CI2RrHFM/AnUSrrMAKuhA2MS9DLFWcSj//Pz9
         nwPlXyBCqy7U8sg0jj1nugS4I9efeiAKLehJnbkqU/6IIFh9LcFPaNHiYyF8ghZnSLoA
         7uBaMV/hwIb/yV/WHHSH7HgvAZIohvs4ns3ggGZeZWtaQsoxuSJAF5Ti2YLn6SW3wQor
         kKyw==
X-Gm-Message-State: APzg51CWvM9cPe5wgrLXBj0eWmRmxk+YQk4CMrJY14I8rxkLGAgri/VU
        gWj1j06NtcYftmcNm5HAso81qZh+ETs=
X-Google-Smtp-Source: ANB0VdYKF+5CelqOiYr7U5FPLbeg7FeNAnYT55IQP6ORg7DoQuRlzmm++7+eXpZ9D74uF4Eh2Whj1g==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr8627064lfd.1.1535369789828;
        Mon, 27 Aug 2018 04:36:29 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z15-v6sm2737503lji.58.2018.08.27.04.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:29 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] soc: qcom: llcc-slice: Add missing include of sizes.h
Date:   Mon, 27 Aug 2018 13:36:00 +0200
Message-Id: <20180827113605.9594-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827113605.9594-1-niklas.cassel@linaro.org>
References: <20180827113605.9594-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/soc/qcom/llcc-slice.c: In function ‘llcc_update_act_ctrl’:
drivers/soc/qcom/llcc-slice.c:41:44: error: ‘SZ_4K’ undeclared
 #define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
                                            ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/llcc-slice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index 54063a31132f..344dc2daf431 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
-- 
2.17.1

