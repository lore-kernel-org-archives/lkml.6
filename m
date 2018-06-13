Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4462DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAD6208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9K5ymwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAD6208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935601AbeFMMzI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42233 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935365AbeFMMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id v135-v6so3754936lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=M9K5ymwFZ4t5t0FhfE5HWzsMG4CykQzXsi0AnfQ9zk6+VcUx/1T8mI8nY9kbMeS9nf
         WbFj85E60zTgYGLvdR2QakSEiaoXneOBFze7Gx8v3r4V3vFoW8WRiFa9Qf/IcS/QScjO
         I1vWcJBAgLDhlvA/3kqK6y7wi0eQ+OIBTkhJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=ox1vNzmn+p/9jFdxmBXBtkd+copH+CA8Cqjde+IOElcY5m8ynROWkj6n32onhXSvdJ
         MCLFZghNHGgcohV4E4Jy8Z04ebm7qxwQ9LmFAWLMx4ems3C0hiZvm15LS4RgQ+brNVrM
         tmAPITv+nWsV4tUbp1bvHOOqmo/x7+dc+FMMiiNYLvP+Od9KJVmlpYz3hdMz3T9UVTud
         XGJc2VUzZYPlBYqU3NJ79TwWKMV8ZGiHmaAfHLEjNb0S2Sp384R0tAMpK7803S9o27rR
         4MuKoPS42mtbFxHjuw4KFxeXDvu+L01JUWB6IfO3z1hghdbrw4ZeSbImiobrcr6Xv3H9
         HBog==
X-Gm-Message-State: APt69E389i2RfhYGAvZWh2GWZA7bhff24e41VRgJDR+Y+mmAmVLnC0om
        4OChXMWX7Dki69+qwY1XTOUMwg==
X-Google-Smtp-Source: ADUXVKITePm0mn7rd5oLQQSX844/ciDsUqxdE3rjR0xjNv8g3v7/Z9F24y/9YJmaXmitdlW42AldpA==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16-v6mr3048006ljj.142.1528894503621;
        Wed, 13 Jun 2018 05:55:03 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o9-v6sm580840lfk.2.2018.06.13.05.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:03 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] rpmsg: smd: Add missing include of sizes.h
Date:   Wed, 13 Jun 2018 14:53:56 +0200
Message-Id: <20180613125401.11734-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613125401.11734-1-niklas.cassel@linaro.org>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
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

