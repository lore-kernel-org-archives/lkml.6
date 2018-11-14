Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3185EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6B12145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="PScYkZtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6B12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbeKOIvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:51:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45959 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeKOIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:51:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id d135so28847042qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rqgUEGz1FTJlMKH6pO4SpUOFIAjrT5Wh/+mw8UulJMI=;
        b=PScYkZtH+JCFwDYHFfHbf/pFyuJWQJuiAmPY65OLpKPoapqMM+a1c1lKhRKhzEKx5/
         tE7l4KxD5s/ECA/sW2etXrvxnfcFrmuDhOh0diXAToNHXxTTxr5sXWcOCC6Ueh00+hix
         mqxq0p2ZDb5w9G55Veu7JgZAF/WgB/tUr0g4RgNggpPIhIDsgifS/cps5pMe9InVHmCl
         WDhdCOgB2r/bgHMWmZhFUzBhX8ZZOWSwfKN0/taTa6BEwsOnL+XTVgCnlaIwjWwb+MxJ
         MOYRE2Y3oloJeV68pgcHNRnZi1lyg1uDXd4lvK8gwRlKGKJkY/4OYtMQgTTQe2sYG5MQ
         oQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rqgUEGz1FTJlMKH6pO4SpUOFIAjrT5Wh/+mw8UulJMI=;
        b=KUSU2NgsD1+afMaB/de/iFWbyGNQWRpUcdphmDtzKHpclOh+skgmvtYrL4oFiUvMcA
         2XwK1mZzhp+nlDwJBQ5LTRvW8KC6tONHKabmiabGM3O7t07/ttzT4fIghNyOSTGFPWtI
         N430ka6EKUuUx/OahJw8qqbZmIh+R6r8wNeBY/CnJPz5CbIfMHb/a7kwFGYRh8u1XNuK
         yJs51fGI9UlpprvKoKH/Ss5NfLluS+uFh5rVAUV9PY1+HZkIGDgBGZ2Z3JJ16EfCPLwz
         uPWQNVn9jcjKP6vvEGc8qFqe67poFH+9ZySdqWY97ypAU6PwJJWEw8bDGWEuraZOL3aP
         q+WQ==
X-Gm-Message-State: AGRZ1gKVyIti0iraiy9FaM6HJtwJEWeU+5k4saZt2f2H8zwF7BFVbAk3
        7kYHkybtFJOD0B7oT8z0oz6XMA==
X-Google-Smtp-Source: AJdET5d2wXGuz8/uqE5LmQXblRqs1JgWzC5fZie+oG1btdvvZ6dGghw9gFLiAz8hIRUyGuLK4LQQUA==
X-Received: by 2002:ac8:d86:: with SMTP id s6mr3636437qti.324.1542235549623;
        Wed, 14 Nov 2018 14:45:49 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id l20sm14275629qke.88.2018.11.14.14.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:45:48 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     bjorn.andersson@linaro.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mfd: qcom_rpm: write fw_version to CTRL_REG
Date:   Wed, 14 Nov 2018 17:42:01 -0500
Message-Id: <20181114224201.16225-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

downstream driver does this, and it is required on msm8060 (hp touchpad)

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/mfd/qcom_rpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 52fafea06067..8d420c37b2a6 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -638,6 +638,10 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	writel(fw_version[0], RPM_CTRL_REG(rpm, 0));
+	writel(fw_version[1], RPM_CTRL_REG(rpm, 1));
+	writel(fw_version[2], RPM_CTRL_REG(rpm, 2));
+
 	dev_info(&pdev->dev, "RPM firmware %u.%u.%u\n", fw_version[0],
 							fw_version[1],
 							fw_version[2]);
-- 
2.17.1

