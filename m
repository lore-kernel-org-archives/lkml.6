Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BDEC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2CA277E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmGS9G/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2CA277E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936751AbeF2RBX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:01:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41906 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbeF2RBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:01:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id a17-v6so4723913ljd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=bmGS9G/Jvsl2uNuDdfDhoxztt7r1nF4bNn6hQhQRevjFXLetiGEp9hkioSbLhE+c0c
         tC3bruycUJh7qLlM4vduVQWTvHyAbSW/pRqx72SxUB5ThE+1PP+QGQnY9wIAMO/X42yj
         B1G4KLYyzlYZmoYJ6QO/8hTOFD4GKUqgu1TPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=QnDmV2KX6VXeEjZEYJTaUnrEtI5UwgSfUFfzo5V9WTUWPRHQljGMy+7sNWfGrt/1H2
         tUeUsp52D2UraDeACaIMcnFL6RHK49tKJSySc9wy/HBrdU8AwsmatqlRjS8LQQOj7DiC
         PrZ96FQCTIL5+pRUd8rCV2mWIRTBfXvaGi1fBCzuwhkTN7ntcQCkwqiX1CepFLANJCY7
         EXbvhyd1WjGf+LAr4ac6xSuiPFm50r5Grc6UrJt+fgkU6kgCnbtavGHLWoc4bXnsiAzo
         xgzCmATDPi0iYB3fLYDs3JP6WgQkjolaBJKO9Jik/Jm2W/BpYekLf8h8Ktxm3wiZclhM
         xTjw==
X-Gm-Message-State: APt69E1mbTa25ZmiVNhH/yhQpoVdm5apQs8NM3PQC3GZ1UYLkE6rwI9i
        AlDj/fcSKWiITastdmTlkxe35g==
X-Google-Smtp-Source: AAOMgpfal2OUXc58BYvG9PZ2qE2gsmUM2AcQ8cXyuodNP7vJy9SgvpcBGFLVC4V+zVe0kZdLwD9B+w==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr3429958ljj.103.1530291680328;
        Fri, 29 Jun 2018 10:01:20 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id f38-v6sm1597066lji.87.2018.06.29.10.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 10:01:19 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: smd: Add missing include of sizes.h
Date:   Fri, 29 Jun 2018 19:01:01 +0200
Message-Id: <20180629170101.16255-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/rpmsg/qcom_smd.c: In function ‘qcom_smd_channel_open’:
drivers/rpmsg/qcom_smd.c:809:36: error: ‘SZ_4K’ undeclared (first use in this function)
  bb_size = min(channel->fifo_size, SZ_4K);
                                    ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 6437bbeebc91..8695cb041c31 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/wait.h>
-- 
2.17.1

